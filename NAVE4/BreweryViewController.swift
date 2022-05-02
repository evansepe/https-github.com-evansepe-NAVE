//
//  BreweryViewController.swift
//  NAVE4
//
//  Created by Evan Sepe on 4/28/22.
//

import UIKit

class BreweryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var breweryTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var stateSearchButton: UIButton!
    @IBOutlet weak var stateTextField: UITextField!
    
    var breweries = Breweries(zipCode: "", state: "")
    var zipCode: Int = 0
    var state: String = ""
    
    var zipPressed: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchButton.isEnabled = false
        stateSearchButton.isEnabled = false
        
        


    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        let inPresentingInAboutMode = presentingViewController is UINavigationController
        if inPresentingInAboutMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }
    
   
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        var zipCode = breweryTextField.text
        if zipCode?.count == 5 {
            searchButton.isEnabled = true
        }
        if zipCode!.count > 5 {
            searchButton.isEnabled = false 
        }
        breweries.zipCode = zipCode ?? ""
        print(zipCode)
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        zipPressed = true
        stateTextField.text = ""
        breweries.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func stateEditingChanged(_ sender: UITextField) {
        var state = stateTextField.text
        state = state?.replacingOccurrences(of: " ", with: "_")
        breweries.state = state ?? ""
        stateSearchButton.isEnabled = true
        print(state)
        
    }
    
    
    @IBAction func stateSearchButtonPressed(_ sender: UIButton) {
        zipPressed = false
        breweryTextField.text = ""
        breweries.getData2 {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("load data")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBreweryDetail" {
            let destination = segue.destination as! BreweryDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            if zipPressed {
                destination.brewery = breweries.breweryArray[selectedIndexPath.row]
            } else {
                print("zip was not pressed")
                destination.statebrewery = breweries.stateBreweryArray[selectedIndexPath.row]
            }

        }
    }
    
    
}

extension BreweryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if zipPressed {
            return breweries.breweryArray.count
        } else {
            return breweries.stateBreweryArray.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if zipPressed {
            cell.textLabel?.text = breweries.breweryArray[indexPath.row].name
        } else {
            cell.textLabel?.text = breweries.stateBreweryArray[indexPath.row].name
        }
        return cell
    }
    

}

