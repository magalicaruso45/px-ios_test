//
//  ChargesTest.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Demian Tejo on 11/7/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import XCTest
import MercadoPagoSDKV4

class ChargesTest: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        sleep(5)
        super.tearDown()
    }

    func test_flujo_con_comision_para_creditcard(){
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeChargeSwitch()
            .tapOtherPreferenceSegment(.charges)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
            .tapCardOption()
            .tapCreditCardOption()
            .completeNumberAndContinue("5323 7937 3550 6106")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToIssuers("30666777")
            .selectIssuerOptionToPayerCostScreenAtRow(1)
            .selectPayerCostOptionAtRow(2)
            .tapPayButtonForAnyCongrats()
            .waitForAnyCongrats()
    }

    func test_one_tap_only_charges() {
        let _ = MainScreen()
            .tapClearButton()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .changeChargeSwitch()
            .changeAdvancedSwitch()
            .changeOneTapSwitch()
            .tapOtherPreferenceSegment(.mla50)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
    }

    func test_one_tap_charges_and_discount() {
        let _ = MainScreen()
            .tapClearButton()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .changeChargeSwitch()
            .changeAdvancedSwitch()
            .changeOneTapSwitch()
            .tapOtherPreferenceSegment(.discountAlwaysOn)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
    }

    func test_one_tap_charges_and_soldout() {
        let _ = MainScreen()
            .tapClearButton()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .changeChargeSwitch()
            .changeAdvancedSwitch()
            .changeOneTapSwitch()
            .tapOtherPreferenceSegment(.discountSoldOut)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
    }
}
