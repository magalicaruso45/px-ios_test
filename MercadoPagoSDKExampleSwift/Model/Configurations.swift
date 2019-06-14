//
//  Configurations.swift
//  MercadoPagoSDKExampleSwift
//
//  Created by Demian Tejo on 11/7/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import UIKit
import MercadoPagoSDKV4

enum PreferenceContext : String, CaseIterable {
    case mla
    case mlb
    case mlm
    case escOneCard
    case discountAlwaysOn
    case discountSoldOut
    case discountByPaymentMethod
    case discountByIssuer
    case discountForAM
    case mla50
    case mla100
    case manyCards
    case boleto
    case oneTap
    case charges
    case pluginProcessor
    case addCardMLA
    case addCardMLB
    case addCardMLM
    case addCardNoDNI
    case gatewayMode1
    case gatewayMode2
    case gatewayMode3
    case gatewayMode4
    case gatewayMode5
    case gatewayMode6
    case marcio

    func getLanguage() -> String {
        return self.getInitConfiguration().language
    }

    func getSite() -> String {
        return self.getInitConfiguration().site
    }
    
    func getContextDescription() -> String {
        return self.rawValue
    }

    func getInitConfiguration() -> InitConfiguration {
        let path = Bundle.main.path(forResource: "Configurations", ofType: "plist")
        let map = NSDictionary(contentsOfFile: path ?? "") as? [String: Any]
        let currentData = map?[self.rawValue] as? [String:String]
        let initConfig = InitConfiguration(map: currentData)
        return initConfig
    }

}

struct InitConfiguration {
    var preferenceID: String
    var publicKey: String
    var accessToken: String?
    var payer: String?
    var collector: String?
    var title: String = "Untitled case"
    var site: String = "MLA"
    var language: String = "es"

    init(preferenceID: String, publicKey: String, accessToken: String? = nil, payer: String? = nil, collector: String? = nil, title: String? = nil, site: String? = nil, language: String? = nil) {
        self.preferenceID = preferenceID
        self.publicKey = publicKey
        self.accessToken = accessToken
        self.payer = payer
        self.collector = collector
        self.title = title ?? self.title
        self.site = title ?? self.site
        self.language = title ?? self.language
    }

    init(map: [String:String]?) {
        self.preferenceID = map?["pref_id"] ?? "unknown pref id"
        self.publicKey = map?["public_key"] ?? "unknown public key"
        self.accessToken = map?["access_token"]
        self.payer = map?["payer"]
        self.collector = map?["collector"]
        self.title = map?["title"] ?? self.title
        self.site = map?["site"] ?? self.site
        self.language = map?["language"] ?? self.language
    }
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
    var exclusions: Bool
    var maxInstallments: Bool
    var defaultInstallments: Bool
    var localizedTexts: Bool
    var openPreference: Bool
    var escEnabled: Bool
    var discountParams: Bool
    var preferenceContext: PreferenceContext
    var businessStatus: PXBusinessResultStatus
    var statusDetail: String
}
