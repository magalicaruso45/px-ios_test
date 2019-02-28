//
//  ConfigurationsViewController.swift
//  MercadoPagoSDKExampleSwift
//
//  Created by Demian Tejo on 11/7/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import UIKit

protocol ConfigurationManager {
    func setConfigurations(configs: Configurations)
}

class ConfigurationsViewController: UIViewController {
    @IBOutlet weak var comisionesSwitch: UISwitch!
    @IBOutlet weak var descuentoSwitch: UISwitch!
    @IBOutlet weak var topeSwitch: UISwitch!
    @IBOutlet weak var paymentPluginSwitch: UISwitch!
    @IBOutlet weak var discountNotAvailableSwitch: UISwitch!
    @IBOutlet weak var maxRedeemPerUserStepper: UIStepper!
    @IBOutlet weak var secondFactorSwitch: UISwitch!
    @IBOutlet weak var accountMoneySwitch: UISwitch!
    @IBOutlet weak var viewControllerSwitch: UISwitch!
    @IBOutlet weak var payerInfoSwitch: UISwitch!
    @IBOutlet weak var maxRedeemPerUserLabel: UILabel!
    @IBOutlet weak var localizedTextsSwitch: UISwitch!
    @IBOutlet weak var countrySegment: UISegmentedControl!
    
    var delegate: ConfigurationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        maxRedeemPerUserStepper.accessibilityIdentifier = "max_redeem_per_user_stepper"

        let frame = CGRect(x: -maxRedeemPerUserStepper.frame.midX, y: maxRedeemPerUserStepper.frame.midY, width: 2, height: 2)
        let view = UIView(frame: frame)
        view.backgroundColor = .red
        self.view.addSubview(view)
    }

    @IBAction func stepperValueChanges(_ sender: Any) {
        maxRedeemPerUserLabel.text = String(describing: Int(exactly: maxRedeemPerUserStepper.value))
    }

    @IBAction func applyAndConfirm(_ sender: Any) {
        let configs = Configurations(comisiones: comisionesSwitch.isOn, descuento: descuentoSwitch.isOn, tope: topeSwitch.isOn, paymentPlugin: paymentPluginSwitch.isOn, paymentPluginViewController: viewControllerSwitch.isOn, discountNotAvailable: discountNotAvailableSwitch.isOn, maxRedeemPerUser: maxRedeemPerUserStepper.value, accountMoney: accountMoneySwitch.isOn, secondFactor: secondFactorSwitch.isOn, payerInfo: payerInfoSwitch.isOn, localizedTexts: localizedTextsSwitch.isOn, countryContext: countryContext() ?? .mla)

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
}
