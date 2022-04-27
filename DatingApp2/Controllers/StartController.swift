//
//  StartController.swift
//  DatingApp2
//
//  Created by Jonathan Hernandez on 3/31/22.
//

import UIKit

class StartController: UIViewController {
    
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        
        Utilities.styleFilledButton(signupButton)
        Utilities.styleFilledButton(loginButton)
    }
    

    
}
