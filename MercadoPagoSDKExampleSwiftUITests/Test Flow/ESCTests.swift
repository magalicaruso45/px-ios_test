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
        case debitCard = 2
        case creditCard = 3
    }

    enum Status {
        case approved
        case rejected
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

    func test_esc_credit_paymentScreenProcessor_oneTap() { //perform cyclic flow
        var configStep = configureFlow(screen: MainScreen(), status: .rejected, paymentScreenProcessor: true, oneTap: true, changeCredentials: true)
        let firstCycle = escOneTap(screen: configStep, escStep: nil, paymentScreenProcessor: true)
        configStep = changeBussinessResultStatus(screen: firstCycle, status: .approved, changeCredentials: true)
        let secondCycle = escOneTap(screen: configStep, escStep: false, paymentScreenProcessor: true)
        let _ = escOneTap(screen:secondCycle, escStep: true, paymentScreenProcessor: true)
    }

    func test_esc_credit_oneTap() { //perform cyclic flow
        var configStep = configureFlow(screen: MainScreen(), status: .rejected, paymentScreenProcessor: false, oneTap: true, changeCredentials: true)
        let firstCycle =  escOneTap(screen: configStep, escStep: nil, paymentScreenProcessor: false)
        configStep = changeBussinessResultStatus(screen: firstCycle, status: .approved, changeCredentials: true)
        let secondCycle = escOneTap(screen: configStep, escStep: false, paymentScreenProcessor: false)
        let _ = escOneTap(screen:secondCycle, escStep: true, paymentScreenProcessor: false)
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
        if changeCredentials {
            configurations = configurations.tapPreferenceSegmentMLAOneCard()
        }
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
            configurations = configurations.tapPreferenceSegmentMLAOneCard()
        }

        return configurations.tapApplyConfigurationsButton()
    }



    func escDebitCardGroups(screen: MainScreen, escStep: Bool?, paymentScreenProcessor: Bool) -> MainScreen {
        let finalScreen = screen
            .tapCheckoutOption()
        var nextStep: ReviewScreen
        if let escStep = escStep, !escStep {
            nextStep = finalScreen.tapSavedCardWithoutESC(index: Cards.debitCard.rawValue)
                .completeCVVAndContinueToReview("123")
        } else if escStep != nil {
            nextStep = finalScreen.tapSavedCardWithESC(index: Cards.debitCard.rawValue)
        } else {
            let securityCodeScreen = finalScreen.tapSavedCardWithoutESC(index: Cards.debitCard.rawValue)
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
    
    func escCreditCardGroups(screen: MainScreen, escStep: Bool?, paymentScreenProcessor: Bool) -> MainScreen {
        let finalScreen = screen
            .tapCheckoutOption()
        var nextStep: ReviewScreen
        finalScreen.tapSavedCreditCard(index: Cards.creditCard.rawValue)
            .selectPayerCostOptionAtRowWithoutESC(1)

        if let escStep = escStep, !escStep {
            nextStep = SecurityCodeScreen().completeCVVAndContinueToReview("123")
        }  else {
            let securityCodeScreen = SecurityCodeScreen()
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

    func escOneTap(screen: MainScreen, escStep: Bool?, paymentScreenProcessor: Bool) -> MainScreen {
        screen.tapOneTapOption()
            .tapPayButton()

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

}
