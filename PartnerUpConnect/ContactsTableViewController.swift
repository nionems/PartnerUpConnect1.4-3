//
//  ContactsTableViewController.swift
//  PartnerUpConnect
//
//  Created by lionel coevoet on 4/11/2022.
//
import UIKit
import Firebase

class ContactsTableViewController: UITableViewController {
    
    @IBOutlet var contactTableView: UITableView!
    
    //Logout button function
    @IBAction func logOutBtn(_ sender: Any) {
        
        let refreshAlert = UIAlertController(title: "Login Out", message: "Are you sure you want to logout", preferredStyle: UIAlertController.Style.alert)
        // will close the application
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            exit(0);
        }))
        // will not close the application and get back to the app
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    let service = FirestoreRepository()
    var contacts = [Contact]()
    var selectedContact : Contact!
    var myProfileContact : Contact!
    var searchFrom : String = ""
    var levelQuery : String = ""
    var locationQuery : String = ""
    var genderQuery : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //   findContactById(id: documentId : "EGk4FqmCecaKMEtV5mmE", onCompletion:)
        //  _ = service.db.collection("contacts").whereField("favorite", isEqualTo: true).
        
        if(searchFrom == "searchByLevel"){
            print("view DidLoad open search by level ")
            
            _ = service.db.collection("contacts").whereField("favorite", isEqualTo: true).addSnapshotListener { querySnapshot,error in
                guard let documents = querySnapshot?.documents else{
                    print ("Error fetching documents \(error!)")
                    return
                }
                self.contacts = documents.compactMap({ queryDocumentSnapshot -> Contact? in
                    return try? queryDocumentSnapshot.data(as: Contact.self)
                })
                for con in self.contacts{
                    print(con.lastname)
                }
                self.contactTableView.reloadData()
             
                
            }
            
        }else if (searchFrom == ""){
            
        
            //let docRef
            _ = service.db.collection("contacts").addSnapshotListener { querySnapshot,error in
                guard let documents = querySnapshot?.documents else{
                    print ("Error fetching documents \(error!)")
                    return
                }
                self.contacts = documents.compactMap({ queryDocumentSnapshot -> Contact? in
                    return try? queryDocumentSnapshot.data(as: Contact.self)
                })
                for con in self.contacts{
                    print(con.lastname)
                }
                self.contactTableView.reloadData()
            }
        }
      else if (searchFrom == "searchByGender"){
          print("view DidLoad open search by Gender  ")
    
        //let docRef fro Male Gender
          _ = service.db.collection("contacts").whereField("gender", isEqualTo:"male").addSnapshotListener { querySnapshot,error in
            guard let documents = querySnapshot?.documents else{
                print ("Error fetching documents \(error!)")
                return
            }
            self.contacts = documents.compactMap({ queryDocumentSnapshot -> Contact? in
                return try? queryDocumentSnapshot.data(as: Contact.self)
            })
            for con in self.contacts{
                print(con.lastname)
            }
            self.contactTableView.reloadData()
        }
    }
        //result of female player
        else if (searchFrom == "searchByGender"){
            print("view DidLoad open search by Gender  ")
      
          //let docRef fro Female Gender
            _ = service.db.collection("contacts").whereField("gender", isEqualTo:"female").addSnapshotListener { querySnapshot,error in
              guard let documents = querySnapshot?.documents else{
                  print ("Error fetching documents \(error!)")
                  return
              }
              self.contacts = documents.compactMap({ queryDocumentSnapshot -> Contact? in
                  return try? queryDocumentSnapshot.data(as: Contact.self)
              })
              for con in self.contacts{
                  print(con.lastname)
              }
              self.contactTableView.reloadData()
          }
      }
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as!ContactCell
        
        // Configure the cell...
        let contact = contacts[indexPath.row]
       
        cell.profilePicture.image = UIImage(named:contact.photo)
        cell.nameLabel.text = "\( contact.firstname) \(contact.lastname)"
        cell.locationLabel.text = contact.location
        cell.levelLabel.text = contact.level
        
//        if contact.photo != "" {
//            
//            let url = URL(string: contact.photo)
//            let task = URLSession.shared.dataTask(with: url! as URL, completionHandler: {(data, response, error) in
//                
//                if  error != nil {
//                    print(error!)
//                    return
//                }
//                DispatchQueue.global(qos: .background).async {
//                    DispatchQueue.main.async {
//                        cell.profilePicture?.image = UIImage(data: data!)
//                    }
//                }
//            })
//            task.resume()
//            //self.contactTableView.reloadData()
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        self.selectedContact = contacts[indexPath.row]
        return indexPath
    }
    
    func showAlertMessage(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:"OK", style: .default))
        
        self.present(alert,animated: true)
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    
       
    // prepare for multiple segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

       switch segue.destination {
           
        case let viewContactVC as ViewContactTableViewController:
        
           viewContactVC.contact = selectedContact
           
       case let searchLevelVC as ViewContactTableViewController:
          
           searchLevelVC.contact = selectedContact
           
       case let searchLocationVC as ViewContactTableViewController:
          
           searchLocationVC.contact = selectedContact
           
       case let searchGenderVC as ViewContactTableViewController:
          
           searchGenderVC.contact = selectedContact
           
       case let favoriteVC as ViewContactTableViewController:
          
           favoriteVC.contact = selectedContact
    
            default:
                return
            }
    }
    //Unwind segue
    @IBAction func unwindToContactTableViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        
      
        // Use data from the view controller which initiated the unwind segue
        if let viewContactVC = sourceViewController as? ViewContactTableViewController{
            
            if service.updateContact(contact: selectedContact){
                print(" contact saved ")
            }
        }
        
        if let editProfileVC = sourceViewController as? EditProfileTableViewController{
            
            if service.updateContact(contact: myProfileContact){
                print("coming from edit")
            }
        }
    }
    
}
    //  extra ContactCell class created
    class ContactCell: UITableViewCell{
        
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var profilePicture: UIImageView!
        @IBOutlet weak var levelLabel: UILabel!
        @IBOutlet weak var locationLabel: UILabel!
    }
    
