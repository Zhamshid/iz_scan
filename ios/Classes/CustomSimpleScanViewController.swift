//
//  CustomSimpleScanViewController.swift
//  Runner
//
//  Created by Zhamshid Irisbayev on 17.11.2023.
//

import CardScan
import Foundation
import UIKit

class CustomSimpleScanViewController: SimpleScanViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
    }
    
    //MARK: -- Background UI --
    override public func setupBlurViewUi() {
        super.setupBlurViewUi()
        blurView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
    }
    

    
    // MARK: -- ROI UI --
    override public func setupRoiViewUi() {
        super.setupRoiViewUi()
        regionOfInterestCornerRadius = 10.0
           
        
        
    }
    
  
    
    // MARK: -- Description UI --
    override public func setupDescriptionTextUi() {
        super.setupDescriptionTextUi()
        

        descriptionText.text = "Point the camera at the card number. The photo will be taken automatically"
        descriptionText.font = UIFont.systemFont(ofSize: 14.0)
        descriptionText.textColor = .white
        descriptionText.backgroundColor = .black
        descriptionText.layer.cornerRadius = 4
        descriptionText.numberOfLines = 0
        descriptionText.layer.masksToBounds = true
        descriptionText.layer.borderWidth = 2
       
    
        
    }
    
    // MARK: -- Close UI --
    override public func setupCloseButtonUi() {
        super.setupCloseButtonUi()
        closeButton.setTitle("", for: .normal)
        closeButton.setImage(UIImage(named: "arrow_back_close"), for: .normal)
//        closeButton.setImage(UIImage(named: "back_arrow"), for: .normal)
    }
    
    // MARK: -- Torch UI --
    override public func setupTorchButtonUi() {
        super.setupTorchButtonUi()
        torchButton.setTitle("", for: .normal)
        torchButton.setImage(UIImage(named: "flash_on"), for: .normal)
    }
    
    override func torchButtonPress() {
        super.torchButtonPress()
        
        if isTorchOn() {
             torchButton.setTitle("", for: .normal)
            torchButton.setImage(UIImage(named: "flash_off"), for: .normal)
        } else {
            torchButton.setTitle("", for: .normal)
            torchButton.setImage(UIImage(named: "flash_on"), for: .normal)
        }
    }
    
    // MARK: -- Permissions UI --
    override public func setupDenyUi() {
        super.setupDenyUi()
        let text = "Allow scanning access"
        let font = UIFont.systemFont(ofSize: 20.0)
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.white, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: text.count))

        enableCameraPermissionsButton.setAttributedTitle(attributedString, for: .normal)
        
        enableCameraPermissionsText.text = "You have denied access to the camera. We use it to scan cards. Allow scanning access in settings."
        enableCameraPermissionsText.textColor = UIColor.white
        enableCameraPermissionsText.textAlignment = .center
    }
    
    //MARK: -- Card Detail UI --
    override public func setupCardDetailsUi() {
        super.setupCardDetailsUi()
        numberText.textColor = UIColor.white
        expiryText.textColor = UIColor.white
        nameText.textColor = UIColor.white
    }
}




