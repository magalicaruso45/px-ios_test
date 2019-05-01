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
    private lazy var payButton = button("Confirmar")
    private lazy var changePaymentMethodButton = otherElement("Cambiar medio de pago")
    private lazy var changePayerInfoButton = otherElement("review_change_payer_action")
    private lazy var backButton = getBackButton()

    override open func waitForElements() {
        waitFor(element: payButton)
    }

    func tapPayButtonForApproved() -> ApprovedScreen {
        payButton.tap()
        return ApprovedScreen()
    }

    func tapPayButtonForRejected() -> RejectedScreen {
        payButton.tap()
        return RejectedScreen()
    }

    func tapPayButtonForPending() -> PendingScreen {
        payButton.tap()
        return PendingScreen()
    }

    func tapPayButtonForInstructions() -> InstructionsScreen {
        payButton.tap()
        return InstructionsScreen()
    }

    func tapPayButtonForAnyCongrats() -> CongratsScreen {
        swipeUp()
        payButton.tap()
        return CongratsScreen()
    }

    func tapPayButtonForPluginProcessorViewController() -> PluginViewControllerScreen {
        swipeUp()
        payButton.tap()
        return PluginViewControllerScreen()
    }

    func tapChangePaymentMethod() -> MainGroupScreen {
        swipeUp()
        let button = XCUIApplication().scrollViews.otherElements.staticTexts["Cambiar medio de pago"].firstMatch
        button.tap()
        return MainGroupScreen()
    }

    func tapChangePaymentMethodWithCardId() -> CardsOptionsScreen {
        swipeUp()
        let button = XCUIApplication().scrollViews.otherElements.staticTexts["Cambiar medio de pago"].firstMatch
        return CardsOptionsScreen()
    }

    func tapBackButtonToPayerCostScreen() -> PayerCostScreen {
        backButton.tap()
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
