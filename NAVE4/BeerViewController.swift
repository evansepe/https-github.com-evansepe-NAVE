//
//  BeerViewController.swift
//  NAVE4
//
//  Created by Evan Sepe on 4/28/22.
//

import UIKit

class BeerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        let inPresentingInAboutMode = presentingViewController is UINavigationController
        if inPresentingInAboutMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    
    @IBAction func breweryDestinationButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowBeerBrewery", sender: sender)
    }
    
    @IBAction func sampleBeerButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowSampleBeer", sender: sender)
    }
    
    
    
    @IBAction func venueButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowVenue", sender: sender)
    }
    

}
