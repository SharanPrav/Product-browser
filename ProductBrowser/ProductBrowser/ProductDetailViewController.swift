//
//  ProductDetailViewController.swift
//  ProductBrowser
//
//  Created by Saranya Ravi on 26/03/2018.
//  Copyright © 2018 Saranya Ravi. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UIWebViewDelegate {
    
    var selectedProduct:Product?

    @IBOutlet weak var productImageHeight: NSLayoutConstraint!
    @IBOutlet weak var productImageLeading: NSLayoutConstraint!
    @IBOutlet weak var productImageTrailing: NSLayoutConstraint!
    @IBOutlet weak var productTitleTop: NSLayoutConstraint!
    @IBOutlet weak var ProductDescriptionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var ProductDescriptionView: UIWebView!
    @IBOutlet weak var ProductTitle: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ProductDescriptionView.delegate = self
        self.ProductTitle.text = selectedProduct!.name
        self.navigationItem.title = selectedProduct!.name

        let imageUrlString = selectedProduct!.image_url ?? ""
        productImageView.sd_setImage(with: URL(string: imageUrlString), placeholderImage: UIImage.init(named: "placeholder.jpg"), completed: nil)
        
        ProductDescriptionView.scrollView.bounces = false;
        ProductDescriptionView.scrollView.isScrollEnabled = false
        ProductDescriptionView.loadHTMLString(selectedProduct!.description!, baseURL: nil)
    }
    
    override func viewDidLayoutSubviews() {
        animateDetailView()
    }

    func animateDetailView() {
        UIView.animate(withDuration: 1.0) {
            self.productImageLeading.constant = 0
            self.productImageTrailing.constant = 0
            
            if let image = self.productImageView.image {
                let ratio = image.size.width / image.size.height
                let newHeight = self.view.frame.width / ratio
                self.productImageHeight.constant = newHeight
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        ProductDescriptionViewHeight.constant = webView.scrollView.contentSize.height
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

