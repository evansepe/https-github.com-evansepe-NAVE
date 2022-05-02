//
//  SampleBeers.swift
//  NAVE4
//
//  Created by Evan Sepe on 4/29/22.
//

import Foundation

class SampleBeers {
    
    var sampleBeersArray: [SampleBeerStruct] = []
    var urlString: String = ""
    
    
    func getData(completed: @escaping () -> ()) {
        let urlString = "https://api.punkapi.com/v2/beers"
        
        print("We are accessing the url.")
        
        guard let url = URL(string: urlString) else {
            print("ERROR7")
            completed()
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("ERROR5")
            }
            do {
                let returned = try JSONDecoder().decode([SampleBeerStruct].self, from: data!)
                self.sampleBeersArray = returned
                print("Here is what was returned.")
            } catch {
                print("ERROR87")
            }
            completed()
        }
        task.resume()
    }
    
}
