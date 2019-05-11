//
//  MultipleSelectionQuestion.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct MultipleSelectionQuestion: Question {
    
    let id: String
    
    let text: String
    
    var answerChoices: [MultipleSelectionAnswer]
    
    var selectedAnswers: [MultipleSelectionAnswer]
}
