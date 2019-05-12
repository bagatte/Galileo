//
//  FreeTextQuestionTableViewCell.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class FreeTextQuestionTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!
    
    var textChanged: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.delegate = self
    }
    
    func layout(title: String) {
        titleLabel.text = title
        
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1.0
    }
}

extension FreeTextQuestionTableViewCell: UITextViewDelegate {
    
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
}
