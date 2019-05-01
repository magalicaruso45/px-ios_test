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

    //reminder: the preset payer feature has been developed to work only in combination with an open preference. As any open preference requires a payment processor, there should be no cases in which "preset payer and closed pref" o "preset payer and no payment processor" could coexist. Since the money-in flow will always initiliaze with an open preference, such limitation does never affect this integration.

    func test_boleto_cpf() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .tapOtherPreferenceSegment(.boleto)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
            .tapBoletoOption()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .tapPayButtonForAnyCongrats()
    }

    func test_boleto_cnpj() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .tapOtherPreferenceSegment(.boleto)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
            .tapBoletoOption()
            .swapToCNPJ()
            .completeNumberAndContinueToPayer("36897693000104")
            .completeBusinessNameAndContinueToReview("Social name")
            .tapPayButtonForAnyCongrats()
    }

    func test_boleto_con_payer() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeOpenPrefSwitch()
            .changePayerInfoSwitch()
            .tapOtherPreferenceSegment(.boleto)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
            .tapBoletoOptionForReview()
            .tapPayButtonForAnyCongrats()
    }

    func test_boleto_modificar_payer() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeOpenPrefSwitch()
            .changePayerInfoSwitch()
            .tapOtherPreferenceSegment(.boleto)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
            .tapBoletoOptionForReview()
            .tapChangePayerInfo()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .tapPayButtonForAnyCongrats()
    }

    // Mark: Pref cerradas
    func test_boleto_pref_cerrada() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .tapOtherPreferenceSegment(.boleto)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
            .tapBoletoOption()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .tapPayButtonForAnyCongrats()
    }
    
    func test_boleto_modificar_payer_pref_cerrada() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePayerInfoSwitch()
            .tapOtherPreferenceSegment(.boleto)
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-f3f035a2-d343-4a6f-bd3b-fc3c3cb72416")
            .fillPreferenceId("245099733-8771f469-d68e-4863-b8cb-9402e22c6bb2")
            .tapCheckoutOption()
            .tapBoletoOption()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .tapChangePayerInfo()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .tapPayButtonForAnyCongrats()
    }

    func test_boleto_accreditation_time_pref_cerrada() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePayerInfoSwitch()
            .tapOtherPreferenceSegment(.boleto)
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-f3f035a2-d343-4a6f-bd3b-fc3c3cb72416")
            .fillPreferenceId("245099733-8771f469-d68e-4863-b8cb-9402e22c6bb2")
            .tapCheckoutOption()
            .tapBoletoOption()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .tapChangePayerInfo()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .findLabelContainsText("Será aprovado em 1 dia útil")
    }

    func test_pec_accreditation_time_pref_cerrada() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePayerInfoSwitch()
            .tapOtherPreferenceSegment(.boleto)
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-f3f035a2-d343-4a6f-bd3b-fc3c3cb72416")
            .fillPreferenceId("245099733-8771f469-d68e-4863-b8cb-9402e22c6bb2")
            .tapCheckoutOption()
            .tapBoletoPec()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .tapChangePayerInfo()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .findLabelContainsText("Será aprovado em 1 hora")
    }
}
