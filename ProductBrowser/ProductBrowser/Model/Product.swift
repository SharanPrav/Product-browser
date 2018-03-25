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

