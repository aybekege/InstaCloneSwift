//
//  ViewController.swift
//  InstaCloneSwift
//
//  Created by Ege Aybek on 26.06.2023.
//

import UIKit
import Firebase
import GoogleSignIn
import GoogleSignInSwift

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
 
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var gidButton: GIDSignInButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
               
          
    }
    
    @IBAction func testButtonClicked(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
           
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }
            print(user.profile?.familyName)

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in

                if error  != nil {
                    print(error!.localizedDescription)
                } else {
                    performSegue(withIdentifier: "toTabBarVC", sender: nil)
                }
            }
        }
        
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
                  
                  Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                      if error != nil {
                          self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")

                      } else {
                          self.performSegue(withIdentifier: "toTabBarVC", sender: nil)

                      }
                  }
                  
                  
              } else {
                  makeAlert(titleInput: "Error!", messageInput: "Username/Password?")

              }
        
        
        
    }
    
  
    
    @IBAction func googleSignIn(_ sender: Any) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
           
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in

                if error  != nil {
                    print(error!.localizedDescription)
                } else {
                    performSegue(withIdentifier: "toTabBarVC", sender: nil)
                }
            }
        }
        
        
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
                   Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                       
                       if error != nil {
                           self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                       } else {
                           self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
                           
                       }
                   }
               
               } else {
                   makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
               }
               

        
    }
    
    
    
    func makeAlert(titleInput:String, messageInput:String) {
            let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
        }
    
}

