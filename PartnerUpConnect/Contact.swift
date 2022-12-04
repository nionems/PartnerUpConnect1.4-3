//
//  Contact.swift
//  ContactsFirebase1
//
//  Created by lionel on 23/10/2022.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

//Contact class which is where all the player are declared
public class Contact : Codable{
    
    @DocumentID var id : String?
    var firstname : String
    var lastname : String
    var email : String
    var phone : String
    var photo : String
    var location : String
    var gender : String
    var dob : String
    var level : String
    var favorite : Bool
    
    //If an object being written contains null, it will be replaced with a server-generated timestamp
    @ServerTimestamp var createdTime : Timestamp?
    @ServerTimestamp var lastUpdatedAt : Timestamp?
    
    //Constructor
    init(firstname: String, lastname: String, email: String, phone: String, photo: String, location: String, gender: String, dob: String, level: String, favorite : Bool,
         createdTime: Timestamp? = nil, lastUpdatedAt: Timestamp? = nil) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.phone = phone
        self.photo = photo
        self.location = location
        self.gender = gender
        self.dob = dob
        self.level = level
        self.favorite = favorite
        self.createdTime = createdTime
        self.lastUpdatedAt = lastUpdatedAt
    }
    
    convenience init(documentId : String) {
        self.init(firstname: "", lastname: "", email: "", phone: "", photo: "", location:"", gender: "", dob:"", level:"", favorite: true)
        self.id = documentId
    }
}
