//
//  DiscountDetailModalScreen.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by AUGUSTO COLLERONE ALFONSO on 11/7/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

public class DiscountDetailModalScreen: BaseScreen {
    private lazy var closeButton = button("MLModalClose")
    private lazy var titleLabel = element("discount_detail_title_label")
    private lazy var disclaimerLabel = element("discount_detail_disclaimer_label")
    private lazy var descriptionLabel = element("discount_detail_description_label")
    private lazy var footerLabel = element("discount_detail_footer_label")

    override open func waitForElements() {}

    func tapCloseButtonToGroupsScreen() -> MainGroupScreen {
        tap(closeButton)
        return MainGroupScreen()
    }

    func tapCloseButtonToPayerCostScreen() -> PayerCostScreen {
        tap(closeButton)
        return PayerCostScreen()
    }
}

