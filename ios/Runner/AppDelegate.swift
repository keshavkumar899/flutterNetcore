import UIKit
import Flutter
import Smartech
import SmartPush
import smartech_base
import SmartechNudges
import Firebase


@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate,SmartechDelegate,HanselDeepLinkListener
                                             //HanselActionListener
{
//    func onActionPerformed(action: String!) {
//        <#code#>
//    }
    
    private var flutterMethodChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   FirebaseApp.configure()
   UNUserNotificationCenter.current().delegate = self
//           let config = SmartechConfig.sharedInstance()
//   
//           // App IDs can be set programmatically to avoid Info.plist level configuration (which may compromise security)
//           config.appGroup = "group.com.netcore.SmartechApp"
//           config.smartechAppId = "cdd5abdf5d9441b21b0f9e6223a4ed7a"
//           config.hanselAppId = "UJMDZOCJJF92T72LR3GUOVZ4F"
//           config.hanselAppKey = "WRAUGKWQFE620ERVV21NCU3PDM0B31UYL9GYOEDCCNOPWYZ11Q"
//   
//           // By default, Hansel SDK is enabled and initialized. Set this flag to true to disable Hansel SDK
//           //config.isHanselDisabled = false
//   
//           // Apply the complete Smartech configuration before initializing the SDK
//           Smartech.sharedInstance().setSmartechConfig(config)

           Smartech.sharedInstance().initSDK(with: self, withLaunchOptions: launchOptions)
           SmartPush.sharedInstance().registerForPushNotificationWithDefaultAuthorizationOptions()
           Hansel.enableDebugLogs()
           Smartech.sharedInstance().setDebugLevel(.verbose)
           Smartech.sharedInstance().trackAppInstallUpdateBySmartech()
//           Hansel.getUser()?.putAttribute("Keshav", forKey:"Name")
//           let deeplinkListener = HanselDeepLinkListener()
//   
//           //Register the instance with this line:
//           Hansel.registerHanselDeeplinkListener(listener: deeplinkListener)
           onClick()
   //        Hansel.registerHanselActionListener(action: String, listener: any HanselActionListener)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
           
           Messaging.messaging().apnsToken = deviceToken
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
           // MARK: Adding the delay of 5ms in didReceive response class will give the pn_clicked event in Terminated state also. Replace existing code with the below lines.
           DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(0.5 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
   //            self.flutterMethodChannel = FlutterMethodChannel(
   //                        name: "com.netcore.SmartechApp",
   //                        binaryMessenger: response as! FlutterBinaryMessenger
   //                    )
   //            self.flutterMethodChannel?.invokeMethod(
   //                        "didReceivedCallback",
   //                        arguments: response
   //                    )
   //            print(response)
                       SmartPush.sharedInstance().didReceive(response)
                       completionHandler()
                   })
       }
       
       func handleDeeplinkAction(withURLString deeplinkURLString: String, andNotificationPayload notificationPayload: [AnyHashable : Any]?) {
           
   //    fabfurni://productPage//, http, https
           NSLog("SMTL deeplink Native---> \(deeplinkURLString)")
      
           SmartechBasePlugin.handleDeeplinkAction(deeplinkURLString, andCustomPayload: notificationPayload)
       }
       
        override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            // Branch SDK handles URI scheme links automatically via flutter_branch_sdk plugin
            // The plugin uses method swizzling to intercept deep links
            
            let handleBySmartech = Smartech.sharedInstance().application(app, open: url, options: options);
           if(!handleBySmartech) {
               //Handle the url by the app
               // Call super to allow Flutter plugins (including Branch) to handle the URL
               return super.application(app, open: url, options: options)
           }
           return true;

       }
       
       // MARK: - Universal Links (handles terminated state for Branch deep links)
       override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
           // Forward to super - flutter_branch_sdk plugin will handle Branch Universal Links
           // This is critical for terminated state deep linking to work
           return super.application(application, continue: userActivity, restorationHandler: restorationHandler)
       }
        func onLaunchURL(URLString: String!) {
          
          }

            func onClick() {
     //https://cedocs.netcorecloud.com/docs/universal-links-for-email-engagement#implementing-link-resolution

           //    https://elink.savmoney.me/vtrack?
   //                let netcoreURL = URL(string: "https://elink.savmoney.me/vtrack?clientid=170681&ul=BgVRBlNEBR5TX15DB154R1VASw4KWVYdTx4=&ml=BA9VSFJEA1MESw==&sl=dUolSDdrSTF9Y0tUClBWXxpFBBUIWF0BSkwLU0xQ&pp=0&c=0000&fl=X0ISRBECGk1DVkFQFkkWVURGSw8MWVhLew88UHkiXFZrI1M=&ext=")!
   //
   ////             if let referralURL = userActivity?.webpageURL, let netcoreURL = URL(string: String(describing: referralURL)) {
   //             if  let netcoreURL = URL(string: String(describing: netcoreURL)) {
   //            print("URL: \(netcoreURL)")
   //
   //            let task = URLSession.shared.dataTask(with: netcoreURL) { data, response, error in
   //                guard error == nil else {
   //                    print("Universal Error resolving link: \(error!)")
   //                    return
   //                }
   //
   //                if let httpResponse = response as? HTTPURLResponse {
   //                    if let originalURL = httpResponse.url {
   //                        let responseValue = originalURL.absoluteString // Convert the URL to a string
   //                        print("Response URL: \(responseValue)")
   //                    } else {
   //                        print("HTTP response was not successful: \(httpResponse.statusCode)")
   //                    }
   //                } else if response == nil {
   //                    print("Response is nil")
   //                } else {
   //                    print("Invalid sor unsuccessful HTTP response")
   //                }
   //
   //            }
                let netcoreURL = URL(string: "https://elink.savmoney.me/vtrack?clientid=170681&ul=BgVRBlNEBR5TX15DB154R1VASw4KWVYdTx4=&ml=BA9VSFJEA1MESw==&sl=dUolSDdrSTF9Y0tUClBWXxpFBBUIWF0BSkwLU0xQ&pp=0&c=0000&fl=X0ISRBECGk1DVkFQFkkWVURGSw8MWVhLew88UHkiXFZrI1M=&ext=")!
                let task = URLSession.shared.dataTask(with: netcoreURL) { data, response, error in
                    guard error == nil else {
                        print("Error resolving link: \(error!)")
                        return
                    }
                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        // Successfully resolved the link
                        if let originalURL = httpResponse.url {
                            // Trigger the click event and navigate to the correct part of your app
                            print("Original URL: \(originalURL)")
                        }
                    }
                }
               task.resume()
   //        }

   //        else {
   //            print("Invalid referral URL")
   //
   //        }

   //        return responseValue
            }
}

