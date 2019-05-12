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
    
    static func routeToPrescriptionFormViewController(flow: PrescriptionRequestFormFlow,
                                                      responseDictionary: [String: [[String: Any]]]? = nil,
                                                      prescriptionInformation: PrescriptionInformation,
                                                      from navigationController: UINavigationController) {
        let viewController = viewControllerBuilder.buildPrescriptionFormViewController(
            flow: flow,
            responseDictionary: responseDictionary,
            prescriptionInformation:prescriptionInformation
        )
        navigationController.pushViewController(viewController, animated: true)
    }
}
