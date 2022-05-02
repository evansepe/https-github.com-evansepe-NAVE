//
//  BreweryDetailViewController.swift
//  NAVE4
//
//  Created by Evan Sepe on 4/28/22.
//

import UIKit

class BreweryDetailViewController: UIViewController {
    

    @IBOutlet weak var breweryNameLabel: UILabel!
    @IBOutlet weak var breweryAddress: UILabel!
    @IBOutlet weak var breweryCity: UILabel!
    @IBOutlet weak var breweryWebsite: UILabel!
    @IBOutlet weak var breweryPhone: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var breweries = Breweries(zipCode: "", state: "")
    var brewery: Brewery!
    var statebrewery: StateBrewery!
    
    var teamsArray: [Team] = []
    var teams: Teams!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teams = Teams()
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self


        
        
        if brewery == nil {
            print("nil")
            brewery = Brewery(name: "", street: "", city: "", state: "", phone: "", website_url: "")
            breweryNameLabel.text = statebrewery.name
            breweryCity.text = statebrewery.city
            breweryWebsite.text = statebrewery.website_url
            breweryAddress.text = statebrewery.street
            breweryPhone.text = statebrewery.phone
        } else {
            print("NOT EMPTY")
        }
        
        
        
        if statebrewery == nil {
            print("nil")
            statebrewery = StateBrewery(name: "", city: "", state: "", phone: "", street: "", website_url: "")
            breweryNameLabel.text = brewery.name
            breweryAddress.text = brewery.street
            breweryCity.text = brewery.city
            breweryWebsite.text = brewery.website_url
            breweryPhone.text = brewery.phone
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        teams.loadData {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func siteButtonPressed(_ sender: UIButton) {
        openLink()
        
    }
    
    func openLink() {
        var url = URL(string: breweryWebsite.text ?? "")!
        UIApplication.shared.open(url)
    }

    
    
    
}

extension BreweryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.teamArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)
        
        
        cell.textLabel?.text = teams.teamArray[indexPath.row].teamName
        cell.detailTextLabel?.text = teams.teamArray[indexPath.row].projectDescription
        return cell
    }


}
