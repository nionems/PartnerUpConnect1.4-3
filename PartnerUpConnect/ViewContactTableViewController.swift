//
//  ViewContactTableViewController.swift
//  PartnerUpConnect
//
//  Created by lionel coevoet on 8/11/2022.
//

import UIKit

class ViewContactTableViewController: UITableViewController {
    
    var contact :Contact!
    
    // UI eleement conected to the class
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var email: UIButton!
    @IBOutlet weak var phone: UIButton!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    //When the page is loaded full contact details is loading into screen
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameLabel.text = "\(contact.firstname) \(contact.lastname)"
        locationLabel.text = "\(contact.location)"
        levelLabel.text = "\(contact.level)"
        dob.text = "\(contact.dob)"
        genderLabel.text = "\(contact.gender)"
        email.setTitle("\(contact.email)", for: UIControl.State.normal)
        phone.setTitle("\(contact.phone)", for: UIControl.State.normal)
        favoriteSwitch.isOn = contact.favorite
        playerImageView.image = UIImage(named:contact.photo)
    }

    // MARK: - Navigation
   // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                // Get the new view controller using segue.destination.
               // Pass the selected object to the new view controller.
        if let contactsTableVC = segue.destination as? ContactsTableViewController{

            contact.favorite = favoriteSwitch.isOn
            contactsTableVC.selectedContact = contact

        }
        
        
    }
}
