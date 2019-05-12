//
//  PrescriptionViewControllerBuilder.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class PrescriptionViewControllerBuilder {
    
    func buildPrescriptionFormViewController(formType: PrescriptionRequestFormType,
                                             nextFormType: PrescriptionRequestFormType,
                                             prescriptionInformation: PrescriptionInformation) -> PrescriptionFormViewController {
        let viewController = UIStoryboard.instantiateViewControllerOfType(PrescriptionFormViewController.self)
        
        viewController.formType = formType
        viewController.nextFormType = nextFormType
        viewController.prescriptionInformation = prescriptionInformation
        
        return viewController
    }
}
