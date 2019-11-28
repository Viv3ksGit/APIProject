//
//  HomeViewController.swift
//  APIProject
//
//  Created by Jeffrey Neil Dsouza on 2019-11-21.
//  Copyright © 2019 com.vivekmohanan. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    var menushowing = false
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        performSegue(withIdentifier: "HometoSettings", sender: nil)
    }
    
    @IBAction func logout(_ sender: UIButton) {
             do {
                        try Auth.auth().signOut()
                    }
                 catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let initial = storyboard.instantiateInitialViewController()
                    UIApplication.shared.keyWindow?.rootViewController = initial
             }
            
        
    
    
    @IBAction func profilebutton(_ sender: Any) {
        performSegue(withIdentifier: "HometoProfile", sender: nil)
    }
    
    
    @IBAction func locationbutton(_ sender: Any) {
        performSegue(withIdentifier: "HometoLocation", sender: nil)
    }
    
    
    
    @IBAction func HometoNews(_ sender: Any) {
         performSegue(withIdentifier: "HometoNews", sender: nil)
    }
    

    @IBAction func openMenu(_ sender: Any) {
        if(menushowing){
            leadingConstraint.constant = -240
            UIView.animate(withDuration: 0.5){
                self.view.layoutIfNeeded()
                
            }
            menushowing = !menushowing
            
        }
        else{
            leadingConstraint.constant=0
            UIView.animate(withDuration: 0.5){
            self.view.layoutIfNeeded()
               
        }
             menushowing = !menushowing
        
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
}
