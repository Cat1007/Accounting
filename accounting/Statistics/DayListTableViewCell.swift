//
//  DayListTableViewCell.swift
//  accounting
//
//  Created by Apple on 2020/12/17.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class DayListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var incomeText: UILabel!
    @IBOutlet weak var expandText: UILabel!
    @IBOutlet weak var balanceText: UILabel!
    
}
