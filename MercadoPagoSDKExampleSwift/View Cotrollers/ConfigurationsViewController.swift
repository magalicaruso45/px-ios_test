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
    var delegate: ConfigurationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func applyAndConfirm(_ sender: Any) {
        let configs = Configurations(comisiones: comisionesSwitch.isOn, descuento: descuentoSwitch.isOn, tope: topeSwitch.isOn, paymentPlugin: paymentPluginSwitch.isOn)
        if let delegate = delegate {
            delegate.setConfigurations(configs: configs)
        }
        self.dismiss(animated: true)
    }
    
}
