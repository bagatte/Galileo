//
//  FileReaderError.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

enum FileReaderError: Error {
    case notFound
    
    var localizedDescription: String {
        switch self {
        case .notFound:
            return "No file found."
        }
    }
}
