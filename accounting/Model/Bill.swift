//
//  Bill.swift
//  accounting
//
//  Created by 叶锦浩 on 2020/12/16.
//  Copyright © 2020 group. All rights reserved.
//

import Foundation
class Bill: NSObject, NSCoding {
    
    static let billPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! +
        "/bills.data"
    
    var amount: Float
    var account: String?
    var date: Date
    
    var type: String
    
    var remark: String?
    
    init(amount: Float, date: Date, type: String, account: String?, remark: String?) {
        self.amount = amount
        self.account = account
        self.date = date
        self.type = type
        self.remark = remark
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.amount, forKey: "amount")
        coder.encode(self.account, forKey: "account")
        coder.encode(self.date, forKey: "date")
        coder.encode(self.type, forKey: "type")
        coder.encode(self.remark, forKey: "remark")
    }
    
    required init?(coder: NSCoder) {
        self.amount = coder.decodeFloat(forKey: "amount")
        self.account = coder.decodeObject(forKey: "account") as? String
        self.date = coder.decodeObject(forKey: "date") as! Date
        self.type = coder.decodeObject(forKey: "type") as! String
        self.remark = coder.decodeObject(forKey: "remark") as? String
    }
}
