//
//  PrescriptionFormViewController.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class PrescriptionFormViewController: UIViewController {
    
    enum Row {
        case title(text: String)
        case freeText(title: String, questionId: String, medicationId: Int?)
        case multipleSelection(title: String, questionId: String, answerChoice: AnswerChoice)
    }

    enum Section {
        case rows(_ rows: [Row])
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var bottomButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Public properties
    
    var prescriptionInformation: PrescriptionInformation!
    var flow: PrescriptionRequestFormFlow!
    var responseDictionary: [String: [[String: Any]]]?
    
    // MARK: - Private properties
    
    private var sections: [Section] = []
    private let formCreator: PrescriptionFormCreator = PrescriptionFormCreator()
    private var hasNextFlowForm: Bool {
        return prescriptionInformation.forms.contains(where: { return $0.type == flow.next })
    }
    
    // MARK: - Lyfecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        title = flow.current.title
        bottomButton.setTitle(hasNextFlowForm ? "Next" : "Submit", for: .normal)
        
        if responseDictionary == nil {
            responseDictionary = [String: [[String: Any]]]()
        }
        if responseDictionary?.keys.contains(flow.current.rawValue) == false {
            responseDictionary?[flow.current.rawValue] = []
        }
        
        sections = setupSections()
        
        tableView.register(QuestionTitleTableViewCell.self)
        tableView.register(FreeTextQuestionTableViewCell.self)
        tableView.register(MultipleSelectionQuestionTableViewCell.self)
    }
    
    // MARK: - Private methods
    
    private func setupSections() -> [Section] {
        let formType = flow.current
        let forms = prescriptionInformation.forms.filter{ return $0.type == formType }
        
        switch formType {
        case .generic:
            sections = formCreator.createGenericFormSections(from: forms, medications: prescriptionInformation.medications)
        case .batch:
            sections = formCreator.createBatchFormSections(from: forms)
        case .medicationSpecific:
            sections = formCreator.createMedicationSpecificFormSections(from: forms)
        }
        
        return sections
    }
    
    private func updateResponseDictionary<T: Comparable>(key: String, type: T.Type, id: T, answerDictionary: [String: Any]) {
        guard let dictionaries = responseDictionary?[flow.current.rawValue] else {
            return
        }
        
        for (index, dictionary) in dictionaries.enumerated() {
            if let medicationID = dictionary[key] as? T, medicationID == id {
                responseDictionary?[flow.current.rawValue]?.remove(at: index)
                break
            }
        }
        responseDictionary?[flow.current.rawValue]?.append(answerDictionary)
    }
    
    // MARK: - IBActions
    
    @IBAction private func bottomButtonTapped(_ sender: Any) {
        guard let navigationController = navigationController else {
            return
        }
        
        guard flow.next != nil, hasNextFlowForm else {
            print(responseDictionary!)
            navigationController.popToRootViewController(animated: true)
            return
        }
        
        let nextIndex = flow.index + 1
        
        PrescriptionRouter.routeToPrescriptionFormViewController(
            flow: PrescriptionRequestFormFlow(startIndex: nextIndex),
            responseDictionary: responseDictionary,
            prescriptionInformation: prescriptionInformation,
            from: navigationController
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
                return
        }
        
        let keyboardSize = keyboardFrameValue.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: tableView.contentInset.top,
                                         left: tableView.contentInset.left,
                                         bottom: keyboardSize.height,
                                         right: tableView.contentInset.right)
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.tableView.contentInset = contentInsets
            strongSelf.tableView.scrollIndicatorInsets = contentInsets
        })
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
                return
        }
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.tableView.contentInset = UIEdgeInsets(top: strongSelf.tableView.contentInset.top,
                                                             left: strongSelf.tableView.contentInset.left,
                                                             bottom: 0,
                                                             right: strongSelf.tableView.contentInset.right)
            strongSelf.tableView.scrollIndicatorInsets = UIEdgeInsets.zero
        })
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
            case .freeText(let title, let questionId, let medicationId):
                return freeTextQuestionTableViewCell(title: title, questionId: questionId, medicationId: medicationId, in: tableView, at: indexPath)
            case .multipleSelection(let title, let questionId, let answerChoice):
                return multipleSelectionCell(title: title, questionId: questionId, answerChoice: answerChoice, in: tableView, at: indexPath)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func freeTextQuestionTableViewCell(title: String,
                                               questionId: String,
                                               medicationId: Int?,
                                               in tableView: UITableView,
                                               at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(FreeTextQuestionTableViewCell.self, forIndexPath: indexPath)
        cell.layout(title: title)
        cell.textChanged = { [weak self] newText in
            self?.tableView.performBatchUpdates(nil)
            
            var answerDictionary: [String: Any] = [
                "question_id": questionId,
                "answer": newText
            ]
            if let medicationId = medicationId {
                answerDictionary["medication_id"] = medicationId
            }
            
            self?.updateResponseDictionary(key: "medication_id", type: Int.self, id: medicationId ?? 0, answerDictionary: answerDictionary)
        }
        return cell
    }
    
    private func multipleSelectionCell(title: String,
                                       questionId: String,
                                       answerChoice: AnswerChoice,
                                       in tableView: UITableView,
                                       at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MultipleSelectionQuestionTableViewCell.self, forIndexPath: indexPath)
        cell.set(title: title)
        cell.switchButtonChanged = { [weak self] isOn in
            let answerDictionary: [String: Any] = [
                "question_id": questionId,
                "choice_id": answerChoice.id,
                "is_on": isOn
            ]
            
            self?.updateResponseDictionary(key: "choice_id", type: String.self, id: answerChoice.id, answerDictionary: answerDictionary)
        }
        return cell
    }
}

extension PrescriptionFormViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension PrescriptionFormViewController: StoryboardInstantiable {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard.prescriptionStoryboard
    }
}
