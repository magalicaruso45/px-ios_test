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
        floatingRow.tap()
        return DiscountDetailModalScreen()
    }

    func tapFloatingRowToGroupsScreen() -> MainGroupScreen {
        floatingRow.tap()
        return self
    }

    func tapCardOption() -> CardsOptionsScreen {
        cardButton.tap()
        return CardsOptionsScreen()
    }

    func tapCashOption() -> CashOptionsScreen {
        cashButton.tap()
        return CashOptionsScreen()
    }

    func tapAccountMoneyOptionForSecondFactor() -> SecondFactorScreen {
        cellNumber(1).tap()
        return SecondFactorScreen()
    }

    func tapSavedCardWithoutESC(index: Int) -> SecurityCodeScreen {
        cellNumber(index).tap()
        return SecurityCodeScreen()
    }

    func tapSavedCardWithESC(index: Int) -> ReviewScreen {
        cellNumber(index).tap()
        return ReviewScreen()
    }

    func tapSavedCreditCard(index: Int) -> PayerCostScreen {
        cellNumber(index).tap()
        return PayerCostScreen()
    }

    func tapAccountMoneyOptionForReview() -> ReviewScreen {
        cellNumber(1).tap()
        return ReviewScreen()
    }

    func tapBoletoOption() -> PayerInfoScreen {
        boletoButton.tap()
        return PayerInfoScreen()
    }

    func tapBoletoOptionForReview() -> ReviewScreen {
        boletoButton.tap()
        return ReviewScreen()
    }

    func tapBoletoPec() -> PayerInfoScreen {
        boletoPecButton.tap()
        return PayerInfoScreen()
    }

    func tapBoletoPecForReview() -> ReviewScreen {
        boletoPecButton.tap()
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
        creditCardButton.tap()
        return CardScreen()
    }

    func tapDebitCardOption() -> CardScreen {
        debitCardButton.tap()
        return CardScreen()
    }

    override func waitForElements() {
        waitFor(element: creditCardButton)
    }
}

class CashOptionsScreen: BaseScreen {
    private lazy var rapipagoButton = cell("Rapipago")

    func tapRapipagoOption() -> ReviewScreen {
        rapipagoButton.tap()
        return ReviewScreen()
    }

    override func waitForElements() {
        waitFor(element: rapipagoButton)
    }
}
