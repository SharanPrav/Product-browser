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
    let items_remaining: Int?
    let image_url: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case category
        case items_remaining
        case image_url
        case description
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(String.self, forKey: .category)
        image_url = try container.decode(String.self, forKey: .image_url)
        description = try container.decode(String.self, forKey: .description)
        do {
            let value = try container.decode(Int.self, forKey: .items_remaining)
            self.items_remaining  = value
        } catch DecodingError.typeMismatch {
            let value = try container.decode(String.self, forKey: .items_remaining)
            self.items_remaining  = Int(value)
        } catch DecodingError.valueNotFound {
            self.items_remaining  = 0
        } catch DecodingError.keyNotFound {
            self.items_remaining  = 0
        }
    }
}


