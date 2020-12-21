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
    // 有哪些月份可供显示
    private var enabledMonths = [EnabledMonth]()
    
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
    
    @IBOutlet var expenditureLabel: UILabel!
    @IBOutlet var incomeLabel: UILabel!
    @IBOutlet var balanceLabel: UILabel!
    
    @IBOutlet var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let today = UTCTime(date: nil)
        navigation.title = "\(today.year)-\(today.month)"
        
        selectedMonth = today.month
        selectedYear = today.year
        
        // 调试用填充数据
        for _ in 1 ..< 10 {
            billList.append(Bill(amount: -23.43, date: Date(), type: "测试", account: "支付宝", remark: "\(today.year)  \(today.month)  \(today.day)"))
        }
        
        // 初始化picker数据
        initEnabledMonth()
        
        // 将本月账单检索并分类好
        arrangeBill()
        
        // 配置账单列表
        billListController.setBillData(bills: nonEmptyDayList)
        billListView.delegate = billListController
        billListView.dataSource = billListController
        
        // 配置选择回调
        timePickerController.setSelectedCallback { index in
            self.selectedYear = self.enabledMonths[index].year
            self.selectedMonth = self.enabledMonths[index].month
            self.arrangeBill()
        }
        timePicker.delegate = timePickerController
        timePicker.dataSource = timePickerController
    }
    
    // 整理月份数据
    func arrangeBill() {
        // 整理每日账单
        var billSection = [[Bill]]()
        // 初始化日期数组
        for _ in 1 ..< 32 { billSection.append([Bill]()) }
        for bill in billList {
            let time = UTCTime(date: bill.date)
            // 检索指定月份的账单
            if time.month == selectedMonth, time.year == selectedYear { billSection[time.day].append(bill) }
            // 标记所有非空月份
            let today = UTCTime(date: Date())
            let monthOffset = (today.year * 12 + today.month) - (time.year * 12 + time.month)
            if enabledMonths[monthOffset].isEmpty {
                enabledMonths[monthOffset].isEmpty = false
            }
        }
        // 清空原列表
        nonEmptyDayList.removeAll()
        for day in billSection {
            if day.count != 0 { nonEmptyDayList.append(day) }
        }
        
        // 统计收支数据
        balance = 0
        income = 0
        expenditure = 0
        
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
        
        // 配置统计数据
        expenditureLabel.text = String(expenditure)
        incomeLabel.text = String(income)
        balanceLabel.text = String(balance)
        
        // 配置选择列表
        var pickerTitles = [String]()
        for month in enabledMonths {
            if month.isEmpty {
                pickerTitles.append("\(month.year)-\(month.month) *")
            } else {
                pickerTitles.append("\(month.year)-\(month.month)")
            }
        }
        timePickerController.setEnabledMonths(EnabledMonths: pickerTitles)
        timePicker.reloadAllComponents()
        
        // 配置账单列表
        billListController.setBillData(bills: nonEmptyDayList)
        billListView.reloadData()
    }
    
    // 生成可供选择的月份
    func initEnabledMonth() {
        // 先添加当前年份已经历月份
        let today = UTCTime(date: Date())
        for month in (1 ... today.month).reversed() {
            enabledMonths.append(EnabledMonth(year: today.year, month: month))
        }
        // 添加18年到现在的月份
        for year in (2018 ..< today.year).reversed() {
            for month in (1 ... 12).reversed() {
                enabledMonths.append(EnabledMonth(year: year, month: month))
            }
        }
    }

    // 选择月份
    @IBAction func chooseMonth(_ sender: Any) {
        // 控制控件的显示
        timePicker.isHidden = !timePicker.isHidden
    }
    
    // 添加账单后返回入口
    @IBAction func addBill(segue: UIStoryboardSegue) {
//        if let addBillVC = segue.source as? AddBillViewController, let editBill  = addBillVC.editBill {
//
//        }
        let tempBill = Bill(amount: 9.0, date: Date(), type: "测试", account: "微信", remark: "添加测试")
        billList.append(tempBill)
        arrangeBill()
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

// 月份信息
class EnabledMonth {
    var year: Int
    var month: Int
    var isEmpty: Bool = true
    
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
}
