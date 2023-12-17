import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var databaseRef = Database.database().reference()
    var loggedInUser: User?
    var loggedInUserData: [String: Any]?

    var contents = [AnyObject?]()

    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var aivLoading: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loggedInUser = Auth.auth().currentUser

        self.databaseRef.child("user_profiles").child(self.loggedInUser!.uid).observeSingleEvent(of: .value) { (snapshot) in
           
            if let data = snapshot.value as? [String: Any] {
                self.loggedInUserData = data
                
                if let uid = data["uid"] as? String {
                    self.databaseRef.child("contents/\(uid)").observe(.childAdded) { (contentSnapshot) in                    self.contents.append(contentSnapshot)
                        let indexPath = IndexPath(row: self.contents.count - 1, section: 0)
                        self.homeTableView.insertRows(at: [indexPath], with: .automatic)
                        
                        self.aivLoading.stopAnimating()
                    }
                }
            }
        }
    }

        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.contents.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewTableViewCell", for: indexPath) as! HomeViewTableViewCell
        
        let content = contents[(self.contents.count - 1) - indexPath.row] as? String
       
        cell.configure(profilePic: nil,name:self.loggedInUserData!["name"] as! String,handle:self.loggedInUserData!["handle"] as! String, content:content!)
        print("TableView hücresi oluşturuldu: \(cell)")

           return cell

        }
    }



