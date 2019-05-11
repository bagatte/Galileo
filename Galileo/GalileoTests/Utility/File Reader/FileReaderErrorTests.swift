//
//  FileReaderErrorTests.swift
//  GalileoTests
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class FileReaderErrorTests: XCTestCase {

    // MARK: - Test methods
    
    func testNotFoundError() {
        do {
            try throwError(FileReaderError.notFound)
        } catch {
            guard case FileReaderError.notFound = error else {
                XCTFail()
                return
            }
        }
    }
    
    func testNotFoundErrorLocalizedDescription() {
        XCTAssertEqual(FileReaderError.notFound.localizedDescription, "No file found.")
    }
    
    // MARK: - Private methods
    
    private func throwError(_ error: FileReaderError) throws {
        throw error
    }
}
