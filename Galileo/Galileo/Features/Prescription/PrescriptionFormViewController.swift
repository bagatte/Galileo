//
//  PrescriptionFormViewController.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class PrescriptionFormViewController: UIViewController {
    
    private enum Row {
        case title(text: String)
        case freeText(title: String)
        case multipleSelection(title: String)
    }
    
    private enum Section {
        case rows(_ rows: [Row])
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var bottomButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Public properties
    
    var prescriptionInformation: PrescriptionInformation!
    var formType: PrescriptionRequestFormType!
    var nextFormType: PrescriptionRequestFormType!
    
    // MARK: - Private properties
    
    private var sections: [Section] = []
    private var medications: [Medication] {
        return prescriptionInformation.medications
    }
    
    // MARK: - Lyfecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = setupSections()
        
        tableView.register(QuestionTitleTableViewCell.self)
        tableView.register(FreeTextQuestionTableViewCell.self)
        tableView.register(MultipleSelectionQuestionTableViewCell.self)
    }
    
    // MARK: - Private methods
    
    private func setupGenericFormSections(from forms: [PrescriptionForm]) -> [Section] {
        var sections: [Section] = []
        var rows: [Row] = []
        
        for form in forms {
            for question in form.questions {
                rows.append(.title(text: question.text))
                
                for medication in medications {
                    if let multipleSelectionQuestion = question as? MultipleSelectionQuestion {
                        for answerChoice in multipleSelectionQuestion.answerChoices {
                            rows.append(.multipleSelection(title: answerChoice.text))
                        }
                    } else {
                        rows.append(.freeText(title: medication.name))
                    }
                }
                
                sections.append(Section.rows(rows))
            }
        }
        
        return sections
    }
    
    private func setupBatchFormSections(from forms: [PrescriptionForm]) -> [Section] {
        var sections: [Section] = []
        var rows: [Row] = []
        
        for form in forms {
            rows = []
            
            for question in form.questions {
                rows.append(.title(text: question.text))
                
                if let multipleSelectionQuestion = question as? MultipleSelectionQuestion {
                    for answerChoice in multipleSelectionQuestion.answerChoices {
                        rows.append(.multipleSelection(title: answerChoice.text))
                    }
                } else {
                    rows.append(.freeText(title: question.text))
                }
                
                sections.append(Section.rows(rows))
            }
        }
        
        return sections
    }
    
    private func setupMedicationSpecificFormSections(from forms: [PrescriptionForm]) -> [Section] {
        var sections: [Section] = []
        var rows: [Row] = []
        
        for form in forms {
            rows = []
            
            if let medication = form.medication {
                rows.append(.title(text: "Regarding \(medication.name)"))
            }
            
            for question in form.questions {
                if let multipleSelectionQuestion = question as? MultipleSelectionQuestion {
                    for answerChoice in multipleSelectionQuestion.answerChoices {
                        rows.append(.multipleSelection(title: answerChoice.text))
                    }
                    
                } else {
                    rows.append(.freeText(title: question.text))
                }
            }
            
            sections.append(Section.rows(rows))
        }
        
        return sections
    }
    
    private func setupSections() -> [Section] {
        let forms = prescriptionInformation.forms.filter{ return $0.type == formType }
        
        if formType == .generic {
            sections = setupGenericFormSections(from: forms)
        } else if formType == .batch {
            sections = setupBatchFormSections(from: forms)
        } else if formType == .medicationSpecific {
            sections = setupMedicationSpecificFormSections(from: forms)
        }
        
        return sections
    }
    
    // MARK: - IBActions
    
    @IBAction private func bottomButtonTapped(_ sender: Any) {
        guard let navigationController = navigationController else {
            return
        }
        
        PrescriptionRouter.routeToPrescriptionFormViewController(
            formType: nextFormType,
            nextFormType: .medicationSpecific,
            prescriptionInformation: prescriptionInformation,
            from: navigationController
        )
    }
}

// MARK: - Protocol Conformance

extension PrescriptionFormViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .rows(let rows):
            return rows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .rows(let rows):
            switch rows[indexPath.row] {
            case .title(let text):
                let cell = tableView.dequeueReusableCell(QuestionTitleTableViewCell.self, forIndexPath: indexPath)
                cell.set(title: text)
                return cell
            case .freeText(let title):
                let cell = tableView.dequeueReusableCell(FreeTextQuestionTableViewCell.self, forIndexPath: indexPath)
                cell.layout(title: title)
                cell.textChanged = { [weak self] newText in
                    self?.tableView.performBatchUpdates(nil)
                }
                return cell
            case .multipleSelection(let title):
                let cell = tableView.dequeueReusableCell(MultipleSelectionQuestionTableViewCell.self, forIndexPath: indexPath)
                cell.set(title: title)
                return cell
            }
        }
    }
}

extension PrescriptionFormViewController: StoryboardInstantiable {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard.prescriptionStoryboard
    }
}
