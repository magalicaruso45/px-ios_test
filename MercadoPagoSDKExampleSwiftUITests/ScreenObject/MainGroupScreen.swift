//
//  MainGroupScreen.swift
//  PXFlowUITests
//
//  Created by Demian Tejo on 12/3/18.
//  Copyright © 2018 MercadoPago. All rights reserved.
//

import XCTest

public class MainGroupScreen: BaseScreen {

    lazy var vaultView = otherElement("paymentOptionImageContainer")
    lazy var cardButton = cell("Nueva tarjeta")
    lazy var cashButton = cell("Pago en efectivo")
    lazy var boletoButton = cell("Boleto Bancário")
    lazy var savedCard = cell("Terminada en 8020")
    lazy var boletoPecButton = cell("Pagamento na lotérica sem boleto")
    lazy var floatingRow = element("floating_row_main_value_label")

    override open func waitForElements() {
        waitFor(element: vaultView)
    }

    func tapFloatingRowToDiscountDetail() -> DiscountDetailModalScreen {
        tap(floatingRow)
        return DiscountDetailModalScreen()
    }

    func tapFloatingRowToGroupsScreen() -> MainGroupScreen {
        tap(floatingRow)
        return self
    }

    func tapCardOption() -> CardsOptionsScreen {
        tap(cardButton)
        return CardsOptionsScreen()
    }

    func tapCashOption() -> CashOptionsScreen {
        tap(cashButton)
        return CashOptionsScreen()
    }

    func tapAccountMoneyOptionForSecondFactor() -> SecondFactorScreen {
        tap(cellNumber(1))
        return SecondFactorScreen()
    }

    func tapSavedCardWithoutESC(index: Int) -> SecurityCodeScreen {
        tap(cellNumber(index))
        return SecurityCodeScreen()
    }

    func tapSavedCardWithESC(index: Int) -> ReviewScreen {
        tap(cellNumber(index))
        return ReviewScreen()
    }

    func tapSavedCreditCard(index: Int) -> PayerCostScreen {
        tap(cellNumber(index))
        return PayerCostScreen()
    }

    func tapAccountMoneyOptionForReview() -> ReviewScreen {
        tap(cellNumber(1))
        return ReviewScreen()
    }

    func tapBoletoOption() -> PayerInfoScreen {
        tap(boletoButton)
        return PayerInfoScreen()
    }

    func tapBoletoOptionForReview() -> ReviewScreen {
        tap(boletoButton)
        return ReviewScreen()
    }

    func tapBoletoPec() -> PayerInfoScreen {
        tap(boletoPecButton)
        return PayerInfoScreen()
    }

    func tapBoletoPecForReview() -> ReviewScreen {
        tap(boletoPecButton)
        return ReviewScreen()
    }

    func findText(_ text: String) -> MainGroupScreen {
        let element = self.element(text)
        waitFor(element: element)
        return MainGroupScreen()
    }
    
    func screenSwipeUp() -> MainGroupScreen {
        let app = XCUIApplication()
        app.otherElements.containing(.navigationBar, identifier:"Checkout Configuration").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.swipeUp()
        return self
    }
    
    func screenSwipeDown() -> MainGroupScreen {
        let app = XCUIApplication()
        app.otherElements.containing(.navigationBar, identifier:"Checkout Configuration").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.swipeDown()
        return self
    }
}

class CardsOptionsScreen: BaseScreen {
    private lazy var creditCardButton = cell("Nueva tarjeta de \ncrédito")
    private lazy var debitCardButton = cell("Nueva tarjeta de \ndébito")

    func tapCreditCardOption() -> CardScreen {
        tap(creditCardButton)
        return CardScreen()
    }

    func tapDebitCardOption() -> CardScreen {
        tap(debitCardButton)
        return CardScreen()
    }

    override func waitForElements() {
        waitFor(element: creditCardButton)
    }
}

class CashOptionsScreen: BaseScreen {
    private lazy var rapipagoButton = cell("Rapipago")

    func tapRapipagoOption() -> ReviewScreen {
        tap(rapipagoButton)
        return ReviewScreen()
    }

    override func waitForElements() {
        waitFor(element: rapipagoButton)
    }
}
