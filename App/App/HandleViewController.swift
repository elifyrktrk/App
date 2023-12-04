//
//  HandleViewController.swift
//  App
//
//  Created by Elif Yürektürk on 1.12.2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HandleViewController: UIViewController {

    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var handle: UITextField!
    @IBOutlet weak var start: UIBarButtonItem!
    @IBOutlet weak var errorMessage: UILabel!
    
    var user : User?
    
    var rootRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.user = Auth.auth().currentUser
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     @IBAction func DidTapStartButton(_ sender: UIBarButtonItem) {
     }
     */
    @IBAction func DidTapStart(_ sender: UIBarButtonItem) {
        
        let handle = self.rootRef.child("handles").child(self.handle.text!).observeSingleEvent(of: .value, with: { (snapshot: DataSnapshot) in
                    
            if !snapshot.exists() {
                // Handle does not exist, you can update it

                // Update the handle in the user_profiles and in the handles node
                self.rootRef.child("user_profiles").child(self.user!.uid).child("handle").setValue(self.handle.text!.lowercased())

                // Update the name of the user
                self.rootRef.child("user_profiles").child(self.user!.uid).child("name").setValue(self.fullName.text!)

                // Update the handle in the handle node
                self.rootRef.child("handles").child(self.handle.text!.lowercased()).setValue(self.user?.uid)

                
                self.performSegue(withIdentifier: "HomeViewSeque", sender: nil)

                // Send the user to the home screen (add your code here for navigation)
            } else {
                self.errorMessage.text = "Handle already in use!"
            }
        })

        }
    
    @IBAction func didTapBack(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
