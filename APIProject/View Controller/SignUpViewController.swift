//
//  SignUpViewController.swift
//  APIProject
//
//  Created by Jeffrey Neil Dsouza on 2019-11-22.
//  Copyright © 2019 com.vivekmohanan. All rights reserved.
//

import UIKit
import Firebase

class Signup: UIViewController {

   
    @IBOutlet weak var confirmpassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var createbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        createbtn.layer.cornerRadius = 15.0
       createbtn.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createBtn(_ sender: UIButton) {
        
        if password.text != confirmpassword.text {
            
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        else
        {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error  == nil {
                    self.performSegue(withIdentifier: "Loginpagesegue", sender: self)
                }
                    else{
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
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

