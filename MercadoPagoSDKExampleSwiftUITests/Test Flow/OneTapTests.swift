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
         super.tearDown()
    }
    
    func onetapPreSet() -> OneTapScreen {
        return MainScreen()
            .tapConfigurationsButton()
            .changeAccessTokenSwitch()
            .changeAdvancedSwitch()
            .changeOneTapSwitch()
            .tapApplyConfigurationsButton()
            .tapCheckoutOptionForOneTap()
    }

    func testPayWithAccountMoneyWhitoutScrolling() {
        _ = onetapPreSet()
        .tapPayButtonForAnyCongrats()
    }

    func testPayWithAccountMoneyWithScrolling() {
        _ = onetapPreSet()
            .swipeCardLeft()
            .swipeCardRight()
            .tapPayButtonForAnyCongrats()
    }

    func testPayWithCreditCard() {
        _ = onetapPreSet()
            .swipeCardLeft()
            .tapPayButtonForCVV()
        .completeCVVAndContinueToAnyCongrats("123")

    }

    func testPayWithDebitCard() {
        _ = onetapPreSet()
            .swipeCardLeft()
            .swipeCardLeft()
            .tapPayButtonForCVV()
            .completeCVVAndContinueToAnyCongrats("123")
    }

    func testPayWithCreditCardChangingInstallments() {
        _ = onetapPreSet()
        // do stuff
        XCUIApplication().scrollViews.otherElements.otherElements["installment_button"].collectionViews.children(matching: .cell).element(boundBy: 1).staticTexts["1x $ 100 Sin interés CFT: 0,00%"].tap()

    }

}
