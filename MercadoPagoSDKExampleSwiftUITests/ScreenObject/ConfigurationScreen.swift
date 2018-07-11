//
//  ConfigurationScreen.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by AUGUSTO COLLERONE ALFONSO on 11/7/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import UIKit

public class ConfigurationScreen: BaseScreen {

    private lazy var descuentoSwitch = switchElement("descuento_switch")
    private lazy var topeDeDescuentoSwitch = switchElement("tope_switch")
    private lazy var comisionesSwitch = switchElement("comisiones_switch")
    private lazy var applyConfigsButton = button("apply_configs_button")

    func tapApplyConfigurationsButton() -> MainScreen {
        applyConfigsButton.tap()
        return MainScreen()
    }

    func changeDiscountSwitch() -> ConfigurationScreen {
        descuentoSwitch.tap()
        return self
    }

    func changeTopeDeDescuentoSwitch() -> ConfigurationScreen {
        topeDeDescuentoSwitch.tap()
        return self
    }

    func changeComisionesSwitch() -> ConfigurationScreen {
        comisionesSwitch.tap()
        return self
    }

    override open func waitForElements() {
        waitFor(element: descuentoSwitch)
        waitFor(element: topeDeDescuentoSwitch)
        waitFor(element: comisionesSwitch)
        waitFor(element: applyConfigsButton)
    }
}
