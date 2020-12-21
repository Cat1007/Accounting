//
//  SelectTypeCollectionViewCell.swift
//  accounting
//
//  Created by 李兴利 on 2020/12/21.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class SelectTypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var cellLabel: UILabel!
    
    //cell边框样式设置
    override func awakeFromNib() {
        cellBackground.layer.borderWidth = 1
        cellBackground.layer.cornerRadius = 20
        cellBackground.layer.borderColor = UIColor.lightGray.cgColor
        cellLabel.textColor = UIColor.lightGray
    }
    
    //cell点击样式改变
    func cellStatusWithSelected(selected:Bool){
        if selected{
            cellBackground.layer.borderColor = UIColor.systemBlue.cgColor
            cellLabel.textColor = UIColor.systemBlue
        }else{
            cellBackground.layer.borderColor = UIColor.lightGray.cgColor
            cellLabel.textColor = UIColor.lightGray
        }
    }
    
    //cell高度固定40，宽度自适应
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        attributes.frame = CGRect(x: 0, y: 0, width: NSString(string : cellLabel.text!).size(withAttributes: [NSAttributedString.Key.font : cellLabel.font!]).width+40, height: 40)
        return attributes
    }
}
