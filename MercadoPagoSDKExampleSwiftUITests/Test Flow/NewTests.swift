//
//  NewTests.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Federico Bustos Fierro on 15/03/2019.
//  Copyright © 2019 Mercado Pago. All rights reserved.
//

import XCTest

class NewTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        sleep(5)
        super.tearDown()
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
 
