//
//  SigninController.swift
//  DatingApp2
//
//  Created by Jonathan Hernandez on 3/31/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class SigninController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var codeTF: UITextField!
    
    var verificationId: String = ""
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func enterButton(_ sender: Any) {
        
        guard let phoneNumber = phoneTF.text else { return }
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if (error != nil) {
                    print("Error")
                  return
                } else {
                    // Successful. User gets verification code
                    // Save verificationID in UserDefaults
                   UserDefaults.standard.set(verificationID, forKey: "firebase_verification")
                   UserDefaults.standard.synchronize()
                    self.performSegue(withIdentifier: "HomeController", sender: sender)
                }
                
            }
    }
    
    @IBAction func verifyNumber(_ sender: Any) {
        
        guard let code = codeTF.text else { return }
        guard let verification_id = userDefault.string(forKey: "verificationId") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verification_id, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { authdata, error in
            if error == nil {
                print("success")
                print("User signed in..")
                
            } else {
                print("Something went wrong..\(error?.localizedDescription)")
            }
        }
        
    }
}
