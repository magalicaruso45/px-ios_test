//
//  CongratsScreen.swift
//  PXFlowUITests
//
//  Created by Demian Tejo on 21/3/18.
//  Copyright © 2018 MercadoPago. All rights reserved.
//

import UIKit

public class CongratsScreen: BaseScreen {
    
    
    
    override open func waitForElements() {
       // let instructionsFooterButton = element("Cancelar pago")
       // waitFor(element: instructionsFooterButton)
        let _ = waitForAnyCongrats()
    }
//
    func waitForAnyCongrats() -> CongratsScreen {
        waitFor(element: button("result_close_button"))
        return self
    }
//
//    func waitForApprovedCongrats() -> CongratsScreen {
//        let instructionsFooterButton = cellButton("Continuar")
//        waitFor(element: instructionsFooterButton)
//        return self
//    }
//
//    func waitForRejectedCongrats() -> CongratsScreen {
//        let instructionsFooterButton = cellButton("Pagar con otro medio")
//        waitFor(element: instructionsFooterButton)
//        return self
//    }
//
//    func waitForInstructionsCongrats() -> CongratsScreen {
//        let instructionsFooterButton = cellButton("Continuar")
//        waitFor(element: instructionsFooterButton)
//        return self
//    }
}

public class ApprovedScreen: CongratsScreen {
}

public class RejectedScreen: CongratsScreen {
    private lazy var subtitleLabel = element("Continuar")
}

public class PendingScreen: CongratsScreen {
}

public class InstructionsScreen: CongratsScreen {
    private lazy var instructionsFooterButton = element("Continuar")
}

