//
//  BillListController.swift
//  accounting
//
//  Created by 叶锦浩 on 2020/12/20.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit
class BillListController: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var billList = [[Bill]]()
    
    // 返回有多少个小节
    func numberOfSections(in: UITableView) -> Int  {
        return billList.count
    }
    
    // 分多少日期
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billList[section].count
    }
    
    // 定义每个cell的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billListCell", for: indexPath) as! BillListTableViewCell
        
        cell.amountText.text = "\(billList[indexPath.section][indexPath.row].amount)"
        cell.accountText.text = billList[indexPath.section][indexPath.row].account
        cell.typeText.text = billList[indexPath.section][indexPath.row].type
        
        if indexPath.row == 3 {
            cell.remarkText.isHidden = true
        } else {
            cell.remarkText.isHidden = false
            cell.remarkText.text = billList[indexPath.section][indexPath.row].remark
        }
        
        return cell
    }
    
    // 定义cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // 返回小节标题
    func tableView(_ tableView: UITableView, titleForHeaderInSection: Int) -> String? {
        let time = UTCTime(date: billList[titleForHeaderInSection][0].date)
        return "\(time.month).\(time.day)"
    }
    
    // 配置数据源
    func setBillData(bills: [[Bill]]) {
        billList = bills
    }
}
