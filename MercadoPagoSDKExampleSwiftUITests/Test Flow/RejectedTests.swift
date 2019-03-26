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
        execute_payment_error_flow("rejected_high_risk")
    }

    func test_cc_high_risk() {
        execute_payment_error_flow("cc_rejected_high_risk")
    }

    func test_call_for_auth() {
        execute_payment_error_flow("cc_rejected_call_for_authorize")
    }

    func test_card_disabled() {
        execute_payment_error_flow("cc_rejected_card_disabled")
    }

    func test_bad_filled() {
        execute_payment_error_flow("cc_rejected_bad_filled_other")
    }

    func test_other_reason() {
        execute_payment_error_flow("cc_rejected_other_reason")
    }

    func test_insufficient_amount() {
        execute_payment_error_flow("cc_rejected_insufficient_amount")
    }

    func test_invalid_installments() {
        execute_payment_error_flow("cc_rejected_invalid_installments")
    }

    func test_duplicated_payment() {
        execute_payment_error_flow("cc_rejected_duplicated_payment")
    }

    func test_fraud() {
        execute_payment_error_flow("cc_rejected_fraud")
    }

    func test_blacklist() {
        execute_payment_error_flow("cc_rejected_blacklist")
    }

    func test_max_attempts() {
        execute_payment_error_flow("cc_rejected_max_attempts")
    }

    func test_rejected_by_regulations() {
        execute_payment_error_flow("rejected_by_regulations")
    }

    func test_review_manual() {
        execute_payment_error_flow("pending_review_manual")
    }

    func test_contingency() {
        execute_payment_error_flow("pending_contingency")
    }

    func test_broken_status_detail() {
        execute_payment_error_flow("broken_status_detail")
    }

    func test_broken_status() {
        execute_payment_error_flow("broken")
    }

    func test_high_risk_mlb() {
        execute_payment_error_flow("rejected_high_risk", isMLA: false)
    }

    func execute_payment_error_flow(_ statusDetail: String, isMLA: Bool = true) { //bad filled
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
