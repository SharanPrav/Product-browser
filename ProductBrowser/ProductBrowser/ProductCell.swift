//
//  ProductCell.swift
//  ProductBrowser
//
//  Created by Saranya Ravi on 25/03/2018.
//  Copyright © 2018 Saranya Ravi. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCardBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImage.contentMode = .scaleAspectFit;
        
        productCardBackground.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        productCardBackground.layer.shadowOffset = CGSize(width:0, height:0)
        productCardBackground.layer.shadowOpacity = 0.8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
