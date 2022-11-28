//
//  SearchTableViewController.swift
//  PartnerUpConnect
//
//  Created by lionel coevoet on 12/11/2022.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    let service = FirestoreRepository()
    var searchFrom : String = ""
    var levelQuery : String = ""
    var locationQuery : String = ""
    var genderQuery : String = ""

    
 
    @IBOutlet weak var searchbyLevel: UITextField!
    
    
    @IBOutlet weak var searchByLocation: UITextField!

    
    @IBOutlet weak var searchByGender: UITextField!
 

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchByLevelBtn(_ sender: UIButton) {
        if sender.titleLabel!.text == "Search by level"{
         searchFrom = "searchByLevel"
         levelQuery  = searchbyLevel.text!
            
            // performSegue(withIdentifier: "Search By Level", sender: self)
        }
        else{//do something
            
        }
    }
    
    
    @IBAction func searchByLocation(_ sender: UIButton) {
        if sender.titleLabel!.text == "Search by location"{
            searchFrom = "searchByLocation"
            locationQuery  = searchByLocation.text!
        }
        else{//do something
            
        }
    }
    
    
    @IBAction func searchByGender(_ sender: UIButton) {
        if sender.titleLabel!.text == "Search by gender"{
            searchFrom = "searchByGender"
            genderQuery  = searchByGender.text!
        }
        else{//do something
            
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
//        if (segue.identifier == "searchByLevel"){
//            _ = segue.destination as? ContactsTableViewController
//            print("search by level triggered")
//
//           // _ = service.db.collection("contacts").whereField("favorite", isEqualTo: true)
//
//
//        }else if segue.identifier == "searchByLocation"{
//            _ = segue.destination as? ContactsTableViewController
//            print("search by location triggered")
//
//        }else if segue.identifier == "searchByGender"{
//            _ = segue.destination as? ContactsTableViewController
//            print("search by gender triggered")
//        }
        if let contactTableVC = segue.destination as? ContactsTableViewController{
            contactTableVC.searchFrom = self.searchFrom
            
        }
     
   
        
  
      //  if let contactTableVC = segue.destination as? ContactsTableViewController{
            // do something
      //  }
    }
     
    

}
