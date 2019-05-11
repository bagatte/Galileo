//
//  JSONDecoder+Extensions.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

enum DecoderError: Error {
    
    case jsonDecoder
    
    var localizedDescription: String {
        switch self {
        case .jsonDecoder:
            return NSLocalizedString(
                "DecoderError.jsonDecoder.localizedDescription.",
                value: "JSON decoder failed.",
                comment: "Error description when the JSON decoding fails."
            )
        }
    }
}

extension JSONDecoder {
    
    func decode<T: Decodable>(result: Result<Data>) -> Result<T> {
        do {
            switch result {
            case .success(let data):
                let model = try decode(T.self, from: data)
                return .success(value: model)
            case .error(let error):
                return .error(error)
            }
        } catch {
            return .error(DecoderError.jsonDecoder)
        }
    }
}
