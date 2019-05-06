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
    @IBOutlet weak var paymentPluginSwitch: UISwitch!
    @IBOutlet weak var viewControllerSwitch: UISwitch!
    @IBOutlet weak var comisionesSwitch: UISwitch!
    @IBOutlet weak var accessTokenSwitch: UISwitch!
    @IBOutlet weak var businessSwitch: UISwitch!
    @IBOutlet weak var statusDetailButton: UIButton!
    @IBOutlet weak var customizationSwitch: UISwitch!
    @IBOutlet weak var openPrefSwitch: UISwitch!
    @IBOutlet weak var businessSegment: UISegmentedControl!

    @IBOutlet weak var advancedConfigSwitch: UISwitch!
    @IBOutlet weak var oneTapSwitch: UISwitch!
    @IBOutlet weak var splitSwitch: UISwitch!
    @IBOutlet weak var escSwitch: UISwitch!
    @IBOutlet weak var discountParamsSwitch: UISwitch!

    @IBOutlet weak var payerInfoSwitch: UISwitch!
    @IBOutlet weak var exclusionsSwitch: UISwitch!
    @IBOutlet weak var maxInstallmentsSwitch: UISwitch!
    @IBOutlet weak var defaultInstallmentsSwitch: UISwitch!
    @IBOutlet weak var localizedTextsSwitch: UISwitch!
    @IBOutlet weak var addCardFlowSkipCongrats: UISwitch!
    @IBOutlet weak var countrySegment: UISegmentedControl!

    var statusDetailText: String = "cc_rejected_call_for_authorize"
    
    var delegate: ConfigurationManager?
    var currentPreferenceContext: PreferenceContext = .mla

    override func viewDidLoad() {
        super.viewDidLoad()
        countrySegment.accessibilityIdentifier = "country_segment"
        businessSegment.accessibilityIdentifier = "business_segment"

        self.businessSegment.isEnabled = false
        self.customizationSwitch.isEnabled = false
        self.validatePaymentPluginSwitches()
        self.validateAddCardFlowSwitches()
        self.validateAdvancedConfigSwitches()
        updateBusinessSegmentColor()
        resizeSwitches()
    }

    @IBAction func customizeStatusDetail(_ sender: Any) {
        let alert = UIAlertController(title: "Status detail", message: "Escribe el status detail asociado al resultado de pago", preferredStyle: UIAlertControllerStyle.alert)

        alert.addTextField(configurationHandler: configurationTextField)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in

            if let textField = alert.textFields!.first,
                let text = textField.text {
                self.statusDetailText = text
            }
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }

    func configurationTextField(textField: UITextField!){
        textField.text = ""
        textField.placeholder = "cc_rejected_call_for_authorize"
    }

    func resizeSwitches() {
        let newScale = CGAffineTransform(scaleX: 0.75, y: 0.75)
        comisionesSwitch.transform = newScale
        customizationSwitch.transform = newScale
        paymentPluginSwitch.transform = newScale
        businessSwitch.transform = newScale
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
        exclusionsSwitch.transform = newScale
        maxInstallmentsSwitch.transform = newScale
        defaultInstallmentsSwitch.transform = newScale
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
        statusDetailButton.isEnabled = !self.businessSwitch.isOn &&  self.paymentPluginSwitch.isOn
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
        statusDetailButton.isEnabled = !self.businessSwitch.isOn &&  self.paymentPluginSwitch.isOn
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

    @IBAction func countrySegmentPressed(_ sender: Any) {
        if countrySegment.selectedSegmentIndex == 3 {
            showAllOptions()
        }
    }

    func showAllOptions() {
        let alert = UIAlertController(title: "Otro preset", message: "Elige un preset de pref_id, public key y access token entre las opciones disponibles.", preferredStyle: .actionSheet)

        var cases = PreferenceContext.allCases
        cases.remove(at: 0)
        cases.remove(at: 0)
        cases.remove(at: 0)
        for option in cases {
            alert.addAction(UIAlertAction(title: option.getContextDescription(),
                                          style: .default,
                                          handler: { _ in
                self.currentPreferenceContext = option
            }))
        }

        alert.addAction(UIAlertAction(title: "Cancelar",
                                      style: .cancel,
                                      handler: { _ in
                                        self.currentPreferenceContext = .mla
                                        self.countrySegment.selectedSegmentIndex = 0
        }))

        self.present(alert, animated: true)
    }

    func action(action: UIAlertAction) {
        print(action.title ?? "no action")
    }
    
    @IBAction func applyAndConfirm(_ sender: Any) {
        let configs = Configurations(
            comisiones: comisionesSwitch.isOn,
            descuento: true,
            fullCustomization: customizationSwitch.isOn,
            paymentPlugin: paymentPluginSwitch.isOn,
            paymentPluginViewController: viewControllerSwitch.isOn,
            businessResult: businessSwitch.isOn,
            maxRedeemPerUser: 0,
            skipCongrats: addCardFlowSkipCongrats.isOn,
            accessToken: accessTokenSwitch.isOn,
            oneTap: oneTapSwitch.isOn,
            advancedConfiguration: advancedConfigSwitch.isOn,
            splitPayment: splitSwitch.isOn,
            payerInfo: payerInfoSwitch.isOn,
            exclusions: exclusionsSwitch.isOn,
            maxInstallments: maxInstallmentsSwitch.isOn,
            defaultInstallments: defaultInstallmentsSwitch.isOn,
            localizedTexts: localizedTextsSwitch.isOn,
            openPreference: openPrefSwitch.isOn,
            escEnabled: escSwitch.isOn,
            discountParams: discountParamsSwitch.isOn,
            preferenceContext: preferenceContext() ?? .mla,
            businessStatus: businessStatus() ?? .APPROVED,
            statusDetail: self.statusDetailText)

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
        default:
            return self.currentPreferenceContext
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
