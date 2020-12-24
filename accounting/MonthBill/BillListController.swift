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
    private var afterDelete: (Int, Int) -> Void = { _, _ in }
    
    // 返回有多少个小节
    func numberOfSections(in: UITableView) -> Int {
        return billList.count
    }
    
    // 分多少日期
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billList[section].count
    }
    
    // 定义每个cell的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billListCell", for: indexPath) as! BillListTableViewCell
        
        if billList[indexPath.section][indexPath.row].amount > 0 {
            if #available(iOS 13.0, *) {
                cell.amountText.textColor = UIColor.link
                cell.amountText.text = "+\(billList[indexPath.section][indexPath.row].amount)"
            } else {
                print("OS Version not support")
            }
        } else {
            cell.amountText.textColor = UIColor.red
            cell.amountText.text = "\(billList[indexPath.section][indexPath.row].amount)"
        }
        
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
        if billList[titleForHeaderInSection].count != 0 {
            let time = UTCTime(date: billList[titleForHeaderInSection][0].date)
            return "\(time.month).\(time.day)"
        } else {
            return "empty"
        }
        
    }
    
//    // 定义出现动画
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
//        UIView.animate(withDuration: 0.8){
//            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
//        }
//    }
    
    // 配置数据源
    func setBillData(bills: [[Bill]]) {
        billList = bills
    }
    
    // 配置删除操作
    func setDelete(callback: @escaping (Int, Int) -> Void) {
        self.afterDelete = callback
    }
    
    // 定义删除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 删除操作
        if editingStyle == .delete {
            billList[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            afterDelete(indexPath.section, indexPath.row)
        }
    }
}
