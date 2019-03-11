//
//  PXBoletoTest.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Marcelo Oscar José on 22/10/2018.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import XCTest

class PXBoletoTest: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        sleep(5)
        super.tearDown()
    }

    func test_boleto() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-0c49ceb6-3cf7-4be9-b59d-f1f76671af68")
            .fillAccessToken("APP_USR-1505-101710-2aa28f80031d35d3fc866e17765bde43-347997394")
            .tapCheckoutOption()
            .tapBoletoOption()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .tapPayButtonForAnyCongrats()
    }

    func test_boleto_con_payer() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changePayerInfoSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-0c49ceb6-3cf7-4be9-b59d-f1f76671af68")
            .fillAccessToken("APP_USR-1505-101710-2aa28f80031d35d3fc866e17765bde43-347997394")
            .tapCheckoutOption()
            .tapBoletoOptionForReview()
            .tapPayButtonForAnyCongrats()
    }

    func test_boleto_modificar_payer() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changePayerInfoSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-0c49ceb6-3cf7-4be9-b59d-f1f76671af68")
            .fillAccessToken("APP_USR-1505-101710-2aa28f80031d35d3fc866e17765bde43-347997394")
            .tapCheckoutOption()
            .tapBoletoOptionForReview()
            .tapChangePayerInfo()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .tapPayButtonForAnyCongrats()
    }

    func test_boleto_cambio_textos() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeLocalizedTextsSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-0c49ceb6-3cf7-4be9-b59d-f1f76671af68")
            .fillAccessToken("APP_USR-1505-101710-2aa28f80031d35d3fc866e17765bde43-347997394")
            .tapCheckoutOption()
            .findText("Como deseas pagar cambiado ?")
            .findText("Total cambiado")
    }

    // Mark: Pref cerradas
    func test_boleto_pref_cerrada() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-f3f035a2-d343-4a6f-bd3b-fc3c3cb72416")
            .fillPreferenceId("245099733-8771f469-d68e-4863-b8cb-9402e22c6bb2")
            .tapCheckoutOption()
            .tapBoletoOption()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .tapPayButtonForAnyCongrats()
    }
    
    func test_boleto_con_payer_pref_cerrada() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changePayerInfoSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-f3f035a2-d343-4a6f-bd3b-fc3c3cb72416")
            .fillPreferenceId("245099733-8771f469-d68e-4863-b8cb-9402e22c6bb2")
            .tapCheckoutOption()
            .tapBoletoOptionForReview()
            .tapPayButtonForAnyCongrats()
    }
    
    func test_boleto_modificar_payer_pref_cerrada() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changePayerInfoSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-f3f035a2-d343-4a6f-bd3b-fc3c3cb72416")
            .fillPreferenceId("245099733-8771f469-d68e-4863-b8cb-9402e22c6bb2")
            .tapCheckoutOption()
            .tapBoletoOptionForReview()
            .tapChangePayerInfo()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .tapPayButtonForAnyCongrats()
    }

    func test_boleto_accreditation_time_pref_cerrada() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changePayerInfoSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-f3f035a2-d343-4a6f-bd3b-fc3c3cb72416")
            .fillPreferenceId("245099733-8771f469-d68e-4863-b8cb-9402e22c6bb2")
            .tapCheckoutOption()
            .tapBoletoOptionForReview()
            .tapChangePayerInfo()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .findLabelContainsText("Se acreditará en 1 día hábil")
    }

    func test_pec_accreditation_time_pref_cerrada() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changePayerInfoSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-f3f035a2-d343-4a6f-bd3b-fc3c3cb72416")
            .fillPreferenceId("245099733-8771f469-d68e-4863-b8cb-9402e22c6bb2")
            .tapCheckoutOption()
            .tapBoletoPecForReview()
            .tapChangePayerInfo()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .findLabelContainsText("Se acreditará en 1 hora")
    }
}
