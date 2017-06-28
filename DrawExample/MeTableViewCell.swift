//
//  MeTableViewCell.swift
//  DrawExample
//
//  Created by Nitesh Kant on 02/06/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import UIKit

class MeTableViewCell: UITableViewCell {

    var meList  : Array<String>! = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        let drawShape = drawShapehandler()
         drawShape.drawItems(itemList: self.meList, onView: self)
    }
}
