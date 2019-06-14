//
//  ReviewScreen.swift
//  PXFlowUITests
//
//  Created by Demian Tejo on 16/3/18.
//  Copyright © 2018 MercadoPago. All rights reserved.
//

import XCTest
import UIKit

public class ReviewScreen: BaseScreen {
    private lazy var payButton = button("Pagar")
    private lazy var changePaymentMethodButton = otherElement("Cambiar medio de pago")
    private lazy var changePayerInfoButton = otherElement("review_change_payer_action")
    private lazy var backButton = getBackButton()

    override open func waitForElements() {
        waitFor(element: payButton)
    }

    func tapPayButtonForApproved() -> ApprovedScreen {
        tap(payButton)
        return ApprovedScreen()
    }

    func tapPayButtonForRejected() -> RejectedScreen {
        tap(payButton)
        return RejectedScreen()
    }

    func tapPayButtonForPending() -> PendingScreen {
        tap(payButton)
        return PendingScreen()
    }

    func tapPayButtonForInstructions() -> InstructionsScreen {
        tap(payButton)
        return InstructionsScreen()
    }

    func tapPayButtonForAnyCongrats() -> CongratsScreen {
        swipeUp()
        tap(payButton)
        return CongratsScreen()
    }

    func tapPayButtonForPluginProcessorViewController() -> PluginViewControllerScreen {
        swipeUp()
        tap(payButton)
        return PluginViewControllerScreen()
    }

    func tapChangePaymentMethod() -> MainGroupScreen {
        swipeUp()
        let button = XCUIApplication().scrollViews.otherElements.staticTexts["Cambiar medio de pago"].firstMatch
        tap(button)
        return MainGroupScreen()
    }

    func tapChangePaymentMethodWithCardId() -> CardsOptionsScreen {
        swipeUp()
        let button = XCUIApplication().scrollViews.otherElements.staticTexts["Cambiar medio de pago"].firstMatch
        return CardsOptionsScreen()
    }

    func tapBackButtonToPayerCostScreen() -> PayerCostScreen {
        tap(backButton)
        return PayerCostScreen()
    }

    func tapChangePayerInfo() -> PayerInfoScreen {
        tap(changePayerInfoButton)
        return PayerInfoScreen()
    }

    func findLabelContainsText(_ text: String) -> ReviewScreen {
        let element = self.labelContains(text)
        waitFor(element: element)
        return ReviewScreen()
    }
}
