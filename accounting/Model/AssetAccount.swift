//
//  AssetAccount.swift
//  accounting
//
//  Created by 叶锦浩 on 2020/12/24.
//  Copyright © 2020 group. All rights reserved.
//

import Foundation
class AssetAccount: NSObject, NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(self.balance, forKey: "balance")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.lastUpdateTime, forKey: "lastUpdateTime")
    }

    required init?(coder: NSCoder) {
        self.balance = coder.decodeObject(forKey: "balance") as! Float
        self.name = coder.decodeObject(forKey: "name") as! String
        self.lastUpdateTime = coder.decodeObject(forKey: "lastUpdateTime") as! Date
    }

    static let assetPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! +
        "/asset.data"

    var balance: Float
    var lastUpdateTime: Date
    var name: String

    init(name: String, balance: Float) {
        self.balance = balance
        self.name = name
        self.lastUpdateTime = Date()
    }
}
