//
//  MainViewController.swift
//  FirstParcingJSONApp
//
//  Created by Alex Kulish on 14.01.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var chuckImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chuckImageView.image = UIImage(named: "chuck")
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let _ = segue.destination as! FactViewController
    }
}
