//
//  MultipleSelectionQuestion.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct MultipleSelectionQuestion: Question {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case answerChoices = "answers"
    }
    
    // MARK: - Public properties
    
    let id: String
    
    let text: String
    
    let answerChoices: [AnswerChoice]

    var selectedAnswers: [AnswerChoice] = []
}
