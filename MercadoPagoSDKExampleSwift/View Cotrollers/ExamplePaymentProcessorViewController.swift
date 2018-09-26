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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func continueToCongrats(_ sender: Any) {
        guard let handler = handler else {
            return
        }
        let bussinessResult = PXBusinessResult(receiptId: "123", status: .APPROVED, title: "hola", subtitle: "nono", icon: nil, mainAction: nil, secondaryAction: nil, helpMessage: nil, showPaymentMethod: true, statementDescription: nil, imageUrl: nil, topCustomView: nil, bottomCustomView: nil, paymentStatus: "APPROVED", paymentStatusDetail: "OK")
        handler.didFinishPayment(businessResult: bussinessResult)
    }
}
