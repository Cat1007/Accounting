//
//  Bill.swift
//  accounting
//
//  Created by 叶锦浩 on 2020/12/16.
//  Copyright © 2020 group. All rights reserved.
//

import Foundation
class Bill {
    var amount: Float
    var account: String?
    var date: Date
    
    var type: String
    
    var remark: String?
    
    init(amount: Float,account: String?,date: Date,type: String,remark: String?) {
        self.amount = amount
        self.account = account
        self.date = date
        self.type = type
        self.remark = remark
    }
}
