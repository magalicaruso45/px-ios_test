//
//  Configurations.swift
//  MercadoPagoSDKExampleSwift
//
//  Created by Demian Tejo on 11/7/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import UIKit

enum CountryContext {
    case mla
    case mlb
    case mlm
    
    func getInitConfiguration() -> InitConfiguration {
        switch self {
        case .mla:
            return mlaConfig()
        case .mlb:
            return mlbConfig()
        case .mlm:
            return mlmConfig()
        default:
            return mlaConfig()
        }
    }
    
    func mlaConfig() -> InitConfiguration {
        //collector: TETE1898701 / qatest4439
        //payer: TESTPJ7DMB1A / qatest3404
        return InitConfiguration(preferenceID: "410973637-e2c78e50-d8a6-43b9-8af2-59fd7fa6ac21",
                          publicKey: "TEST-47638845-b0ff-469d-9700-1779a2e26e44",
                          accessToken: "TEST-2339206676136732-022711-66711b94df7125aff837f84ca14210df-410998299")
    }
    
    func mlbConfig() -> InitConfiguration {
        //collector: TETE9478140 / qatest3151
        //payer: TETE636968 / qatest9197
        return InitConfiguration(preferenceID: "411544354-b3318624-9f4c-4d3c-839a-3e716c8a383f",
                                 publicKey: "TEST-f8dbbe4e-e63e-48b1-b17f-5da486d61547",
                                 accessToken: "TEST-7182822688046193-022812-1fc2bafbe7ce8a723231331c8b383aee-411549390")
    }
    
    func mlmConfig() -> InitConfiguration {
        //collector: TESTYWDWDD2F / qatest32
        //payer: TETE5752063 / qatest7669
        return InitConfiguration(preferenceID: "411553753-b7dce9dc-bf46-4545-91a5-bdb904b90cb8",
                                 publicKey: "TEST-d79fd045-dc90-436e-8bd0-3aef25834ead",
                                 accessToken: "TEST-1178809857150049-022812-1b795ddd0f07c85489b50d6f827b0600-411553753")
    }
    
    
    
    
}

struct InitConfiguration {
    var preferenceID: String
    var publicKey: String
    var accessToken: String
}

struct Configurations {
    var comisiones: Bool
    var descuento: Bool
    var tope: Bool
    var paymentPlugin: Bool
    var paymentPluginViewController: Bool
    var discountNotAvailable: Bool
    var maxRedeemPerUser: Double
    var accountMoney: Bool
    var secondFactor: Bool
    var payerInfo: Bool
    var localizedTexts: Bool
    var countryContext: CountryContext
}
