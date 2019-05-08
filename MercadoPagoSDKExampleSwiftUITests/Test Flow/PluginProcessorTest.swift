//
//  PluginProcessorTest.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Demian Tejo on 26/9/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import XCTest
import MercadoPagoSDKV4

class PluginProcessorTest: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_payment_processor_without_view_controller() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .tapOtherPreferenceSegment(.pluginProcessor)
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .tapCheckoutOption()
            .tapCashOption()
            .tapRapipagoOption()
            .tapPayButtonForAnyCongrats()
    }

    func test_payment_processor_with_view_controller() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changePaymentVCSwitchSwitch()
            .tapOtherPreferenceSegment(.pluginProcessor)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
            .tapCashOption()
            .tapRapipagoOption()
            .tapPayButtonForPluginProcessorViewController()
            .continueCheckoutToAnyCongrats()
    }
}
