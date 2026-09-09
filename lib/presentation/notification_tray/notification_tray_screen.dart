import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Removed: ${notification.title}'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } on PlatformException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to remove: ${e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Tray'),
        actions: [
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
          child: Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    if (_notifications.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.notifications_off_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No Smartech notifications\nin the tray',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchNotifications,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _NotificationTile(
            notification: notification,
            onDismissed: () => _removeNotification(notification),
          );
        },
      ),
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
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDismissed(),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Color(0xFF6A1B9A),
            child: Icon(Icons.notifications, color: Colors.white, size: 20),
          ),
          title: Text(
            notification.title.isNotEmpty ? notification.title : '(No title)',
            style: const TextStyle(fontWeight: FontWeight.w600),
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
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'trid: ${notification.trid}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            tooltip: 'Remove from tray',
            onPressed: onDismissed,
          ),
          isThreeLine: notification.body.isNotEmpty,
        ),
      ),
    );
  }
}
