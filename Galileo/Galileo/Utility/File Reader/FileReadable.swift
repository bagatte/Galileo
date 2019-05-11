//
//  FileReadable.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

protocol FileReadable {
    
    func contentsOfFile(_ filename: String, fileType: FileType) -> Result<Data>
}
