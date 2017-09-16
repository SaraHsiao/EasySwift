//
//  TableViewCell.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/16.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var areas: UILabel!
    @IBOutlet weak var provinces: UILabel!
    @IBOutlet weak var parts: UILabel!
    @IBOutlet weak var areasImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set areasImage Style
        areasImage.layer.cornerRadius = 60 / 2
        areasImage.layer.borderColor = UIColor.green.cgColor
        areasImage.layer.borderWidth = 1.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
