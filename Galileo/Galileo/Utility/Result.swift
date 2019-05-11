//
//  Result.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

enum Result<T> {
    case success(value : T)
    case error(Error)
}
