//
//  PrescriptionRouter.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class PrescriptionRouter {
    
    static let viewControllerBuilder = PrescriptionViewControllerBuilder()
    
    static func routeToPrescriptionFormViewController(formType: PrescriptionRequestFormType,
                                                      nextFormType: PrescriptionRequestFormType,
                                                      prescriptionInformation: PrescriptionInformation,
                                                      from navigationController: UINavigationController) {
        let viewController = viewControllerBuilder.buildPrescriptionFormViewController(
            formType: formType,
            nextFormType: nextFormType,
            prescriptionInformation:prescriptionInformation
        )
        navigationController.pushViewController(viewController, animated: true)
    }
}
