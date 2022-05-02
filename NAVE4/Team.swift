//
//  Team.swift
//  NAVE4
//
//  Created by Evan Sepe on 5/1/22.
//

import Foundation
import Firebase

class Team {
    
    var teamName: String
    var projectName: String
    var projectDescription: String
    var createdOn: Date
    var postingUserID: String
    var documentID: String
    
    internal init(teamName: String, projectName: String, projectDescription: String, createdOn: Date, postingUserID: String, documentID: String) {
        self.teamName = teamName
        self.projectName = projectName
        self.projectDescription = projectDescription
        self.createdOn = createdOn
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    
    convenience init(dictionary: [String: Any]) {
        let teamName = dictionary["teamName"] as! String? ?? ""
        let projectName = dictionary["projectName"] as! String? ?? ""
        let projectDescription = dictionary["projectDescription"] as! String? ?? ""
        let timeIntervalDate = dictionary["createdOn"] as! TimeInterval? ?? TimeInterval()
        let createdOn = Date(timeIntervalSince1970: timeIntervalDate)
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        self.init(teamName: teamName, projectName: projectName, projectDescription: projectDescription, createdOn: createdOn, postingUserID: postingUserID, documentID: "")
    }

    
var dictionary: [String: Any] {
    // from Date to timeInterval before storing
    let timeIntervalDate = createdOn.timeIntervalSince1970
    return ["teamName": teamName, "projectName": projectName, "projectDescription": projectDescription, "createdOn": timeIntervalDate, "postingUserID": postingUserID, "documentID":documentID]
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
            let ref = db.collection("teams").document(self.documentID)
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
            ref = db.collection("teams").addDocument(data: dataToSave) { (error) in
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
