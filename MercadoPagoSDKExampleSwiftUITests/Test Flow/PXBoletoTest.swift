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
        super.tearDown()
    }

    func test_boleeto() {
        let _ = MainScreen()
            .tapClearButton()
            .tapConfigurationsButton()
            .changePaymentPluginSwitch()
            .tapApplyConfigurationsButton()
            .fillPublicKey("APP_USR-0c49ceb6-3cf7-4be9-b59d-f1f76671af68")
            .fillAccessToken("APP_USR-1505-101710-2aa28f80031d35d3fc866e17765bde43-347997394")
            .tapCheckoutOption()
            .tapBoletoOption()
            .tapBoletoInternetBanking()
            .completeNumberAndContinueToPayer("05487765634")
            .completeNameAndContinueToPayer("JUAN")
            .completeLastNameAndContinueToReview("PEREZ")
            .tapPayButtonForAnyCongrats()
    }
}
