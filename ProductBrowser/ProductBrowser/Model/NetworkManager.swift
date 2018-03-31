//
//  NetworkManager.swift
//  ProductBrowser
//
//  Created by Saranya Ravi on 30/03/2018.
//  Copyright © 2018 Saranya Ravi. All rights reserved.
//

import Foundation

class NetworkManager {
    
    var filteredProducts = [Product]()
    var request : URLRequest?
    var urlSession : URLSession?
    let sharedCache =  URLCache.init(memoryCapacity: 200 * 1024 * 1024, diskCapacity: 200 * 1024 * 1024, diskPath: "productCache")

    public init(urlSession: URLSession) {
        self.urlSession = urlSession
        URLCache.shared = sharedCache
        let urlString = "https://gist.githubusercontent.com/anonymous/a3b3e50413fff111505a/raw/0522419f508e7ea506a8856586dce11a5664e9df/products.json"
        self.request = URLRequest.init(url: URL(string: urlString)!)
    }
    
    func downloadProductsList(completed: @escaping([Product]) -> ()) {
        let task = self.urlSession!.dataTask(with: self.request!) { (data, response, error) in
            guard let data = data else {return}
            self.filteredProducts = self.parseProductList(responseData: data)
            let cachedURLResponse = CachedURLResponse(response: response!, data: (data as Data), userInfo: nil, storagePolicy: .allowed)
            self.sharedCache.storeCachedResponse(cachedURLResponse, for: self.request!)
            DispatchQueue.main.async {
                completed(self.filteredProducts)
            }
        }
        task.resume()
    }
    
    func cachedProductList() -> ([Product]) {
        guard let cachedResponse = self.sharedCache.cachedResponse(for: self.request!) else{ return[] }
        self.filteredProducts = self.parseProductList(responseData: cachedResponse.data)
        return self.filteredProducts
    }
    
    func parseProductList(responseData: Data) -> ([Product]) {
        var filteredProducts = [Product]()
        do {
            let productList = try
                JSONDecoder().decode([Product].self, from: responseData)
            filteredProducts = productList.filter({$0.items_remaining! > 0 })
        } catch  let jsonErr {
            print("Error serializing from json:", jsonErr)
        }
        return filteredProducts
    }
}
