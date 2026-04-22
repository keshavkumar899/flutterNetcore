#!/usr/bin/env python3
"""
Simple local web UI for payload log validation.

Run:
  python3 payload_validator_webapp.py
Then open:
  http://127.0.0.1:8000
"""

from __future__ import annotations

import json
import os
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import parse_qs

from payload_log_validator import (
    extract_json_object_from_log,
    parse_expected_keys,
    parse_expected_schema,
    validate_payload,
    validate_payload_keys_only,
)


HTML_PAGE = """<!doctype html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Payload Log Validator</title>
  <style>
    body {{ font-family: Arial, sans-serif; margin: 24px; max-width: 980px; }}
    h1 {{ margin-bottom: 8px; }}
    p {{ margin-top: 0; color: #444; }}
    textarea, input[type="text"], select {{
      width: 100%; box-sizing: border-box; padding: 10px; margin-top: 6px;
      margin-bottom: 16px; border: 1px solid #ccc; border-radius: 6px;
      font-family: monospace;
    }}
    button {{
      padding: 10px 16px; border: none; border-radius: 6px;
      background: #1f6feb; color: #fff; cursor: pointer;
    }}
    button:hover {{ background: #195ec3; }}
    .card {{
      border: 1px solid #ddd; border-radius: 8px; padding: 16px; margin-top: 20px;
      background: #fafafa;
      position: relative;
    }}
    .error {{ color: #b00020; white-space: pre-wrap; }}
    .ok {{ color: #0a7f2e; }}
    pre {{
      background: #111; color: #f5f5f5; padding: 12px;
      border-radius: 8px; overflow-x: auto;
    }}
    .hint {{ color: #666; font-size: 13px; margin-top: -10px; margin-bottom: 16px; }}
    .copy-btn {{
      position: absolute; top: 12px; right: 12px;
      background: #2e7d32;
      padding: 8px 10px;
      font-size: 12px;
      transition: background 0.2s ease, transform 0.2s ease;
    }}
    .copy-btn:hover {{ background: #256528; }}
    .copy-btn.copied {{
      background: #1b5e20;
      transform: scale(1.03);
    }}
    .copy-btn.copy-failed {{
      background: #b00020;
    }}
  </style>
  <script>
    function copyValidation(jsonText, buttonEl) {{
      const originalText = buttonEl.dataset.originalText || buttonEl.textContent;
      buttonEl.dataset.originalText = originalText;
      navigator.clipboard.writeText(jsonText).then(function() {{
        buttonEl.textContent = "Copied ✓";
        buttonEl.classList.remove("copy-failed");
        buttonEl.classList.add("copied");
        setTimeout(function() {{
          buttonEl.textContent = originalText;
          buttonEl.classList.remove("copied");
        }}, 1200);
      }}, function() {{
        buttonEl.textContent = "Copy Failed";
        buttonEl.classList.remove("copied");
        buttonEl.classList.add("copy-failed");
        setTimeout(function() {{
          buttonEl.textContent = originalText;
          buttonEl.classList.remove("copy-failed");
        }}, 1200);
      }});
    }}
  </script>
</head>
<body>
  <h1>Payload Log Validator</h1>
  <p>Paste SMT log text and expected payload definition.</p>

  <form method="post" action="/validate">
    <label for="mode">Validation mode</label>
    <select name="mode" id="mode">
      <option value="keys_and_types" {keys_and_types_selected}>Keys + Types</option>
      <option value="keys_only" {keys_only_selected}>Keys Only</option>
    </select>

    <label for="log_text">Log text</label>
    <textarea id="log_text" name="log_text" rows="8" placeholder="Paste full log line here...">{log_text}</textarea>

    <label for="expected">Expected (keys + data type)</label>
    <input id="expected" name="expected" type="text" value="{expected}" placeholder="media_id:str,video_type:int OR media_id String video_type String" />
    <div class="hint">Used in "Keys + Data Type" mode. Supports comma style (key:type) and sheet style (key type key2 type2).</div>

    <label for="expected_keys">Expected keys only (key1,key2,key3)</label>
    <input id="expected_keys" name="expected_keys" type="text" value="{expected_keys}" placeholder="media_id,video_type,program_genres" />
    <div class="hint">Used in "Keys Only" mode.</div>

    <button type="submit">Validate</button>
  </form>

  {result_block}
</body>
</html>
"""


def render_page(
    mode: str = "keys_and_types",
    log_text: str = "",
    expected: str = "",
    expected_keys: str = "",
    result: dict | None = None,
    error: str = "",
) -> str:
    keys_and_types_selected = "selected" if mode == "keys_and_types" else ""
    keys_only_selected = "selected" if mode == "keys_only" else ""

    if error:
        result_block = f'<div class="card"><h3>Error</h3><div class="error">{html_escape(error)}</div></div>'
    elif result is not None:
        is_valid = not (
            result.get("missing_keys_in_logs")
            or result.get("unexpected_keys")
            or result.get("data_type_mismatch")
        )
        status_class = "ok" if is_valid else "error"
        status_label = "VALIDATION PASSED" if is_valid else "VALIDATION FAILED"
        output_json = json.dumps(result, indent=2, ensure_ascii=False)
        output_json_escaped = html_escape(output_json)
        output_json_js = json.dumps(output_json, ensure_ascii=False)
        result_block = (
            f'<div class="card"><h3 class="{status_class}">{status_label}</h3>'
            f'<button type="button" class="copy-btn" onclick=\'copyValidation({output_json_js}, this)\'>Copy Validation</button>'
            f"<pre>{output_json_escaped}</pre></div>"
        )
    else:
        result_block = ""

    return HTML_PAGE.format(
        keys_and_types_selected=keys_and_types_selected,
        keys_only_selected=keys_only_selected,
        log_text=html_escape(log_text),
        expected=html_escape(expected),
        expected_keys=html_escape(expected_keys),
        result_block=result_block,
    )


def html_escape(text: str) -> str:
    return (
        text.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace('"', "&quot;")
    )


class RequestHandler(BaseHTTPRequestHandler):
    def _send_html(self, html: str, status: int = 200) -> None:
        content = html.encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(content)))
        self.end_headers()
        self.wfile.write(content)

    def do_GET(self) -> None:  # noqa: N802
        if self.path == "/":
            self._send_html(render_page())
            return
        self._send_html("<h1>Not Found</h1>", status=404)

    def do_POST(self) -> None:  # noqa: N802
        if self.path != "/validate":
            self._send_html("<h1>Not Found</h1>", status=404)
            return

        length = int(self.headers.get("Content-Length", "0"))
        body = self.rfile.read(length).decode("utf-8", errors="replace")
        form = parse_qs(body)

        mode = form.get("mode", ["keys_and_types"])[0]
        log_text = form.get("log_text", [""])[0].strip()
        expected = form.get("expected", [""])[0].strip()
        expected_keys = form.get("expected_keys", [""])[0].strip()

        try:
            event_obj = extract_json_object_from_log(log_text)
            payload = event_obj.get("payload")
            if not isinstance(payload, dict):
                raise ValueError("The extracted event JSON does not contain a payload object.")

            if mode == "keys_only":
                if not expected_keys:
                    raise ValueError("Expected keys is required for Keys Only mode.")
                parsed_keys = parse_expected_keys(expected_keys)
                result = validate_payload_keys_only(payload, parsed_keys)
            else:
                if not expected:
                    raise ValueError("Expected schema is required for Keys + Types mode.")
                parsed_schema = parse_expected_schema(expected)
                result = validate_payload(payload, parsed_schema)

            self._send_html(
                render_page(
                    mode=mode,
                    log_text=log_text,
                    expected=expected,
                    expected_keys=expected_keys,
                    result=result,
                )
            )
        except Exception as exc:  # noqa: BLE001
            self._send_html(
                render_page(
                    mode=mode,
                    log_text=log_text,
                    expected=expected,
                    expected_keys=expected_keys,
                    error=str(exc),
                ),
                status=400,
            )


def main() -> None:
    host = os.environ.get("HOST", "127.0.0.1")
    port = int(os.environ.get("PORT", "8000"))
    server = HTTPServer((host, port), RequestHandler)
    print(f"Starting Payload Validator web app on http://{host}:{port}")
    server.serve_forever()


if __name__ == "__main__":
    main()
