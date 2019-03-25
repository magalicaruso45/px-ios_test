//
//  ExamplePaymentProcessorViewController.swift
//  MercadoPagoSDKExampleSwift
//
//  Created by Demian Tejo on 26/9/18.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//
import MercadoPagoSDKV4
import UIKit

class ExamplePaymentProcessorViewController: UIViewController {
    var handler : PXPaymentProcessorNavigationHandler?
    var status: String = ""
    var businessResultStatus: PXBusinessResultStatus? = nil

    override func viewDidLoad() {
        handler?.hideLoading()
        super.viewDidLoad()
    }

    @IBAction func continueToCongrats(_ sender: Any) {
        guard let handler = handler else {
            return
        }
        let bussinessResult = PXBusinessResult(receiptId: "123", status: businessResultStatus ?? .APPROVED, title: "hola", subtitle: "nono", icon: nil, mainAction: nil, secondaryAction: nil, helpMessage: nil, showPaymentMethod: true, statementDescription: nil, imageUrl: nil, topCustomView: nil, bottomCustomView: nil, paymentStatus: status, paymentStatusDetail: "OK")
        handler.didFinishPayment(businessResult: bussinessResult)
    }
}
