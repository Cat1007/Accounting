//
//  MainViewController.swift
//  accounting
//
//  Created by 叶锦浩 on 2020/12/16.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var billList = [Bill]()
    // 按section存放Bill
    private var billSection = [[Bill]]()
    
    private var selectedMonth = 0
    private var selectedDay = 0
    private var selectedYear = 0
    
    // 返回列表项的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = section
        
        for sec in billSection {
            // 遇到不为0的日期
            if sec.count != 0 {
                // 查看是否是所需要的日期
                if count == 0 {
                    return sec.count
                } else {
                    count-=1
                }
            }
        }
        
        return 0
    }
    
    // 返回有多少个小节
    func numberOfSections(in: UITableView) -> Int {
        var count = 0
        for section in billSection {
            if section.count != 0 {
                count += 1
            }
        }
        return count
    }
    
    // 返回小节标题
    func tableView(_ tableView: UITableView, titleForHeaderInSection: Int) -> String? {
        var count = titleForHeaderInSection
        
        for sec in billSection {
            // 遇到不为0的日期
            if sec.count != 0 {
                // 查看是否是所需要的日期
                if count == 0 {
                    let time = UTCTime(date: sec[0].date)
                    return "\(time.month).\(time.day)"
                } else {
                    count-=1
                }
            }
        }
        
        return ""
    }
    
    // 返回对应的cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billListCell", for: indexPath) as! BillListTableViewCell
        
        cell.amountText.text = "\(billList[indexPath.row].amount)"
        cell.accountText.text = billList[indexPath.row].account
        cell.typeText.text = billList[indexPath.row].type
        
        if indexPath.row == 3 {
            cell.remarkText.isHidden = true
        } else {
            cell.remarkText.isHidden = false
            cell.remarkText.text = billList[indexPath.row].remark
        }
        
        return cell
    }
    
    
    @IBOutlet var navigation: UINavigationItem!
    @IBOutlet var billListView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let today = UTCTime(date: nil)
        navigation.title = today.getTimeString()
        
        selectedMonth = today.month
        selectedDay = today.day
        selectedYear = today.year
    
        
        for _ in 1 ..< 10 {
            billList.append(Bill(amount: -23.43, account: "支付宝",date: Date(), type: "测试",remark: "\(today.year)  \(today.month)  \(today.day)"))
        }
        // 初始化日期数组
        for _ in 1 ..< 32 {
            billSection.append([Bill]())
        }
        
        arrangeBill(month: selectedMonth, year: selectedYear)
        
        billListView.delegate = self
        billListView.dataSource = self
    }
    
    // 整理月份数据
    func arrangeBill(month: Int,year: Int) {
        for bill in billList {
            let time = UTCTime(date: bill.date)
            if time.month == self.selectedMonth && time.year == self.selectedYear {
                billSection[time.day].append(bill)
            }
        }
    }

    // 选择月份
    @IBAction func chooseMonth(_ sender: Any) {}

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
