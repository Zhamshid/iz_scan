//
//  ViewController.swift
//  Runner
//
//  Created by Zhamshid Irisbayev on 18.11.2023.
//

import Foundation
import CardScan
import UIKit

class ViewController: UIViewController {
    
    
    @objc private func onClickAction(){
      
        let simpleScanVC = CustomSimpleScanViewController()
        simpleScanVC.delegate = self
        present(simpleScanVC, animated: true, completion: nil)
    }

    
    
    let actionButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading....")
    
        view.backgroundColor = .white
        actionButton.setTitle("TEST", for: .normal)
        actionButton.backgroundColor = .black
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.addTarget(self, action: #selector(onClickAction), for: .touchUpInside)
    
        var layoutConstraints = [NSLayoutConstraint]()
    
    
        self.view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
         layoutConstraints += [
                 actionButton.heightAnchor.constraint(equalToConstant: 48),
                 actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                 actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ]
    
                NSLayoutConstraint.activate(layoutConstraints)
    
    
    
    }


    @IBAction func customSimpleScanButtonPress(_ sender: Any) {
        let simpleScanVC = CustomSimpleScanViewController()
        simpleScanVC.delegate = self
        present(simpleScanVC, animated: true, completion: nil)
    }
    
    @IBAction func customScanViewButtonPress(_ sender: Any) {
        guard let scanVC = ScanViewController.createViewController(withDelegate: self) else {
            return
        }
        
        scanVC.stringDataSource = self
        
        scanVC.backButtonColor = UIColor.red
        scanVC.hideBackButtonImage = true
        scanVC.backButtonImageToTextDelta = 8.0
        
        scanVC.backButtonFont = UIFont(name: "Verdana", size: CGFloat(17.0))
        scanVC.scanCardFont = UIFont(name: "Chalkduster", size: CGFloat(24.0))
        scanVC.positionCardFont = UIFont(name: "Chalkduster", size: CGFloat(17.0))
        scanVC.skipButtonFont = UIFont(name: "Chalkduster", size: CGFloat(17.0))
        scanVC.cornerColor = UIColor.blue
        
        scanVC.torchButtonImage = ScanViewController.cameraImage()
        scanVC.torchButtonSize = CGSize(width: 44, height: 44)
        present(scanVC, animated: true, completion: nil)
    }
}

// MARK: SimpleScanViewController Delegate
extension ViewController: SimpleScanDelegate {
    func userDidCancelSimple(_ scanViewController: SimpleScanViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func userDidScanCardSimple(_ scanViewController: SimpleScanViewController, creditCard: CreditCard) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: ScanViewController Delegates
extension ViewController: ScanDelegate, FullScanStringsDataSource {
    // MARK: - Scan Delegate Logic
    func userDidCancel(_ scanViewController: ScanViewController) {
        dismiss(animated: true, completion: nil )
    }
    
    func userDidScanCard(_ scanViewController: ScanViewController, creditCard: CreditCard) {
        dismiss(animated: true, completion: nil)
    }
    
    func userDidSkip(_ scanViewController: ScanViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - ScanViewController: Full Scan String Data Source Logic
    func scanCard() -> String { return "New Scan Card" }
    func positionCard() -> String { return "New Position Card" }
    func backButton() -> String { return "New Back" }
    func skipButton() -> String { return "New Skip" }
    func denyPermissionTitle() -> String { return "New Deny" }
    func denyPermissionMessage() -> String { return "New Deny Message" }
    func denyPermissionButton() -> String { return "GO" }
}



