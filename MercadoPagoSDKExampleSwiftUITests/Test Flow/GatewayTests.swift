//
//  GatewayTests.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Federico Bustos Fierro on 10/06/2019.
//  Copyright © 2019 Mercado Pago. All rights reserved.
//

import XCTest

class GatewayTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        sleep(5)
        super.tearDown()
    }

    func test_aggregator_mode() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .tapOtherPreferenceSegment(.gatewayMode1)
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

    func test_gateway_mode() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .tapOtherPreferenceSegment(.gatewayMode2)
            .tapApplyConfigurationsButton()
            .tapCheckoutOptionOnlyCard()
            .completeNumberAndContinue("4242 4242 4242 4242")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToIssuers("30666777")
            .selectIssuerOptionToPayerCostScreenAtRow(1)
            .selectPayerCostOptionAtRow(2)
            .tapPayButtonForAnyCongrats()
            .waitForAnyCongrats()
    }

    func test_branch_id_mode() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .tapOtherPreferenceSegment(.gatewayMode3)
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

    func test_no_agg_no_gateway_mode() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .tapOtherPreferenceSegment(.gatewayMode4)
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


    func test_safe_gateway_mode() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .tapOtherPreferenceSegment(.gatewayMode5)
            .tapApplyConfigurationsButton()
            .tapCheckoutOptionOnlyCard()
            .completeNumberAndContinue("4242 4242 4242 4242")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToIssuers("30666777")
            .selectIssuerOptionToPayerCostScreenAtRow(1)
            .selectPayerCostOptionAtRow(2)
            .tapPayButtonForAnyCongrats()
            .waitForAnyCongrats()
    }


    func test_hibrid_mode() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .tapOtherPreferenceSegment(.gatewayMode6)
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
