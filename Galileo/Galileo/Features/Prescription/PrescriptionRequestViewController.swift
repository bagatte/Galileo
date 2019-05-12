//
//  PrescriptionRequestViewController.swift
//  Galileo
//
//  Created by bagatte on 5/11/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class PrescriptionRequestViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var dataProvider: PrecriptionDataProvider = StaticPrecriptionDataProvider()
    private var prescriptionInformation: PrescriptionInformation?

    // MARK: - Lyfecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestLiptorAndAmoxilPrescriptions()
    }
    
    private func requestLiptorAndAmoxilPrescriptions() {
        dataProvider.lipitorAndAmoxilPrescriptionRequest { [weak self] result in
            switch result {
            case .success(let prescriptionInformation):
                self?.prescriptionInformation = prescriptionInformation
            case .error(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction private func requestPrescriptionButtonTapped(_ sender: Any) {
        guard
            let prescriptionInformation = prescriptionInformation,
            let navigationController = navigationController else {
                return
        }
        
        PrescriptionRouter.routeToPrescriptionFormViewController(
            formType: .generic,
            nextFormType: .batch,
            prescriptionInformation: prescriptionInformation,
            from: navigationController
        )
    }
}
