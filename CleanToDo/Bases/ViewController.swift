//
//  BaseViewController.swift
//  CleanToDo
//
//  Created by Park on 2021/01/21.
//

import Foundation
import UIKit

protocol SetupLogic {
    func setup()
}

class ViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        (self as? SetupLogic)?.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        (self as? SetupLogic)?.setup()
    }
}

extension ViewController {
    func displayErrorMessage(errorMessage: String) {
        let dialog = UIAlertController(title: "오류 메세지", message: errorMessage, preferredStyle: .alert)

        let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        dialog.addAction(action)
           
        self.present(dialog, animated: true, completion: nil)
    }
}
