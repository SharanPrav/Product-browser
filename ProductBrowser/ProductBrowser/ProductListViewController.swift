//
//  ViewController.swift
//  ProductBrowser
//
//  Created by Saranya Ravi on 24/03/2018.
//  Copyright © 2018 Saranya Ravi. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var totalProducts: UILabel!
    @IBOutlet weak var productListTable: UITableView!
    @IBOutlet weak var lastUpdated: UILabel!
    
    var productList = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadProductsList {
            self.totalProducts.text = NSString(format:"Total items: %d", self.productList.count) as String
            
            self.productListTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProductCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductCell
        cell.productName.text = self.productList[indexPath.row].name ?? ""
        return cell
    }
    
    func downloadProductsList(completed: @escaping() -> ()) {
        let url = URL(string: "https://gist.githubusercontent.com/anonymous/a3b3e50413fff111505a/raw/0522419f508e7ea506a8856586dce11a5664e9df/products.json")
        
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            guard let data = data else {return}
            do {
                let productList = try
                    JSONDecoder().decode([Product].self, from: data)
                    self.productList = productList
                DispatchQueue.main.async {
                    completed()
                }
            } catch let jsonErr {
                print("Error serializing from json:", jsonErr)
            }
        }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

