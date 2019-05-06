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
        waitFor(element: floatingRow)
        waitFor(element: backButton)
    }

    func selectPayerCostOptionAtRow(_ rowNumber: Int) -> ReviewScreen {
        tapRow(number: rowNumber)
        return ReviewScreen()
    }

    @discardableResult
    func selectPayerCostOptionAtRowWithoutESC(_ rowNumber: Int) -> SecurityCodeScreen {
        tapRow(number: rowNumber)
        return SecurityCodeScreen()
    }
    
    func tapFloatingRowToPayerCost() -> PayerCostScreen {
        tap(floatingRow)
        return self
    }

    func tapFloatingRowToDiscountDetail() -> DiscountDetailModalScreen {
        tap(floatingRow)
        return DiscountDetailModalScreen()
    }

    func tapRow(number: Int) {
        let payerCostCell = cellNumber(headerCellCount + number)
        tap(payerCostCell)
    }

    func tapBackButtonToIssuersScreen() -> IssuersScreen {
        tap(backButton)
        return IssuersScreen()
    }

    func tapBackButtonToIdentificationScreen() -> IdentificationScreen {
        tap(backButton)
        return IdentificationScreen()
    }
}
