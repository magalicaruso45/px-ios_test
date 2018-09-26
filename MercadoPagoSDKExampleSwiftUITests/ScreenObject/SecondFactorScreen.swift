//
//  SecondFactorScreen.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Demian Tejo on 25/9/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import Foundation

public class SecondFactorScreen: BaseScreen {
    private lazy var confirmButton = element("Confirmar")
    private lazy var secondFactorTextfield = firstSecureTextField()
    
    override open func waitForElements() {
        waitFor(element: secondFactorTextfield)
    }
    func completeSecondFactor(_ text: String) -> SecondFactorScreen{
        secondFactorTextfield.typeText(text)
        return self
    }
    func continueToReview() -> ReviewScreen {
        confirmButton.tap()
        return ReviewScreen()
    }
}
