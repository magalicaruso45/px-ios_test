//
//  PayerCostScreen.swift
//  PXFlowUITests
//
//  Created by Demian Tejo on 16/3/18.
//  Copyright © 2018 MercadoPago. All rights reserved.
//

import UIKit

public class PayerCostScreen: BaseScreen {

    private lazy var headerCellCount = 1
    private lazy var backButton = getBackButton()
    private lazy var floatingRow = element("floating_row_main_value_label")


    override open func waitForElements() {
        waitFor(element: cellNumber(1))
    }

    func selectPayerCostOptionAtRow(_ rowNumber: Int) -> ReviewScreen {
        tapRow(number: rowNumber)
        return ReviewScreen()
    }

    func tapFloatingRowToPayerCost() -> PayerCostScreen {
        floatingRow.tap()
        return self
    }

    func tapFloatingRowToDiscountDetail() -> DiscountDetailModalScreen {
        floatingRow.tap()
        return DiscountDetailModalScreen()
    }

    func tapRow(number: Int) {
        let payerCostCell = cellNumber(headerCellCount + number)
        payerCostCell.tap()
    }

    func tapBackButtonToIssuersScreen() -> IssuersScreen {
        backButton.tap()
        return IssuersScreen()
    }

    func tapBackButtonToIdentificationScreen() -> IdentificationScreen {
        backButton.tap()
        return IdentificationScreen()
    }
}
