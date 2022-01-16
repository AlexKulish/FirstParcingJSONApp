//
//  FactViewController.swift
//  FirstParcingJSONApp
//
//  Created by Alex Kulish on 14.01.2022.
//

import UIKit

class FactViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let url = "https://api.chucknorris.io/jokes/random"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        NetworkingManager.shared.fetchFact(url: url) { image, fact in
            self.imageView.image = image
            self.factLabel.text = fact
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func returnAction() {
        dismiss(animated: true)
    }
}
