//
//  FileReader.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct FileReader: FileReadable {
    
    func contentsOfFile(_ filename: String, fileType: FileType) -> Result<Data> {
        guard let filePath = Bundle.main.path(forResource: filename, ofType: fileType.rawValue) else {
            return .error(FileReaderError.notFound)
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            return .success(value: data)
        } catch {
            return .error(error)
        }
    }
}
