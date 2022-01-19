//
//  Fact.swift
//  FirstParcingJSONApp
//
//  Created by Alex Kulish on 14.01.2022.
//

import Foundation

struct Fact: Decodable {
    let icon_url: String?
    let value: String?
}

enum Link: String {
    case chuckNorrisApi = "https://api.chucknorris.io/jokes/random"
}
