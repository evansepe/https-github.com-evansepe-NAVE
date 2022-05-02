//
//  Breweries.swift
//  NAVE4
//
//  Created by Evan Sepe on 4/28/22.
//

import Foundation

class Breweries {
    
    var breweryArray: [Brewery] = []
    var stateBreweryArray: [StateBrewery] = []
    var zipCode: String
    var urlString: String
    var state: String
    var urlString2: String
    
    init(zipCode: String, state: String) {
        self.zipCode = zipCode
        self.urlString = "https://api.openbrewerydb.org/breweries?by_postal=\(zipCode)"
        self.state = state
        self.urlString2 = "https://api.openbrewerydb.org/breweries?by_state=\(state)"
        
        
    }
    
    
    //zipcode input 
    func getData(completed: @escaping () -> ()) {
        let urlString = "https://api.openbrewerydb.org/breweries?by_postal=\(zipCode)"
        
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
                let returned = try JSONDecoder().decode([Brewery].self, from: data!)
                self.breweryArray = returned
                print("Here is what was returned.")
            } catch {
                print("ERROR4")
            }
            completed()
        }
        task.resume()
    }
    
    //state getData function
    func getData2(completed: @escaping () -> ()) {
        let urlString2 = "https://api.openbrewerydb.org/breweries?by_state=\(state)"

        print("We are accessing the url.")

        guard let url2 = URL(string: urlString2) else {
            print("ERROR3")
            completed()
            return
        }

        let session = URLSession.shared
        let task = session.dataTask(with: url2) { (data, response, error) in
            if let error = error {
                print("ERROR1")
            }
            do {
                let returned = try JSONDecoder().decode([StateBrewery].self, from: data!)
                self.stateBreweryArray = returned
                print("Here is what was returned \(returned).")
            } catch {
                print("ERROR here2 \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
    
    
}
