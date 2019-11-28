//
//  ForgotPassword.swift
//  APIProject
//
//  Created by Jeffrey Neil Dsouza on 2019-11-28.
//  Copyright © 2019 com.vivekmohanan. All rights reserved.
//

import UIKit
import Firebase

class ForgotPassword: UIViewController {

    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var email: UITextField!
    
    @IBAction func resetPass(_ sender: Any) {
        sendPasswordReset(withEmail: email.text!)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        reset.layer.cornerRadius = 15.0
               reset.layer.masksToBounds = true
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(_ sender: UIButton) {
         dismiss(animated: true, completion:nil)
    }
    func sendPasswordReset(withEmail email: String, _ callback: ((Error?) -> ())? = nil){
               Auth.auth().sendPasswordReset(withEmail: email) { error in
                callback?(error)
                       if error  == nil {
                           self.performSegue(withIdentifier: "Forgetpass", sender: self)
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


