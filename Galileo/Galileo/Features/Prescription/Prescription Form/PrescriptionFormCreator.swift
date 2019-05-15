//
//  PrescriptionFormCreator.swift
//  Galileo
//
//  Created by bagatte on 5/12/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class PrescriptionFormCreator {
    
    func createGenericFormSections(from forms: [PrescriptionForm], medications: [Medication]) -> [PrescriptionFormViewController.Section] {
        var sections: [PrescriptionFormViewController.Section] = []
        var rows: [PrescriptionFormViewController.Row] = []
        
        for form in forms {
            for question in form.questions {
                rows = []
                
                rows.append(.title(text: question.text))
                
                for medication in medications {
                    if let multipleSelectionQuestion = question as? MultipleSelectionQuestion {
                        for answerChoice in multipleSelectionQuestion.answerChoices {
                            rows.append(.multipleSelection(title: answerChoice.text, questionId: question.id, answerChoice: answerChoice))
                        }
                    } else {
                        rows.append(.freeText(title: medication.name, questionId: question.id, medicationId: medication.id))
                    }
                }
                
                sections.append(PrescriptionFormViewController.Section.rows(rows))
            }
        }
        
        return sections
    }
    
    func createBatchFormSections(from forms: [PrescriptionForm]) -> [PrescriptionFormViewController.Section] {
        var sections: [PrescriptionFormViewController.Section] = []
        var rows: [PrescriptionFormViewController.Row] = []
        
        for form in forms {
            for question in form.questions {
                rows = []
                
                if let multipleSelectionQuestion = question as? MultipleSelectionQuestion {
                    rows.append(.title(text: question.text))
                    
                    for answerChoice in multipleSelectionQuestion.answerChoices {
                        rows.append(.multipleSelection(title: answerChoice.text, questionId: question.id, answerChoice: answerChoice))
                    }
                } else {
                    rows.append(.freeText(title: question.text, questionId: question.id, medicationId: nil))
                }
                
                sections.append(PrescriptionFormViewController.Section.rows(rows))
            }
        }
        
        return sections
    }
    
    func createMedicationSpecificFormSections(from forms: [PrescriptionForm]) -> [PrescriptionFormViewController.Section] {
        var sections: [PrescriptionFormViewController.Section] = []
        var rows: [PrescriptionFormViewController.Row] = []
        
        for form in forms {
            rows = []
            
            guard let medication = form.medication else {
                return sections
            }
            
            rows.append(.title(text: "Regarding \(medication.name)"))
            
            for question in form.questions {
                if let multipleSelectionQuestion = question as? MultipleSelectionQuestion {
                    rows.append(.title(text: question.text))
                    
                    for answerChoice in multipleSelectionQuestion.answerChoices {
                        rows.append(.multipleSelection(title: answerChoice.text, questionId: question.id, answerChoice: answerChoice))
                    }
                    
                } else {
                    rows.append(.freeText(title: question.text, questionId: question.id, medicationId: medication.id))
                }
            }
            
            sections.append(PrescriptionFormViewController.Section.rows(rows))
        }
        
        return sections
    }
}
