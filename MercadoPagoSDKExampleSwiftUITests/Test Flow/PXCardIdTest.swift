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

    func test_nueva_tarjeta_debito() {
        let _ = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-04c0e3ac-d6f5-415a-8db1-5d555469d42e")
            .fillAccessToken("APP_USR-6519316523937252-070516-964fafa7e2c91a2c740155fcb5474280__LA_LD__-261748045")
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
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("TEST-47638845-b0ff-469d-9700-1779a2e26e44")
            .fillAccessToken("APP_USR-6519316523937252-070516-964fafa7e2c91a2c740155fcb5474280__LA_LD__-261748045")
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
            .tapApplyConfigurationsButton()
            .tapClearButton()
            .fillPublicKey("APP_USR-04c0e3ac-d6f5-415a-8db1-5d555469d42e")
            .fillAccessToken("APP_USR-6519316523937252-070516-964fafa7e2c91a2c740155fcb5474280__LA_LD__-261748045")
            .fillCardId("8620515887")
            .tapCheckoutOptionWithCardSelected()
            .completeCVVAndContinueToReview("123")
            .tapPayButtonForApproved()
            .waitForAnyCongrats()
    }
}
