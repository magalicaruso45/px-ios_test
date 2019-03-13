//
//  IdentificationScreen.swift
//  PXFlowUITests
//
//  Created by Demian Tejo on 16/3/18.
//  Copyright © 2018 MercadoPago. All rights reserved.
//

import XCTest

public class IdentificationScreen: BaseScreen {

    private lazy var numberTextField = textField("Número")
    private lazy var continueButton = toolbarButton("Continuar")
    private lazy var backButton = getBackButton()

    override open func waitForElements() {
        waitFor(element: numberTextField)
    }

    func completeNumberAndContinueToPayerCost(_ text: String) -> PayerCostScreen {
        numberTextField.typeText(text)
        continueButton.tap()
        return PayerCostScreen()
    }

    func completeNumberAndContinueToIssuers(_ text: String) -> IssuersScreen {
        numberTextField.typeText(text)
        continueButton.tap()
        return IssuersScreen()
    }

    func completeNumberAndContinueToReview(_ text: String) -> ReviewScreen {
        numberTextField.typeText(text)
        continueButton.tap()
        return ReviewScreen()
    }

    func tapBackButtonToCardScreen() -> CardScreen {
        backButton.tap()
        return CardScreen()
    }
    
    func completeNumberAndContinueToCongrats(_ text: String) -> CongratsScreen {
        numberTextField.typeText(text)
        continueButton.tap()
        return CongratsScreen()
    }
    
    func completeNumberAndFinish(_ text: String) {
        numberTextField.typeText(text)
        continueButton.tap()
    }
    
}
