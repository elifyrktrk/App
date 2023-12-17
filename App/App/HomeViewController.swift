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

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewTableViewCell", for: indexPath) as! HomeViewTableViewCell
//        
//        let content = contents[(self.contents.count - 1) - indexPath.row] as? String
//       
//        cell.configure(profilePic: nil,name:self.loggedInUserData!["name"] as! String,handle:self.loggedInUserData!["handle"] as! String, content:content!)
//        print("TableView hücresi oluşturuldu: \(cell)")
//
//           return cell
//
//        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewTableViewCell", for: indexPath) as! HomeViewTableViewCell
        
        
//        Bu kod satırı, contents adlı dizinin içinden belirli bir indeksteki elemanı alır ve bu elemanın bir [String: Any] türünde bir sözlük olup olmadığını kontrol eder. Kodun anlamını adım adım açıklayalım:
//
//        self.contents.count - 1: Bu ifade, contents dizisinin eleman sayısını alır ve bir eksiltme yapar. Çünkü dizi indeksleri sıfırdan başlar, ancak eleman sayısı sıfırdan başlamaz. Bu şekilde en sonuncu elemana ulaşılır.
//
//        indexPath.row: Bu değer, şu anda işlenen tablo hücresinin indeksini temsil eder.
//
//        (self.contents.count - 1) - indexPath.row: Bu ifade, dizinin en sonuncu elemanından başlayarak tablo hücrelerini geri sayar ve mevcut indeksi belirler.
//
//        contents[(self.contents.count - 1) - indexPath.row]: Bu ifade, contents dizisindeki belirli bir indeksteki elemanı alır.
//
//        as? [String: Any]: Bu ifade, alınan elemanın bir [String: Any] türünde bir sözlük olup olmadığını kontrol eder. Eğer bu koşul sağlanıyorsa, contentData adlı bir değişken içine atanır; aksi takdirde, nil olur.
        if let contentData = contents[(self.contents.count - 1) - indexPath.row] as? [String: Any],
            let name = self.loggedInUserData?["name"] as? String,
            let handle = self.loggedInUserData?["handle"] as? String,
            let content = contentData["content"] as? String {
            
            cell.configure(
                profilePic: contentData["profilePic"] as? String,
                name: name,
                handle: handle,
                content: content
            )
        } else {
            print("contentData: \(contents[(self.contents.count - 1) - indexPath.row])")
//
        }

       
        print("TableView hücresi oluşturuldu: \(cell)")
        return cell
    }

    }



