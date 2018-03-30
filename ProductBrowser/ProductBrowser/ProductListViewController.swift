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
    
   
    var reachability: Reachability?
    var productList = [Product]()
    var networkManager: NetworkManager!

    private let timer = DispatchSource.makeTimerSource()
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let session = URLSession(configuration: URLSessionConfiguration.default,
                                  delegate: URLSessionPinningDelegate(),
                                  delegateQueue: nil)
        networkManager = NetworkManager.init(urlSession: session)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reachability = Reachability.init()
        triggerDataRefresh()
    }
    
    func triggerDataRefresh() {
        timer.schedule(deadline: .now(), repeating: 300.0)
        timer.setEventHandler {
            DispatchQueue.main.sync {
                if (self.reachability!.connection) != .none {
                    self.networkManager.downloadProductsList(completed: { (productList) in
                        self.productList = productList
                        self.productListTable.reloadData()
                        self.updateHeader()
                    })
                } else {
                    self.productList = self.networkManager.cachedProductList()
                    self.productListTable.reloadData()
                    self.updateHeader()
                }
            }
        }
        timer.activate()
    }
    
    func updateHeader() {
        var totalItemsInStock = 0
        for  product in self.productList {
            totalItemsInStock = totalItemsInStock + product.items_remaining!
        }
        self.totalProducts.text = NSString(format:"%d items in stock", totalItemsInStock) as String
        self.lastUpdated.text = NSString(format:"Last updated: %@", self.currentTimeString()) as String
    }
    
    func currentTimeString() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.productList[indexPath.row]
        
        selectedProduct = product
        
        performSegue(withIdentifier:"showDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let destinationVC = segue.destination as! ProductDetailViewController
            destinationVC.selectedProduct = selectedProduct
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProductCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductCell
        
        let productName = self.productList[indexPath.row].name ?? ""
        let imageUrlString =  self.productList[indexPath.row].image_url ?? ""
        
        cell.thumbnailImage.sd_setImage(with: URL(string: imageUrlString), placeholderImage: UIImage(named:"placeholder-image"), options:.progressiveDownload, completed: nil)
        
        cell.productName.text = productName
        
        return cell
    }
    
}

