import UIKit
import Flutter
import Smartech
import SmartPush
import smartech_base

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, SmartechDelegate{
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        Smartech.sharedInstance().initSDK(with: self, withLaunchOptions: launchOptions)
        SmartPush.sharedInstance().registerForPushNotificationWithDefaultAuthorizationOptions()
        //     SmartPush.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
        //     SmartPush.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)
        Smartech.sharedInstance().setDebugLevel(.verbose)
        Smartech.sharedInstance().trackAppInstallUpdateBySmartech()
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application,
                                 //didRegisterForRemoteNotificationsWithDeviceToken:deviceToken,didFailToRegisterForRemoteNotificationsWithError:Error,
                                 didFinishLaunchingWithOptions: launchOptions)
        //      return true
    }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        SmartPush.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
        
    }
    
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        SmartPush.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)
    }
    
    //MARK:- UNUserNotificationCenterDelegate Methods
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        SmartPush.sharedInstance().willPresentForegroundNotification(notification)
        completionHandler([.alert, .badge, .sound])
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        SmartPush.sharedInstance().didReceive(response)
        completionHandler()
    }
    
    func handleDeeplinkAction(withURLString deeplinkURLString: String, andNotificationPayload notificationPayload: [AnyHashable : Any]?) {
        
//    fabfurni://productPage//, http, https
        NSLog("SMTL deeplink Native---> \(deeplinkURLString)")
   
        SmartechBasePlugin.handleDeeplinkAction(deeplinkURLString, andCustomPayload: notificationPayload)
    }
    
}
