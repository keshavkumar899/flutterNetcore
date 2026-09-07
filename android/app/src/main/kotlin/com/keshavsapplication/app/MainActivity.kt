package com.keshavsapplication.app

import android.content.Intent
import android.os.Bundle
import android.util.Log
import com.netcore.android.Smartech
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.hansel.hanselsdk.Hansel
import java.lang.ref.WeakReference

class MainActivity : FlutterActivity() {

//    companion object {
//        private const val TAG = "FabFurniMainActivity"
//        private const val SMARTECH_CHANNEL_NAME = "fabfurni/smartech"
//    }
//
//    private var pendingIntent: Intent? = null
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SMARTECH_CHANNEL_NAME)
//            .setMethodCallHandler { call, result ->
//                val app = application as Application
//
//                when (call.method) {
//                    "initializeSmartechSDK" -> {
//                        app.onCreate()
//                        processPendingDeeplinkIfNeeded()
//                        result.success(app.isSmartechInitialized())
//                    }
//
//                    "isSmartechInitialized" -> {
//                        result.success(app.isSmartechInitialized())
//                    }
//
//                    else -> result.notImplemented()
//                }
//            }
//    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Hansel.pairTestDevice(getIntent().getDataString());
        val isSmartechHandledDeeplink = Smartech.getInstance(WeakReference(this)).isDeepLinkFromSmartech(intent)
        if (!isSmartechHandledDeeplink) {
            //Handle deeplink on app side
        }
//        handleSmartechDeeplink(intent)
    }

//    override fun onNewIntent(intent: Intent) {
//        super.onNewIntent(intent)
//        setIntent(intent)
//        handleSmartechDeeplink(intent)
//    }

//    private fun handleSmartechDeeplink(intent: Intent?) {
//        if (intent == null) {
//            return
//        }
//
//        val app = application as Application
//        if (!app.isSmartechInitialized()) {
//            Log.d(TAG, "Smartech not initialized yet, storing pending deeplink intent")
//            pendingIntent = intent
//            return
//        }
//
//        Log.d(TAG, "Handling deeplink: ${intent.dataString}")
//        Hansel.pairTestDevice(intent.dataString)
//
//        val isSmartechHandledDeeplink =
//            Smartech.getInstance(WeakReference(this)).isDeepLinkFromSmartech(intent)
//
//        if (!isSmartechHandledDeeplink) {
//            // Handle deeplink on app side
//        }
//    }

//    private fun processPendingDeeplinkIfNeeded() {
//        val intent = pendingIntent ?: return
//        pendingIntent = null
//        handleSmartechDeeplink(intent)
//    }
}
