//
//  PrescriptionRequestFormType.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

enum PrescriptionRequestFormType: String {
    
    case generic = "generic_form"
    case batch = "batch_form"
    case medicationSpecific = "medication_specific_forms"
    
    var title: String {
        switch self {
        case .generic:
            return NSLocalizedString(
                "PrescriptionRequestFormType.generic.title.",
                value: "Generic Form",
                comment: "Generic form title."
            )
        case .batch:
            return NSLocalizedString(
                "PrescriptionRequestFormType.batch.title.",
                value: "Batch Form",
                comment: "Batch form title."
            )
        case .medicationSpecific:
            return NSLocalizedString(
                "PrescriptionRequestFormType.medicationSpecific.title.",
                value: "Medication Specific",
                comment: "Medication Specific form title."
            )
        }
    }
}
