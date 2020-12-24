//
//  StatisticsViewController.swift
//  accounting
//
//  Created by Apple on 2020/12/17.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let currentTime = UTCTime(date:nil)

    var billList: [Bill] = [Bill]()
    var arrangedBill = [[Bill]]()
    var sortedList = [dailyBill]()
    
    var monthIncome:Float = 0.0
    var monthExpenditure:Float = 0.0
    var dailyExpenditure:Float = 0.0
    //返回对应的cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayListCell", for: indexPath) as! DayListTableViewCell
        //此处绑定cell的文本和分类后列表项的数据
        cell.balanceText.text = String(sortedList[indexPath.row].balance)
        if(sortedList[indexPath.row].balance < 0){
            cell.balanceText.textColor = UIColor.systemRed
        }else if(sortedList[indexPath.row].balance > 0){
            cell.balanceText.textColor = UIColor.systemGreen
        }
        cell.dateText.text = sortedList[indexPath.row].date
        if(sortedList[indexPath.row].expenditure != 0){
            cell.expandText.text = String(-sortedList[indexPath.row].expenditure)
        }else{
            cell.expandText.text = String(sortedList[indexPath.row].expenditure)
        }
        cell.incomeText.text = String(sortedList[indexPath.row].income)
        return cell
    }
    
    //返回小节标题
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return " "
//    }

    //返回列表项的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedList.count
    }
    
    
    @IBOutlet weak var dayTableView: UITableView!
    
    @IBOutlet weak var headerExpend: UILabel!
    @IBOutlet weak var headerIncome: UILabel!
    @IBOutlet weak var headerDailyExpend: UILabel!
    @IBOutlet weak var headerBalance: UILabel!
    @IBOutlet weak var dailyExpend: UILabel!
    @IBOutlet weak var income: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayTableView.delegate = self
        dayTableView.dataSource = self
//        // 拉取本地列表
//        loadBillFromLocal()
//        // 分类原始数据
//        arrangeBill()
//        // 生成按日分类列表
//        sortBill()
//        if(monthExpenditure == 0){
//            headerExpend.text = String(monthExpenditure)
//        }else{
//            headerExpend.text = String(-monthExpenditure)
//        }
//        headerIncome.text = String(monthIncome)
//        headerBalance.text = String(format: "%.2f",monthExpenditure + monthIncome)
//        headerDailyExpend.text = String(format: "%.2f",-dailyExpenditure)
//        dailyExpend.text = String(format: "%.2f",-dailyExpenditure)
//        income.text = String(monthIncome)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 拉取本地列表
        loadBillFromLocal()
        // 分类原始数据
        arrangeBill()
        // 生成按日分类列表
        sortBill()
        self.dayTableView.reloadData()
        if(monthExpenditure == 0){
            headerExpend.text = String(monthExpenditure)
        }else{
            headerExpend.text = String(-monthExpenditure)
        }
        headerIncome.text = String(monthIncome)
        headerBalance.text = String(format: "%.2f",monthExpenditure + monthIncome)
        headerDailyExpend.text = String(format: "%.2f",-dailyExpenditure)
        dailyExpend.text = String(format: "%.2f",-dailyExpenditure)
        income.text = String(monthIncome)

    }
    func loadBillFromLocal() {
        if let bills = NSKeyedUnarchiver.unarchiveObject(withFile: Bill.billPath) as? [Bill] {
            billList = bills
            print("load bills success")
        } else {
            print("load bills fail")
        }
    }
    
    func arrangeBill(){
        // 初始化日期数组
        arrangedBill.removeAll()
        for _ in 1 ... 32 { arrangedBill.append([Bill]()) }
        for bill in billList.reversed() {
            let time = UTCTime(date: bill.date)
            // 检索指定月份的账单
            if time.month == currentTime.month , time.year == currentTime.year { arrangedBill[time.day].append(bill) }
        }
    }
    
    func sortBill(){
        sortedList.removeAll()
        monthIncome = 0
        monthExpenditure = 0
        var day:Int = Int()
        let y = currentTime.year
        switch currentTime.month {
        case 1,3,5,7,8,10,12:
            day = 31
            break
        case 2:
            if( y%4==0 && y%100==0 || y%400==0){
                day = 28
            }else{
                day = 29
            }
            break
        default:
            day = 30
            break
        }
        for index in 1...day{
            var temp = dailyBill(d: "\(currentTime.month)-\(index)", i: 0.0, e: 0.0, b: 0.0)
            for item in arrangedBill[index]{
                if item.amount < 0 {
                    temp.expenditure = temp.expenditure + item.amount
                    monthExpenditure = monthExpenditure + item.amount
                }else{
                    temp.income = temp.income + item.amount
                    monthIncome = monthIncome + item.amount
                }
                temp.balance = temp.balance + item.amount
            }
            if(temp.expenditure != 0 || temp.income != 0){
                sortedList.append(temp)
            }
        }
        dailyExpenditure = monthExpenditure / Float(day)
    }
    

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class dailyBill {
    var date :String
    var income:Float
    var expenditure:Float
    var balance: Float
    
    init(d:String,i:Float,e:Float,b:Float) {
        date = d
        income = i
        expenditure = e
        balance = b
    }
}
