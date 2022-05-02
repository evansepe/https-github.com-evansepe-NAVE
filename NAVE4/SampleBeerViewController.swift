//
//  SampleBeerViewController.swift
//  NAVE4
//
//  Created by Evan Sepe on 4/29/22.
//

import UIKit

class SampleBeerViewController: UIViewController {

    var sampleBeers = SampleBeers()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 30
        
        sampleBeers.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.sampleBeers.sampleBeersArray.count) Beers"
            }
        }
        
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSampleDetail" {
            let destination = segue.destination as! DetailSampleBeerViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.samplebeersstruct = sampleBeers.sampleBeersArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    
    


}

extension SampleBeerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleBeers.sampleBeersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sampleBeers.sampleBeersArray[indexPath.row].name
        cell.detailTextLabel?.text = sampleBeers.sampleBeersArray[indexPath.row].tagline
        return cell
    }
    
    
}
