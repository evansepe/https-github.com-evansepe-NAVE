//
//  MixedDrinkViewController.swift
//  NAVE4
//
//  Created by Evan Sepe on 4/28/22.
//

import UIKit

class MixedDrinkViewController: UIViewController {

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
    

}
