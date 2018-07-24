//
//  DiscountDetailModalScreen.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by AUGUSTO COLLERONE ALFONSO on 11/7/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

public class DiscountDetailModalScreen: BaseScreen {
    private lazy var titleLabel = element("Mi descuento")
    private lazy var closeButton = button("MLModalClose")

    override open func waitForElements() {
        waitFor(element: titleLabel)
    }

    func tapCloseButtonToGroupsScreen() -> MainGroupScreen {
        closeButton.tap()
        return MainGroupScreen()
    }

    func tapCloseButtonToPayerCostScreen() -> PayerCostScreen {
        closeButton.tap()
        return PayerCostScreen()
    }
}

