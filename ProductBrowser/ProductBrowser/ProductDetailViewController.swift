//
//  ProductDetailViewController.swift
//  ProductBrowser
//
//  Created by Saranya Ravi on 26/03/2018.
//  Copyright © 2018 Saranya Ravi. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var selectedProduct = Product(name: "",category: "",itemsRemaining: -1,image_url: "",description: "")

    @IBOutlet weak var productImageHeight: NSLayoutConstraint!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productImageLeading: NSLayoutConstraint!
    @IBOutlet weak var productImageTrailing: NSLayoutConstraint!
    @IBOutlet weak var ProductTitle: UILabel!
    @IBOutlet weak var productTitleTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = selectedProduct.name
        let imageUrlString = selectedProduct.image_url ?? "http://www.newlaunches.com/wp-content/uploads/2013/04/pad-mini.jpg"
        self.ProductTitle.text = selectedProduct.name
        
        productDescription.text = selectedProduct.description ?? ""
        productImage.downloadImageFromUrlString(urlString: imageUrlString)
        animateDetails()
    }

    func animateDetails() {
        UIView.animate(withDuration: 1.0) {
            self.productImageLeading.constant = 0
            self.productImageTrailing.constant = 0
            if let image = self.productImage.image {
                let ratio = image.size.width / image.size.height
                let newHeight = self.view.frame.width / ratio
                self.productImageHeight.constant = newHeight
            }
            self.productTitleTop.constant = self.productImageHeight.constant+20
            self.view.layoutIfNeeded()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

