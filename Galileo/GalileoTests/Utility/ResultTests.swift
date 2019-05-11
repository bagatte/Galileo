//
//  ResultTests.swift
//  GalileoTests
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class ResultTests: XCTestCase {

    private enum ResultTestError: Error {
        case resultFailed
    }
    
    // MARK: - Test mehtods
    
    func testResultSucceeds() {
        let result: Result<Bool> = Result.success(value: true)
        
        if case Result.error(let error) = result {
            XCTFail("Result failed with error: \(error)")
        }
    }
    
    func testResultFails() {
        let error = ResultTestError.resultFailed
        let result: Result<Bool> = Result.error(error)
        
        if case Result.success(_) = result {
            XCTFail("Result should fail with error: \(error)")
        }
    }
}
