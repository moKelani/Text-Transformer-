//
//  ZalgoCharacters.swift
//  TextTransformer
//
//  Created by Mohamed Kelany on 10/25/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation
 
struct ZalgoCharacters: Codable {
    let above: [String]
    let inline: [String]
    let below: [String]
    
    init() {
        let url = Bundle.main.url(forResource: "zalgo", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        
        
        let decoder = JSONDecoder()
        self = try! decoder.decode(ZalgoCharacters.self, from: data)
    }
}
