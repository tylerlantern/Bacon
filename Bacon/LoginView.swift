//
//  LoginView.swift
//  Bacon
//
//  Created by Pantheb Tachajarrupan on 2/3/2560 BE.
//  Copyright © 2560 Toyota Leasing Thailand. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import TwitterCore
import TwitterKit
import GoogleSignIn

class LoginView: UIViewController , GIDSignInUIDelegate {
    
    var databaseRef : FIRDatabaseReference!
    
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnTwitter.isHidden = true
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        //        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
        //            if (session != nil) {
        //                let authToken = session?.authToken
        //                let authTokenSecret = session?.authTokenSecret
        //
        //                let credential = FIRTwitterAuthProvider.credential(withToken: authToken!, secret: authTokenSecret!)
        //                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
        //                    if error != nil {
        //                        print("\(error)")
        //                        return
        //                    }
        //                }
        //            } else {
        //                // ...
        //            }
        //        })
        
        //        logInButton.center = self.view.center
        //        self.view.addSubview(logInButton)
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                var alert = UIAlertController()
                alert = UIAlertController(title: "Fire Base Message", message: "\(user?.email)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    //self.performSegue(withIdentifier: "Iden_Goto_Landing", sender: self)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func btnLogin_Click(_ sender: Any) {
        FIRAuth.auth()!.signIn(withEmail: txtEmail.text!,
                               password: txtPassword.text!)
    }
    
    @IBAction func btnSignIn_Click(_ sender: Any) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        let emailField = alert.textFields![0]
                                        let passwordField = alert.textFields![1]
                                        
                                        FIRAuth.auth()!.createUser(withEmail: emailField.text!,
                                                                   password: passwordField.text!) { user, error in
                                                                    if error == nil {
                                                                        FIRAuth.auth()!.signIn(withEmail: self.txtEmail.text!,
                                                                                               password: self.txtPassword.text!)
                                                                    }
                                        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnFacebook_Click(_ sender: Any) {
        
        let facebookLogin : FBSDKLoginManager = FBSDKLoginManager()
        print("Logging In")
        facebookLogin.logIn(withReadPermissions: ["email"], from: self, handler:{(facebookResult, facebookError) -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else if (facebookResult?.isCancelled)! {
                print("Facebook login was cancelled.")
            }else {
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    // handle logged in user
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
//                        self.databaseRef = FIRDatabase.database().reference()
//                        self.databaseRef.child("User_Profiles").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
//                            let snapshot = snapshot.value as? NSDictionary
//                            if (snapshot == nil) {
//                                self.databaseRef.child("User_Profiles").child(user!.uid).child("name").setValue(user?.displayName)
//                                self.databaseRef.child("User_Profiles").child(user!.uid).child("email").setValue(user?.email)
//                                
//                            }})
                        print("successfullyAuthenticated")
                    }
                }
            }
        })
    }
    
    
    @IBAction func btnTwetter_Click(_ sender: Any) {
        
        Twitter.sharedInstance().logIn(completion: { session, error in
            if (session != nil) {
                let authToken = session?.authToken
                let authTokenSecret = session?.authTokenSecret
                
                let credential = FIRTwitterAuthProvider.credential(withToken: authToken!, secret: authTokenSecret!)
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    if error != nil {
                        print("\(error)")
                        return
                    }
                }
            } else {
                // ...
            }
        })
        
    }
    
    //    @IBAction func btnLogout_Click(_ sender: Any) {
    //
    //        let firebaseAuth = FIRAuth.auth()
    //        do {
    //            try firebaseAuth?.signOut()
    //        } catch let signOutError as NSError {
    //            print ("Error signing out: %@", signOutError)
    //        }
    //
    //    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "Iden_Goto_Landing" {
            //let WorkQView:WorkQ = segue.destination as! WorkQ
            //WorkQView.Authen_Class = self.AuthenData
        }
    }
    
    
    
    
    
    
    
}

extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        }
        if textField == txtPassword {
            textField.resignFirstResponder()
        }
        return true
    }
}
