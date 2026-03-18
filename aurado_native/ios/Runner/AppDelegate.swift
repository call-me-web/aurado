import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  
  private var secureTextField: UITextField?
  private var isSecureModeEnabled = false
  private var blurEffectView: UIVisualEffectView?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let securityChannel = FlutterMethodChannel(name: "com.aurado/security",
                                              binaryMessenger: controller.binaryMessenger)
    
    securityChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard let self = self else { return }
      
      switch call.method {
      case "enableSecureMode":
        self.isSecureModeEnabled = true
        self.setupSecureTextField()
        self.updateSecureState() // Handle immediate blur if already recording
        result(nil)
      case "disableSecureMode":
        self.isSecureModeEnabled = false
        self.removeSecureTextField()
        self.updateSecureState()
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    
    // Observers for screen recording and screenshots
    NotificationCenter.default.addObserver(self, selector: #selector(handleScreenCaptureChange), name: UIScreen.capturedDidChangeNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleScreenshot), name: UIApplication.userDidTakeScreenshotNotification, object: nil)

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }

  // MARK: - UITextField Hack for Screenshots
  private func setupSecureTextField() {
    guard let window = self.window else { return }
    
    if secureTextField == nil {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(field)
        
        field.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        field.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        
        // The core trick: Add the root Flutter view layer to the UITextField's secure layer
        if let root = window.rootViewController?.view, let secureLayer = field.layer.sublayers?.first {
            secureLayer.addSublayer(root.layer)
        }
        
        secureTextField = field
    }
  }

  private func removeSecureTextField() {
    guard let window = self.window, let root = window.rootViewController?.view else { return }
    
    // Restore the root layer to the main window
    window.layer.addSublayer(root.layer)
    
    secureTextField?.removeFromSuperview()
    secureTextField = nil
  }

  // MARK: - Screen Recording Detection (Fallback & Warning)
  @objc private func handleScreenCaptureChange() {
    updateSecureState()
  }
  
  @objc private func handleScreenshot() {
    // Screenshot captured. The system will blackout the image thanks to isSecureTextEntry.
    // This hook is primarily for logging if needed.
    print("Screenshot Attempt Detected")
  }
  
  private func updateSecureState() {
    let isCaptured = UIScreen.main.isCaptured
    
    DispatchQueue.main.async {
        if self.isSecureModeEnabled && isCaptured {
            self.showBlurOverlay()
        } else {
            self.hideBlurOverlay()
        }
    }
  }
  
  private func showBlurOverlay() {
    guard blurEffectView == nil, let window = self.window else { return }
    let blurEffect = UIBlurEffect(style: .dark)
    let bView = UIVisualEffectView(effect: blurEffect)
    bView.frame = window.bounds
    bView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    let label = UILabel()
    label.text = "Screen Recording Detected\nPlease stop recording to view content."
    label.textColor = .white
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    bView.contentView.addSubview(label)
    
    NSLayoutConstraint.activate([
        label.centerXAnchor.constraint(equalTo: bView.centerXAnchor),
        label.centerYAnchor.constraint(equalTo: bView.centerYAnchor),
        label.leadingAnchor.constraint(equalTo: bView.leadingAnchor, constant: 20),
        label.trailingAnchor.constraint(equalTo: bView.trailingAnchor, constant: -20)
    ])
    
    window.addSubview(bView)
    blurEffectView = bView
  }
  
  private func hideBlurOverlay() {
    blurEffectView?.removeFromSuperview()
    blurEffectView = nil
  }
}
