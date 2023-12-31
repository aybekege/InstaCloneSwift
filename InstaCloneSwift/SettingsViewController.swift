//
//  SettingsViewController.swift
//  InstaCloneSwift
//
//  Created by Ege Aybek on 28.06.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signOutClicked(_ sender: Any) {
        
        do {
                   try Auth.auth().signOut()
                   self.performSegue(withIdentifier: "toStartSegue", sender: nil)
                   
               } catch {
                   print("error")
               }
    }
    
}
