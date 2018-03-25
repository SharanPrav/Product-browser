//
//  ViewController.swift
//  ProductBrowser
//
//  Created by Saranya Ravi on 24/03/2018.
//  Copyright © 2018 Saranya Ravi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let products = Products()
        products.getProductsList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

