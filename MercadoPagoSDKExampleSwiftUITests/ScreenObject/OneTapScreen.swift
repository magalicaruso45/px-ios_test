//
//  OneTapScreen.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Demian Tejo on 13/11/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import XCTest

class OneTapScreen: BaseScreen {

    private lazy var payButton = button("pay_button")
    private lazy var cardCarrousel = otherElement("card_carrousel")
    
    override open func waitForElements() {
        waitFor(element: payButton)
    }

    private var  installmentButton : XCUIElement {
        get {
            return element("installment_button")
        }
    }
    
    private var currentCard : XCUIElement {
        get {
            return element("current_card")
        }
    }
    private var emptyCard : XCUIElement {
        get {
            return element("empty_card")
        }
    }
    @discardableResult
    func tapPayButtonForAnyCongrats() -> CongratsScreen {
        payButton.tap()
        return CongratsScreen()
    }
    func tapPayButtonForCVV() -> SecurityCodeScreen {
        payButton.tap()
        return SecurityCodeScreen()
    }
    func tapInstallmentButton() -> OneTapScreen {
        installmentButton.tap()
        return self
    }
    func swipeCardLeft() -> OneTapScreen {
        cardCarrousel.swipeLeft()
        return self
    }
    func swipeCardRight() -> OneTapScreen {
        cardCarrousel.swipeRight()
        return self
    }
}
