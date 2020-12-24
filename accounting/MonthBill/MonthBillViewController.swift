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
    // 图片选择控制器
    private var imagePiackerController = ImagePiackerController()
    
    // 背景图片存放路径
    private let backgroundPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! +
        "/background.data"
    
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
    @IBOutlet var emptyHint: UILabel!
    @IBOutlet var backgoundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let today = UTCTime(date: nil)
        navigation.title = "\(today.year)-\(today.month)"
        
        selectedMonth = today.month
        selectedYear = today.year
        
        // 从本地拉取列表
        loadBillFromLocal()
        
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
        
        // 配置图片选择
        if let backgroundPic = NSKeyedUnarchiver.unarchiveObject(withFile: backgroundPath) as? UIImage {
            backgoundImage.image = backgroundPic
        } else {
            let defaultBackground = UIImage(named: "background.jpeg")
            backgoundImage.image = defaultBackground
        }
        
        imagePiackerController.setCallback{image in
            self.dismiss(animated: true){
                let success = NSKeyedArchiver.archiveRootObject(image, toFile: self.backgroundPath)
                if success {
                    self.backgoundImage.image = image
                    print("save background success")
                } else {
                    print("save background fail")
                }
            }
        }
    }
    
    // 整理月份数据
    func arrangeBill() {
        // 整理每日账单
        var billSection = [[Bill]]()
        // 初始化日期数组
        for _ in 1 ... 32 { billSection.append([Bill]()) }
        for bill in billList.reversed() {
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
        for day in billSection.reversed() {
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
        if nonEmptyDayList.isEmpty {
            billListView.isHidden = true
            emptyHint.isHidden = false
        } else {
            emptyHint.isHidden = true
            billListView.isHidden = false
            billListController.setBillData(bills: nonEmptyDayList)
            billListView.reloadData()
        }
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
    
    // 保存账单
    func saveBillToLocal() {
        let success = NSKeyedArchiver.archiveRootObject(billList, toFile: Bill.billPath)
        if !success {
            print("save bills failed")
        } else {
            print("save bills success")
        }
    }
    
    // 拉取账单
    func loadBillFromLocal() {
        if let bills = NSKeyedUnarchiver.unarchiveObject(withFile: Bill.billPath) as? [Bill] {
            billList = bills
            print("load bills success")
        } else {
            print("load bills fail")
        }
    }

    // 选择月份
    @IBAction func chooseMonth(_ sender: Any) {
        // 控制控件的显示
        if timePicker.isHidden {
            timePicker.alpha = 0
            timePicker.isHidden = !timePicker.isHidden
            UIView.animate(withDuration: 0.4, animations: {
                self.timePicker.alpha = 1
            })
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                self.timePicker.alpha = 0
            }) { _ in
                self.timePicker.isHidden = !self.timePicker.isHidden
            }
        }
    }
    
    @IBAction func tapBackground(_ sender: Any) {
        print("tap")
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            imagePicker.delegate = imagePiackerController
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // 添加账单后返回入口
    @IBAction func addBill(segue: UIStoryboardSegue) {
        if let addBillVC = segue.source as? AddBillViewController, let editBill  = addBillVC.editBill {
            billList.append(editBill)
            saveBillToLocal()
            arrangeBill()
        }
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

class ImagePiackerController: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private var afterChoose: (UIImage) -> Void = {_ in }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        afterChoose(selectedImage!)
    }
    
    func setCallback(callback: @escaping (UIImage) -> Void) {
        self.afterChoose = callback
    }
}
