//
//  OneTapScreen.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Eden Torres on 22/03/2019.
//  Copyright © 2019 Mercado Pago. All rights reserved.
//

import XCTest

public class OneTapScreen: BaseScreen {

    private lazy var payButton = button("Pagar")

    override open func waitForElements() {
        waitFor(element: payButton)
    }

    @discardableResult
    func tapPayButton() -> BaseScreen {
        payButton.tap()
        return BaseScreen()
    }
}
