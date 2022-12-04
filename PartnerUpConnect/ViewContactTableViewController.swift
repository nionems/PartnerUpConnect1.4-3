//
//  ViewContactTableViewController.swift
//  PartnerUpConnect
//
//  Created by lionel coevoet on 8/11/2022.
//
import UIKit

class ViewContactTableViewController: UITableViewController {
    
    var contact :Contact!
    
    // UI element ViewController connected to the class ViewContactController !
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var email: UIButton!
    @IBOutlet weak var phone: UIButton!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    //When the page is loaded full player details is loaded into the screen
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
   
    //Prepare for segue player data to be sent to contact table VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               
        if let contactsTableVC = segue.destination as? ContactsTableViewController{

            contact.favorite = favoriteSwitch.isOn
            contactsTableVC.selectedContact = contact
        }
    }
}
