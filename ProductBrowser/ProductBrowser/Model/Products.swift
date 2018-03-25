//
//  Products.swift
//  ProductBrowser
//
//  Created by Saranya Ravi on 24/03/2018.
//  Copyright © 2018 Saranya Ravi. All rights reserved.
//

import Foundation

struct Product: Decodable {
    let name: String?
    let category: String?
    let ItemsRemaining: Int?
    let image: String?
    let description: String?
}

class Products {    
    let url = URL(string: "https://gist.githubusercontent.com/anonymous/a3b3e50413fff111505a/raw/0522419f508e7ea506a8856586dce11a5664e9df/products.json")
    
    func getProductsList() {
        
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            guard let data = data else {return}
            do {
                let products = try
                    JSONDecoder().decode([Product].self, from: data)
                    print(products)
            } catch let jsonErr {
                print("Error serializing from json:", jsonErr)
            }
            }.resume()
        }
}
