//
//  ViewController.swift
//  App
//
//  Created by Elif Yürektürk on 30.11.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Auth.auth().addStateDidChangeListener({ (auth, user) in
            
            if let currentUser = user{
                
                print("user is signed in")
                
//                send the user to homeViewController
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let homeViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarControllerView")
                
//            send the user to the Home screen
                self.present(homeViewController, animated: true, completion: nil)

            }
            
        })
       
        
    }

  
}

