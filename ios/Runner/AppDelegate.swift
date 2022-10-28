import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      EncryptorForFlutter.register(with: self.registrar(forPlugin: "EncryptorForFlutter")!);
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class CustomFlutterViewController: FlutterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "io.flutter.plugin.platform.SystemChromeOverlayNotificationName"), object: nil, userInfo: ["io.flutter.plugin.platform.SystemChromeOverlayNotificationKey":1])
    }
}
