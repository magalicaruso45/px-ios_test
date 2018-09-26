//
//  PluginViewControllerScreen.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Demian Tejo on 26/9/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import Foundation
public class PluginViewControllerScreen: BaseScreen {
    private lazy var continueButton = button("continue_button")
    override open func waitForElements() {
        waitFor(element: continueButton)
    }
    func continueCheckoutToAnyCongrats() -> CongratsScreen{
        continueButton.tap()
        return CongratsScreen()
    }
}
