//
//  HomeViewController.swift
//  App
//
//  Created by Elif Yürektürk on 1.12.2023.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var databaseRef = Database.database().reference()
    
    var loggedInUser: User? // User türünden bir optional değişken
    var loggedInUserData: DataSnapshot? // DataSnapshot türünden bir optional değişken

    var contents: [DataSnapshot] = []
    
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var aivLoading: UIActivityIndicatorView!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loggedInUser = Auth.auth().currentUser
       
        self.databaseRef.child("user_profile").child(self.loggedInUser!.uid).observeSingleEvent(of: .value) { (snapshot) in
                  // Store the logged in user's detail into the variable
                  self.loggedInUserData = snapshot
                  
                  // Kullanıcının oluşturduğu içerikleri al
                  self.databaseRef.child("contents/\(self.loggedInUser!.uid)").observe(.childAdded) { (snapshot) in
                      // contents dizisine ekleyin
                      self.contents.append(snapshot)
                      
                      // TableView'e ekleme yapın
                      self.homeTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                      
                      self.aivLoading.stopAnimating() // Bu satırı ekledim, ancak aivLoading değişkenini tanımlamanız gerekiyor.
                  } withCancel: { (error) in
                      print(error.localizedDescription)
                  }
              }
          }
        
//        burası videodan
//        //        get the logged in users detail
//        self.databaseRef.child("user_profile").child(self.loggedInUser!.uid).observeSingleEventOfType( .Value) { (snapshot:FIRDataSnapshot) in
//            
//            //store the logged in users detail into the variable
//            self.loggedInUserData = snapshot
//            
//            //            get all the content that are made by the user
//            self.databaseRef.child("contents/\(self.loggedInUser!.uid)").observe(.childAdded, with: DataSnapshot) in
//            
//            self.contents.append(snapshot)
//            
//            self.homeTableView.insertRowsAtIndexPath( [NSIndexPath[forRow:0,inSection:0)], withRowAnimation:UITableViewRowAnimation.Automatic]
//                                                      
//                                                      self.aivLoading.stopAnimating()
//            
//                                                      }){(error) in
//                print(error.localizedDescription)
//            }
//    
//
//
//        // Do any additional setup after loading the view.
//    }
//    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeViewTableViewCell", for: indexPath) as! HomeViewTableViewCell
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
