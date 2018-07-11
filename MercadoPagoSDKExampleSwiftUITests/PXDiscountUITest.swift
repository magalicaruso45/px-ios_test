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

    func test_descuento_directo_con_tope() { //Tarjeta MASTER con cuotas SIN INTERES
        MainScreen()
            .tapClearButton()
            .fillPublicKey("APP_USR-648a260d-6fd9-4ad7-9284-90f22262c18d")
            .fillPreferenceId("243966003-d0be0be0-6fd8-4769-bf2f-7f2d979655f5")
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
}

