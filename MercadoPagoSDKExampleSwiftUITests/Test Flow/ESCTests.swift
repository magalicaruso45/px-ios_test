//
//  ESCTests.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Eden Torres on 15/03/2019.
//  Copyright © 2019 Mercado Pago. All rights reserved.
//

import XCTest

class ESCTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        sleep(5)
        super.tearDown()
    }

    enum Cards: Int {
        case cabal = 6
        case visa = 5
        case amex = 1
    }

    enum Status {
        case approved
        case rejected
    }

    func test_infinite_cycle() { //perform infinite cyclic flow

        var configStep = configureFlow(screen: MainScreen(), status: .approved, paymentScreenProcessor: false, oneTap: true)
        let secondCycle = escOneTap(screen: configStep, escStep: nil, paymentScreenProcessor: false)
        for i in 0..<100 {
            let repeatingCycle = escOneTap(screen:secondCycle, escStep: nil, paymentScreenProcessor: false)
        }
        let a = 1

    }
    
    func test_esc_debit() { //perform cyclic flow
        var configStep = configureFlow(screen: MainScreen(), status: .rejected, paymentScreenProcessor: false, oneTap: false)
        let firstCycle = escDebitCardGroups(screen: configStep, escStep: nil, paymentScreenProcessor: false)
        configStep = changeBussinessResultStatus(screen: firstCycle, status: .approved)
        let secondCycle = escDebitCardGroups(screen: configStep, escStep: false, paymentScreenProcessor: false)
        let _ = escDebitCardGroups(screen:secondCycle, escStep: true, paymentScreenProcessor: false)
    }

    func test_esc_credit() { //perform cyclic flow
        var configStep = configureFlow(screen: MainScreen(), status: .rejected, paymentScreenProcessor: false, oneTap: false)
        let firstCycle = escCreditCardGroups(screen: configStep, escStep: nil, paymentScreenProcessor: false)
        configStep = changeBussinessResultStatus(screen: firstCycle, status: .approved)
        let secondCycle = escCreditCardGroups(screen: configStep, escStep: false, paymentScreenProcessor: false)
        let _ = escCreditCardGroups(screen:secondCycle, escStep: true, paymentScreenProcessor: false)
    }

    func test_esc_debit_paymentScreenProcessor() { //perform cyclic flow
        var configStep = configureFlow(screen: MainScreen(), status: .rejected, paymentScreenProcessor: true, oneTap: false)
        let firstCycle = escDebitCardGroups(screen: configStep, escStep: nil, paymentScreenProcessor: true)
        configStep = changeBussinessResultStatus(screen: firstCycle, status: .approved)
        let secondCycle = escDebitCardGroups(screen: configStep, escStep: false, paymentScreenProcessor: true)
        let _ = escDebitCardGroups(screen:secondCycle, escStep: true, paymentScreenProcessor: true)
    }

    func test_esc_credit_paymentScreenProcessor() { //perform cyclic flow
        var configStep = configureFlow(screen: MainScreen(), status: .rejected, paymentScreenProcessor: true, oneTap: false)
        let firstCycle = escCreditCardGroups(screen: configStep, escStep: nil, paymentScreenProcessor: true)
        configStep = changeBussinessResultStatus(screen: firstCycle, status: .approved)
        let secondCycle = escCreditCardGroups(screen: configStep, escStep: false, paymentScreenProcessor: true)
        let _ = escCreditCardGroups(screen:secondCycle, escStep: true, paymentScreenProcessor: true)
    }

    func test_esc_paymentScreenProcessor_oneTap() { //perform cyclic flow
        var configStep = configureFlow(screen: MainScreen(), status: .rejected, paymentScreenProcessor: true, oneTap: true, changeCredentials: true)
        let firstCycle = escOneTap(screen: configStep, escStep: nil, paymentScreenProcessor: true)
        configStep = changeBussinessResultStatus(screen: firstCycle, status: .approved, changeCredentials: true)
        let secondCycle = escOneTap(screen: configStep, escStep: false, paymentScreenProcessor: true)
        let _ = escOneTap(screen:secondCycle, escStep: true, paymentScreenProcessor: true)
    }

    func test_esc_oneTap() { //perform cyclic flow
        var configStep = configureFlow(screen: MainScreen(), status: .rejected, paymentScreenProcessor: false, oneTap: true, changeCredentials: true)
        let firstCycle =  escOneTap(screen: configStep, escStep: nil, paymentScreenProcessor: false)
        configStep = changeBussinessResultStatus(screen: firstCycle, status: .approved, changeCredentials: true)
        let secondCycle = escOneTap(screen: configStep, escStep: false, paymentScreenProcessor: false)
        let _ = escOneTap(screen:secondCycle, escStep: true, paymentScreenProcessor: false)
    }

    func test_esc_newCard() {
        var configStep = configureFlow(screen: MainScreen(), status: .approved, paymentScreenProcessor: false, oneTap: false, changeCredentials: true)
        let firstCycle =  escCreditCardGroups(screen: configStep, escStep: nil, paymentScreenProcessor: false, creditCard: .amex)
        configStep = changeBussinessResultStatus(screen: firstCycle, status: .approved, changeCredentials: true)
        let secondCycle = escNewCard(screen: configStep)
        let _ = escCreditCardGroups(screen:secondCycle, escStep: true, paymentScreenProcessor: false, creditCard: .amex)
    }
    
    func configureFlow(screen: MainScreen, status: Status, paymentScreenProcessor: Bool, oneTap: Bool, changeCredentials: Bool = false) -> MainScreen {
        let mainScreen = screen
            .tapClearButton()
            .resetExtraConfigurations()
            .tapConfigurationsButton()
            .changePaymentProcessorSwitch()
            .changeBusinessSwitch()
            .changeAccessTokenSwitch()
        var flow: ConfigurationScreen
        if status == .approved {
            flow = mainScreen.tapBusinessSegmentApproved()
        } else {
            flow = mainScreen.tapBusinessSegmentRejected()
        }
        var configurations = flow.changeAdvancedSwitch()
            .changeESCSwitch()
        if paymentScreenProcessor {
            configurations =  configurations.changePaymentVCSwitchSwitch()
        }
        if oneTap {
            configurations = configurations.changeOneTapSwitch()
        }
        let preset : PreferenceContext = changeCredentials ? .escOneCard : .manyCards
        configurations = configurations.tapOtherPreferenceSegment(preset)

        return configurations.tapApplyConfigurationsButton()
    }

    func changeBussinessResultStatus(screen: MainScreen, status: Status, changeCredentials: Bool = false) -> MainScreen {
        let mainScreen = screen.tapConfigurationsButton()
        var configurations: ConfigurationScreen
        if status == .approved {
            configurations = mainScreen.tapBusinessSegmentApproved()
        } else {
            configurations = mainScreen.tapBusinessSegmentRejected()
        }

        if changeCredentials {
            configurations = configurations.tapOtherPreferenceSegment(.escOneCard)
        }

        return configurations.tapApplyConfigurationsButton()
    }

    func escDebitCardGroups(screen: MainScreen, escStep: Bool?, paymentScreenProcessor: Bool) -> MainScreen {
        let finalScreen = screen
            .tapCheckoutOption()
        var nextStep: ReviewScreen
        if let escStep = escStep, !escStep {
            nextStep = finalScreen.tapSavedCardWithoutESC(index: Cards.cabal.rawValue)
                .completeCVVAndContinueToReview("123")
        } else if escStep != nil {
            nextStep = finalScreen.tapSavedCardWithESC(index: Cards.cabal.rawValue)
        } else {
            let securityCodeScreen = finalScreen.tapSavedCardWithoutESC(index: Cards.cabal.rawValue)
            let hasESC = !securityCodeScreen.hasCVV()
            if !hasESC {
                nextStep = securityCodeScreen.completeCVVAndContinueToReview("123")
            } else {
                nextStep = ReviewScreen()
            }
        }
        let congrats: CongratsScreen
        if paymentScreenProcessor {
            congrats = nextStep.tapPayButtonForPluginProcessorViewController()
                .continueCheckoutToAnyCongrats()
        } else {
            congrats =  nextStep.tapPayButtonForAnyCongrats()
        }

        let final = congrats.waitForAnyCongrats()
            .tapCloseButton()
        return final
    }
    
    func escCreditCardGroups(screen: MainScreen, escStep: Bool?, paymentScreenProcessor: Bool, creditCard: Cards = .visa) -> MainScreen {
        let securityCode = creditCard == .amex ? "1234" : "123"
        let finalScreen = screen
            .tapCheckoutOption()
        var nextStep: ReviewScreen
        finalScreen.tapSavedCreditCard(index: creditCard.rawValue)
            .selectPayerCostOptionAtRowWithoutESC(1)

        if let escStep = escStep, !escStep {
            nextStep = SecurityCodeScreen().completeCVVAndContinueToReview(securityCode)
        } else if escStep != nil {
            nextStep = ReviewScreen()
        } else {
            let securityCodeScreen = SecurityCodeScreen()
            let hasESC = !securityCodeScreen.hasCVV()
            if !hasESC {
                nextStep = securityCodeScreen.completeCVVAndContinueToReview(securityCode)
            } else {
                nextStep = ReviewScreen()
            }
        }
        let congrats: CongratsScreen
        if paymentScreenProcessor {
            congrats = nextStep.tapPayButtonForPluginProcessorViewController()
                .continueCheckoutToAnyCongrats()
        } else {
            congrats =  nextStep.tapPayButtonForAnyCongrats()
        }

        let final = congrats.waitForAnyCongrats()
            .tapCloseButton()
        return final
    }

    func escOneTap(screen: MainScreen, escStep: Bool?, paymentScreenProcessor: Bool) -> MainScreen {
        screen.tapOneTapOption()
            .tapPayButtonForCVV()

        if let escStep = escStep, !escStep {
            SecurityCodeScreen().completeCVVAndContinue("1234")
        } else if escStep != nil {

        } else {
            let hasESC = !SecurityCodeScreen().hasCVV()
            if !hasESC {
                SecurityCodeScreen().completeCVVAndContinue("1234")
            }
        }
        if paymentScreenProcessor {
            PluginViewControllerScreen().continueCheckoutToAnyCongrats()
        }
        let finalScreen = CongratsScreen().waitForAnyCongrats()
            .tapCloseButton()

        return finalScreen
    }

    func escNewCard(screen: MainScreen) -> MainScreen {
        screen.tapCheckoutOption()
        .tapCardOption()
        .tapCreditCardOption()
        .completeNumberAndContinue("371180600257522")
        .completeNameAndContinue("APRO")
        .completeExpirationDateAndContinue("1225")
        .completeCVVAndContinue("1243")
        .completeNumberAndContinueToPayerCost("30666777")
        .selectPayerCostOptionAtRow(1)
        .tapPayButtonForAnyCongrats()
        .waitForAnyCongrats()
        .tapCloseButton()

        return screen
    }

}
