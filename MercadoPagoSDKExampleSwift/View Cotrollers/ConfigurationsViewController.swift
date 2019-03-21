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
    @IBOutlet weak var oneTapSwitch: UISwitch!
    @IBOutlet weak var splitSwitch: UISwitch!
    @IBOutlet weak var addCardFlowSkipCongrats: UISwitch!
    @IBOutlet weak var escSwitch: UISwitch!
    @IBOutlet weak var discountParamsSwitch: UISwitch!
    @IBOutlet weak var openPrefSwitch: UISwitch!
    
    var delegate: ConfigurationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        maxRedeemPerUserStepper.accessibilityIdentifier = "max_redeem_per_user_stepper"
        countrySegment.accessibilityIdentifier = "country_segment"
        businessSegment.accessibilityIdentifier = "business_segment"
        
        let frame = CGRect(x: -maxRedeemPerUserStepper.frame.midX, y: maxRedeemPerUserStepper.frame.midY, width: 2, height: 2)
        let view = UIView(frame: frame)
        view.backgroundColor = .red
        self.view.addSubview(view)
        self.businessSegment.isEnabled = false
        self.customizationSwitch.isEnabled = false
        self.validatePaymentPluginSwitches()
        self.validateAddCardFlowSwitches()
        self.validateAdvancedConfigSwitches()
        updateBusinessSegmentColor()
        resizeSwitches()
    }
    
    func resizeSwitches() {
        let newScale = CGAffineTransform(scaleX: 0.75, y: 0.75)
        comisionesSwitch.transform = newScale
        customizationSwitch.transform = newScale
        paymentPluginSwitch.transform = newScale
        businessSwitch.transform = newScale
        maxRedeemPerUserStepper.transform = newScale
        accessTokenSwitch.transform = newScale
        viewControllerSwitch.transform = newScale
        payerInfoSwitch.transform = newScale
        advancedConfigSwitch.transform = newScale
        localizedTextsSwitch.transform = newScale
        oneTapSwitch.transform = newScale
        splitSwitch.transform = newScale
        addCardFlowSkipCongrats.transform = newScale
        escSwitch.transform = newScale
        discountParamsSwitch.transform = newScale
        openPrefSwitch.transform = newScale
    }

    @IBAction func stepperValueChanges(_ sender: Any) {
        maxRedeemPerUserLabel.text = String(describing: Int(exactly: maxRedeemPerUserStepper.value))
    }
    @IBAction func paymentPluginChanged(_ sender: Any) {
        self.validatePaymentPluginSwitches()
    }
    @IBAction func openPrefChanged(_ sender: Any) {
        self.payerInfoSwitch.isOn = false
        self.payerInfoSwitch.isEnabled = self.openPrefSwitch.isOn
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
        self.openPrefSwitch.isEnabled = false
        self.oneTapSwitch.isOn = false
        self.openPrefSwitch.isOn = false
        self.payerInfoSwitch.isOn = false
        self.payerInfoSwitch.isEnabled = false
        self.oneTapSwitch.isEnabled = false
        self.viewControllerSwitch.isEnabled = enableSwitchs
        self.accessTokenSwitch.isEnabled = enableSwitchs
        self.comisionesSwitch.isEnabled = enableSwitchs
        self.businessSwitch.isEnabled = enableSwitchs
        self.openPrefSwitch.isEnabled = enableSwitchs
        self.updateBusinessSegmentColor()
        self.validateAdvancedConfigSwitches()
    }
    
    func validateAddCardFlowSwitches() {
        self.addCardFlowSkipCongrats.isOn = false
    }
    
    @IBAction func advancedConfigChanged(_ sender: Any) {
        self.validateAdvancedConfigSwitches()
    }
    
    func validateAdvancedConfigSwitches() {
        self.oneTapSwitch.isOn = false
        self.splitSwitch.isOn = false
        self.escSwitch.isOn = false
        self.discountParamsSwitch.isOn = false
        let enableSwitchs = self.advancedConfigSwitch.isOn
        self.escSwitch.isEnabled = enableSwitchs
        self.discountParamsSwitch.isEnabled = enableSwitchs
        self.splitSwitch.isEnabled = false
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
        let configs = Configurations(
            comisiones: comisionesSwitch.isOn,
            descuento: true,
            fullCustomization: customizationSwitch.isOn,
            paymentPlugin: paymentPluginSwitch.isOn,
            paymentPluginViewController: viewControllerSwitch.isOn,
            businessResult: businessSwitch.isOn,
            maxRedeemPerUser: maxRedeemPerUserStepper.value,
            skipCongrats: addCardFlowSkipCongrats.isOn,
            accessToken: accessTokenSwitch.isOn,
            oneTap: oneTapSwitch.isOn,
            advancedConfiguration: advancedConfigSwitch.isOn,
            splitPayment: splitSwitch.isOn,
            payerInfo: payerInfoSwitch.isOn,
            localizedTexts: localizedTextsSwitch.isOn,
            openPreference: openPrefSwitch.isOn,
            escEnabled: escSwitch.isOn,
            discountParams: discountParamsSwitch.isOn,
            preferenceContext: preferenceContext() ?? .mla,
            businessStatus: businessStatus() ?? .APPROVED)

        if let delegate = delegate {
            delegate.setConfigurations(configs: configs)
        }

        self.dismiss(animated: true)
    }
    
    func preferenceContext() -> PreferenceContext? {
        switch self.countrySegment.selectedSegmentIndex {
        case 0:
            return .mla
        case 1:
            return .mlb
        case 2:
            return .mlm
        case 3:
            return .discountAlwaysOn
        case 4:
            return .discountSoldOut
        case 5:
            return .discountByPaymentMethod
        case 6:
            return .discountByIssuer
        case 7:
            return .discountForAM
        case 8:
            return .boleto
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
