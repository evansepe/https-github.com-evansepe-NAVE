//
//  VenueDetailTableViewController.swift
//  NAVE4
//
//  Created by Evan Sepe on 5/2/22.
//

import UIKit

class VenueDetailTableViewController: UITableViewController {

    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var suggestedBeerTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    var venue: Venue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if venue == nil {
            venue = Venue(dictionary: ["":""])
        }
        
        updateUserInterface()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)

    
    }
    
    func updateUserInterface() {
        suggestedBeerTextField.text = venue.suggestedBeer
        descriptionTextField.text = venue.description
    }
    
    func updateDataFromInterface() {
        venue.suggestedBeer = suggestedBeerTextField.text!
        venue.description = descriptionTextField.text!
    }
    
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        self.updateDataFromInterface()
        venue.saveData() { success in
                if success {
                    self.leaveViewController()
                } else {
                    print("Can't segue because of the error")
                }
            }
    }
    
    
}
