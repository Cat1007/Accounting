//
//  InputCollectionViewCell.swift
//  accounting
//
//  Created by 李兴利 on 2020/12/21.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class InputCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var inputBackground: UIView!
    
    //cell边框样式设置
    override func awakeFromNib() {
        inputBackground.layer.borderWidth = 1
        inputBackground.layer.borderColor = UIColor.lightGray.cgColor
        inputLabel.textColor = UIColor.lightGray
    }
    
}
