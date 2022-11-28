//
//  EditProfileTableViewController.swift
//  PartnerUpConnect
//
//  Created by lionel coevoet on 9/11/2022.
//
import UIKit
import FirebaseCore
import FirebaseFirestore

class EditProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var contact : Contact!
    var myProfileContact : Contact!
    let database = Firestore.firestore()
    let service = FirestoreRepository()
    var contacts = [Contact]()

    private var storageManager = StorageManager()
    private var downloadUrl : String = ""
    
    @IBOutlet weak var uploadPicture: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstnameProfile: UITextField!
    @IBOutlet weak var lastnameProfile: UITextField!
    @IBOutlet weak var locationProfile: UITextField!
    @IBOutlet weak var levelProfile: UITextField!
    @IBOutlet weak var dobProfile: UITextField!
    @IBOutlet weak var genderProfile: UITextField!
    @IBOutlet weak var emailProfile: UITextField!
    @IBOutlet weak var phoneProfile: UITextField!
    @IBOutlet weak var photoProfile: UILabel!
    
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        //need to vreate login function first
        
        //playerImageView.image = UIImage(named:contact.photo)
        configurePicker()
    }
    
    @IBAction func EditProfile(_ sender: Any) {
        
        var contact = Contact (firstname:self.firstnameProfile.text!
                               ,lastname: self.lastnameProfile.text!
                               ,email:self.emailProfile.text!
                               ,phone:self.phoneProfile.text!
                               ,photo:self.photoProfile.text!
                               ,location:self.locationProfile.text!
                               ,gender:self.genderProfile.text!
                               ,dob:self.dobProfile.text!
                               ,level:self.levelProfile.text!
                               ,favorite:false)
        
        if service.addContact(contact: contact){
            
            showAlertMessage(title:"Success",message: "\(contact.firstname)\(contact.lastname) was edited")
        }
        else{
            showAlertMessage(title:"No luck",message: "couldnt register")}
    }
    func configurePicker() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPictureImageView)))
    }
    
     @objc
     func handleSelectPictureImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true, completion: nil)
    }
    
    
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("picker canceled by user ")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print(info)
        var selectedImageFromPicker : UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        }else if let originalImage = info[.originalImage] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        imageView.image = selectedImageFromPicker
    
        
        dismiss(animated: true , completion: nil)
    }
    
    func saveContactImage() -> String {
        guard let image = imageView.image,
              let data = image.jpegData(compressionQuality: 0.0) else{
            return ""
        }
        
        let fileName = "\(contact.email)-profile.jpg"
        storageManager.uploadImage(with: data, fileName: fileName, completion: {result in
           
            switch result {
            case .success(let downloadUrl) :
                print ("all good , url : \(downloadUrl)")
                self.downloadUrl = downloadUrl
                
            case .failure(let error):
                print("error storage Manager \(error)")
            }
        })
        return self.downloadUrl
        
    }
    @IBAction func changeImageDidPress(_ sender : Any){

    }
    
    //To delete profile
    @IBAction func deleteProfile(_ sender: Any) {
        
        let docEmail = emailProfile.text
        if docEmail!.isEmpty{
            showAlertMessage(title:"email cannot be missing", message: "try again")
            return
        }
        
        let contact = Contact(documentId: docEmail!)
        if service.deleteContact(contact: contact){
            showAlertMessage(title: "Success", message: "Profile deleted")
        }
        else{
            showAlertMessage(title: "Failed", message: "couldnt delete contact ")
        }
        
    }
    
    
    func showAlertMessage(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:"OK", style: .default))
        
        self.present(alert,animated: true)
        
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        // Get the new view controller using segue.destination.
        //        // Pass the selected object to the new view controller.
        
        // if is destination screen = as arrival
        if let contactTableVC = segue.destination as? ContactsTableViewController{
            
            contact.email = emailProfile.text!
           // contact.photo = photoProfile.text!
            contact.level = levelProfile.text!
            contact.location = locationProfile.text!
            contact.lastname = lastnameProfile.text!
            contact.firstname = firstnameProfile.text!
            contact.gender = genderProfile.text!
            contact.dob = dobProfile.text!
            //save the photo to firebase storage
            //contact.photo = saveContactImage()
            contact.lastUpdatedAt = nil
            contact.photo = self.downloadUrl
            
            contactTableVC.myProfileContact = contact
        
            
        }
        

//                contact.favorite = favoriteSwitch.isOn
//                contactsTableVC.selectedContact = contact
//
//            }
//
//        if let editTableVC = segue.destination as? MyProfileTableViewController{
//            service.addContact(contact: contact)
//
//        }
        
    }
//    @IBAction func actionForUnwindButton(sender: AnyObject) {
//        println("actionForUnwindButton");
//    }
}
        
    
    

