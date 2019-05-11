//
//  Medication.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct Medication: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    // MARK: - Public properties
    
    let id: Int
    
    let name: String
}
