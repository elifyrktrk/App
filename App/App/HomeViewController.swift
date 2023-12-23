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
                
                print("Logged In User Data: \(data)")
                
                
                
                self.databaseRef.child("contents/\(self.loggedInUser!.uid)").observe(.childAdded) { (snapshot) in
                    
                    self.contents.append(snapshot)
                    
                    self.homeTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                    
                    
                    self.aivLoading.stopAnimating()
                    self.homeTableView.reloadData()
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
        
        if let contentSnapshot = contents[(self.contents.count - 1) - indexPath.row] as? DataSnapshot,
           let contentData = contentSnapshot.value as? [String: Any],
           let name = self.loggedInUserData?["name"] as? String,
           let handle = self.loggedInUserData?["handle"] as? String,
           let content = contentData["text"] as? String { // Değişiklik burada: "text" değerini alıyoruz
            // Kontrol edilen değerleri yazdır
            print("contentData: \(contentSnapshot)")
            print("name: \(name)")
            print("handle: \(handle)")
            print("content: \(content)")
            
            cell.configure(
                profilePic: contentData["profilePic"] as? String,
                name: name,
                handle: handle,
                content: content
            )
        } else {
            // Sorunlu durumda, değerleri yazdır
            print("contentData: \(contents[(self.contents.count - 1) - indexPath.row])")
            print("name: \(self.loggedInUserData?["name"] as? String)")
            print("handle: \(self.loggedInUserData?["handle"] as? String)")
            
            if let contentSnapshot = contents[(self.contents.count - 1) - indexPath.row] as? DataSnapshot {
                print("content: \(contentSnapshot.value as? [String: Any])")
            } else {
                print("contentSnapshot içindeki değer nil veya uygun türde değil.")
            }
        }
        
        print("TableView hücresi oluşturuldu: \(cell)")
        return cell
    }
}

