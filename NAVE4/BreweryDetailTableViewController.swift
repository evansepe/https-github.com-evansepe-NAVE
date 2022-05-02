//
//  BreweryDetailTableViewController.swift
//  NAVE4
//
//  Created by Evan Sepe on 5/1/22.
//

import UIKit

class BreweryDetailTableViewController: UITableViewController {

    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var teamNameField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    
    
    var team: Team!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if team == nil {
            team = Team(dictionary: ["":""])
        }
        
        updateUserInterface()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap) 


    }
    
    func updateUserInterface() {
        teamNameField.text = team.teamName
        descriptionTextField.text = team.projectDescription
    }
    
    func updateDataFromInterface() {
        team.teamName = teamNameField.text!
        team.projectDescription = descriptionTextField.text!
            
        }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }


    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()

    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        self.updateDataFromInterface()
        team.saveData { success in
            if success {
                self.leaveViewController()
                    } else {
                        print("Can't segue because of the error")
                    }
                }

        }
    }

