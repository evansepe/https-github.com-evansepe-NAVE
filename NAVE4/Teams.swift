//
//  Teams.swift
//  NAVE4
//
//  Created by Evan Sepe on 5/1/22.
//

import Foundation
import Firebase

class Teams {
    var teamArray: [Team] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ())  {
        db.collection("teams").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.teamArray = []
            // there are querySnapshot!.documents.count documents in the snapshot
            for document in querySnapshot!.documents {
                let team = Team(dictionary: document.data())
                team.documentID = document.documentID
                self.teamArray.append(team)
            }
            completed()
        }
    }

}
