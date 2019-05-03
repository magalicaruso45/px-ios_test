//
//  OneTapTests.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Demian Tejo on 13/11/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import XCTest

class OneTapTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        sleep(1)
        super.tearDown()
    }
    
    func onetapPreSet() -> OneTapScreen {
        return MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .swipe(type: ConfigurationScreen(), direction: .up)
            .changeAccessTokenSwitch()
            .changeAdvancedSwitch()
            .changeOneTapSwitch()
            .tapOtherPreferenceSegment(.oneTap)
            .tapApplyConfigurationsButton()
            .tapCheckoutOptionForOneTap()
    }

    func testPayWithoutScrolling() {
        _ = onetapPreSet()
        .tapPayButtonForCVV()
        .completeCVVAndContinueToAnyCongrats("1234")
        .waitForAnyCongrats()
    }

    func testPayWithScrolling() {
        _ = onetapPreSet()
            .swipeCardLeft()
            .swipeCardRight()
            .tapPayButtonForCVV()
            .completeCVVAndContinueToAnyCongrats("1234")
            .waitForAnyCongrats()
    }

    func testPayWithCreditCard() {
        _ = onetapPreSet()
            .swipeCardLeft()
            .tapPayButtonForCVV()
        .completeCVVAndContinueToAnyCongrats("123")
            .waitForAnyCongrats()

    }

    func testPayWithDebitCard() {
        _ = onetapPreSet()
            .swipeCardLeft()
            .swipeCardLeft()
            .tapPayButtonForCVV()
            .completeCVVAndContinueToAnyCongrats("123")
            .waitForAnyCongrats()
    }

}
