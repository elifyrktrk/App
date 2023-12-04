//
//  LoginViewController.swift
//  App
//
//  Created by Elif Yürektürk on 1.12.2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var errorMessage: UILabel!
    
    var rootRef = Database.database().reference()
    
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
    @IBAction func didTapCancel(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
//    for hide the keyboard 
    @IBAction func btnHideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func didTapLogin(_ sender: UIBarButtonItem) {
        
        Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!, completion: { (authResult, error) in
            if let error = error {
                // Hata durumu
                print("Error signing in: \(error.localizedDescription)")
            } else if let user = authResult?.user {
                // Giriş başarılı, kullanıcı UID alınır
                self.rootRef.child("user_profiles").child(user.uid).child("handle").observeSingleEvent(of: .value, with: { (snapshot: DataSnapshot) in
                    if !snapshot.exists() {
                        // Kullanıcının handle'ı yok, HandleView'e yönlendirilir
                        self.performSegue(withIdentifier: "HandleViewSeque", sender: nil)
                    }
                    else {
                        // Kullanıcının handle'ı zaten var, istediğiniz başka bir işlemi burada gerçekleştirebilirsiniz.
                        self.performSegue(withIdentifier: "HomeViewSeque", sender: nil)
                    }
                    
                })
            }
            else
            {
                self.errorMessage.text = error?.localizedDescription
            }
        })
    }}
