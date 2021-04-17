//
//  ErrorAlert+UIViewController.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import UIKit

extension UIViewController {
    func errorAlertShow(with error: Error) {
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription , preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Close", style: .cancel) { _ in
            return
        }
        alert.addAction(dismissAction)
        
        present(alert, animated: true, completion: nil)
    }
}
