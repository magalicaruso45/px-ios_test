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
    @IBOutlet weak var maxRedeemPerUserLabel: UILabel!
    var delegate: ConfigurationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maxRedeemPerUserStepper.accessibilityIdentifier = "max_redeem_per_user_stepper"

        let frame = CGRect(x: -maxRedeemPerUserStepper.frame.midX, y: maxRedeemPerUserStepper.frame.midY, width: 2, height: 2)
        let view = UIView(frame: frame)
        view.backgroundColor = .red
        self.view.addSubview(view)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepperValueChanges(_ sender: Any) {
        maxRedeemPerUserLabel.text = String(describing: Int(exactly: maxRedeemPerUserStepper.value))
    }

    @IBAction func applyAndConfirm(_ sender: Any) {
        let configs = Configurations(comisiones: comisionesSwitch.isOn, descuento: descuentoSwitch.isOn, tope: topeSwitch.isOn, paymentPlugin: paymentPluginSwitch.isOn, discountNotAvailable: discountNotAvailableSwitch.isOn, maxRedeemPerUser: maxRedeemPerUserStepper.value)
        if let delegate = delegate {
            delegate.setConfigurations(configs: configs)
        }
        self.dismiss(animated: true)
    }
    
}
