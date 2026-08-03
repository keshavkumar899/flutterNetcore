package com.keshavsapplication.app

import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.netcore.android.smartechpush.SmartPush
import org.json.JSONObject
import java.lang.ref.WeakReference

class MyFirebaseMessagingService : FirebaseMessagingService() {

    override fun onNewToken(token: String) {
        super.onNewToken(token)

        val app = application as Application
        if (!app.isSmartechInitialized()) {
            return
        }

        SmartPush.getInstance(WeakReference(this)).setDevicePushToken(token)
    }

    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)

        val app = application as Application
        if (!app.isSmartechInitialized()) {
            return
        }

        val isPushFromSmartech = SmartPush.getInstance(WeakReference(this)).isNotificationFromSmartech(
            JSONObject(message.data.toString())
        )

        if (isPushFromSmartech) {
            SmartPush.getInstance(WeakReference(applicationContext)).handleRemotePushNotification(message)
        } else {
            // Notification received from other sources
        }
    }
}
