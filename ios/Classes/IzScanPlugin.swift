import Flutter
import UIKit
import CardScan

public class IzScanPlugin: NSObject, FlutterPlugin, SimpleScanDelegate {
    
    private var scanResult: FlutterResult?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "iz_scan", binaryMessenger: registrar.messenger())
        let instance = IzScanPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "configureCardScan":
            if let arguments = call.arguments as? [String: Any], let apiKey = arguments["apiKey"] as? String {
                configureCardScan(apiKey: apiKey)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments", details: nil))
            }
        case "startCardScan":
            startCardScan(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func configureCardScan(apiKey: String) {
        ScanViewController.configure(apiKey: apiKey)
    }

    private func startCardScan(result: @escaping FlutterResult) {
        print("LET SCANNING...");
        scanResult = result

        guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else {
            return
        }

        let vc = CustomSimpleScanViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self

        rootViewController.present(vc, animated: true)
    }

    // MARK: - SimpleScanDelegate methods
    
    public func userDidCancelSimple(_ scanViewController: SimpleScanViewController) {
        scanViewController.dismiss(animated: true)
        scanResult?(nil)
    }
    
    public func userDidScanCardSimple(_ scanViewController: SimpleScanViewController, creditCard: CreditCard) {
        let number = creditCard.number
        let expiryMonth = creditCard.expiryMonth
        let expiryYear = creditCard.expiryYear
        let cardholderName = creditCard.name

        let cardInfo = [
            "number": number,
            "expiryDate": expiryYear,
            "expiryMonth": expiryMonth,
            "cardholderName": cardholderName,
        ]

        scanResult?(cardInfo)
        scanViewController.dismiss(animated: true)
    }
}


