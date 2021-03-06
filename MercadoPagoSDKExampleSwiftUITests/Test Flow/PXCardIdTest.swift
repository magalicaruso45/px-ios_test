//
//  PXCardIdTest.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Marcelo Oscar José on 09/08/2018.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import XCTest

class PXCardIdTest: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        sleep(5)
        super.tearDown()
    }

    func test_nueva_tarjeta_debito_approved() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .changeOpenPrefSwitch()
            .changeExclusionsSwitch()
            .configurePaymentStatusDetail("accredited")
            .tapOtherPreferenceSegment(.manyCards)
            .tapApplyConfigurationsButton()
            .swipeDown(type: MainScreen())
            .fillCardId("debit_card")
            .tapCheckoutOptionOnlyCard()
            .completeNumberAndContinue("6042 0130 7660 8231")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToReview("30666777")
            .tapPayButtonForApproved()
            .waitForAnyCongrats()
    }

    func test_nueva_tarjeta_debito_rejected() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .changeOpenPrefSwitch()
            .configurePaymentStatusDetail("cc_rejected_high_risk")
            .changeExclusionsSwitch()
            .tapOtherPreferenceSegment(.manyCards)
            .tapApplyConfigurationsButton()
            .swipeDown(type: MainScreen())
            .fillCardId("debit_card")
            .tapCheckoutOptionOnlyCard()
            .completeNumberAndContinue("6042 0130 7660 8231")
            .completeNameAndContinue("OTHE")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToReview("30666777")
            .tapPayButtonForRejected()
            .waitForAnyCongrats()
    }

    func test_tarjeta_debito_guardada() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .changeOpenPrefSwitch()
            .changeExclusionsSwitch()
            .tapOtherPreferenceSegment(.manyCards)
            .tapApplyConfigurationsButton()
            .swipeDown(type: MainScreen())
            .fillCardId("8620515887")
            .tapCheckoutOptionWithCardSelected()
            .completeCVVAndContinueToReview("123")
            .tapPayButtonForApproved()
            .waitForAnyCongrats()
    }

    func test_no_card_id() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .changeOpenPrefSwitch()
            .changeExclusionsSwitch()
            .tapOtherPreferenceSegment(.manyCards)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
        //check that one saved debit card and only new debit card options are available
    }
}
