//
//  PrecriptionDataProviderTests.swift
//  GalileoTests
//
//  Created by bagatte on 5/12/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class PrecriptionDataProviderTests: XCTestCase {

    private let dataProvider: PrecriptionDataProvider = StaticPrecriptionDataProvider()

    func testLipitorAndAmoxilPrescriptionRequest() {
        dataProvider.lipitorAndAmoxilPrescriptionRequest { result in
            switch result {
            case .success(let prescriptionInformation):
                XCTAssertEqual(prescriptionInformation.forms[0].type, .generic)
                XCTAssertEqual(prescriptionInformation.forms[1].type, .batch)
                XCTAssertEqual(prescriptionInformation.forms[2].type, .medicationSpecific)
                
                XCTAssertEqual(prescriptionInformation.forms.count, 3)
                XCTAssertEqual(prescriptionInformation.medications.count, 2)
                
            case .error(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}
