//
//  Question.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

protocol Question: Decodable {
    
    var id: String { get }
    
    var text: String { get }
}
