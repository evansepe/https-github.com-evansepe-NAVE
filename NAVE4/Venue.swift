//
//  Venue.swift
//  NAVE4
//
//  Created by Evan Sepe on 5/2/22.
//

import Foundation
import Firebase

class Venue {
    
    var suggestedBeer: String
    var description: String
    var documentID: String
    var postingUserID: String
    
    internal init(suggestedBeer: String, description: String, documentID: String, postingUserID: String) {
        self.suggestedBeer = suggestedBeer
        self.description = description
        self.documentID = documentID
        self.postingUserID = postingUserID
    }
    
    convenience init(dictionary: [String: Any]) {
        let suggestedBeer = dictionary["suggestedBeer"] as! String? ?? ""
        let description = dictionary["description"] as! String? ?? ""
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        self.init(suggestedBeer: suggestedBeer, description: description, documentID: "", postingUserID: postingUserID)
    }
    
    var dictionary: [String: Any] {
        return ["suggestedBeer": suggestedBeer, "description": description, "documentID": documentID, "postingUserID": postingUserID]
    }
    
    func saveData(completion: @escaping (Bool) -> ())  {
        let db = Firestore.firestore()
        // Grab the user ID
        guard let postingUserID = (Auth.auth().currentUser?.uid) else {
            print("*** ERROR: Could not save data because we don't have a valid postingUserID")
            return completion(false)
        }
        self.postingUserID = postingUserID
        // Create the dictionary representing data we want to save
        let dataToSave: [String: Any] = self.dictionary
        // if we HAVE saved a record, we'll have an ID
        if self.documentID != "" {
            let ref = db.collection("venues").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("ERROR: updating document \(error.localizedDescription)")
                    completion(false)
                } else { // It worked!
                    completion(true)
                }
            }
        } else { // Otherwise create a new document via .addDocument
            var ref: DocumentReference? = nil // Firestore will create a new ID for us
            ref = db.collection("venues").addDocument(data: dataToSave) { (error) in
                if let error = error {
                    print("ERROR: adding document \(error.localizedDescription)")
                    completion(false)
                } else { // It worked! Save the documentID in Spot’s documentID property
                    self.documentID = ref!.documentID
                    completion(true)
                }
            }
        }
    }

    
}
