//
//  AboutViewController.swift
//  NAVE4
//
//  Created by Evan Sepe on 4/27/22.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


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
