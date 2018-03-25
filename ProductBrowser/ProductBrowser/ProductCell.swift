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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
