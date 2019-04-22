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
            .tapClearButton()
            .fillAccessToken("TEST-2339206676136732-022711-66711b94df7125aff837f84ca14210df-410998299")
            .tapAddCardButton()
            .completeNumberAndContinue("4111111111111111")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToCongrats("12345678")
    }

    func testAddAmexCard() {
        _ = MainScreen()
            .tapClearButton()
            .fillAccessToken("TEST-2339206676136732-022711-66711b94df7125aff837f84ca14210df-410998299")
            .tapAddCardButton()
            .completeNumberAndContinue("371180303257522")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("1234")
            .completeNumberAndContinueToCongrats("12345678")
    }

    func testMasterDebitCard() {
        _ = MainScreen()
            .tapClearButton()
            .fillAccessToken("TEST-1178809857150049-022812-1b795ddd0f07c85489b50d6f827b0600-411553753")
            .tapAddCardButton()
            .completeNumberAndContinue("5579078521025680")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinueToCongrats("123")
    }

    func testAddAmexNoID() {
        //AT de MLM
        _ = MainScreen()
            .tapClearButton()
            .fillAccessToken("TEST-1178809857150049-022812-1b795ddd0f07c85489b50d6f827b0600-411553753")
            .tapAddCardButton()
            .completeNumberAndContinue("371180303257522")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinueToCongrats("1234")
    }

    func testAddHipercardMLB() {
        _ = MainScreen()
            .tapClearButton()
            .fillAccessToken("TEST-7182822688046193-022812-1fc2bafbe7ce8a723231331c8b383aee-411549390")
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
            .changeSkipCongratsSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillAccessToken("TEST-2339206676136732-022711-66711b94df7125aff837f84ca14210df-410998299")
            .tapAddCardButton()
            .completeNumberAndContinue("4111111111111111")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndFinish("12345678")
    }
}

