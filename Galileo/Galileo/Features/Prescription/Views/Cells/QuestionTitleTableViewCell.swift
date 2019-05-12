//
//  QuestionTitleTableViewCell.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class QuestionTitleTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet private weak var titleLabel: UILabel!
    
    func set(title: String) {
        titleLabel.text = title
    }
}
