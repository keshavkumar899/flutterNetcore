package com.keshavsapplication.app

import android.app.Application
import android.util.Log
import com.netcore.android.Smartech
import com.netcore.android.smartechpush.SmartPush
import com.netcore.android.smartechpush.notification.SMTNotificationOptions
import com.netcore.android.utility.config.SmartechConfig
import com.netcore.smartech_appinbox.SmartechAppinboxPlugin
import com.netcore.smartech_base.SmartechBasePlugin
import com.netcore.smartech_push.SmartechPushPlugin
import io.hansel.core.logger.HSLLogLevel
import java.lang.ref.WeakReference

class Application : Application() {

    companion object {
        private const val TAG = "FabFurniApplication"

        @Volatile

        private var isSmartechInitialized = false
    }

    fun isSmartechInitialized(): Boolean = isSmartechInitialized

    fun initializeSmartechSDK() {
        if (isSmartechInitialized) {
            return
        }

        synchronized(this) {
            if (isSmartechInitialized) {
                return
            }

            Log.d(TAG, "Initializing Smartech SDK after login")

            val config = SmartechConfig()

            //Appid's can be set through below functions to avoid Manifest level configuration(which breaks the security)
            config.smartechAppId = "c233670ff952e492b556c946405e5ce1"
            config.hanselAppId = "2LOT46SOUILN1W2VZEIVKQBZE"
            config.hanselAppKey = "E2BW8TRR2S8FJHIGG7JMJKUB0N89Q89GIOSIXYXIDD31SZG9NC"
            //By defalut hansel sdk is enabled and initialized, to disable hansel you can set the flag to true
            config.disableHansel = false
            //Set the complete Smartech config before initializing the sdk
            Smartech.getInstance(WeakReference(applicationContext)).setConfig(config)


            Smartech.getInstance(WeakReference(applicationContext)).initializeSdk(this)
            Smartech.getInstance(WeakReference(applicationContext)).setDebugLevel(9)
            Smartech.getInstance(WeakReference(applicationContext)).trackAppInstallUpdateBySmartech()

            HSLLogLevel.all.setEnabled(true)
            HSLLogLevel.mid.setEnabled(true)
            HSLLogLevel.debug.setEnabled(true)
            HSLLogLevel.min.setEnabled(true)

            SmartechBasePlugin.initializePlugin(this)
            SmartechPushPlugin.initializePlugin(this)
            SmartechAppinboxPlugin.initializePlugin(this)

            val options = SMTNotificationOptions(this)
            options.brandLogo = "@drawable/ic_notification"
            options.largeIcon = "@drawable/ic_notification"
            options.smallIcon = "@drawable/ic_notification"
            options.smallIconTransparent = "@drawable/ic_notification"
            options.transparentIconBgColor = "#88568C"
            options.placeHolderIcon = "@drawable/ic_notification"
            SmartPush.getInstance(WeakReference(applicationContext)).setNotificationOptions(options)

            isSmartechInitialized = true
        }
    }

    override fun onCreate() {
        super.onCreate()
    }

    override fun onTerminate() {
        super.onTerminate()
        Log.d("onTerminate", "onTerminate")
    }
}
