import UIKit
import Flutter
import Smartech
import SmartPush

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate ,SmartechDelegate{
  override func application(
    _ application: UIApplication,
//     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data,
//     didFailToRegisterForRemoteNotificationsWithError error: Error,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    Smartech.sharedInstance().initSDK(with: self, withLaunchOptions: launchOptions)
//     SmartPush.sharedInstance().registerForPushNotificationWithDefaultAuthorizationOptions()
//     SmartPush.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
//      SmartPush.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)
    Smartech.sharedInstance().setDebugLevel(.verbose)
    Smartech.sharedInstance().trackAppInstallUpdateBySmartech()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application,
    //didRegisterForRemoteNotificationsWithDeviceToken:deviceToken,didFailToRegisterForRemoteNotificationsWithError:Error,
    didFinishLaunchingWithOptions: launchOptions)
//      return true
  }
}
