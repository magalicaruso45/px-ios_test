//
//  RejectedTests.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Federico Bustos Fierro on 23/03/2019.
//  Copyright © 2019 Mercado Pago. All rights reserved.
//

import XCTest

class RejectedTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        sleep(500)
        super.tearDown()
    }

    func test_high_risk() {
        let _ = test_payment_error("rejected_high_risk")
    }

    func test_cc_high_risk() {
        let _ = test_payment_error("cc_rejected_high_risk")
    }

    func test_call_for_auth() {
        let _ = test_payment_error("cc_rejected_call_for_authorize")
    }

    func test_card_disabled() {
        let _ = test_payment_error("cc_rejected_card_disabled")
    }

    func test_bad_filled() {
        let _ = test_payment_error("cc_rejected_bad_filled_other")
    }

    func test_insufficient_amount() {
        let _ = test_payment_error("cc_rejected_insufficient_amount")
    }

    func test_invalid_installments() {
        let _ = test_payment_error("cc_rejected_invalid_installments")
    }

    func test_other_reason() {
        let _ = test_payment_error("cc_rejected_other_reason")
    }

    func test_duplicated_payment() {
        let _ = test_payment_error("cc_rejected_duplicated_payment")
    }

    func test_fraud() {
        let _ = test_payment_error("cc_rejected_fraud")
    }

    func test_blacklist() {
        let _ = test_payment_error("cc_rejected_blacklist")
    }

    func test_max_attempts() {
        let _ = test_payment_error("cc_rejected_max_attempts")
    }

    func test_rejected_by_regulations() {
        let _ = test_payment_error("rejected_by_regulations")
    }

    func test_payment_error(_ statusDetail: String, isMLA: Bool = true) { //bad filled
        let main = isMLA ? configureForMLA(statusDetail) : configureForMLB(statusDetail)
        main.tapCheckoutOption()
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

    func configureForMLA(_ statusDetail: String) -> MainScreen {
        let main = MainScreen()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .configurePaymentStatusDetail(statusDetail)
            .tapPreferenceSegmentMLA()
            .tapApplyConfigurationsButton()
        return main
    }

    func configureForMLB(_ statusDetail: String) -> MainScreen {
        let main = MainScreen()
            .tapClearButton()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .configurePaymentStatusDetail(statusDetail)
            .tapPreferenceSegmentMLB()
            .tapApplyConfigurationsButton()
        return main
    }

}
