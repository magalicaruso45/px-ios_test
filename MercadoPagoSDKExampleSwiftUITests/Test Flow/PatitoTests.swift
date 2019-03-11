//
//  PatitoTests.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Federico Bustos Fierro on 08/03/2019.
//  Copyright © 2019 Mercado Pago. All rights reserved.
//

import XCTest

class PatitoTests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        sleep(5)
        super.tearDown()
    }
    
    func test_payment_error() { //Tarjeta MASTER con cuotas SIN INTERES
        let _ = MainScreen()
            .tapClearButton()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
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
}
