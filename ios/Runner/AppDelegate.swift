import UIKit
import Flutter
#import "GoogleMaps/GoogleMaps.h"

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    [GMSServices provideAPIKey:@"AIzaSyDFD7ZX1tgUoxpvIJjVButgXS6VSXlSfM4"];
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
