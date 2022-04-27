//
//  EmailController.swift
//  DatingApp2
//
//  Created by Jonathan Hernandez on 4/5/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUoElements()
    }
    
    func setUoElements() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTF)
        
        Utilities.styleTextField(lastNameTF)
        
        Utilities.styleTextField(emailTF)
        
        Utilities.styleTextField(passwordTF)
        
        Utilities.styleFilledButton(signupButton)
        
    }
    
    func validateFields() -> String? {
        
        //Check that all the fields are filled in
        if firstNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all lines"
        }
        
        //check if the password is secured
        
        let cleanedPassword = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //Password isnt secure enough
            return "Please make sure your password is at least 8 characters, contains a special charatcer and a number."
        }
        
        return nil
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            //theres something wrong with the fields, show error message
            showError(error!)
        } else {
            
            // create the user
                let firstName = firstNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let lastName = lastNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                //check for errors
                
                if err != nil {
                    self.showError("Error creating users")
                } else {
                    //user was created succesfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstName": firstName, "lastname": lastName, "uid": result!.user.uid ]) { (error) in
                        
                        //show error message
                        if error != nil {
                            self.showError("User name couldnt be created")
                        }
                    }
                    
                    //transition to the home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.StoryBoard.homeViewController) as? HomeController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
}
