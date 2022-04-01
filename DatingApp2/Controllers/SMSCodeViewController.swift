//
//  SMSCodeViewController.swift
//  DatingApp2
//
//  Created by Jonathan Hernandez on 3/31/22.
//

import UIKit

class SMSCodeViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var codeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text, !text.isEmpty {
            let code = text
            AuthManager.shared.verifyCode(smsCode: code) { [weak self]success in
                guard success else { return }
                DispatchQueue.main.async {
                    let vc = HomeController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                }
            }
        }
        return true
    }
}
