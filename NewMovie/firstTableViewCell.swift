//
//  firstTableViewCell.swift
//  NewMovie
//
//  Created by 黃毓皓 on 2016/11/22.
//  Copyright © 2016年 ice elson. All rights reserved.
//

import UIKit

class firstTableViewCell: UITableViewCell {

    @IBOutlet weak var ImageShow: UIImageView!
    @IBOutlet weak var labelShow: UILabel!
    @IBOutlet weak var cpShow: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
