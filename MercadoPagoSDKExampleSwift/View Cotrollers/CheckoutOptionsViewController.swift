//
//  CheckoutOptionsViewController.swift
//  MercadoPagoSDKExampleSwift
//
//  Created by AUGUSTO COLLERONE ALFONSO on 19/4/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import UIKit
import MercadoPagoSDKV4
import MercadoPagoServicesV4

class CheckoutOptionsViewController: UIViewController, ConfigurationManager {

    var configurations: Configurations?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func startCheckout(publicKey: String, prefId: String, accessToken: String? = nil) {
        let checkoutPreference = CheckoutPreference(preferenceId: prefId)
        let at: String = accessToken != nil ? accessToken! : ""
        if let navigationController = self.navigationController {
            MercadoPagoCheckout.setLanguage(language: ._SPANISH)
            let mpCheckout = MercadoPagoCheckout(publicKey: publicKey, accessToken: at, checkoutPreference: checkoutPreference, discount: nil, navigationController: navigationController)
            if configurations != nil {
                applyConfigurations(checkout: mpCheckout)
            }
            mpCheckout.start()
        }
    }

    func setupUI() {
        //View
        self.title = "Checkout Configuration"
        self.view.backgroundColor = .white
        let topMargin = PXLayout.getSafeAreaTopInset() + 70

        //Public Key Input
        let publicKeyField: UITextField = createInputTextField(placeholder: "Public Key")
        PXLayout.centerHorizontally(view: publicKeyField).isActive = true
        PXLayout.pinTop(view: publicKeyField, withMargin: topMargin).isActive = true

        //Preference ID Input
        let preferenceIDField: UITextField = createInputTextField(placeholder: "Pref ID")
        PXLayout.put(view: preferenceIDField, onBottomOf: publicKeyField, withMargin: PXLayout.S_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: preferenceIDField).isActive = true

        //Access Token Input
        let accessTokenField: UITextField = createInputTextField(placeholder: "Access Token (Optional)")
        PXLayout.put(view: accessTokenField, onBottomOf: preferenceIDField, withMargin: PXLayout.S_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: accessTokenField).isActive = true

        //Start Button
        let startButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .gray
            button.setTitle("Start Checkout", for: .normal)
            button.layer.cornerRadius = 20
            button.setTitleColor(.white, for: .normal)
            button.add(for: .touchUpInside, {
                if let publicKey = publicKeyField.text, let prefId = preferenceIDField.text {
                    self.startCheckout(publicKey: publicKey, prefId: prefId, accessToken: accessTokenField.text)
                }
            })
            return button
        }()
        self.view.addSubview(startButton)
        PXLayout.put(view: startButton, onBottomOf: accessTokenField, withMargin: PXLayout.L_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: startButton).isActive = true
        PXLayout.setHeight(owner: startButton, height: 40).isActive = true
        PXLayout.setWidth(owner: startButton, width: 200).isActive = true

        //Clear Fields Button
        let clearFieldsButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .red
            button.setTitle("Clear fields", for: .normal)
            button.layer.cornerRadius = 20
            button.setTitleColor(.white, for: .normal)
            button.add(for: .touchUpInside, {
                publicKeyField.text = ""
                preferenceIDField.text = ""
                accessTokenField.text = ""
            })
            return button
        }()
        self.view.addSubview(clearFieldsButton)
        PXLayout.put(view: clearFieldsButton, onBottomOf: startButton, withMargin: PXLayout.M_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: clearFieldsButton).isActive = true
        PXLayout.setHeight(owner: clearFieldsButton, height: 40).isActive = true
        PXLayout.setWidth(owner: clearFieldsButton, width: 200).isActive = true
        
        //Clear Fields Button
        let additionalConfigButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .blue
            button.setTitle("Add Configutations", for: .normal)
            button.layer.cornerRadius = 20
            button.setTitleColor(.white, for: .normal)
            button.add(for: .touchUpInside, {
                self.additionalConfigs()
            })
            return button
        }()
        self.view.addSubview(additionalConfigButton)
        PXLayout.put(view: additionalConfigButton, onBottomOf: clearFieldsButton, withMargin: PXLayout.M_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: additionalConfigButton).isActive = true
        PXLayout.setHeight(owner: additionalConfigButton, height: 40).isActive = true
        PXLayout.setWidth(owner: additionalConfigButton, width: 200).isActive = true

        publicKeyField.text = "APP_USR-648a260d-6fd9-4ad7-9284-90f22262c18d"
        preferenceIDField.text = "243966003-d0be0be0-6fd8-4769-bf2f-7f2d979655f5"
        accessTokenField.text = ""
    }

    func createInputTextField(placeholder: String? = nil) -> UITextField {
        let textField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.placeholder = placeholder
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.cornerRadius = 5
            return textField
        }()
        self.view.addSubview(textField)
        PXLayout.setHeight(owner: textField, height: 40).isActive = true
        PXLayout.matchWidth(ofView: textField, withPercentage: 80).isActive = true
        return textField
    }
    
    func additionalConfigs(){
        let vc = ConfigurationsViewController()
        vc.delegate = self
        vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    func setConfigurations(configs: Configurations) {
        self.configurations = configs
    }
    func applyConfigurations(checkout: MercadoPagoCheckout){
        applyDiscountConfigurations(checkout: checkout)
        applyPaymentPluginConfigurations(checkout: checkout)
    }
}

//MARK: Configurations --
extension CheckoutOptionsViewController {
    func applyPaymentPluginConfigurations(checkout: MercadoPagoCheckout) {
        guard let configs = configurations else {
            return
        }
        if configs.paymentPlugin {
            let paymentPlugin = PaymentPluginViewController(nibName: nil, bundle: nil)
            checkout.setPaymentPlugin(paymentPlugin: paymentPlugin)
        }
    }

    func applyDiscountConfigurations(checkout: MercadoPagoCheckout) {
        guard let configs = configurations else {
            return
        }
        if configs.descuento {
            var maxCouponAmount: Double = 0
            if configs.tope {
                maxCouponAmount = 10
            }

            let discount = PXDiscount(id: "12344", name: "Descuento de prueba", percentOff: 0, amountOff: 10, couponAmount: 10, currencyId: "ARS")
            let campaign = PXCampaign(id: 12344, code: "code", name: "Campaña de prueba", maxCouponAmount: maxCouponAmount)
            checkout.setDiscount(discount, withCampaign: campaign)
        }
    }
}

class PaymentPluginViewController: UIViewController, PXPaymentPluginComponent {
    func render(store: PXCheckoutStore, theme: PXTheme) -> UIView? {
        return nil
    }
}
