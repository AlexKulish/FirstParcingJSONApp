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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchFact()
    }
    
    @IBAction func returnAction() {
        dismiss(animated: true)
    }
    
    private func fetchFact() {
        NetworkingManager.shared.fetchFact(Link.chuckNorrisApi.rawValue) { result in
            switch result {
            case .success(let fact):
                self.factLabel.text = fact.value
                
                guard let urlImage = URL(string: fact.iconUrl ?? "") else { return }
                guard let imageData = try? Data(contentsOf: urlImage) else { return }
                self.imageView.image = UIImage(data: imageData)
                
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}





/* Использование URLSession
 private func fetchFact() {
 NetworkingManager.shared.fetchFact(from: Link.chuckNorrisApi.rawValue) { fact in
 // помещаем в глобал поток, чтобы не тормозило переход
 DispatchQueue.global().async {
 guard let urlImage = URL(string: fact.iconUrl ?? "") else { return }
 guard let imageData = try? Data(contentsOf: urlImage) else { return }
 
 //вариант реализации через class ImageManager
 //guard let imageData = ImageManager.shared.fetchImage(from: fact.icon_url) else { return }
 
 DispatchQueue.main.async {
 self.factLabel.text = fact.value
 self.imageView.image = UIImage(data: imageData)
 self.activityIndicator.stopAnimating()
 }
 }
 }
 }
 */
