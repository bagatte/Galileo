//
//  FreeTextQuestion.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct FreeTextQuestion: Question {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case text
    }
    
    // MARK: - Public properties

    let id: String
    
    let text: String
}
