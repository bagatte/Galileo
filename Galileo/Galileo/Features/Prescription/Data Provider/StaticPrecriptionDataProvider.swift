//
//  StaticPrecriptionDataProvider.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

struct StaticPrecriptionDataProvider: PrecriptionDataProvider {
    
    // MARK: - Private properties
    
    private var fileReadable: FileReadable
    
    // MARK: - Initializer
    
    init() {
        fileReadable = FileReader()
    }
    
    // MARK: - Public functions
    
    func lipitorAndAmoxilPrescriptionRequest(_ completion: ((Result<PrescriptionInformation>) -> Void)) {
        let fileResult = fileReadable.contentsOfFile("prescription_request", fileType: .json)
        let prescriptionRequestResult: Result<PrescriptionInformation> = JSONDecoder().decode(result: fileResult)
        completion(prescriptionRequestResult)
    }
}
