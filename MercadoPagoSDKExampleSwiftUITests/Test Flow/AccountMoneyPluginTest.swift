//
//  AccountMoneyPluginTest.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Demian Tejo on 25/9/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import XCTest
import MercadoPagoSDKV4


class AccountMoneyPluginTest: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_account_money_with_second_factor() {
        MainScreen()
            .tapConfigurationsButton()
            .changeAccountMoneySwitch()
            .changeSecondFactorSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-648a260d-6fd9-4ad7-9284-90f22262c18d")
            .fillPreferenceId("243966003-d0be0be0-6fd8-4769-bf2f-7f2d979655f5")
            .tapCheckoutOption()
            .tapAccountMoneyOptionForSecondFactor()
            .completeSecondFactor("mercadopago")
        .continueToReview()
        .tapPayButtonForAnyCongrats()
    }
    
    func test_account_money_without_second_factor() {
        MainScreen()
            .tapConfigurationsButton()
            .changeAccountMoneySwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-648a260d-6fd9-4ad7-9284-90f22262c18d")
            .fillPreferenceId("243966003-d0be0be0-6fd8-4769-bf2f-7f2d979655f5")
            .tapCheckoutOption()
            .tapAccountMoneyOptionForReview()
            .tapPayButtonForAnyCongrats()
    }
}
