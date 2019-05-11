//
//  PrescriptionInformation.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct PrescriptionInformation: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case medications
        case genericForm = "generic_form"
        case batchForm = "batch_form"
        case medicationSpecificForm = "medication_specific_forms"
    }
    
    // MARK: - Public properties

    let medications: [Medication]
    
    let forms: [PrescriptionForm]
    
    // MARK: - Private properties
    
    private static var medicationId: String?
    
    // MARK: - Initializer
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let medications = try container.decode([Medication].self, forKey: .medications)
        
        var genericForm = try container.decode(PrescriptionForm.self, forKey: .genericForm)
        genericForm.type = .generic
        
        var batchForm = try container.decode(PrescriptionForm.self, forKey: .batchForm)
        batchForm.type = .batch
        
        self.medications = medications
        self.forms = [genericForm] + [batchForm] + PrescriptionInformation.medicationSpecificForms(from: container, medications: medications)
        
        PrescriptionInformation.medicationId = nil
    }
    
    // MARK: - Private methods
    
    private static func medicationSpecificForms(from container: KeyedDecodingContainer<CodingKeys>, medications: [Medication]) -> [PrescriptionForm] {
        var medicationSpecificForms: [PrescriptionForm] = []
        for medication in medications {
            PrescriptionInformation.medicationId = String(medication.id)
            
            if
                let medicationSpecificFormResponse = try? container.decode(MedicationSpecificFormResponse.self, forKey: .medicationSpecificForm),
                var form = medicationSpecificFormResponse.form {
                form.type = .medicationSpecific
                form.medication = medication
                medicationSpecificForms.append(form)
            }
        }
        return medicationSpecificForms
    }
}

extension PrescriptionInformation {
    
    /*
     This structure is necessery because the JSON response returns a dynamic key based on the medication id.
     Ideally, the JSON response should be better formated so the client can avoid this workaround.
     */
    private struct MedicationSpecificFormResponse: Decodable {
        
        private struct JSONCodingKeys: CodingKey {
            
            var stringValue: String
            init?(stringValue: String) {
                self.stringValue = stringValue
            }
            
            var intValue: Int?
            init?(intValue: Int) {
                self.init(stringValue: "\(intValue)")
                self.intValue = intValue
            }
        }
        
        // MARK: - Public properties
        
        var form: PrescriptionForm?
        
        // MARK: - Initializer
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: JSONCodingKeys.self)
            
            guard
                let medicationId = PrescriptionInformation.medicationId,
                let key = JSONCodingKeys(stringValue: medicationId) else {
                    return
            }
            
            form = try container.decode(PrescriptionForm.self, forKey: key)
        }
    }
}
