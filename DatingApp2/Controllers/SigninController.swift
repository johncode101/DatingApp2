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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        codeTF.isHidden = true
    }
    
    var verificationId: String? = nil

    @IBAction func enterButton(_ sender: Any) {
        if (codeTF.isHidden) {
            if !phoneTF.text!.isEmpty {
            Auth.auth().settings?.isAppVerificationDisabledForTesting = false
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneTF.text!, uiDelegate: nil, completion: { verificationID, error in
                if error != nil {
                    print(error.debugDescription)
                } else {
                    self.verificationId = verificationID
                    self.codeTF.isHidden = false
                }
            })
        } else {
            print("Error getting the phone number")
        }
        } else {
            if verificationId != nil {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId!, verificationCode: codeTF.text!)
                Auth.auth().signIn(with: credential, completion: { authdata, error in
                    if (error != nil) {
                        print(error.debugDescription)
                    } else {
                        print("Authentication Success with Number " + (authdata?.user.phoneNumber! ?? "Phone Number"))
                    }
                })
            } else {
                print("Error in getting verification ID")
            }
        }
    }
}
