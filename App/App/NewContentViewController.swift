//
//  NewContentViewController.swift
//  App
//
//  Created by Elif Yürektürk on 1.12.2023.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class NewContentViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var newContentTextView: UITextView!
    
    var databaseRef = Database.database().reference()
    var loggedInUser: User?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loggedInUser = Auth.auth().currentUser
        
        newContentTextView.textContainerInset = UIEdgeInsets(top: 30, left: 20, bottom: 20, right: 20);
        newContentTextView.text = "What's Happening?"
        newContentTextView.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(newContentTextView.textColor == UIColor.lightGray)
        {
            newContentTextView.text = ""
            newContentTextView.textColor = UIColor.black
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func didTapShare(_ sender: AnyObject) {
        
        if(newContentTextView.text.count > 0)
        {
            let key = self.databaseRef.child("contents").childByAutoId().key
      
            let childUpdates = [
                "contents/\(self.loggedInUser!.uid)/\(key)/text": newContentTextView.text,
                "contents/\(self.loggedInUser!.uid)/\(key)/timestamp": "\(NSDate().timeIntervalSince1970)"
            ] as [String : Any]

            
            self.databaseRef.updateChildValues(childUpdates)
            
            dismiss(animated: true, completion: nil)
            
            print("Key: \(key)")
            print("Content Text: \(newContentTextView.text)")

        }

    }
}
