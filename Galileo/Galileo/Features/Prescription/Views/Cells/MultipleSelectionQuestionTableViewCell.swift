//
//  MultipleSelectionQuestionTableViewCell.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class MultipleSelectionQuestionTableViewCell: UITableViewCell, NibLoadable {
    
    var switchButtonChanged: ((_ isOn: Bool) -> Void)?
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    @IBAction func switchButtonValueChanged(_ sender: UISwitch) {
        switchButtonChanged?(sender.isOn)
    }
}
