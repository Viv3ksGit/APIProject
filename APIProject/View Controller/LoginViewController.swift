//
//  LoginViewController.swift
//  APIProject
//
//  Created by Jeffrey Neil Dsouza on 2019-11-22.
//  Copyright © 2019 com.vivekmohanan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Loginpage: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        login.layer.cornerRadius = 15.0
        login.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "AfterLogin", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

