//
//  UIStoryboard+StoryboardInstantiable.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable {
    
    /// Storyboard.
    static var storyboard: UIStoryboard { get }
}

extension StoryboardInstantiable {
    
    /// Returns type name as default identifier.
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    
    static var prescriptionStoryboard: UIStoryboard {
        return UIStoryboard(name: "Prescription", bundle: nil)
    }
    
    static func instantiateViewControllerOfType<T: StoryboardInstantiable>(_ t: T.Type) -> T {
        guard let viewController = T.storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Could not instantiate view controller from storyboard.")
        }
        
        return viewController
    }
}
