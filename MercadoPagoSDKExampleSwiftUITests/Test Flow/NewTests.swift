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

    func test_business_pending() { //custom pending screen
        let _ = MainScreen()
            .tapClearButton()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeBusinessSwitch()
            .tapBusinessSegmentPending()
            .changeFullCustomizationSwitch()
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
    
    func test_esc() { //perform cyclic flow
        let configStep = configureFlow(screen: MainScreen())
        let firstCycle = cycleTest(screen: configStep)
        let secondCycle = cycleTest(screen:firstCycle)
        let _ = cycleTest(screen:secondCycle)
    }
    
    func configureFlow(screen: MainScreen) -> MainScreen {
        let mainScreen = screen
            .tapClearButton()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeBusinessSwitch()
            .tapBusinessSegmentApproved()
            .tapESCSwitch()
            .tapApplyConfigurationsButton()
        return mainScreen
    }
    
    func cycleTest(screen: MainScreen) -> MainScreen {
        let finalScreen = screen
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
            .tapCloseButton()
        return finalScreen
    }

}
