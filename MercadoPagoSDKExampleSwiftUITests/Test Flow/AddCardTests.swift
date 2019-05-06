//
//  AddCardTests.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Diego Flores Domenech on 1/10/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//
import XCTest

class AddCardTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        sleep(5)
        super.tearDown()
    }

    func testAddVisaCard() {
        _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .tapOtherPreferenceSegment(.addCardMLA)
            .tapApplyConfigurationsButton()
            .tapAddCardButton()
            .completeNumberAndContinue("4111111111111111")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToCongrats("12345678")
    }

    func testAddAmexCard() {
        _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .tapOtherPreferenceSegment(.addCardMLA)
            .tapApplyConfigurationsButton()
            .tapAddCardButton()
            .completeNumberAndContinue("371180303257522")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("1234")
            .completeNumberAndContinueToCongrats("12345678")
    }

    func testMasterDebitCard() {
        _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeSkipCongratsSwitch()
            .changeAccessTokenSwitch()
            .tapOtherPreferenceSegment(.addCardNoDNI)
            .tapApplyConfigurationsButton()
            .tapAddCardButton()
            .completeNumberAndContinue("5579078521025680")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinueToCongrats("123")
    }

    func testAddAmexNoIDMLM() {
        _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .tapOtherPreferenceSegment(.addCardMLM)
            .tapApplyConfigurationsButton()
            .tapAddCardButton()
            .completeNumberAndContinue("371180303257522")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinueToCongrats("1234")
    }

    func testAddHipercardMLB() {
        _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeAccessTokenSwitch()
            .tapOtherPreferenceSegment(.addCardMLB)
            .tapApplyConfigurationsButton()
            .tapAddCardButton()
            .completeNumberAndContinue("6062826786276634")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToCongrats("63538416397")
    }

    func testAddCardSkippingCongrats() {
        _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeSkipCongratsSwitch()
            .changeAccessTokenSwitch()
            .tapOtherPreferenceSegment(.addCardMLA)
            .tapApplyConfigurationsButton()
            .tapAddCardButton()
            .completeNumberAndContinue("4111111111111111")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndFinish("12345678")
    }
}

