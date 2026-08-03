import UIKit
import Flutter

class SceneDelegate: FlutterSceneDelegate {

    override func scene(_ scene: UIScene,
                        willConnectTo session: UISceneSession,
                        options connectionOptions: UIScene.ConnectionOptions) {

        super.scene(scene, willConnectTo: session, options: connectionOptions)

        if let urlContext = connectionOptions.urlContexts.first {
            let url = urlContext.url
            print("Scene willConnect URL: \(url.absoluteString)")
            routeOpenURL(url)
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
        routeOpenURL(url)
    }

    private func routeOpenURL(_ url: URL) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        _ = appDelegate.handleOpenURL(url, options: [:])
    }
}
