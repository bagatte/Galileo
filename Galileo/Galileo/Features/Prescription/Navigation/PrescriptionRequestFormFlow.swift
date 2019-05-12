//
//  PrescriptionRequestFormFlow.swift
//  Galileo
//
//  Created by bagatte on 5/12/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct PrescriptionRequestFormFlow {
    
    private let formsSequence: [PrescriptionRequestFormType] = [.generic, .batch, .medicationSpecific]
    
    var index: Int
    
    init(startIndex: Int) {
        self.index = startIndex
    }
    
    var current: PrescriptionRequestFormType {
        return formsSequence[index]
    }
    
    var next: PrescriptionRequestFormType? {
        let nextIndex = index + 1
        guard nextIndex < formsSequence.count else {
            return nil
        }
        
        return formsSequence[nextIndex]
    }
}
