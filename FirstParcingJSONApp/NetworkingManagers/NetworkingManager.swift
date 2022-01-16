//
//  NetworkingManager.swift
//  FirstParcingJSONApp
//
//  Created by Alex Kulish on 16.01.2022.
//

import UIKit

class NetworkingManager {
    static var shared = NetworkingManager()
    private init () {}
    
    func fetchFact(url: String, complition: @escaping(_ image: UIImage, _ fact: String) -> Void ) {
        
        guard let url = URL(string: url) else { return }
        
        // проверяю на валидность url
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            // пытаюсь распарсить json, если получится - вернет заполненный экземпляр модели
            do {
                let fact = try JSONDecoder().decode(Fact.self, from: data)
                
                // помещаем в глобал поток, чтобы не тормозило переход
                DispatchQueue.global().async {
                    guard let urlImage = URL(string: fact.icon_url ?? "") else { return }
                    guard let imageData = try? Data(contentsOf: urlImage) else { return }
                    guard let image = UIImage(data: imageData) else { return }
                    print(fact)
                    
                    // выношу в main thread чтобы действие происходило асинхронно, т.е параллельно основному потоку
                    DispatchQueue.main.async {
                        complition(image, fact.value ?? "No fact's")
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
