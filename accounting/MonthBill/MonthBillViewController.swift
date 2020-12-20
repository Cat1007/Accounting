//
//  MainViewController.swift
//  accounting
//
//  Created by 叶锦浩 on 2020/12/16.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // 时间选择控制器
    private var timePickerController = MonthPickerController()
    // 账单列表控制器
    private var billListController = BillListController()
    
    // 所有的账单列表
    private var billList = [Bill]()
    // 按日期存放的本月Bill
    private var nonEmptyDayList = [[Bill]]()
    
    // 当前显示日期控制变量
    private var selectedMonth = 0
    private var selectedDay = 0
    private var selectedYear = 0
    
    // 统计数据
    private var expenditure: Float = 0
    private var income: Float = 0
    private var balance: Float = 0
    
    @IBOutlet var navigation: UINavigationItem!
    @IBOutlet var billListView: UITableView!
    @IBOutlet var timePicker: UIPickerView!
    
    @IBOutlet weak var expenditureLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let today = UTCTime(date: nil)
        navigation.title = today.getTimeString()
        
        selectedMonth = today.month
        selectedDay = today.day
        selectedYear = today.year
    
        timePicker.isHidden = true
        
        // 调试用填充数据
        for _ in 1 ..< 10 {
            billList.append(Bill(amount: -23.43, account: "支付宝", date: Date(), type: "测试", remark: "\(today.year)  \(today.month)  \(today.day)"))
        }
        
        // 将本月账单检索并分类好
        arrangeBill(month: selectedMonth, year: selectedYear)
        
        // 配置统计数据
        expenditureLabel.text = String(expenditure)
        incomeLabel.text = String(income)
        balanceLabel.text = String(balance)
        
        // 配置账单列表
        billListController.setBillData(bills: nonEmptyDayList)
        billListView.delegate = billListController
        billListView.dataSource = billListController
        
        // 配置选择列表
        let temp = ["2020-02", "2020-01"]
        timePickerController.setEnabledMonths(EnabledMonths: temp)
        // 配置选择回调
        timePickerController.setSelectedCallback { index in
            print("selected \(temp[index])")
        }
        timePicker.delegate = timePickerController
        timePicker.dataSource = timePickerController
    }
    
    // 整理月份数据
    func arrangeBill(month: Int, year: Int) {
        // 整理每日账单
        var billSection = [[Bill]]()
        // 初始化日期数组
        for _ in 1 ..< 32 { billSection.append([Bill]()) }
        for bill in billList {
            let time = UTCTime(date: bill.date)
            if time.month == selectedMonth, time.year == selectedYear { billSection[time.day].append(bill) }
        }
        for day in billSection {
            if day.count != 0 { nonEmptyDayList.append(day) }
        }
        
        // 统计收支数据
        for nonEmptyDay in nonEmptyDayList {
            for bill in nonEmptyDay {
                if bill.amount <= 0 {
                    expenditure += abs(bill.amount)
                } else {
                    income += bill.amount
                }
            }
        }
        balance = income - expenditure
    }

    // 选择月份
    @IBAction func chooseMonth(_ sender: Any) {
        timePicker.isHidden = !timePicker.isHidden
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
