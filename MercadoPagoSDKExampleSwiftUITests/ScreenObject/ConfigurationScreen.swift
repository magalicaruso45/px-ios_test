//
//  ConfigurationScreen.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by AUGUSTO COLLERONE ALFONSO on 11/7/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import UIKit

public class ConfigurationScreen: BaseScreen {

    private lazy var paymentProcessorSwitch = switchElement("payment_processor_switch")
    private lazy var paymentVCSwitch = switchElement("payment_vc_switch")
    private lazy var chargeSwitch = switchElement("charge_switch")
    private lazy var accessTokenSwitch = switchElement("access_token_switch")
    private lazy var businessSwitch = switchElement("business_switch")
    private lazy var fullCustomizationSwitch = switchElement("full_customization_switch")
    private lazy var addCardFlowSkipCongratsSwitch = switchElement("skip_congrats_switch")
    private lazy var advancedSwitch = switchElement("advanced_switch")
    private lazy var oneTapSwitch = switchElement("one_tap_switch")
    private lazy var splitSwitch = switchElement("split_switch")
    private lazy var payerInfoSwitch = switchElement("payer_info_switch")
    private lazy var localizedSwitch = switchElement("localized_texts_switch")
    private lazy var openPrefSwitch = switchElement("open_pref_switch")
    private lazy var escSwitch = switchElement("esc_switch")
    private lazy var discountParamsSwitch = switchElement("discount_switch")
    
    
    private lazy var businessSegment = element("business_segment")
    private lazy var countrySegment = element("country_segment")
    private lazy var preferenceSegment = element("preference_segment")
    
    private lazy var maxRedeemPerUserStepper = stepper("max_redeem_per_user_stepper")
    private lazy var applyConfigsButton = button("apply_configs_button")
    private lazy var mlaButton = button("Argentina")
    private lazy var mlbButton = button("Brasil")
    private lazy var mlmButton = button("México")
    private lazy var discountAlwaysOnButton = button("Always On")
    private lazy var discountSoldoutButton = button("Soldout")
    private lazy var discountByPaymentMethodButton = button("PM")
    private lazy var discountByIssuerButton = button("Issuer")
    private lazy var discountForAMButton = button("AM")
    private lazy var boletoButton = button("Boleto")
    private lazy var approvedButton = button("Approved")
    private lazy var pendingButton = button("Pending")
    private lazy var rejectedButton = button("Rejected")

    func tapApplyConfigurationsButton() -> MainScreen {
        applyConfigsButton.tap()
        return MainScreen()
    }
    
    func changePaymentProcessorSwitch() -> ConfigurationScreen {
        paymentProcessorSwitch.tap()
        return self
    }

    func changePaymentVCSwitchSwitch() -> ConfigurationScreen {
        paymentVCSwitch.tap()
        return self
    }

    func changeChargeSwitch() -> ConfigurationScreen {
        chargeSwitch.tap()
        return self
    }

    func changeAccessTokenSwitch() -> ConfigurationScreen {
        accessTokenSwitch.tap()
        return self
    }

    func changeBusinessSwitch() -> ConfigurationScreen {
        businessSwitch.tap()
        return self
    }
    
    func changeFullCustomizationSwitch() -> ConfigurationScreen {
        fullCustomizationSwitch.tap()
        return self
    }
    
    func changeSkipCongratsSwitch() -> ConfigurationScreen {
        addCardFlowSkipCongratsSwitch.tap()
        return self
    }

    func changeAdvancedSwitch() -> ConfigurationScreen {
        advancedSwitch.tap()
        return self
    }

    func changeOneTapSwitch() -> ConfigurationScreen {
        oneTapSwitch.tap()
        return self
    }

    func changeSplitSwitch() -> ConfigurationScreen {
        splitSwitch.tap()
        return self
    }
    
    func changePayerInfoSwitch() -> ConfigurationScreen {
        payerInfoSwitch.tap()
        return self
    }

    func changeLocalizedTextsSwitch() -> ConfigurationScreen {
        localizedSwitch.tap()
        return self
    }
    
    func changeESCSwitch() -> ConfigurationScreen {
        escSwitch.tap()
        return self
    }
    
    func changeOpenPrefSwitch() -> ConfigurationScreen {
        openPrefSwitch.tap()
        return self
    }
    
    func changeDiscountParamsSwitch() -> ConfigurationScreen {
        discountParamsSwitch.tap()
        return self
    }
    
    func tapBusinessSegmentApproved() -> ConfigurationScreen {
        approvedButton.tap()
        return self
    }
    
    func tapBusinessSegmentPending() -> ConfigurationScreen {
        pendingButton.tap()
        return self
    }
    
    func tapBusinessSegmentRejected() -> ConfigurationScreen {
        rejectedButton.tap()
        return self
    }
    
    func tapPreferenceSegmentMLA() -> ConfigurationScreen {
        mlaButton.tap()
        return self
    }
    
    func tapPreferenceSegmentMLB() -> ConfigurationScreen {
        mlbButton.tap()
        return self
    }
    
    func tapPreferenceSegmentMLM() -> ConfigurationScreen {
        mlmButton.tap()
        return self
    }
    
    func tapPreferenceSegmentDiscountAlwaysOn() -> ConfigurationScreen {
        discountAlwaysOnButton.tap()
        return self
    }
    
    func tapPreferenceSegmentDiscountSoldout() -> ConfigurationScreen {
        discountSoldoutButton.tap()
        return self
    }
    
    func tapPreferenceSegmentDiscountByPaymentMethod() -> ConfigurationScreen {
        discountByPaymentMethodButton.tap()
        return self
    }
    
    
    func tapPreferenceSegmentDiscountByIssuer() -> ConfigurationScreen {
        discountByIssuerButton.tap()
        return self
    }
    
    func tapPreferenceSegmentDiscountForAM() -> ConfigurationScreen {
        discountForAMButton.tap()
        return self
    }
    
    func tapPreferenceSegmentBoleto() -> ConfigurationScreen {
        boletoButton.tap()
        return self
    }
    
    func incrementMaxRedeemPerUserStepperBy(_ int: Int) -> ConfigurationScreen {
        for _ in 1...int {
            maxRedeemPerUserStepper.buttons["Increment"].tap()
        }
        return self
    }

    func decrementMaxRedeemPerUserStepperBy(_ int: Int) -> ConfigurationScreen {
        for _ in 1...int {
            maxRedeemPerUserStepper.buttons["Decrement"].tap()
        }
        return self
    }

    override open func waitForElements() {
        waitFor(element: paymentProcessorSwitch)
    }
}
