//
//  BillListTableViewCell.swift
//  accounting
//
//  Created by 叶锦浩 on 2020/12/16.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class BillListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var typeText: UILabel!
    @IBOutlet weak var remarkText: UILabel!
    @IBOutlet weak var amountText: UILabel!
    @IBOutlet weak var accountText: UILabel!
    
    
}
