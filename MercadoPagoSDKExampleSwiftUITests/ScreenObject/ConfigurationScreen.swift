//
//  ConfigurationScreen.swift
//  MercadoPagoSDKExampleSwiftUITests
//
//  Created by AUGUSTO COLLERONE ALFONSO on 11/7/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import UIKit
import XCTest

public class ConfigurationScreen: BaseScreen {

    private lazy var paymentProcessorSwitch = switchElement("payment_processor_switch")
    private lazy var paymentVCSwitch = switchElement("payment_vc_switch")
    private lazy var chargeSwitch = switchElement("charge_switch")
    private lazy var accessTokenSwitch = switchElement("access_token_switch")
    private lazy var exclusionsSwitch = switchElement("exclusions_switch")
    private lazy var maxInstallmentsSwitch = switchElement("max_installments_switch")
    private lazy var defaultInstallmentsSwitch = switchElement("default_installments_switch")
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
    private lazy var statusDetailButton = button("status_detail_button")
    private lazy var otherButton = button("Otro")
    private lazy var approvedButton = button("Approved")
    private lazy var pendingButton = button("Pending")
    private lazy var rejectedButton = button("Rejected")

    func configurePaymentStatusDetail(_ statusDetail: String) -> ConfigurationScreen {
        tap(statusDetailButton)
        let app = XCUIApplication()
        let textfield = app.alerts["Status detail"].textFields.firstMatch
        textfield.typeText(statusDetail)
        let okButton = app.alerts["Status detail"].buttons["Ok"]
        tap(okButton)
        return ConfigurationScreen()
    }

    func tapApplyConfigurationsButton() -> MainScreen {
        tap(applyConfigsButton)
        return MainScreen()
    }
    
    func changePaymentProcessorSwitch() -> ConfigurationScreen {
        tap(paymentProcessorSwitch)
        return self
    }

    func changePaymentVCSwitchSwitch() -> ConfigurationScreen {
        tap(paymentVCSwitch)
        return self
    }

    func changeChargeSwitch() -> ConfigurationScreen {
        tap(chargeSwitch)
        return self
    }

    func changeAccessTokenSwitch() -> ConfigurationScreen {
        tap(accessTokenSwitch)
        return self
    }

    func changeBusinessSwitch() -> ConfigurationScreen {
        tap(businessSwitch)
        return self
    }
    
    func changeFullCustomizationSwitch() -> ConfigurationScreen {
        tap(fullCustomizationSwitch)
        return self
    }
    
    func changeSkipCongratsSwitch() -> ConfigurationScreen {
        tap(addCardFlowSkipCongratsSwitch)
        return self
    }

    func changeAdvancedSwitch() -> ConfigurationScreen {
        tap(advancedSwitch)
        return self
    }

    func changeOneTapSwitch() -> ConfigurationScreen {
        tap(oneTapSwitch)
        return self
    }

    func changeSplitSwitch() -> ConfigurationScreen {
        tap(splitSwitch)
        return self
    }
    
    func changePayerInfoSwitch() -> ConfigurationScreen {
        tap(payerInfoSwitch)
        return self
    }

    func changeMaxInstallmentsSwitch() -> ConfigurationScreen {
        tap(maxInstallmentsSwitch)
        return self
    }

    func changeDefaultInstallmentsSwitch() -> ConfigurationScreen {
        tap(defaultInstallmentsSwitch)
        return self
    }

    func changeExclusionsSwitch() -> ConfigurationScreen {
        tap(exclusionsSwitch)
        return self
    }

    func changeLocalizedTextsSwitch() -> ConfigurationScreen {
        tap(localizedSwitch)
        return self
    }
    
    func changeESCSwitch() -> ConfigurationScreen {
        tap(escSwitch)
        return self
    }
    
    func changeOpenPrefSwitch() -> ConfigurationScreen {
        tap(openPrefSwitch)
        return self
    }
    
    func changeDiscountParamsSwitch() -> ConfigurationScreen {
        tap(discountParamsSwitch)
        return self
    }
    
    func tapBusinessSegmentApproved() -> ConfigurationScreen {
        tap(approvedButton)
        return self
    }
    
    func tapBusinessSegmentPending() -> ConfigurationScreen {
        tap(pendingButton)
        return self
    }
    
    func tapBusinessSegmentRejected() -> ConfigurationScreen {
        tap(rejectedButton)
        return self
    }
    
    func tapPreferenceSegmentMLA() -> ConfigurationScreen {
        tap(mlaButton)
        return self
    }

    func tapPreferenceSegmentMLB() -> ConfigurationScreen {
        tap(mlbButton)
        return self
    }
    
    func tapPreferenceSegmentMLM() -> ConfigurationScreen {
        tap(mlmButton)
        return self
    }

    func tapOtherPreferenceSegment(_ preferenceContext: PreferenceContext) -> ConfigurationScreen {
        tap(mlaButton)
        tap(otherButton)
        sleep(1)

        let identifier = preferenceContext.getContextDescription()
        let item = button(identifier)
        tap(item)
        return self
    }
    
    func incrementMaxRedeemPerUserStepperBy(_ int: Int) -> ConfigurationScreen {
        for _ in 1...int {
            tap(maxRedeemPerUserStepper.buttons["Increment"])
        }
        return self
    }

    func decrementMaxRedeemPerUserStepperBy(_ int: Int) -> ConfigurationScreen {
        for _ in 1...int {
            tap(maxRedeemPerUserStepper.buttons["Decrement"])
        }
        return self
    }

    override open func waitForElements() {
        waitFor(element: accessTokenSwitch)
    }
}
