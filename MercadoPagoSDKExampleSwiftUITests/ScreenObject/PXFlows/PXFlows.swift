//
//  PXFlows.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by AUGUSTO COLLERONE ALFONSO on 16/5/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import Foundation

public class PXFlows {
    public static func startPXFlowWithCreditCardVisa() -> CongratsScreen {
        let congratsScreen = MainGroupScreen()
            .tapCardOption()
            .tapCreditCardOption()
            .completeNumberAndContinue("4509 9535 6623 3704")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToPayerCost("30666777")
            .selectPayerCostOptionAtRow(3)
            .tapPayButtonForAnyCongrats()
        return congratsScreen
    }

    public static func startPXFlowWithCreditCardMaster() -> CongratsScreen {
        let congratsScreen = MainGroupScreen()
            .tapCardOption()
            .tapCreditCardOption()
            .completeNumberAndContinue("5323 7937 3550 6106")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToIssuers("30666777")
            .selectIssuerOptionToPayerCostScreenAtRow(1)
            .selectPayerCostOptionAtRow(2)
            .tapPayButtonForAnyCongrats()
        return congratsScreen
    }

    public static func startPXFlowWithDebitCardMaestro() -> CongratsScreen {
        let congratsScreen = MainGroupScreen()
            .tapCardOption()
            .tapDebitCardOption()
            .completeNumberAndContinue("501081066 0634280114")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToReview("30666777")
            .tapPayButtonForAnyCongrats()
        return congratsScreen
    }

    public static func startPXFlowWithCashPaymentRapipago() -> CongratsScreen {
        let congratsScreen = MainGroupScreen()
            .tapCashOption()
            .tapRapipagoOption()
            .tapPayButtonForInstructions()
        return congratsScreen
    }
}
