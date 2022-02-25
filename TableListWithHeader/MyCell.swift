//
//  MyCell.swift
//  TableListWithHeader
//
//  Created by Milan on 3/8/20.
//  Copyright © 2020 667.Co.Ltd. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet weak var lblCarName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
