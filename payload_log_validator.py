#!/usr/bin/env python3
"""
Validate `payload` keys (and optionally value types) from SMT single-event logs.

Example:
python payload_log_validator.py \
  --log '🟩 SMTLogger(INFO) SMTTrackEventRequest: Single Event: {"payload":{"video_type":341,"premium_video":"false"}} -[SMTTrackEventRequest ...]' \
  --expected 'video_type:int,premium_video:str'

python payload_log_validator.py \
  --log '🟩 SMTLogger(INFO) SMTTrackEventRequest: Single Event: {"payload":{"video_type":341,"premium_video":"false"}} -[SMTTrackEventRequest ...]' \
  --expected-keys 'video_type,premium_video'
"""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path
from typing import Any


TYPE_ALIASES = {
    "str": "string",
    "string": "string",
    "int": "integer",
    "integer": "integer",
    "float": "float",
    "double": "float",
    "number": "number",
    "numeric": "number",
    "bool": "boolean",
    "boolean": "boolean",
    "list": "array",
    "array": "array",
    "dict": "object",
    "object": "object",
    "null": "null",
    "none": "null",
    "date": "string",
    "datetime": "string",
    "any": "any",
}

DISPLAY_TYPE_NAMES = {
    "string": "String",
    "boolean": "Boolean",
    "array": "List",
    "object": "Object",
    "integer": "Integer",
    "float": "Float",
    "number": "Number",
    "null": "Null",
    "any": "Any",
}


def extract_json_object_from_log(log_text: str) -> dict[str, Any]:
    """
    Extract and parse the first complete JSON object found in a log line.
    """
    def find_complete_json_end(text: str, start_idx: int) -> int:
        in_string = False
        escape = False
        depth = 0

        for idx in range(start_idx, len(text)):
            ch = text[idx]

            if escape:
                escape = False
                continue

            if ch == "\\" and in_string:
                escape = True
                continue

            if ch == '"':
                in_string = not in_string
                continue

            if in_string:
                continue

            if ch == "{":
                depth += 1
            elif ch == "}":
                depth -= 1
                if depth == 0:
                    return idx
        return -1

    def parse_json_object_blob(blob: str) -> dict[str, Any]:
        parsed_obj = json.loads(blob)
        if not isinstance(parsed_obj, dict):
            raise ValueError("Top-level JSON is not an object.")
        return parsed_obj

    start = log_text.find("{")
    if start == -1:
        raise ValueError("No JSON object found in log text.")

    # Primary path: parse balanced JSON object.
    end = find_complete_json_end(log_text, start)
    if end != -1:
        return parse_json_object_blob(log_text[start : end + 1])

    # Fallback for truncated tail logs like "... <decode: missing data> (Line ...)".
    missing_data_match = re.search(r"<decode:\s*missing data>", log_text, flags=re.IGNORECASE)
    if missing_data_match:
        truncated_text = log_text[: missing_data_match.start()]
        end = find_complete_json_end(truncated_text, start)
        if end != -1:
            return parse_json_object_blob(truncated_text[start : end + 1])

    # Best effort fallback: try parsing until the last parseable closing brace.
    for close_idx in range(log_text.rfind("}"), start, -1):
        if log_text[close_idx] != "}":
            continue
        candidate = log_text[start : close_idx + 1]
        try:
            return parse_json_object_blob(candidate)
        except (json.JSONDecodeError, ValueError):
            continue

    raise ValueError(
        "Could not find a complete JSON object in log text, even after truncation at '<decode: missing data>'."
    )


def normalize_expected_type(type_name: str) -> str:
    normalized = TYPE_ALIASES.get(type_name.strip().lower())
    if not normalized:
        supported = ", ".join(sorted(set(TYPE_ALIASES.values())))
        raise ValueError(f"Unsupported type '{type_name}'. Supported: {supported}.")
    return normalized


def parse_expected_schema(schema_csv: str) -> dict[str, str]:
    """
    Parse expected schema in either format:
    1) key:type,key2:type2
    2) key type key2 type2 (spaces/tabs/newlines allowed)
    """
    schema_text = schema_csv.strip()
    if not schema_text:
        raise ValueError("Expected schema is empty.")

    parsed: dict[str, str] = {}

    # Format 1: key:type, key2:type2 (comma and/or whitespace separated entries)
    if ":" in schema_text:
        entries = [chunk.strip() for chunk in re.split(r"[,\s]+", schema_text) if chunk.strip()]
        for entry in entries:
            if ":" not in entry:
                raise ValueError(
                    f"Invalid entry '{entry}'. Use key:type format, e.g. media_id:str"
                )
            key, expected_type = entry.split(":", 1)
            key = key.strip()
            if not key:
                raise ValueError(f"Invalid empty key in entry '{entry}'.")
            parsed[key] = normalize_expected_type(expected_type)
        return parsed

    # Format 2: key type key2 type2 (spaces/tabs/newlines)
    tokens = [chunk.strip() for chunk in re.split(r"[\s,]+", schema_text) if chunk.strip()]
    if len(tokens) % 2 != 0:
        raise ValueError(
            "Invalid key/type pairs. Use either key:type,key2:type2 or key type key2 type2."
        )

    for idx in range(0, len(tokens), 2):
        key = tokens[idx]
        expected_type = tokens[idx + 1]
        parsed[key] = normalize_expected_type(expected_type)

    return parsed


def parse_expected_keys(keys_csv: str) -> list[str]:
    """
    Parse keys with comma and/or whitespace separators.
    Examples:
    - key1,key2,key3
    - key1 key2 key3
    - key1, key2 key3
    """
    keys = [chunk.strip() for chunk in re.split(r"[,\s]+", keys_csv) if chunk.strip()]
    if not keys:
        raise ValueError("Expected keys list is empty.")

    # Keep original order while removing duplicates.
    return list(dict.fromkeys(keys))


def detect_type(value: Any) -> str:
    if value is None:
        return "null"
    if isinstance(value, bool):
        return "boolean"
    if isinstance(value, int):
        return "integer"
    if isinstance(value, float):
        return "float"
    if isinstance(value, str):
        return "string"
    if isinstance(value, list):
        return "array"
    if isinstance(value, dict):
        return "object"
    return type(value).__name__.lower()


def matches_type(value: Any, expected: str) -> bool:
    if expected == "any":
        return True

    actual = detect_type(value)

    if expected == "number":
        return actual in {"integer", "float"}
    if expected == "boolean":
        # Panel expects boolean-like values as string/integer, not JSON boolean.
        if isinstance(value, str):
            return value.strip().lower() in {"true", "false"}
        if isinstance(value, int) and not isinstance(value, bool):
            return value in {0, 1}
        return False
    return actual == expected


def display_type_name(type_name: str) -> str:
    return DISPLAY_TYPE_NAMES.get(type_name, type_name.capitalize())


def validate_payload(payload: dict[str, Any], expected_schema: dict[str, str]) -> dict[str, Any]:
    found_keys = sorted([k for k in expected_schema if k in payload])
    found_keys_with_types = [
        f"{key}:{display_type_name(detect_type(payload[key]))}" for key in found_keys
    ]
    missing_keys = sorted([k for k in expected_schema if k not in payload])
    unexpected_keys = sorted([k for k in payload if k not in expected_schema])

    data_type_mismatch = []
    for key, expected_type in expected_schema.items():
        if key not in payload:
            continue
        value = payload[key]
        if not matches_type(value, expected_type):
            data_type_mismatch.append(
                {
                    "key": key,
                    "expected": display_type_name(expected_type),
                    "actual": display_type_name(detect_type(value)),
                    "value": value,
                }
            )

    result = {
        "found_keys_in_logs": found_keys_with_types,
        "missing_keys_in_logs": missing_keys,
        "unexpected_keys": unexpected_keys,
        "data_type_mismatch": data_type_mismatch,
        "is_valid": not (missing_keys or unexpected_keys or data_type_mismatch),
    }
    return compact_output(result)


def validate_payload_keys_only(payload: dict[str, Any], expected_keys: list[str]) -> dict[str, Any]:
    found_keys = sorted([k for k in expected_keys if k in payload])
    found_keys_with_types = [
        f"{key}:{display_type_name(detect_type(payload[key]))}" for key in found_keys
    ]
    missing_keys = sorted([k for k in expected_keys if k not in payload])
    unexpected_keys = sorted([k for k in payload if k not in expected_keys])

    result = {
        "found_keys_in_logs": found_keys_with_types,
        "missing_keys_in_logs": missing_keys,
        "unexpected_keys": unexpected_keys,
        "data_type_mismatch": [],
        "is_valid": not (missing_keys or unexpected_keys),
        "mode": "keys_only",
    }
    return compact_output(result)


def compact_output(result: dict[str, Any]) -> dict[str, Any]:
    """
    Remove optional empty sections and hide internal metadata from final output.
    """
    compact = dict(result)
    if not compact.get("unexpected_keys"):
        compact.pop("unexpected_keys", None)
    if not compact.get("data_type_mismatch"):
        compact.pop("data_type_mismatch", None)

    # Keep validation metadata internal; do not print in final output payload.
    compact.pop("is_valid", None)
    compact.pop("mode", None)
    return compact


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Validate payload keys or keys+types from SMT single-event log lines."
    )
    parser.add_argument(
        "--log",
        help="Raw log line text containing JSON.",
    )
    parser.add_argument(
        "--log-file",
        help="Path to text file containing raw log text.",
    )
    parser.add_argument(
        "--expected",
        help=(
            "Expected schema in either format: "
            "'media_id:str,video_type:int' OR 'media_id String video_type String'"
        ),
    )
    parser.add_argument(
        "--expected-keys",
        help="Payload keys separated by commas and/or spaces, e.g. 'media_id,video_type program_genres'",
    )
    return parser.parse_args()


def read_log_text(args: argparse.Namespace) -> str:
    if args.log and args.log_file:
        raise ValueError("Use either --log or --log-file, not both.")
    if not args.log and not args.log_file:
        raise ValueError("Provide one of --log or --log-file.")
    if args.log:
        return args.log
    return Path(args.log_file).read_text(encoding="utf-8")


def main() -> None:
    args = parse_args()
    if not args.expected and not args.expected_keys:
        raise ValueError("Provide one of --expected or --expected-keys.")
    if args.expected and args.expected_keys:
        raise ValueError("Use either --expected or --expected-keys, not both.")

    log_text = read_log_text(args)

    event_obj = extract_json_object_from_log(log_text)
    payload = event_obj.get("payload")

    if not isinstance(payload, dict):
        raise ValueError("The extracted event JSON does not contain a payload object.")

    if args.expected:
        expected_schema = parse_expected_schema(args.expected)
        result = validate_payload(payload, expected_schema)
        is_valid = not (
            result.get("missing_keys_in_logs")
            or result.get("unexpected_keys")
            or result.get("data_type_mismatch")
        )
    else:
        expected_keys = parse_expected_keys(args.expected_keys)
        result = validate_payload_keys_only(payload, expected_keys)
        is_valid = not (
            result.get("missing_keys_in_logs") or result.get("unexpected_keys")
        )

    print(json.dumps(result, indent=2, ensure_ascii=False))

    if is_valid:
        print("\nValidation passed.")
    else:
        print("\nValidation failed.")


if __name__ == "__main__":
    main()
