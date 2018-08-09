//
//  PXDiscountUITest.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by AUGUSTO COLLERONE ALFONSO on 11/7/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import XCTest

class PXDiscountUITest: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_descuento_integrador_con_tope() { //Tarjeta MASTER con cuotas SIN INTERES
        MainScreen()
            .tapClearButton()
            .fillPublicKey("APP_USR-b8925182-e1bf-4c0e-bc38-1d893a19ab45")
            .fillPreferenceId("241261700-459d4126-903c-4bad-bc05-82e5f13fa7d3")
            .tapConfigurationsButton()
            .changePaymentPluginSwitch()
            .changeDiscountSwitch()
            .incrementMaxRedeemPerUserStepperBy(2)
            .changeTopeDeDescuentoSwitch()
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
            .validate(validationAssets: { (groupsScreen) in
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_main_value_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_secondary_value_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_title_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_disclaimer_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.imageView("floating_row_chevron_image_view")))
            })
            .tapFloatingRowToDiscountDetail()
            .validate(validationAssets: { (discountDetailScreen) in
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_title_label")))
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_disclaimer_label")))
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_footer_label")))
                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_description_label")))
            })
            .tapCloseButtonToGroupsScreen()
            .tapCardOption()
            .tapCreditCardOption()
            .completeNumberAndContinue("5323 7937 3550 6106")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToIssuers("30666777")
            .selectIssuerOptionToPayerCostScreenAtRow(1)
            .validate(validationAssets: { (payerCostScreen) in
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_main_value_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_secondary_value_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_title_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_disclaimer_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.imageView("floating_row_chevron_image_view")))
            })
            .tapFloatingRowToDiscountDetail()
            .validate(validationAssets: { (discountDetailScreen) in
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_title_label")))
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_disclaimer_label")))
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_footer_label")))
                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_description_label")))
            })
            .tapCloseButtonToPayerCostScreen()
            .selectPayerCostOptionAtRow(2)
    }

    func test_descuento_directo_con_payment_plugin() { //Tarjeta MASTER con cuotas SIN INTERES
        MainScreen()
            .tapClearButton()
            .fillPublicKey("APP_USR-b8925182-e1bf-4c0e-bc38-1d893a19ab45")
            .fillPreferenceId("241261700-459d4126-903c-4bad-bc05-82e5f13fa7d3")
            .tapConfigurationsButton()
            .changePaymentPluginSwitch()
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
            .validate(validationAssets: { (groupsScreen) in
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_main_value_label")))
                XCTAssertFalse(groupsScreen.exist(element: groupsScreen.element("floating_row_secondary_value_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_title_label")))
                XCTAssertFalse(groupsScreen.exist(element: groupsScreen.element("floating_row_disclaimer_label")))
                XCTAssertFalse(groupsScreen.exist(element: groupsScreen.imageView("floating_row_chevron_image_view")))
            })
            .tapFloatingRowToGroupsScreen()
            .tapCardOption()
            .tapCreditCardOption()
            .completeNumberAndContinue("5323 7937 3550 6106")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToIssuers("30666777")
            .selectIssuerOptionToPayerCostScreenAtRow(1)
            .validate(validationAssets: { (payerCostScreen) in
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_main_value_label")))
                XCTAssertFalse(payerCostScreen.exist(element: payerCostScreen.element("floating_row_secondary_value_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_title_label")))
                XCTAssertFalse(payerCostScreen.exist(element: payerCostScreen.element("floating_row_disclaimer_label")))
                XCTAssertFalse(payerCostScreen.exist(element: payerCostScreen.imageView("floating_row_chevron_image_view")))
            })
            .tapFloatingRowToPayerCost()
            .selectPayerCostOptionAtRow(2)
    }

    func test_descuento_directo_con_tope() { //Tarjeta MASTER con cuotas SIN INTERES
        MainScreen()
            .tapClearButton()
            .fillPublicKey("APP_USR-b8925182-e1bf-4c0e-bc38-1d893a19ab45")
            .fillPreferenceId("241261700-459d4126-903c-4bad-bc05-82e5f13fa7d3")
            .tapCheckoutOption()
            .validate(validationAssets: { (groupsScreen) in
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_main_value_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_secondary_value_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_title_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_disclaimer_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.imageView("floating_row_chevron_image_view")))
            })
            .tapFloatingRowToDiscountDetail()
            .validate(validationAssets: { (discountDetailScreen) in
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_title_label")))
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_disclaimer_label")))
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_footer_label")))
                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_description_label")))
            })
            .tapCloseButtonToGroupsScreen()
            .tapCardOption()
            .tapCreditCardOption()
            .completeNumberAndContinue("5323 7937 3550 6106")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToIssuers("30666777")
            .selectIssuerOptionToPayerCostScreenAtRow(1)
            .validate(validationAssets: { (payerCostScreen) in
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_main_value_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_secondary_value_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_title_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_disclaimer_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.imageView("floating_row_chevron_image_view")))
            })
            .tapFloatingRowToDiscountDetail()
            .validate(validationAssets: { (discountDetailScreen) in
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_title_label")))
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_disclaimer_label")))
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_footer_label")))
                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_description_label")))
            })
            .tapCloseButtonToPayerCostScreen()
            .selectPayerCostOptionAtRow(2)
    }

    func test_descuento_no_disponible_por_budget_agotado() { //Tarjeta MASTER con cuotas SIN INTERES
        MainScreen()
            .tapClearButton()
            .fillPublicKey("APP_USR-b8925182-e1bf-4c0e-bc38-1d893a19ab45")
            .fillPreferenceId("241261700-459d4126-903c-4bad-bc05-82e5f13fa7d3")
            .tapConfigurationsButton()
            .changeDiscountNotAvailableSwitch()
            .changeDiscountSwitch()
            .changePaymentPluginSwitch()
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
            .validate(validationAssets: { (groupsScreen) in
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_main_value_label")))
                XCTAssertFalse(groupsScreen.exist(element: groupsScreen.element("floating_row_secondary_value_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_title_label")))
                XCTAssertFalse(groupsScreen.exist(element: groupsScreen.element("floating_row_disclaimer_label")))
                    XCTAssertFalse(groupsScreen.exist(element: groupsScreen.imageView("floating_row_chevron_image_view")))
            })
            .tapFloatingRowToDiscountDetail()
            .validate(validationAssets: { (discountDetailScreen) in
                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_title_label")))

                let disclaimerLabel = discountDetailScreen.element("discount_detail_disclaimer_label")
                XCTAssertTrue(discountDetailScreen.exist(element: disclaimerLabel))
                XCTAssertTrue(disclaimerLabel.label == "Este descuento ya no aplica porque consumiste el tope máximo.")

                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_description_label")))
                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_footer_label")))
            })
            .tapCloseButtonToGroupsScreen()
            .tapCardOption()
            .tapCreditCardOption()
            .completeNumberAndContinue("5323 7937 3550 6106")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToIssuers("30666777")
            .selectIssuerOptionToPayerCostScreenAtRow(1)
            .validate(validationAssets: { (payerCostScreen) in
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_main_value_label")))
                XCTAssertFalse(payerCostScreen.exist(element: payerCostScreen.element("floating_row_secondary_value_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_title_label")))
                XCTAssertFalse(payerCostScreen.exist(element: payerCostScreen.element("floating_row_disclaimer_label")))
                XCTAssertFalse(payerCostScreen.exist(element: payerCostScreen.imageView("floating_row_chevron_image_view")))
            })
            .tapFloatingRowToDiscountDetail()
            .validate(validationAssets: { (discountDetailScreen) in
                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_title_label")))

                let disclaimerLabel = discountDetailScreen.element("discount_detail_disclaimer_label")
                XCTAssertTrue(discountDetailScreen.exist(element: disclaimerLabel))
                XCTAssertTrue(disclaimerLabel.label == "Este descuento ya no aplica porque consumiste el tope máximo.")

                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_description_label")))
                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_footer_label")))
            })
            .tapCloseButtonToPayerCostScreen()
            .selectPayerCostOptionAtRow(2)
    }

    func test_descuento_one_shot() { //Tarjeta MASTER con cuotas SIN INTERES
        MainScreen()
            .tapClearButton()
            .fillPublicKey("APP_USR-b8925182-e1bf-4c0e-bc38-1d893a19ab45")
            .fillPreferenceId("241261700-459d4126-903c-4bad-bc05-82e5f13fa7d3")
            .tapConfigurationsButton()
            .changeDiscountSwitch()
            .changePaymentPluginSwitch()
            .incrementMaxRedeemPerUserStepperBy(1)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
            .validate(validationAssets: { (groupsScreen) in
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_main_value_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_secondary_value_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_title_label")))
                XCTAssertFalse(groupsScreen.exist(element: groupsScreen.element("floating_row_disclaimer_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.imageView("floating_row_chevron_image_view")))
            })
            .tapFloatingRowToDiscountDetail()
            .validate(validationAssets: { (discountDetailScreen) in
                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_title_label")))

                let disclaimerLabel = discountDetailScreen.element("discount_detail_disclaimer_label")
                XCTAssertTrue(discountDetailScreen.exist(element: disclaimerLabel))
                XCTAssertTrue(disclaimerLabel.label == "Tope disponible para consumir en un único pago.")

                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_description_label")))
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_footer_label")))
            })
            .tapCloseButtonToGroupsScreen()
            .tapCardOption()
            .tapCreditCardOption()
            .completeNumberAndContinue("5323 7937 3550 6106")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToIssuers("30666777")
            .selectIssuerOptionToPayerCostScreenAtRow(1)
            .validate(validationAssets: { (payerCostScreen) in
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_main_value_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_secondary_value_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_title_label")))
                XCTAssertFalse(payerCostScreen.exist(element: payerCostScreen.element("floating_row_disclaimer_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.imageView("floating_row_chevron_image_view")))
            })
            .tapFloatingRowToDiscountDetail()
            .validate(validationAssets: { (discountDetailScreen) in
                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_title_label")))

                let disclaimerLabel = discountDetailScreen.element("discount_detail_disclaimer_label")
                XCTAssertTrue(discountDetailScreen.exist(element: disclaimerLabel))
                XCTAssertTrue(disclaimerLabel.label == "Tope disponible para consumir en un único pago.")

                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_description_label")))
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_footer_label")))
            })
            .tapCloseButtonToPayerCostScreen()
            .selectPayerCostOptionAtRow(2)
    }

    func test_descuento_multiple_redeem_per_user() { //Tarjeta MASTER con cuotas SIN INTERES
        MainScreen()
            .tapClearButton()
            .fillPublicKey("APP_USR-b8925182-e1bf-4c0e-bc38-1d893a19ab45")
            .fillPreferenceId("241261700-459d4126-903c-4bad-bc05-82e5f13fa7d3")
            .tapConfigurationsButton()
            .changeDiscountSwitch()
            .changePaymentPluginSwitch()
            .incrementMaxRedeemPerUserStepperBy(3)
            .tapApplyConfigurationsButton()
            .tapCheckoutOption()
            .validate(validationAssets: { (groupsScreen) in
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_main_value_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_secondary_value_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.element("floating_row_title_label")))
                XCTAssertFalse(groupsScreen.exist(element: groupsScreen.element("floating_row_disclaimer_label")))
                XCTAssertTrue(groupsScreen.exist(element: groupsScreen.imageView("floating_row_chevron_image_view")))
            })
            .tapFloatingRowToDiscountDetail()
            .validate(validationAssets: { (discountDetailScreen) in
                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_title_label")))

                let disclaimerLabel = discountDetailScreen.element("discount_detail_disclaimer_label")
                XCTAssertTrue(discountDetailScreen.exist(element: disclaimerLabel))
                XCTAssertTrue(disclaimerLabel.label == "Con cada pago en esta marca vas a consumir el tope hasta agotarlo.")

                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_description_label")))
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_footer_label")))
            })
            .tapCloseButtonToGroupsScreen()
            .tapCardOption()
            .tapCreditCardOption()
            .completeNumberAndContinue("5323 7937 3550 6106")
            .completeNameAndContinue("APRO")
            .completeExpirationDateAndContinue("1225")
            .completeCVVAndContinue("123")
            .completeNumberAndContinueToIssuers("30666777")
            .selectIssuerOptionToPayerCostScreenAtRow(1)
            .validate(validationAssets: { (payerCostScreen) in
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_main_value_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_secondary_value_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.element("floating_row_title_label")))
                XCTAssertFalse(payerCostScreen.exist(element: payerCostScreen.element("floating_row_disclaimer_label")))
                XCTAssertTrue(payerCostScreen.exist(element: payerCostScreen.imageView("floating_row_chevron_image_view")))
            })
            .tapFloatingRowToDiscountDetail()
            .validate(validationAssets: { (discountDetailScreen) in
                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_title_label")))

                let disclaimerLabel = discountDetailScreen.element("discount_detail_disclaimer_label")
                XCTAssertTrue(discountDetailScreen.exist(element: disclaimerLabel))
                XCTAssertTrue(disclaimerLabel.label == "Con cada pago en esta marca vas a consumir el tope hasta agotarlo.")

                XCTAssertFalse(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_description_label")))
                XCTAssertTrue(discountDetailScreen.exist(element: discountDetailScreen.element("discount_detail_footer_label")))
            })
            .tapCloseButtonToPayerCostScreen()
            .selectPayerCostOptionAtRow(2)
    }
}

