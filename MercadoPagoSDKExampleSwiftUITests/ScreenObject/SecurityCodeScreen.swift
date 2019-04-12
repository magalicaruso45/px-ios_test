//
//  SecurityCodeScreen.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Marcelo Oscar José on 11/08/2018.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import XCTest

public class SecurityCodeScreen: BaseScreen {

    private lazy var securityCodeTextField = textField("security_code")
    private lazy var continueToolbarButton = toolbarButton("Continuar")

    override open func waitForElements() {
        waitFor(element: securityCodeTextField)
    }

    func completeCVVAndContinueToReview(_ text: String) -> ReviewScreen {
        waitFor(element: securityCodeTextField)
        securityCodeTextField.tap()
        securityCodeTextField.typeText(text)
        continueToolbarButton.tap()
        return ReviewScreen()
    }

    @discardableResult
    func completeCVVAndContinue(_ text: String) -> BaseScreen {
        waitFor(element: securityCodeTextField)
        securityCodeTextField.tap()
        securityCodeTextField.typeText(text)
        continueToolbarButton.tap()
        return BaseScreen()
    }

    func hasCVV() -> Bool{
        return waitFor(element: securityCodeTextField, time: 3, terminate: false)
    }

    
    func completeCVVAndContinueToAnyCongrats(_ text: String) -> CongratsScreen {
        waitFor(element: securityCodeTextField)
        securityCodeTextField.tap()
        securityCodeTextField.typeText(text)
        continueToolbarButton.tap()
        return CongratsScreen()
    }
}
