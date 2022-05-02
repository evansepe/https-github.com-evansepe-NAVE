//
//  MainViewController.swift
//  NAVE4
//
//  Created by Evan Sepe on 4/27/22.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSound(name: "pouringsound")


    }
    
    func playSound(name: String){
        if let sound = NSDataAsset(name: name) {
            do{
                audioPlayer = try AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR")
            }
        } else {
            print("ERROR")
        }
    }
    
    @IBAction func wineImageTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowWine", sender: sender)
    }
    @IBAction func beerImageTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowBeer", sender: sender)
    }
    
    @IBAction func mixedDrinkImageTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowMixedDrink", sender: sender)
    }
    
    
}
