//
//  Venues.swift
//  NAVE4
//
//  Created by Evan Sepe on 5/2/22.
//

import Foundation
import Firebase

class Venues {
    var venueArray: [Venue] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ())  {
        db.collection("venues").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.venueArray = []
            // there are querySnapshot!.documents.count documents in the snapshot
            for document in querySnapshot!.documents {
                let venue = Venue(dictionary: document.data())
                venue.documentID = document.documentID
                self.venueArray.append(venue)
            }
            completed()
        }
    }
}
