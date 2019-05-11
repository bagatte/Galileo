//
//  FileTypeTests.swift
//  GalileoTests
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class FileTypeTests: XCTestCase {

    func testJsonFileType() {
        let plistType = FileType.json
        XCTAssertEqual(plistType.rawValue, "json")
    }
}
