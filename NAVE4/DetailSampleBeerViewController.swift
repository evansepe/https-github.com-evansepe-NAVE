//
//  DetailSampleBeerViewController.swift
//  NAVE4
//
//  Created by Evan Sepe on 4/29/22.
//

import UIKit

class DetailSampleBeerViewController: UIViewController {

    @IBOutlet weak var sampleName: UILabel!
    @IBOutlet weak var sampleDescription: UILabel!
    @IBOutlet weak var samplePh: UILabel!
    @IBOutlet weak var sampleABV: UILabel!
    
    
    var  samplebeersstruct: SampleBeerStruct!
//    var foodpairings: FoodPairings!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if samplebeersstruct == nil {
            samplebeersstruct = SampleBeerStruct(name: "", tagline: "", description: "", ph: 0.0, abv: 0.0)
        }
        
        sampleName.text = samplebeersstruct.name
        sampleDescription.text = samplebeersstruct.description
        samplePh.text = "\(samplebeersstruct.ph!)"
        sampleABV.text = "\(samplebeersstruct.abv!)"
        


    }
    


}

    
    

    
    

