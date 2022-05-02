//
//  VenueListViewController.swift
//  NAVE4
//
//  Created by Evan Sepe on 5/2/22.
//

import UIKit

class VenueListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var venuesArray: [Venue] = []
    var venues: Venues!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        venues = Venues()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        venues.loadData {
            self.tableView.reloadData()
        }
    }

    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let inPresentingInAboutMode = presentingViewController is UINavigationController
        if inPresentingInAboutMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }
    

}

extension VenueListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.venueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = venues.venueArray[indexPath.row].suggestedBeer
        cell.detailTextLabel?.text = venues.venueArray[indexPath.row].description 
        return cell
    }
    
    
}
