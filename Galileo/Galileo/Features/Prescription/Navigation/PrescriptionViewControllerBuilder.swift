//
//  PrescriptionViewControllerBuilder.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class PrescriptionViewControllerBuilder {
    
    func buildPrescriptionFormViewController(flow: PrescriptionRequestFormFlow,
                                             responseDictionary: [String: [[String: Any]]]?,
                                             prescriptionInformation: PrescriptionInformation) -> PrescriptionFormViewController {
        let viewController = UIStoryboard.instantiateViewControllerOfType(PrescriptionFormViewController.self)
        
        viewController.flow = flow
        viewController.responseDictionary = responseDictionary
        viewController.prescriptionInformation = prescriptionInformation
        
        return viewController
    }
}
