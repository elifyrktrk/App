//
//  SignUpViewController.swift
//  App
//
//  Created by Elif Yürektürk on 1.12.2023.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signUp: UIBarButtonItem!
    
    @IBOutlet weak var errorMessage: UILabel!
    var databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUp.isEnabled = false
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
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func didTapSignUp(_ sender: Any) {
        signUp.isEnabled = false
        Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: { (authResult, error) in
            if let error = error as NSError? {
                if error.code == 17999 {
                    self.errorMessage.text = "Invalid Email Address"
                } else {
                    self.errorMessage.text = error.localizedDescription
                }
            } else {
                self.errorMessage.text = "Registered Successfully"
                
                Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!, completion: { (authResult, error) in
                    if error == nil {
                        if let user = authResult?.user {
                            self.databaseRef.child("user_profiles").child(user.uid).child("email").setValue(self.email.text!)
                            self.performSegue(withIdentifier: "HandleViewSeque", sender: nil)
                        }
                    }
                })
            }
        })



    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
        if let emailText = email.text, let passwordText = password.text, !emailText.isEmpty, !passwordText.isEmpty {
            signUp.isEnabled = true
        } else {
            signUp.isEnabled = false
        }
    }
   
}
