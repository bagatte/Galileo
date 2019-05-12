//
//  NibLoadable.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

protocol NibLoadable {}

extension NibLoadable {
    
    /// Returns type name as default identifier.
    static var identifier: String {
        return String(describing: self)
    }
    
    /// Returns type name as default nib name.
    static var nibName: String {
        return String(describing: self)
    }
}
