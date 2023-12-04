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

    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var aivLoading: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
          }
        

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HomeViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeViewTableViewCell", for: indexPath) as! HomeViewTableViewCell
        
        return cell
    }
    
}
