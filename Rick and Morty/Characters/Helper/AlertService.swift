//
//  AlertService.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 18/10/20.
//

import UIKit

class AlertService {
    
    private init() {}
    
    static func alert(in vc: UIViewController, title: String, message: String, actionTitle: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { (_) in
            completion()
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
