//
//  Fact.swift
//  FirstParcingJSONApp
//
//  Created by Alex Kulish on 14.01.2022.
//

import Foundation

struct Fact: Decodable {
    let iconUrl: String?
    let value: String?
    
    init(iconUrl: String, value: String) {
        self.iconUrl = iconUrl
        self.value = value
    }
    
    init(factData: [String: Any]) {
        iconUrl = factData["icon_url"] as? String
        value = factData["value"] as? String
    }
    
    static func getFact(from value: Any) -> Fact {
        
        guard let factData = value as? [String: Any] else { return Fact(iconUrl: "", value: "")}
        let fact = Fact(factData: factData)
        return fact
    }
}

enum Link: String {
    case chuckNorrisApi = "https://api.chucknorris.io/jokes/random"
}
