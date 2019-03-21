//
//  Configurations.swift
//  MercadoPagoSDKExampleSwift
//
//  Created by Demian Tejo on 11/7/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import UIKit
import MercadoPagoSDKV4

enum PreferenceContext {
    case mla
    case mlb
    case mlm
    case discountAlwaysOn
    case discountSoldOut
    case discountByPaymentMethod
    case discountByIssuer
    case discountForAM
    case boleto
    
    func getContextDescription() -> String {
        switch self {
        case .mla:
            return "MLA Default"
        case .mlb:
            return "MLB Default"
        case .mlm:
            return "MLM Default"
        case .discountAlwaysOn:
            return "Always ON discount"
        case .discountSoldOut:
            return "Sold out discount"
        case .discountByPaymentMethod:
            return "Discount by Payment method"
        case .discountByIssuer:
            return "Discount by issuer"
        case .discountForAM:
            return "Discount for Account Money"
        case .boleto:
            return "Boleto valid case"
        }
    }
    
    func getInitConfiguration() -> InitConfiguration {
        switch self {
        case .mla:
            return mlaConfig()
        case .mlb:
            return mlbConfig()
        case .mlm:
            return mlmConfig()
        case .discountAlwaysOn:
            return discountAlwaysOnConfig()
        case .discountSoldOut:
            return discountSoldOutConfig()
        case .discountByPaymentMethod:
            return discountByPaymentMethodConfig()
        case .discountByIssuer:
            return discountByIssuerConfig()
        case .discountForAM:
            return discountForAMConfig()
        case .boleto:
            return boletoConfig()
        }
    }
    
    func mlaConfig() -> InitConfiguration {
        //collector: TETE1898701 / qatest4439
        //payer: TESTPJ7DMB1A / qatest3404
        return InitConfiguration(preferenceID: "410973637-e2c78e50-d8a6-43b9-8af2-59fd7fa6ac21",
                          publicKey: "TEST-47638845-b0ff-469d-9700-1779a2e26e44",
                          accessToken: "TEST-2339206676136732-022711-66711b94df7125aff837f84ca14210df-410998299",
                          payer: "TESTPJ7DMB1A",
                          collector: "TETE1898701")
    }
    
    func mlbConfig() -> InitConfiguration {
        //collector: TETE9478140 / qatest3151
        //payer: TETE636968 / qatest9197
        return InitConfiguration(preferenceID: "411544354-b3318624-9f4c-4d3c-839a-3e716c8a383f",
                                 publicKey: "TEST-f8dbbe4e-e63e-48b1-b17f-5da486d61547",
                                 accessToken: "TEST-7182822688046193-022812-1fc2bafbe7ce8a723231331c8b383aee-411549390",
                                 payer: "TETE636968",
                                 collector: "TETE9478140")
    }
    
    func mlmConfig() -> InitConfiguration {
        //collector: TESTYWDWDD2F / qatest32
        //payer: TETE5752063 / qatest7669
        return InitConfiguration(preferenceID: "411553753-b7dce9dc-bf46-4545-91a5-bdb904b90cb8",
                                 publicKey: "TEST-d79fd045-dc90-436e-8bd0-3aef25834ead",
                                 accessToken: "TEST-1178809857150049-022812-1b795ddd0f07c85489b50d6f827b0600-411553753",
                                 payer: "TETE5752063",
                                 collector: "TESTYWDWDD2F")
    }
    
    func discountAlwaysOnConfig() -> InitConfiguration {
        return InitConfiguration(preferenceID: "384414502-d095679d-f7d9-4653-ad71-4fb5feda3494",
                                 publicKey: "APP_USR-ba2e6b8c-8b6d-4fc3-8a47-0ab241d0dba4",
                                 accessToken: "TEST-1458038826212807-062020-ff9273c67bc567320eae1a07d1c2d5b5-246046416",
                                 payer: "unknown",
                                 collector: "unknown")
    }
    
    func discountSoldOutConfig() -> InitConfiguration {
        return InitConfiguration(preferenceID: "380636546-1c7b7731-97eb-492b-a25b-2374e36f24c9",
                                 publicKey: "APP_USR-d1c95375-5137-4eb7-868e-da3ca8067d79",
                                 accessToken: "APP_USR-6094765363333165-122815-204eeee0a1ad662e7a977b2e7596a7c4-368735296",
                                 payer: "unknown",
                                 collector: "unknown")
    }
    
    func discountByPaymentMethodConfig() -> InitConfiguration {
        return InitConfiguration(preferenceID: "388462750-e44082ad-6246-4b8d-a1c0-25cae994b223",
                                 publicKey: "APP_USR-3300f176-307d-4600-9769-ad1d10d51a4a",
                                 accessToken: "TEST-1458038826212807-062020-ff9273c67bc567320eae1a07d1c2d5b5-246046416",
                                 payer: "unknown",
                                 collector: "unknown")
    }
    
    func discountByIssuerConfig() -> InitConfiguration {
        return InitConfiguration(preferenceID: "388466010-9b7f0eab-e1aa-4098-bb3c-c95244308274",
                                 publicKey: "APP_USR-013db0be-9f4a-494f-acc8-44bd3f3e75a2",
                                 accessToken: "TEST-1458038826212807-062020-ff9273c67bc567320eae1a07d1c2d5b5-246046416",
                                 payer: "unknown",
                                 collector: "unknown")
    }
    
    func discountForAMConfig() -> InitConfiguration {
        return InitConfiguration(preferenceID: "413655952-2a137fcf-2fbc-4926-be95-4d8077341e2f",
                                 publicKey: "APP_USR-6167c43b-8bfa-4eb5-b4b8-b66b15246f19",
                                 accessToken: "TEST-5511028488113173-010314-a0d3138592c4e0281dda29f840baa4f5-384294267",
                                 payer: "unknown",
                                 collector: "unknown")
    }
    
    func boletoConfig() -> InitConfiguration {
        return InitConfiguration(preferenceID: "245099733-8771f469-d68e-4863-b8cb-9402e22c6bb2",
                                 publicKey: "APP_USR-f3f035a2-d343-4a6f-bd3b-fc3c3cb72416",
                                 accessToken: "",
                                 payer: "unknown",
                                 collector: "unknown")
    }
}

struct InitConfiguration {
    var preferenceID: String
    var publicKey: String
    var accessToken: String
    var payer: String
    var collector: String
}

struct Configurations {
    var comisiones: Bool
    var descuento: Bool
    var fullCustomization: Bool
    var paymentPlugin: Bool
    var paymentPluginViewController: Bool
    var businessResult: Bool
    var maxRedeemPerUser: Double
    var skipCongrats: Bool
    var accessToken: Bool
    var oneTap: Bool
    var advancedConfiguration: Bool
    var splitPayment: Bool
    var payerInfo: Bool
    var localizedTexts: Bool
    var openPreference: Bool
    var escEnabled: Bool
    var discountParams: Bool
    var preferenceContext: PreferenceContext
    var businessStatus: PXBusinessResultStatus
}
