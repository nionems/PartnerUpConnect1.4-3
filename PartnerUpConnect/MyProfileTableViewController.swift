//
//  MyProfileTableViewController.swift
//  PartnerUpConnect
//
//  Created by lionel coevoet on 9/11/2022.
//
import UIKit
import Firebase

class MyProfileTableViewController: UITableViewController {
    
    var contact : Contact!
    var contacts = [Contact]()
    var myProfileContact : Contact!
    var service = FirestoreRepository()
    var db = Firestore.firestore()
    
    @IBOutlet weak var profilepicture: UIImageView!
    @IBOutlet weak var locationProfile: UILabel!
    @IBOutlet weak var levelProfile: UILabel!
    @IBOutlet weak var dobProfile: UILabel!
    @IBOutlet weak var genderProfile: UILabel!
    @IBOutlet weak var emailProfile: UILabel!
    @IBOutlet weak var phoneProfile: UILabel!
    @IBOutlet weak var firstnameProfile: UILabel!
    @IBOutlet weak var lastnameProfile: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = db.collection(" contacts ").whereField("email", isEqualTo: "lionel@icloud.com")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    
                    print(" error fetching lionel's profile \(error!)")
                    return
                }
                self.contacts = documents.compactMap({ queryDocumentSnapshot -> Contact? in
                    return try? queryDocumentSnapshot.data(as : Contact.self)
                })
                for lio in self.contacts {
                    print(lio.firstname)
        
                }
                print ("nonononnononononnoon")
                
            }
//        firstnameProfile.text = "\(myProfileContact.firstname)"
//        lastnameProfile.text = "\(myProfileContact.lastname)"
//        locationProfile.text = "\(myProfileContact.location)"
//        levelProfile.text = "\(myProfileContact.level)"
//        dobProfile.text = "\(myProfileContact.dob)"
//        genderProfile.text = "\(myProfileContact.gender)"
//        emailProfile.text = "\(myProfileContact.email)"
//        phoneProfile.text = "\(myProfileContact.phone)"
       // favoriteSwitch.isOn = myProfileContact.favorite
    }
    
   //  MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //   Get the new view controller using segue.destination.
      //   Pass the selected object to the new view controller.
        
        if let editProfileTableVC = segue.destination as? EditProfileTableViewController{
            editProfileTableVC.myProfileContact = self.contact
        }
    }
    
//    @IBAction func unwindToMyProfileVC( _ unwindSegue : UIStoryboardSegue){
//
//        if let editProfileTableVC = unwindSegue.source as? EditProfileTableViewController {
//
//            print ("we came back from edit")
//
//        }
        
  //  }
}
