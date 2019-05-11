//
//  FileReaderTests.swift
//  GalileoTests
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class FileReaderTests: XCTestCase {

    // MARK: - Private properties
    
    private let fileReader: FileReadable = FileReader()
    
    // MARK: - Test methods
    
    func testReadPrescriptionRequestSucceeds() {
        let result = fileReader.contentsOfFile("prescription_request", fileType: .json)
        switch result {
        case .success:
            break
        case .error(let error):
            XCTFail("Failed with error: \(error.localizedDescription)")
        }
    }
    
    func testReadUnknownJsonFileFails() {
        let result = fileReader.contentsOfFile("unknown", fileType: .json)
        switch result {
        case .success:
            break
        case .error(let error):
            guard case FileReaderError.notFound = error else {
                XCTFail()
                return
            }
        }
    }
}
