//
//  ConfigurationsViewController.swift
//  MercadoPagoSDKExampleSwift
//
//  Created by Demian Tejo on 11/7/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import UIKit
import MercadoPagoSDKV4

protocol ConfigurationManager {
    func setConfigurations(configs: Configurations)
}

class ConfigurationsViewController: UIViewController {
    @IBOutlet weak var comisionesSwitch: UISwitch!
    @IBOutlet weak var descuentoSwitch: UISwitch!

    @IBOutlet weak var customizationSwitch: UISwitch!
    @IBOutlet weak var paymentPluginSwitch: UISwitch!
    @IBOutlet weak var businessSwitch: UISwitch!
    @IBOutlet weak var maxRedeemPerUserStepper: UIStepper!
    @IBOutlet weak var accessTokenSwitch: UISwitch!
    @IBOutlet weak var viewControllerSwitch: UISwitch!
    @IBOutlet weak var payerInfoSwitch: UISwitch!
    @IBOutlet weak var advancedConfigSwitch: UISwitch!
    @IBOutlet weak var maxRedeemPerUserLabel: UILabel!
    @IBOutlet weak var localizedTextsSwitch: UISwitch!
    @IBOutlet weak var countrySegment: UISegmentedControl!
    @IBOutlet weak var businessSegment: UISegmentedControl!
    @IBOutlet weak var preferenceSegment: UISegmentedControl!
    @IBOutlet weak var oneTapSwitch: UISwitch!
    @IBOutlet weak var splitSwitch: UISwitch!
    @IBOutlet weak var AddCardFlowSkipCongrats: UISwitch!
    
    var delegate: ConfigurationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        maxRedeemPerUserStepper.accessibilityIdentifier = "max_redeem_per_user_stepper"
        countrySegment.accessibilityIdentifier = "country_segment"
        businessSegment.accessibilityIdentifier = "business_segment"
        preferenceSegment.accessibilityIdentifier = "preference_segment"

        let frame = CGRect(x: -maxRedeemPerUserStepper.frame.midX, y: maxRedeemPerUserStepper.frame.midY, width: 2, height: 2)
        let view = UIView(frame: frame)
        view.backgroundColor = .red
        self.view.addSubview(view)
        self.businessSegment.isEnabled = false
        self.customizationSwitch.isEnabled = false
        self.validatePaymentPluginSwitches()
        self.validateAdvancedConfigSwitches()
        updateBusinessSegmentColor()
    }

    @IBAction func stepperValueChanges(_ sender: Any) {
        maxRedeemPerUserLabel.text = String(describing: Int(exactly: maxRedeemPerUserStepper.value))
    }
    @IBAction func paymentPluginChanged(_ sender: Any) {
        self.validatePaymentPluginSwitches()
    }
    
    func validatePaymentPluginSwitches() {
        let enableSwitchs = self.paymentPluginSwitch.isOn
        self.viewControllerSwitch.isOn = false
        self.customizationSwitch.isOn = false
        self.comisionesSwitch.isOn = false
        self.accessTokenSwitch.isOn = false
        self.businessSwitch.isOn = false
        self.businessSegment.isEnabled = false
        self.customizationSwitch.isEnabled = false
        self.oneTapSwitch.isOn = false
        self.oneTapSwitch.isEnabled = false
        self.viewControllerSwitch.isEnabled = enableSwitchs
        self.accessTokenSwitch.isEnabled = enableSwitchs
        self.comisionesSwitch.isEnabled = enableSwitchs
        self.businessSwitch.isEnabled = enableSwitchs
        self.updateBusinessSegmentColor()
        self.validateAdvancedConfigSwitches()
    }
    
    @IBAction func advancedConfigChanged(_ sender: Any) {
        self.validateAdvancedConfigSwitches()
    }
    
    func validateAdvancedConfigSwitches() {
        self.oneTapSwitch.isOn = false
        self.splitSwitch.isOn = false
        self.splitSwitch.isEnabled = false
//        let enableSwitchs = self.advancedConfigSwitch.isOn
        self.oneTapSwitch.isEnabled = self.advancedConfigSwitch.isOn && self.accessTokenSwitch.isOn && self.paymentPluginSwitch.isOn
    }
    
    @IBAction func businessStateChanged(_ sender: Any) {
        self.businessSegment.isEnabled = self.businessSwitch.isOn
        self.customizationSwitch.isEnabled = self.businessSwitch.isOn
        if !self.customizationSwitch.isEnabled {
            self.customizationSwitch.isOn = false
        }
        updateBusinessSegmentColor()
    }
    @IBAction func accessTokenStateChanged(_ sender: Any) {
        self.validateAdvancedConfigSwitches()
    }
    @IBAction func oneTapStateChanged(_ sender: Any) {
        self.splitSwitch.isEnabled = self.oneTapSwitch.isOn
        self.splitSwitch.isOn = false
    }
    
    func updateBusinessSegmentColor() {
        if !self.customizationSwitch.isEnabled {
            self.businessSegment.tintColor = UIColor.gray
            return
        }
        
        switch self.businessSegment.selectedSegmentIndex {
        case 0:
            self.businessSegment.tintColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
            break
        case 1:
            self.businessSegment.tintColor = UIColor.orange
            break
        case 2:
            self.businessSegment.tintColor = UIColor.red
            break
        default:
            break
        }
    }
    
    @IBAction func businessSegmentPressed(_ sender: Any) {
        updateBusinessSegmentColor()
    }
    
    @IBAction func applyAndConfirm(_ sender: Any) {
        let configs = Configurations(comisiones: comisionesSwitch.isOn, descuento: descuentoSwitch.isOn, fullCustomization: customizationSwitch.isOn, paymentPlugin: paymentPluginSwitch.isOn, paymentPluginViewController: viewControllerSwitch.isOn, businessResult: businessSwitch.isOn, maxRedeemPerUser: maxRedeemPerUserStepper.value, accessToken: accessTokenSwitch.isOn, oneTap: oneTapSwitch.isOn, advancedConfiguration: advancedConfigSwitch.isOn, splitPayment: splitSwitch.isOn, payerInfo: payerInfoSwitch.isOn, localizedTexts: localizedTextsSwitch.isOn, countryContext: countryContext() ?? .mla, businessStatus: businessStatus() ?? .APPROVED)

        if let delegate = delegate {
            delegate.setConfigurations(configs: configs)
        }

        self.dismiss(animated: true)
    }
    
    func countryContext() -> CountryContext? {
        switch self.countrySegment.selectedSegmentIndex {
        case 0:
            return .mla
        case 1:
            return .mlb
        case 2:
            return .mlm
        default:
            return nil
        }
    }
    
    func businessStatus() -> PXBusinessResultStatus? {
        switch self.businessSegment.selectedSegmentIndex {
        case 0:
            return .APPROVED
        case 1:
            return .PENDING
        case 2:
            return .REJECTED
        default:
            return nil
        }
    }
}
