import UserNotifications
import SmartPush
import Smartech


class NotificationService: UNNotificationServiceExtension {
  
  let smartechServiceExtension = SMTNotificationServiceExtension()
    
  
  override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
  
      let config = SmartechConfig.sharedInstance()

      // App IDs can be set programmatically to avoid Info.plist level configuration (which may compromise security)
      config.appGroup = "group.com.netcore.SmartechApp"
      config.smartechAppId = "cdd5abdf5d9441b21b0f9e6223a4ed7a"


      // Apply the complete Smartech configuration before initializing the SDK
      Smartech.sharedInstance().setSmartechConfig(config)
     
      
  if SmartPush.sharedInstance().isNotification(fromSmartech:request.content.userInfo){
      smartechServiceExtension.didReceive(request, withContentHandler: contentHandler)
    }
    //...
  }
  
  override func serviceExtensionTimeWillExpire() {
    //...
    smartechServiceExtension.serviceExtensionTimeWillExpire()
    //...
  }
}
