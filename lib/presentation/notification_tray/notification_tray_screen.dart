import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// A model representing a delivered notification in the iOS notification tray.
class DeliveredNotification {
  final String identifier;
  final String title;
  final String body;
  final String trid;

  DeliveredNotification({
    required this.identifier,
    required this.title,
    required this.body,
    required this.trid,
  });

  factory DeliveredNotification.fromMap(Map<String, dynamic> map) {
    return DeliveredNotification(
      identifier: map['identifier'] as String? ?? '',
      title: map['title'] as String? ?? '',
      body: map['body'] as String? ?? '',
      trid: map['trid'] as String? ?? '',
    );
  }
}

/// Screen that shows all delivered notifications currently in the iOS
/// notification tray (only those sent via Smartech that carry a `trid`).
/// Swiping a notification removes it from the tray in real-time.
class NotificationTrayScreen extends StatefulWidget {
  const NotificationTrayScreen({Key? key}) : super(key: key);

  @override
  State<NotificationTrayScreen> createState() => _NotificationTrayScreenState();
}

class _NotificationTrayScreenState extends State<NotificationTrayScreen> {
  static const _channel = MethodChannel('fabfurni/smartech');

  List<DeliveredNotification> _notifications = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    if (!Platform.isIOS) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'This feature is currently supported only on iOS.';
      });
      return;
    }

    try {
      final result = await _channel.invokeMethod('getDeliveredNotifications');
      final List<dynamic> rawList = result as List<dynamic>? ?? [];

      final notifications = rawList
          .map((e) => DeliveredNotification.fromMap(
                Map<String, dynamic>.from(e as Map),
              ))
          .where((n) => n.trid.isNotEmpty)
          .toList();

      setState(() {
        _notifications = notifications;
        _isLoading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to fetch notifications: ${e.message}';
      });
    }
  }

  Future<void> _removeNotification(DeliveredNotification notification) async {
    try {
      await _channel.invokeMethod('removeNotificationByTrid', {
        'trid': notification.trid,
      });

      setState(() {
        _notifications.removeWhere((n) => n.trid == notification.trid);
      });

      Fluttertoast.showToast(
        msg: "✅ Removed: ${notification.title.isNotEmpty ? notification.title : 'Notification'}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFF323232),
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
        msg: "❌ Failed to remove: ${e.message}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red.shade700,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> _removeAllNotifications() async {
    if (_notifications.isEmpty) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Clear All Notifications'),
        content: Text(
          'Remove all ${_notifications.length} notification(s) from the tray?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Remove All'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    int removedCount = 0;
    for (final notification in List.of(_notifications)) {
      try {
        await _channel.invokeMethod('removeNotificationByTrid', {
          'trid': notification.trid,
        });
        removedCount++;
      } catch (_) {}
    }

    setState(() {
      _notifications.clear();
    });

    Fluttertoast.showToast(
      msg: "🗑️ Cleared $removedCount notification(s) from tray",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF323232),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification Tray',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          if (_notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: 'Remove All',
              onPressed: _removeAllNotifications,
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              setState(() => _isLoading = true);
              _fetchNotifications();
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 56, color: Colors.orange),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    if (_notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No Smartech notifications\nin the tray',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () {
                setState(() => _isLoading = true);
                _fetchNotifications();
              },
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Refresh'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Count header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: Colors.grey.shade100,
          child: Text(
            '${_notifications.length} notification(s) in tray',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // List
        Expanded(
          child: RefreshIndicator(
            onRefresh: _fetchNotifications,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _notifications.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                indent: 72,
                color: Colors.grey.shade200,
              ),
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _NotificationTile(
                  notification: notification,
                  onDismissed: () => _removeNotification(notification),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// A single notification tile with swipe-to-dismiss support.
class _NotificationTile extends StatelessWidget {
  final DeliveredNotification notification;
  final VoidCallback onDismissed;

  const _NotificationTile({
    required this.notification,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.trid),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: Colors.red.shade400,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 24),
            SizedBox(height: 4),
            Text(
              'Remove',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (_) async {
        onDismissed();
        return true;
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.notifications_active_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
        title: Text(
          notification.title.isNotEmpty ? notification.title : '(No title)',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notification.body.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  notification.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'trid: ${notification.trid}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.close, color: Colors.red.shade400, size: 20),
          tooltip: 'Remove from tray',
          onPressed: onDismissed,
        ),
        isThreeLine: notification.body.isNotEmpty,
      ),
    );
  }
}
