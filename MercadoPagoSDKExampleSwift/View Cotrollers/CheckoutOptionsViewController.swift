//
//  CheckoutOptionsViewController.swift
//  MercadoPagoSDKExampleSwift
//
//  Created by AUGUSTO COLLERONE ALFONSO on 19/4/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import UIKit
import MercadoPagoSDKV4
import PureLayout

class CheckoutOptionsViewController: UIViewController, ConfigurationManager, AddCardFlowProtocol, PXLifeCycleProtocol {
    func cancelCheckout() -> (() -> Void)? {
        return {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    func finishCheckout() -> ((PXResult?) -> Void)? {
        return { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }


    var configurations: Configurations =
        Configurations(comisiones: false,
                       descuento: false,
                       fullCustomization: false,
                       paymentPlugin: false,
                       paymentPluginViewController : false,
                       businessResult: false,
                       maxRedeemPerUser: 0,
                       skipCongrats: false,
                       accessToken: false,
                       oneTap: false,
                       advancedConfiguration: false,
                       splitPayment: false,
                       payerInfo: false,
                       localizedTexts: false,
                       openPreference: false,
                       escEnabled: false,
                       discountParams: false,
                       preferenceContext: .mla,
                       businessStatus: .REJECTED,
                       statusDetail: "cc_rejected_call_for_authorize")

    var addCardFlow : AddCardFlow?
    var descriptionLabel: UILabel!
    var publicKeyField: UITextField!
    var preferenceIDField: UITextField!
    var accessTokenField: UITextField!
    var cardIdField: UITextField!
    var scrollView: UIScrollView!
    var containerView: UIView!
    var configurationViewController = ConfigurationsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        //View
        self.title = "Checkout Configuration"
        self.view.backgroundColor = .white
        let topMargin = PXLayout.getSafeAreaTopInset() + 70

        //General scrollview
        self.scrollView = createScrollView()
        self.containerView = createContainerView()
        
        //General description label
        self.descriptionLabel = createDescriptionLabel()
        PXLayout.centerHorizontally(view: descriptionLabel).isActive = true
        PXLayout.pinTop(view: descriptionLabel, withMargin: topMargin).isActive = true
        
        //Public Key Input
        self.publicKeyField = createInputTextField(placeholder: "Public Key")
        PXLayout.put(view: publicKeyField, onBottomOf: descriptionLabel, withMargin: PXLayout.S_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: publicKeyField).isActive = true

        //Preference ID Input
        self.preferenceIDField = createInputTextField(placeholder: "Pref ID")
        PXLayout.put(view: preferenceIDField, onBottomOf: publicKeyField, withMargin: PXLayout.S_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: preferenceIDField).isActive = true

        //Access Token Input
        self.accessTokenField = createInputTextField(placeholder: "Access Token (Optional)")
        PXLayout.put(view: accessTokenField, onBottomOf: preferenceIDField, withMargin: PXLayout.S_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: accessTokenField).isActive = true

        //Card ID Input
        self.cardIdField = createInputTextField(placeholder: "Card Id (Optional)")
        self.cardIdField.autocapitalizationType = .none
        PXLayout.put(view: cardIdField, onBottomOf: accessTokenField, withMargin: PXLayout.S_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: cardIdField).isActive = true
        
        //Add card flow button
        let addCardFlowButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .gray
            button.setTitle("Start Card Flow", for: .normal)
            button.layer.cornerRadius = 5
            button.setTitleColor(.white, for: .normal)
            button.add(for: .touchUpInside, {
                if let accessToken = self.accessTokenField.text {
                    self.configurations.skipCongrats ? self.startAddCardFlowSkippingCongrats(accessToken: accessToken) :self.startAddCardFlow(accessToken: accessToken)
                }
            })
            return button
        }()
        self.containerView.addSubview(addCardFlowButton)
        PXLayout.put(view: addCardFlowButton, onBottomOf: cardIdField, withMargin: PXLayout.L_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: addCardFlowButton).isActive = true
        PXLayout.setHeight(owner: addCardFlowButton, height: 48).isActive = true
        PXLayout.setWidth(owner: addCardFlowButton, width: 250).isActive = true

        //Start Button
        let startButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .gray
            button.setTitle("Start Checkout", for: .normal)
            button.layer.cornerRadius = 5
            button.setTitleColor(.white, for: .normal)
            button.add(for: .touchUpInside, {
                if let publicKey = self.publicKeyField.text, let prefId = self.preferenceIDField.text {
                    self.startCheckout(publicKey: publicKey, prefId: prefId, accessToken: self.accessTokenField.text, cardId: self.cardIdField.text)
                }
            })
            return button
        }()
        self.containerView.addSubview(startButton)
        PXLayout.put(view: startButton, onBottomOf: addCardFlowButton, withMargin: PXLayout.L_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: startButton).isActive = true
        PXLayout.setHeight(owner: startButton, height: 48).isActive = true
        PXLayout.setWidth(owner: startButton, width: 250).isActive = true

        //Clear Fields Button
        let clearFieldsButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .red
            button.setTitle("Clear fields", for: .normal)
            button.layer.cornerRadius = 5
            button.setTitleColor(.white, for: .normal)
            button.add(for: .touchUpInside, {
                self.publicKeyField.text = ""
                self.preferenceIDField.text = ""
                self.accessTokenField.text = ""
            })
            return button
        }()
        self.containerView.addSubview(clearFieldsButton)
        PXLayout.put(view: clearFieldsButton, onBottomOf: startButton, withMargin: PXLayout.M_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: clearFieldsButton).isActive = true
        PXLayout.setHeight(owner: clearFieldsButton, height: 48).isActive = true
        PXLayout.setWidth(owner: clearFieldsButton, width: 250).isActive = true

        //Add configurations
        let additionalConfigButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .blue
            button.setTitle("Add Configurations", for: .normal)
            button.layer.cornerRadius = 5
            button.setTitleColor(.white, for: .normal)
            button.add(for: .touchUpInside, {
                self.additionalConfigs()
            })
            return button
        }()
        self.containerView.addSubview(additionalConfigButton)
        PXLayout.put(view: additionalConfigButton, onBottomOf: clearFieldsButton, withMargin: PXLayout.M_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: additionalConfigButton).isActive = true
        PXLayout.setHeight(owner: additionalConfigButton, height: 48).isActive = true
        PXLayout.setWidth(owner: additionalConfigButton, width: 250).isActive = true


        //Clear Fields Button
        let resetExtraConfigButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .red
            button.setTitle("Reset extra configs", for: .normal)
            button.layer.cornerRadius = 5
            button.setTitleColor(.white, for: .normal)
            button.add(for: .touchUpInside, {
                self.configurationViewController = ConfigurationsViewController()
            })
            return button
        }()
        self.view.addSubview(resetExtraConfigButton)
        PXLayout.put(view: resetExtraConfigButton, onBottomOf: additionalConfigButton, withMargin: PXLayout.S_MARGIN).isActive = true
        PXLayout.centerHorizontally(view: resetExtraConfigButton).isActive = true
        PXLayout.setHeight(owner: resetExtraConfigButton, height: 48).isActive = true
        PXLayout.setWidth(owner: resetExtraConfigButton, width: 250).isActive = true

        publicKeyField.text = "APP_USR-ba2e6b8c-8b6d-4fc3-8a47-0ab241d0dba4"
        preferenceIDField.text = "384414502-d095679d-f7d9-4653-ad71-4fb5feda3494"
        accessTokenField.text = "APP_USR-6519316523937252-070516-964fafa7e2c91a2c740155fcb5474280__LA_LD__-261748045"
    }

    func createScrollView() -> UIScrollView {
        let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()
        self.view.addSubview(scrollView)
        _ = PXLayout.pinTop(view: scrollView)
        _ = PXLayout.pinLeft(view: scrollView)
        _ = PXLayout.pinRight(view: scrollView)
        _ = PXLayout.pinBottom(view: scrollView)
        return scrollView
    }

    func createContainerView() -> UIView {
        let containerView: UIView = {
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            return containerView
        }()
        self.scrollView.addSubview(containerView)
        _ = PXLayout.pinTop(view: containerView)
        _ = PXLayout.pinLeft(view: containerView)
        _ = PXLayout.pinRight(view: containerView)
        _ = PXLayout.pinBottom(view: containerView)
        PXLayout.setHeight(owner: containerView, height: 900).isActive = true
        PXLayout.matchWidth(ofView: containerView, withPercentage: 100).isActive = true
        return containerView
    }
    
    func createDescriptionLabel() -> UILabel {
        let label: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Empty"
            label.numberOfLines = 0
            return label
        }()
        self.containerView.addSubview(label)
        PXLayout.setHeight(owner: label, height: 90).isActive = true
        PXLayout.matchWidth(ofView: label, withPercentage: 80).isActive = true
        return label
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
        self.containerView.addSubview(textField)
        PXLayout.setHeight(owner: textField, height: 40).isActive = true
        PXLayout.matchWidth(ofView: textField, withPercentage: 80).isActive = true
        return textField
    }

    func additionalConfigs(){
        configurationViewController.delegate = self
        configurationViewController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.navigationController?.present(configurationViewController, animated: true, completion: nil)
    }

    func setConfigurations(configs: Configurations) {
        self.configurations = configs
        let initConfig = configurations.preferenceContext.getInitConfiguration()
        publicKeyField.text = initConfig.publicKey
        preferenceIDField.text = initConfig.preferenceID
        accessTokenField.text = configurations.accessToken ? initConfig.accessToken : ""
        descriptionLabel.text = "Case: \(configurations.preferenceContext.getContextDescription()) \nPayer: \(initConfig.payer) \nCollector: \(initConfig.collector)"
    }

    //---- Configs
    func startCheckout(publicKey: String, prefId: String, accessToken: String? = nil, cardId: String? = nil) {
        var paymentPref: PXPaymentConfiguration? = nil
        if configurations.paymentPlugin {
            if configurations.splitPayment {
                let processor = SplitPaymentPlugin()
                paymentPref = PXPaymentConfiguration(splitPaymentProcessor: processor)
            } else if configurations.paymentPluginViewController {
                let processor = PaymentPluginViewController(isBusinessResult: configurations.businessResult, showFullCustomization: configurations.fullCustomization, businessResultStatus: configurations.businessStatus, statusDetail: configurations.statusDetail)
                paymentPref = PXPaymentConfiguration(paymentProcessor: processor)
            } else{
                let processor = PaymentPlugin(isBusinessResult: configurations.businessResult, showFullCustomization: configurations.fullCustomization, businessResultStatus: configurations.businessStatus, statusDetail: configurations.statusDetail)
                paymentPref = PXPaymentConfiguration(paymentProcessor: processor)
            }
            if configurations.comisiones == true {
                _ = paymentPref!.addChargeRules(charges: getComisions())
            }
        }
    
        let builder =  getBuilder(publicKey: publicKey, prefId: prefId, accessToken:accessToken, cardId: cardId, paymentConfig: paymentPref, setPayer: configurations.payerInfo, localizedTexts: configurations.localizedTexts)
        
        if configurations.advancedConfiguration {
            let advancedConfig = PXAdvancedConfiguration()
            if configurations.oneTap {
                advancedConfig.expressEnabled = true
            }
            if configurations.discountParams {
                advancedConfig.discountParamsConfiguration = PXDiscountParamsConfiguration(labels: ["fruta"], productId: "BCKJO2VHAU10018OVCE0")
            }
            if configurations.escEnabled {
                advancedConfig.escEnabled = true
            }
            builder.setAdvancedConfiguration(config: advancedConfig)
        }
        
        MercadoPagoCheckout.init(builder:builder).start(navigationController: self.navigationController!, lifeCycleProtocol: self)
    }

    func startAddCardFlow(accessToken: String) {
        guard let navController = self.navigationController else {
            return
        }
        self.addCardFlow = AddCardFlow(accessToken: accessToken, locale: "es", navigationController: navController)
        let site = configurations.preferenceContext.getSite()
        self.addCardFlow?.setSiteId(site)
        self.addCardFlow?.delegate = self
        self.addCardFlow?.start()
    }
 
    func startAddCardFlowSkippingCongrats(accessToken: String) {
        guard let navController = self.navigationController else {
            return
        }
        self.addCardFlow = AddCardFlow(accessToken: accessToken, locale: "es", navigationController: navController, shouldSkipCongrats: true)
        let site = configurations.preferenceContext.getSite()
        self.addCardFlow?.setSiteId(site)
        self.addCardFlow?.delegate = self
        self.addCardFlow?.start()
    }

    func addCardFlowSucceded(result: [String: Any]) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func addCardFlowFailed(shouldRestart: Bool) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func getBuilder(publicKey: String, prefId: String, accessToken: String?,  cardId: String?, paymentConfig: PXPaymentConfiguration?, setPayer: Bool, localizedTexts: Bool) -> MercadoPagoCheckoutBuilder {
        var builder : MercadoPagoCheckoutBuilder

        if let payconf = paymentConfig {
            if configurations.openPreference {
                let preference = createPreference(prefId: prefId,
                                                  cardId: cardId,
                                                  setPayer: setPayer)
                builder = MercadoPagoCheckoutBuilder(publicKey: publicKey,
                                                     checkoutPreference: preference,
                                                     paymentConfiguration: payconf)
            } else {
                builder = MercadoPagoCheckoutBuilder(publicKey: publicKey, preferenceId: prefId, paymentConfiguration: payconf)
            }
        } else {
            builder = MercadoPagoCheckoutBuilder(publicKey: publicKey, preferenceId: prefId)
        }
        
        if let privateKey = accessToken {
            builder.setPrivateKey(key: privateKey)
        }

        let language = configurations.preferenceContext.getLanguage()
        builder.setLanguage(language)
        if localizedTexts {
            let texts: [PXCustomTranslationKey : String] = [.total_to_pay: "Total cambiado", .how_to_pay: "Como deseas pagar cambiado ?"]
            builder.setLanguage(language, texts)
        } else {
            builder.setLanguage(language)
        }
            
        return builder
    }


    func createPreference(prefId: String, cardId: String? = nil, setPayer: Bool) -> PXCheckoutPreference {

        let item = PXItem(title: "id", quantity: 1, unitPrice: 123)

        let site = configurations.preferenceContext.getSite()
        let checkoutPreference = PXCheckoutPreference(siteId: site, payerEmail: "sadsd@asd.com", items: [item])

        checkoutPreference.setMaxInstallments(3)
        if setPayer {
            let type = PXIdentificationType(id: "CNPJ", name: "CNPJ", minLength: 1, maxLength: 1, type: "CNPJ")
            let payer = PXPayer(id: "", accessToken: "", identification: PXIdentification(identificationType: type, identificationNumber: "66493851238"), type: nil, entityType: nil, email: "sadsd@asd.com", firstName: "Pepe", lastName: "Hongo", legalName: "RAZAO")
            checkoutPreference.setPayer(payer: payer)
        }
        if cardId != nil && cardId != "" {
            checkoutPreference.setExcludedPaymentMethods(["visa"])
            checkoutPreference.setExcludedPaymentTypes(["debit_card", "atm"])
            checkoutPreference.setCardId(cardId: cardId!)
            return checkoutPreference
        }
        return checkoutPreference
    }
}

//MARK: Configurations --
extension CheckoutOptionsViewController {

    func getComisions() ->  [PXPaymentTypeChargeRule] {
        let comision = PXPaymentTypeChargeRule(paymentMethdodId: "credit_card", amountCharge: 10.0)
        var chargesArray = [PXPaymentTypeChargeRule]()
        chargesArray.append(comision)
        return chargesArray
    }

    func applyPaymentPluginConfigurations(checkout: MercadoPagoCheckout) {
        /*guard let configs = configurations else {
            return
        }
        if configs.paymentPlugin {
            let paymentPlugin = PaymentPluginViewController(nibName: nil, bundle: nil)
            checkout.setPaymentPlugin(paymentPlugin: paymentPlugin)
        }*/
    }
}



class SplitPaymentPlugin: NSObject, PXSplitPaymentProcessor {
    func paymentProcessorViewController() -> UIViewController? {
        return UIViewController()
    }
    
    func support() -> Bool {
        return true
    }
    
    func supportSplitPaymentMethodPayment(checkoutStore: PXCheckoutStore) -> Bool {
        return true
    }
}

class PaymentPlugin: NSObject, PXPaymentProcessor {
    let isBusinessResult: Bool
    let showFullCustomization: Bool
    let businessResultStatus: PXBusinessResultStatus
    let statusDetail: String
    
    init(isBusinessResult: Bool, showFullCustomization: Bool, businessResultStatus: PXBusinessResultStatus, statusDetail: String) {
        self.isBusinessResult = isBusinessResult
        self.showFullCustomization = showFullCustomization
        self.businessResultStatus = businessResultStatus
        self.statusDetail = statusDetail
    }

    func paymentProcessorViewController() -> UIViewController? {
        return nil
    }
 
    func support() -> Bool {
        return true
    }

    func didReceive(navigationHandler: PXPaymentProcessorNavigationHandler){
        navigationHandler.next()
    }

    func didReceive(checkoutStore: PXCheckoutStore){
        
    }

    func startPayment(checkoutStore: PXCheckoutStore, errorHandler: PXPaymentProcessorErrorHandler, successWithBusinessResult: @escaping ((PXBusinessResult) -> Void), successWithPaymentResult: @escaping  ((PXGenericPayment) -> Void)){
        if (self.isBusinessResult) {
            let status = self.getStringStatus(businessResultStatus)
            let topCustomView : UIView? = self.showFullCustomization ? buildCustomView(color: UIColor.gray) : nil
            let bottomCustomView : UIView? = self.showFullCustomization ? buildCustomView(color: UIColor.lightGray) : nil
            let customAction : PXAction? = self.showFullCustomization ? buildCustomAction() : nil
            let customDescription = self.showFullCustomization ? "Sample text" : nil
            successWithBusinessResult(PXBusinessResult(receiptId: nil, status: businessResultStatus, title: "Ejecutamos tu transacción custom", subtitle: "Subtitulo", icon: nil, mainAction: customAction, secondaryAction: customAction, helpMessage: customDescription, showPaymentMethod: true, statementDescription: customDescription, imageUrl: nil, topCustomView: topCustomView, bottomCustomView: bottomCustomView, paymentStatus: status, paymentStatusDetail: ""))
        } else {

            var status: String
            switch statusDetail {
            case "pending_review_manual":
                status = "in_process"
            case "pending_contingency":
                status = "in_process"
            case "broken":
                status = "broken"
            default:
                status = "rejected"
            }

            successWithPaymentResult(PXGenericPayment(status: status, statusDetail: self.statusDetail))
        }
    }
}

class PaymentPluginViewController: NSObject, PXPaymentProcessor {
    var navigationHandler: PXPaymentProcessorNavigationHandler!
    let viewController = ExamplePaymentProcessorViewController()
    let isBusinessResult: Bool
    let showFullCustomization: Bool
    let businessResultStatus: PXBusinessResultStatus
    let statusDetail: String
    
    init(isBusinessResult: Bool, showFullCustomization: Bool, businessResultStatus: PXBusinessResultStatus, statusDetail: String) {
        self.isBusinessResult = isBusinessResult
        self.showFullCustomization = showFullCustomization
        self.businessResultStatus = businessResultStatus
        self.statusDetail = statusDetail
    }

    func paymentProcessorViewController() -> UIViewController? {
        return viewController
    }

    func support() -> Bool {
        return true
    }

    func didReceive(navigationHandler: PXPaymentProcessorNavigationHandler){
        self.navigationHandler = navigationHandler
        viewController.handler = navigationHandler
        viewController.status = self.getStringStatus(businessResultStatus)
        viewController.businessResultStatus = businessResultStatus
    }

    func didReceive(checkoutStore: PXCheckoutStore){
        
    }

    func startPayment(checkoutStore: PXCheckoutStore, errorHandler: PXPaymentProcessorErrorHandler, successWithBusinessResult: @escaping ((PXBusinessResult) -> Void), successWithPaymentResult: @escaping  ((PXGenericPayment) -> Void)){
        if (self.isBusinessResult) {
            let status = self.getStringStatus(businessResultStatus)
            let topCustomView : UIView? = self.showFullCustomization ? buildCustomView(color: UIColor.gray) : nil
            let bottomCustomView : UIView? = self.showFullCustomization ? buildCustomView(color: UIColor.lightGray) : nil
            let customAction : PXAction? = self.showFullCustomization ? buildCustomAction() : nil
            let customDescription = self.showFullCustomization ? "Sample text" : nil
            successWithBusinessResult(PXBusinessResult(receiptId: nil, status: businessResultStatus, title: "Ejecutamos tu transacción custom", subtitle: "Subtitulo", icon: nil, mainAction: customAction, secondaryAction: customAction, helpMessage: customDescription, showPaymentMethod: true, statementDescription: customDescription, imageUrl: nil, topCustomView: topCustomView, bottomCustomView: bottomCustomView, paymentStatus: status, paymentStatusDetail: ""))
        } else {
            var status: String
            switch statusDetail {
            case "pending_review_manual":
                status = "in_process"
            case "pending_contingency":
                status = "in_process"
            case "broken":
                status = "broken"
            default:
                status = "rejected"
            }
            successWithPaymentResult(PXGenericPayment(status: status, statusDetail: self.statusDetail))
        }
    }
}

extension PXPaymentProcessor {
    func getStringStatus(_ businessResultStatus : PXBusinessResultStatus) -> String {
        switch businessResultStatus {
        case .APPROVED: return "approved"
        case .REJECTED: return "REJECTED"
        case .PENDING: return "PENDING"
        case .IN_PROGRESS: return "IN PROGRESS"
        }
    }
    
    
    func buildCustomView(color: UIColor? = UIColor.red) -> UIView {
        let height = CGFloat(90)
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        let containerView = UIView(frame: frame)
        containerView.backgroundColor = color
        containerView.autoSetDimension(ALDimension.height, toSize: 240)
        return containerView
    }
    
    func buildCustomAction() -> PXAction {
        let action = PXAction(label: "Custom action") {
            let alert: UIAlertView = UIAlertView(title: "Sample custom action", message: "Custom message",
                                                        delegate: nil, cancelButtonTitle: "Continue", otherButtonTitles: "Cancel")
            alert.show()
        }
        return action
    }
}

