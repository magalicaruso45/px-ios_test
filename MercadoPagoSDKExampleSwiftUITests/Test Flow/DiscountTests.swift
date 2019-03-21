//
//  PatitoTests.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Federico Bustos Fierro on 08/03/2019.
//  Copyright © 2019 Mercado Pago. All rights reserved.
//

import XCTest

class DiscountTests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        sleep(5)
        super.tearDown()
    }
    
    func test_no_coupon() { //success no coupon
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
    
    func test_coupons_always_on() { //Always on
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .tapPreferenceSegmentDiscountAlwaysOn()
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
    
    func test_coupons_sold_out() { //Sold out
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-d1c95375-5137-4eb7-868e-da3ca8067d79")
            .fillPreferenceId("380636546-1c7b7731-97eb-492b-a25b-2374e36f24c9")
            .fillAccessToken("APP_USR-6094765363333165-122815-204eeee0a1ad662e7a977b2e7596a7c4-368735296")
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
    
    func test_coupons_by_payment_method() { //By payment method
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-3300f176-307d-4600-9769-ad1d10d51a4a")
            .fillPreferenceId("388462750-e44082ad-6246-4b8d-a1c0-25cae994b223")
            .fillAccessToken("TEST-1458038826212807-062020-ff9273c67bc567320eae1a07d1c2d5b5-246046416")
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
    
    func test_coupons_issuer_discount() { //By issuer
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-013db0be-9f4a-494f-acc8-44bd3f3e75a2")
            .fillPreferenceId("388466010-9b7f0eab-e1aa-4098-bb3c-c95244308274")
            .fillAccessToken("TEST-1458038826212807-062020-ff9273c67bc567320eae1a07d1c2d5b5-246046416")
            .tapCheckoutOption()
            .screenSwipeUp()
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
