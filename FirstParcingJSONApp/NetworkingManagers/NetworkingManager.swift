//
//  NetworkingManager.swift
//  FirstParcingJSONApp
//
//  Created by Alex Kulish on 16.01.2022.
//

import Alamofire

enum NetworkError: Error {
    case noData
    case invalidUrl
    case decodingError
}

class NetworkingManager {
    static var shared = NetworkingManager()
    private init () {}
    
    func fetchFact(_ url: String, completion: @escaping(Result<Fact, NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let fact = Fact.getFact(from: value)
                    completion(.success(fact))
                case .failure(let error):
                    completion(.failure(.decodingError))
                    print(error)
                }
            }
    }
}

/* Вариант реализации загрузки картинки
class ImageManager {
    static var shared = ImageManager()
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringUrl = url else { return nil}
        guard let urlImage = URL(string: stringUrl) else { return nil }
        return try? Data(contentsOf: urlImage)
        
    }
}
*/


/* Использование URLSession
 func fetchFact(from url: String?, with completion: @escaping(Fact) -> Void ) {
 guard let url = URL(string: url ?? "") else { return }
 // проверяю на валидность url
 URLSession.shared.dataTask(with: url) { data, _, error in
 guard let data = data else {
 print(error?.localizedDescription ?? "No error description")
 return
 }
 // пытаюсь распарсить json, если получится - вернет заполненный экземпляр модели
 do {
 let decoder = JSONDecoder()
 decoder.keyDecodingStrategy = .convertFromSnakeCase
 
 let fact = try decoder.decode(Fact.self, from: data)
 // выношу в main thread чтобы действие происходило асинхронно, т.е параллельно основному потоку
 DispatchQueue.main.async {
 completion(fact)
 }
 } catch {
 print(error.localizedDescription)
 }
 }.resume()
 }
 */
