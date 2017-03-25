//
//  LoginViewController.swift
//  Find my Tutor
//
//  Created by Sudheesh Bhattarai on 3/24/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UITextField!
    
    @IBOutlet weak var passWordLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func studentSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = userNameLabel.text
        newUser.password = passWordLabel.text
       
        newUser.email = "student@student.com"
        //newUser.isLinked(withAuthType: "Student")
        newUser.signUpInBackground {
            (succeeded: Bool, error:Error?) -> Void in
            if succeeded {
                print("Created a student user")
                let alertController = UIAlertController(title: "WELCOME", message: "Welcome to Chat", preferredStyle: .alert)
                
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    
                }
                alertController.addAction(cancelAction)
                
                
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                print("Error is : ",error?.localizedDescription)
            }
        }
        
    }
    
    @IBOutlet weak var tutorSignUp: UIButton!
    
    
    @IBAction func tutorSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = userNameLabel.text
        newUser.password = passWordLabel.text
        newUser.email = "tutor@tutor.com"
        newUser.signUpInBackground {
            (succeeded: Bool, error:Error?) -> Void in
            if succeeded {
                print("Created a tutor user")
                let alertController = UIAlertController(title: "WELCOME", message: "Welcome to Chat", preferredStyle: .alert)
                
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    
                }
                alertController.addAction(cancelAction)
                
                
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                print("Error is : ",error?.localizedDescription)
            }
        }

        
        
        
    }
    
    
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: userNameLabel.text!, password: passWordLabel.text!){
            user, error in
            if user != nil{
                print("User logined")
                var currentUser = user?.email as String!
                
                if let currentUser = currentUser{
                    if(currentUser as String! == "student@student.com"){
                        print("Student has logged in")
                    }
                    else{
                        print("Tutor has logged in")
                    }
                    
                    
                }
                print("Student email is : ", user?.email)
                //PFUser.isLinked("Student")
                
////                var currentUser = PFUser.accessibilityHint()
//                print("User accessibility is : ", PFUser.accessibilityHint())
////                if currentUser as String! == "Student"{
////                    
////                    print("Student logged in")
////                }
//                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                let alertController = UIAlertController(title: "ERROR", message: "INVALID VALUES", preferredStyle: .alert)
                
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                
            }
        }
        
        
    }
    @IBOutlet weak var onSignIn: UIButton!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
