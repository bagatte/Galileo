//
//  PrescriptionRequest.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct PrescriptionRequest: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case medications
        case genericForm = "generic_form"
        case batchForm = "batch_form"
        case medicationSpecificForm = "medication_specific_forms"
    }
    
    // MARK: - Public properties

    let medications: [Medication]
    
    let forms: [Form]
    
    // MARK: - Private properties
    
    private static var medicationId: String = ""
    
    // MARK: - Initializer
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let medications = try container.decode([Medication].self, forKey: .medications)
        
        var genericForm = try container.decode(Form.self, forKey: .genericForm)
        genericForm.type = .generic
        
        var batchForm = try container.decode(Form.self, forKey: .batchForm)
        batchForm.type = .batch
        
        self.medications = medications
        self.forms = [genericForm] + [batchForm] + PrescriptionRequest.medicationSpecificForms(from: container, medications: medications)
        
        PrescriptionRequest.medicationId = ""
    }
    
    // MARK: - Private methods
    
    private static func medicationSpecificForms(from container: KeyedDecodingContainer<CodingKeys>, medications: [Medication]) -> [Form] {
        var medicationSpecificForms: [Form] = []
        for medication in medications {
            PrescriptionRequest.medicationId = String(medication.id)
            
            if let medicationSpecificFormResponse = try? container.decode(MedicationSpecificFormResponse.self, forKey: .medicationSpecificForm) {
                medicationSpecificForms.append(medicationSpecificFormResponse.form)
            }
        }
        return medicationSpecificForms
    }
}

extension PrescriptionRequest {
    
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
        
        var form: Form
        
        // MARK: - Initializer
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: JSONCodingKeys.self)
            form = try container.decode(Form.self, forKey: JSONCodingKeys(stringValue: PrescriptionRequest.medicationId)!)
            form.type = .medicationSpecific
        }
    }
}
