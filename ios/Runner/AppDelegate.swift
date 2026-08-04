import Flutter
import UIKit
//import GoogleMaps
import FirebaseCore
import FirebaseMessaging
import UserNotifications
import Smartech
import SmartPush
import smartech_base
import SmartechNudges

@main
@objc class AppDelegate: FlutterAppDelegate, SmartechDelegate {

    private var isSmartechInitialized = false
    private var storedLaunchOptions: [UIApplication.LaunchOptionsKey: Any]?
    private var pendingDeepLinkURL: URL?
    private static let smartechMethodChannelName = "fabfurni/smartech"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        storedLaunchOptions = launchOptions

        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self

        GeneratedPluginRegistrant.register(with: self)
        setupSmartechMethodChannel()

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func setupSmartechMethodChannel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let controller = self.flutterViewController else {
                return
            }

            let channel = FlutterMethodChannel(
                name: AppDelegate.smartechMethodChannelName,
                binaryMessenger: controller.binaryMessenger
            )

            channel.setMethodCallHandler { [weak self] call, result in
                guard let self = self else {
                    result(false)
                    return
                }

                switch call.method {
                case "initializeSmartechSDK":
                    self.initializeSmartechSDK(with: self.storedLaunchOptions)
                    result(self.isSmartechInitialized)
                case "isSmartechInitialized":
                    result(self.isSmartechInitialized)
                default:
                    result(FlutterMethodNotImplemented)
                }
            }
        }
    }

    private var flutterViewController: FlutterViewController? {
        if let controller = window?.rootViewController as? FlutterViewController {
            return controller
        }

        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })?
            .rootViewController as? FlutterViewController
    }

    /// Called only from Flutter via smartechLogin() after the user logs in.
    func initializeSmartechSDK(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        guard !isSmartechInitialized else {
            return
        }

        let config = SmartechConfig.sharedInstance()


        // App IDs can be set programmatically to avoid Info.plist level configuration (which may compromise security)
        config.smartechAppId = "cdd5abdf5d9441b21b0f9e6223a4ed7a"
        config.hanselAppId = "UJMDZOCJJF92T72LR3GUOVZ4F"
        config.hanselAppKey = "WRAUGKWQFE620ERVV21NCU3PDM0B31UYL9GYOEDCCNOPWYZ11Q"

        // By default, Hansel SDK is enabled and initialized. Set this flag to true to disable Hansel SDK
        config.isHanselDisabled = false

        // Apply the complete Smartech configuration before initializing the SDK
        Smartech.sharedInstance().setSmartechConfig(config)

        Smartech.sharedInstance().initSDK(with: self, withLaunchOptions: launchOptions)
        SmartPush.sharedInstance().registerForPushNotificationWithDefaultAuthorizationOptions()
        Hansel.enableDebugLogs()
        Smartech.sharedInstance().setDebugLevel(.verbose)
        Smartech.sharedInstance().trackAppInstallUpdateBySmartech()
        isSmartechInitialized = true

        processPendingDeepLinkIfNeeded()
    }

    private func processPendingDeepLinkIfNeeded() {
        guard let url = pendingDeepLinkURL else {
            return
        }

        pendingDeepLinkURL = nil
        _ = handleOpenURL(url, options: [:])
    }

    @discardableResult
    func handleOpenURL(_ url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        NSLog("SMTL open URL Native---> \(url.absoluteString)")

        guard isSmartechInitialized else {
            pendingDeepLinkURL = url
            return false
        }

        let handledBySmartech = Smartech.sharedInstance().application(
            UIApplication.shared,
            open: url,
            options: options
        )

        if !handledBySmartech {
            return super.application(UIApplication.shared, open: url, options: options)
        }

        return true
    }

    // Handle APNS token registration
    override func application(_ application: UIApplication,
                            didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Successfully registered for remote notifications")
        Messaging.messaging().apnsToken = deviceToken
        guard isSmartechInitialized else { return }
        SmartPush.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
    }

    override func application(_ application: UIApplication,
                            didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error)")
        guard isSmartechInitialized else { return }
        SmartPush.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)
    }

    // Handle background notifications with content-available
    override func application(_ application: UIApplication,
                             didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                             fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        if isSmartechInitialized {
            SmartPush.sharedInstance().didReceiveRemoteNotification(userInfo, withCompletionHandler: completionHandler)
        }

        if let aps = userInfo["aps"] as? [String: AnyObject],
           aps["content-available"] as? Int == 1 {
            print("Silent notification received - forwarding to Flutter")
            super.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
            return
        }

        super.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }

    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                        willPresent notification: UNNotification,
                                        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if isSmartechInitialized {
            SmartPush.sharedInstance().willPresentForegroundNotification(notification)
        }
        completionHandler([.alert, .sound, .badge])
    }

    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                        didReceive response: UNNotificationResponse,
                                        withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        print("Notification tapped: \(userInfo)")
        if isSmartechInitialized {
            SmartPush.sharedInstance().didReceive(response)
        }
        completionHandler()

        super.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }

    func handleDeeplinkAction(withURLString deeplinkURLString: String, andNotificationPayload notificationPayload: [AnyHashable : Any]?) {
        NSLog("SMTL deeplink Native---> \(deeplinkURLString)")
        SmartechBasePlugin.handleDeeplinkAction(
            deeplinkURLString,
            andCustomPayload: notificationPayload as? [AnyHashable: Any]
        )
    }

    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        return handleOpenURL(url, options: options)
    }
}

// MARK: - Firebase Messaging Delegate
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")

        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
}
