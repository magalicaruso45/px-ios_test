//
//  MainScreen.swift
//  PXFlowUITests
//
//  Created by Demian Tejo on 12/3/18.
//  Copyright © 2018 MercadoPago. All rights reserved.
//

import XCTest

public class MainScreen: BaseScreen {

    private lazy var checkoutButton = button("Start Checkout")
    private lazy var addCardButton = button("Start Card Flow")
    private lazy var clearButton = button("Clear fields")
    private lazy var configurationButton = button("Add Configurations")
    private lazy var resetExtraConfigsButton = button("Reset extra configs")
    private lazy var publicKeyField = textField("Public Key")
    private lazy var preferenceIdField = textField("Pref ID")
    private lazy var accessTokenField = textField("Access Token (Optional)")
    private lazy var cardIdField = textField("Card Id (Optional)")

    func tapCheckoutOptionForOneTap() -> OneTapScreen {
        tap(checkoutButton)
        let onetapScreen = OneTapScreen()
        return onetapScreen
    }
    
    func tapCheckoutOption() -> MainGroupScreen {
        tap(checkoutButton)
        let mainGroupScreen = MainGroupScreen()
        return mainGroupScreen
    }

    func tapOneTapOption() -> OneTapScreen {
        tap(checkoutButton)
        return OneTapScreen()
    }

    func tapCheckoutOptionOnlyCard() -> CardScreen {
        tap(checkoutButton)
        return CardScreen()
    }

    func tapCheckoutOptionWithCardSelected() -> SecurityCodeScreen {
        tap(checkoutButton)
        return SecurityCodeScreen()
    }

    func tapClearButton() -> MainScreen {
        tap(clearButton)
        return self
    }

    func fillPublicKey(_ text: String) -> MainScreen {
        tap(publicKeyField)
        publicKeyField.typeText(text)
        return self
    }

    func fillPreferenceId(_ text: String) -> MainScreen {
        tap(preferenceIdField)
        preferenceIdField.typeText(text)
        return self
    }

    func fillAccessToken(_ text: String) -> MainScreen {
        tap(accessTokenField)
        accessTokenField.typeText(text)
        return self
    }

    func fillCardId(_ text: String) -> MainScreen {
        tap(cardIdField)
        cardIdField.typeText(text)
        return self
    }

    func tapConfigurationsButton() -> ConfigurationScreen {
        tap(configurationButton)
        return ConfigurationScreen()
    }

    func resetExtraConfigurations() -> MainScreen {
        tap(resetExtraConfigsButton)
        return self
    }
    
    func tapAddCardButton() -> CardScreen{
        tap(addCardButton)
        return CardScreen()
    }

    override open func waitForElements() {
        waitFor(element: checkoutButton)
    }
}
