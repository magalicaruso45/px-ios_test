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
            .changePluginViewControllerSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-648a260d-6fd9-4ad7-9284-90f22262c18d")
            .fillPreferenceId("243966003-d0be0be0-6fd8-4769-bf2f-7f2d979655f5")
            .tapCheckoutOption()
            .tapCashOption()
            .tapRapipagoOption()
            .tapPayButtonForAnyCongrats()
    }

    func test_payment_processor_with_view_controller() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePluginViewControllerSwitch()
            .changePaymentPluginSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-648a260d-6fd9-4ad7-9284-90f22262c18d")
            .fillPreferenceId("243966003-d0be0be0-6fd8-4769-bf2f-7f2d979655f5")
            .tapCheckoutOption()
            .tapCashOption()
            .tapRapipagoOption()
            .tapPayButtonForPluginProcessorViewController()
            .continueCheckoutToAnyCongrats()
    }
}
