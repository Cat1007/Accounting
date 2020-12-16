//
//  MainViewController.swift
//  accounting
//
//  Created by 叶锦浩 on 2020/12/16.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 返回列表项的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billList.count
    }
    
    // 返回对应的cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billListCell", for: indexPath) as! BillListTableViewCell
        
        cell.amountText.text = String(billList[indexPath.row].amount)
        cell.accountText.text = billList[indexPath.row].account
        cell.remarkText.text = "test"
        cell.typeText.text = billList[indexPath.row].type
        
        return cell
    }
    
    private var billList = [Bill]()
    
    @IBOutlet var navigation: UINavigationItem!
    @IBOutlet var billListView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigation.title = "自定义月份test"
        
        for _ in 0..<10 {
            billList.append(Bill(amount: 10.00, account: "微信", time: "2020-01-11", type: "三餐"))
        }
        
        billListView.delegate = self
        billListView.dataSource = self
    }

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
