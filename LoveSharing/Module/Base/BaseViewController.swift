//
//  BaseViewController.swift
//  LoveSharing
//
//  Created by Prem Pratap Singh on 19/10/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var interactor: BaseInteractor!
    
    func presentError(messege: String) {
        let alertController = UIAlertController(title: "Error".localizedCapitalized,
                                                message: messege,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok".localizedCapitalized, style: .default, handler: { _ in
            alertController.dismiss(animated: false)
        })
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
