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
    var time: String
    var type: String

    init(amount: Float, account: String, time: String, type: String) {
        self.amount = amount
        self.account = account
        self.time = time
        self.type = type
    }
}
