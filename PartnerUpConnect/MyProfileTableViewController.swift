//
//  MyProfileTableViewController.swift
//  PartnerUpConnect
//
//  Created by lionel coevoet on 9/11/2022.
//

import UIKit
import Firebase

class MyProfileTableViewController: UITableViewController {
    
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

        firstnameProfile.text = "\(myProfileContact.firstname)"
        lastnameProfile.text = "\(myProfileContact.lastname)"
        locationProfile.text = "\(myProfileContact.location)"
        levelProfile.text = "\(myProfileContact.level)"
        dobProfile.text = "\(myProfileContact.dob)"
        genderProfile.text = "\(myProfileContact.gender)"
        emailProfile.text = "\(myProfileContact.email)"
        phoneProfile.text = "\(myProfileContact.phone)"
        profilepicture.image = UIImage(named:myProfileContact.photo)
 
    }
    
    //  MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         if let editProfileTableVC = segue.destination as? EditProfileTableViewController{
             editProfileTableVC.myProfileContact = self.myProfileContact
         }
     }
     // unwind segue, going back to previous view controller removing stacks in between
     @IBAction func unwindToMyProfileViewController(_ unwindSegue: UIStoryboardSegue) {
         
         let sourceViewController = unwindSegue.source
         // Use data from the view controller which initiated the unwind segue
             if let editContactTableVC = sourceViewController as? EditProfileTableViewController{
             
                 if service.updateContact(contact: self.myProfileContact) {
                     print ("we came back from edit")
                 }
         }
     }
 }

