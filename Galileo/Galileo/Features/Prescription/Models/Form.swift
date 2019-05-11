//
//  Form.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct Form: Decodable {

    private enum CodingKeys: String, CodingKey {
        case questions
    }
    
    // MARK: - Public properties
    
    var type: PrescriptionRequestFormType = .generic
    
    let questions: [Question]
    
    // MARK: - Initializer
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let questionsContainer = try? container.nestedUnkeyedContainer(forKey: .questions) else {
            self.questions = []
            return
        }
        
        self.questions = Form.decodeQuestions(from: questionsContainer)
    }
    
    // MARK: - Private methods
    
    private static func decodeQuestions(from container: UnkeyedDecodingContainer) -> [Question] {
        var questions: [Question] = []
        var questionsContainer = container
        
        if let count = container.count {
            for _ in 0..<count {
                if let multipleSelectionQuestion = try? questionsContainer.decode(MultipleSelectionQuestion.self) {
                    questions.append(multipleSelectionQuestion)
                } else if let freeTextQuestion = try? questionsContainer.decode(FreeTextQuestion.self) {
                    questions.append(freeTextQuestion)
                }
            }
        }
        
        return questions
    }
}
