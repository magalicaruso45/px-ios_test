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

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAddVisaCard() {
        _ = MainScreen()
            .fillAccessToken("APP_USR-1505-080815-c6ea450de1bf828e39add499237d727f-312667294")
            .tapAddCardButton()
            .completeNumberAndContinue("4111111111111111")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToCongrats("12345678")
    }

    func testAddAmexCard() {
        _ = MainScreen()
            .fillAccessToken("APP_USR-1505-080815-c6ea450de1bf828e39add499237d727f-312667294")
            .tapAddCardButton()
            .completeNumberAndContinue("371180303257522")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("1234")
            .completeNumberAndContinueToCongrats("12345678")
    }

    func testMasterDebitCard() {
        _ = MainScreen()
            .fillAccessToken("APP_USR-1945000207238192-100316-bfa3a266fb63c50143034e0bef59c254-290714514")
            .tapAddCardButton()
            .completeNumberAndContinue("5579078521025680")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinueToCongrats("123")
    }

    func testAddAmexNoID() {
        //AT de MLM
        _ = MainScreen()
            .fillAccessToken("APP_USR-1945000207238192-100316-bfa3a266fb63c50143034e0bef59c254-290714514")
            .tapAddCardButton()
            .completeNumberAndContinue("371180303257522")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinueToCongrats("1234")
    }

    func testAddHipercardMLB() {
        _ = MainScreen()
            .fillAccessToken("APP_USR-1945000207238192-100317-a0ae23e7c7b588d4b735dd070725b3ac-242964413")
            .tapAddCardButton()
            .completeNumberAndContinue("6062826786276634")
            .completeNameAndContinue("JUAN PEREZ")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToCongrats("63538416397")
    }
}
