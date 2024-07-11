import UIKit
import Flutter
import Smartech
import SmartPush
import smartech_base
import SmartechNudges


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, SmartechDelegate
                         //HanselActionListener
{
//    func onActionPerformed(action: String!) {
//        <#code#>
//    }
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        UNUserNotificationCenter.current().delegate = self
        Smartech.sharedInstance().initSDK(with: self, withLaunchOptions: launchOptions)
        SmartPush.sharedInstance().registerForPushNotificationWithDefaultAuthorizationOptions()
        Hansel.enableDebugLogs()
        Smartech.sharedInstance().setDebugLevel(.verbose)
        Smartech.sharedInstance().trackAppInstallUpdateBySmartech()
//        Hansel.registerHanselActionListener(action: String, listener: any HanselActionListener)
        return super.application(application,
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
    
     override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
          var handleBySmartech = Smartech.sharedInstance().application(app, open: url, options: options);
        if(!handleBySmartech) {
            //Handle the url by the app
        }
        return true;
    }
     func onLaunchURL(URLString: String!) {
       
       }
    
}
