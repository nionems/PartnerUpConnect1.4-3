//
//  ContactsTableViewController.swift
//  PartnerUpConnect
//
//  Created by lionel coevoet on 4/11/2022.
//
import UIKit
import Firebase

class ContactsTableViewController: UITableViewController{

    @IBOutlet var contactTableView: UITableView!
    
    let service = FirestoreRepository()
    var contacts = [Contact]()
    var selectedContact : Contact!
    var myProfileContact : Contact!
    var searchFrom : String = ""
    var levelQuery : String = ""
    var locationQuery : String = ""
    var genderQuery : String = ""
    var profile : Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // retrieving my profile from the database via ID since LOGIN isn't implemented!
        service.findContactById(id: "EGk4FqmCecaKMEtV5mmE") { retContact in
            if let retContact = retContact{
                self.profile = retContact
                print("contact returned \(self.profile.email)")
                
            }else{
                print("Unable to retrieve the contact")
            }
        }
        // variable "Query" declared.
        //the view did load will load the player in accordance to the search method!
        var query : Query!
        if searchFrom == ""{
            query = service.db.collection("contacts")
        }else if self.searchFrom == "searchByLevel" {
            query = service.db.collection("contacts").whereField("level", isEqualTo: self.levelQuery)
        }else if searchFrom == "searchByGender" {
            query = service.db.collection("contacts").whereField("gender", isEqualTo:self.genderQuery)
        }else if searchFrom == "searchByLocation"{
            query = service.db.collection("contacts").whereField("location", isEqualTo:self.locationQuery)
        }
    
        // reload all contact to the page
        query.addSnapshotListener { querySnapshot,error in
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
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
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
           
       case let profileVC as MyProfileTableViewController:
           profileVC.myProfileContact = self.profile
    
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
    
