import UIKit
import Flutter
import Smartech

class SceneDelegate: FlutterSceneDelegate {

    override func scene(_ scene: UIScene,
                        willConnectTo session: UISceneSession,
                        options connectionOptions: UIScene.ConnectionOptions) {

        super.scene(scene, willConnectTo: session, options: connectionOptions)

        if let urlContext = connectionOptions.urlContexts.first {
            let url = urlContext.url

            print("Scene willConnect URL: \(url.absoluteString)")

            let handled = Smartech.sharedInstance().application(
                UIApplication.shared,
                open: url,
                options: [:]
            )

            if !handled {
                // Handle by your app if needed
            }
        }
    }

    override func scene(_ scene: UIScene,
                        openURLContexts URLContexts: Set<UIOpenURLContext>) {

        super.scene(scene, openURLContexts: URLContexts)

        guard let urlContext = URLContexts.first else {
            return
        }

        let url = urlContext.url

        print("Scene openURL: \(url.absoluteString)")

        let handled = Smartech.sharedInstance().application(
            UIApplication.shared,
            open: url,
            options: [:]
        )

        if !handled {
            // Handle by your app if needed
        }
    }
}
