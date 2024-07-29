//
//  AlertUtils.swift
//  MantenedorCoreData
//
//  Created by Jose David Bustos H on 28-07-24.
//  Copyright © 2024 Jose David Bustos H. All rights reserved.
//

import UIKit

class AlertUtils {
    static func showAlert(on viewController: UIViewController, code: Int) {
        let title: String
        let message: String
        
        switch code {
        case 1:
            title = "Éxito"
            message = "Se grabaron sus datos."
        case 2:
            title = "Error"
            message = "No se grabaron sus datos."
        default:
            title = "Error"
            message = "Ocurrió un error."
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

