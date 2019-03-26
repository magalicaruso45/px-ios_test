//
//  PayerInfoScreen.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by Marcelo Oscar José on 23/10/2018.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import XCTest

public class PayerInfoScreen: BaseScreen {

    private lazy var payerBoletoComponent = element("DADOS PARA VALIDAR O SEU PAGAMENTO")
    private lazy var numberTextField = textField("Número")
    private lazy var nameTextField = textField("Nome")
    private lazy var lastNameTextField = textField("Sobrenome")
    private lazy var businessName = textField("Razão Social")
    private lazy var continueButton = toolbarButton("Continuar")
    private lazy var pickerWheel = textField("Tipo")
    private lazy var backButton = getBackButton()

    override open func waitForElements() {
        waitFor(element: payerBoletoComponent)
    }

    func swapToCNPJ() -> PayerInfoScreen {
        pickerWheel.tap()
        let app = XCUIApplication()
        app.textFields["Tipo"].tap()
        sleep(1)
        app.pickerWheels["CPF"].adjust(toPickerWheelValue: "CNPJ")
        return PayerInfoScreen()
    }


    func completeNumberAndContinueToPayer(_ text: String) -> PayerInfoScreen {
        numberTextField.typeText(text)
        continueButton.tap()
        return PayerInfoScreen()
    }

    func completeNameAndContinueToPayer(_ text: String) -> PayerInfoScreen {
        nameTextField.typeText(text)
        continueButton.tap()
        return PayerInfoScreen()
    }

    func completeLastNameAndContinueToReview(_ text: String) -> ReviewScreen {
        lastNameTextField.typeText(text)
        continueButton.tap()
        return ReviewScreen()
    }

    func completeBusinessNameAndContinueToPayer(_ text: String) -> PayerInfoScreen {
        businessName.typeText(text)
        continueButton.tap()
        return PayerInfoScreen()
    }

    func completeBusinessNameAndContinueToReview(_ text: String) -> ReviewScreen {
        businessName.typeText(text)
        continueButton.tap()
        return ReviewScreen()
    }

}
