//
//  ShareViewController.swift
//  Find my Tutor
//
//  Created by Sudheesh Bhattarai on 4/4/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit
import Parse

class ShareViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    static var FirstName: String!
    static var LastName: String!
    static var PhoneNumber: String!
    static var email: String!
    static var occupation: String!
    static var userName: String!
    static var history = Dictionary<String, String>()
    

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    static var currentUserDetail: String?
    var userNameTemp: String?

    
    @IBOutlet weak var passWordTextField: UITextField!
    
    @IBOutlet weak var jobPickerView: UIPickerView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    var choiceIndex = 0
    
    var choices = ["Student","Tutor"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobPickerView.delegate = self
        jobPickerView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    

    @IBAction func onSignUp(_ sender: Any) {
        var checkSpecialCharacter = false
        let newUser = PFUser()
        var temp = userNameTextField.text
        
        if choiceIndex == 0{
            
            var checker = userNameTextField.text!
            if checker.characters.count == 0{
                let alertController = UIAlertController(title: "ERROR!", message: "Username can't be empty", preferredStyle: .alert)
                
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    
                }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
            else{
                LoginViewController.currentUserDetail = "Student"
                userNameTemp = "student_" + userNameTextField.text!

            }
            
        }
        else{
            var checker = userNameTextField.text!
            if checker.characters.count == 0{
                let alertController = UIAlertController(title: "ERROR!", message: "Username can't be empty", preferredStyle: .alert)
                
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    
                }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
            else{
                LoginViewController.currentUserDetail = "Tutor"
                userNameTemp = "tutor_" + userNameTextField.text!
            }
           
            
        }
        if userNameTextField.text?.characters.count != 0  && passWordTextField.text?.characters.count != 0{
            
            for characters in (temp?.characters)!{
                if characters == "_"{
                    checkSpecialCharacter = true
                    let alertController = UIAlertController(title: "ERROR!", message: "Cannot include _ in username ", preferredStyle: .alert)
                    
                    
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                        
                    }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true) {
                        self.userNameTextField.text = ""
                        checkSpecialCharacter =  false
                        // optional code for what happens after the alert controller has finished presenting
                    }

                }
                
                
            }
            print("Check speial character is : ", checkSpecialCharacter)
            
            if !checkSpecialCharacter{
                newUser.username = userNameTemp
                newUser.password = passWordTextField.text
                newUser.email = emailTextField.text
                
                ShareViewController.userName = userNameTextField.text
                ShareViewController.FirstName = firstNameTextField.text
                ShareViewController.LastName = lastNameTextField.text
                ShareViewController.PhoneNumber = phoneNumberTextField.text
                ShareViewController.email = emailTextField.text
                if choiceIndex == 0{
                    ShareViewController.occupation = "Student"
                }
                else{
                        ShareViewController.occupation = "Tutor"
                }
                
                Student.postUserImage( withCompletion: { _ in
                    //s MBProgressHUD.showAdded(to: self.view, animated: true)
                    print("Completed")
                    DispatchQueue.main.async {
                        print("POSTED")
                        
                    }}
                )
                newUser.signUpInBackground {
                    (succeeded: Bool, error:Error?) -> Void in
                    if succeeded {
                        print("Created a", LoginViewController.currentUserDetail!, " user")
                        
                        
                        let alertController = UIAlertController(title: "WELCOME", message: "Welcome to Chat", preferredStyle: .alert)
                        
                        
                        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                            
                        }
                        alertController.addAction(cancelAction)
                        
                        
                        self.present(alertController, animated: true) {
                            // optional code for what happens after the alert controller has finished presenting
                            self.performSegue(withIdentifier: "loginSignUpSegue", sender: nil)
                            //self.dismiss(animated: true, completion: nil)
                        }
                        //loginSignUpSegue
                        
                        
                    }
                    else{
                        print("Error is : ",error?.localizedDescription)
                    }
                    
                }
            }
            
            

        }
        else{
            
            let alertController = UIAlertController(title: "ERROR!", message: "Username or password can't be empty", preferredStyle: .alert)
            
            
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
            }
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }

            
        }
            
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
