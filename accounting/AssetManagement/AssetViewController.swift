//
//  AssetViewController.swift
//  accounting
//
//  Created by Apple on 2020/12/23.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class AssetViewController: UIViewController {
    // 0是银行卡 1是微信 2是支付宝
    private var editAccount: Int = 0
    private var accounts = [AssetAccount]()
    
    private var billList = [Bill]()
    

    @IBOutlet weak var bank: UILabel!
    @IBOutlet weak var wechat: UILabel!
    @IBOutlet weak var alipay: UILabel!
    @IBOutlet weak var totalBalance: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        loadBills()
//        initAccount()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadBills()
        initAccount()
    }
    
    // 初始化账号
    func initAccount() {
        if let localAccounts = NSKeyedUnarchiver.unarchiveObject(withFile: AssetAccount.assetPath) as? [AssetAccount] {
            accounts = localAccounts
            // 进行对应余额的计算
            
            // 修改页面显示
            updatePage()
            print("load account success")
        } else {
            // 新建三个账号
            accounts.append(AssetAccount(name: "银行卡", balance: 0))
            accounts.append(AssetAccount(name: "微信", balance: 0))
            accounts.append(AssetAccount(name: "支付宝", balance: 0))
            saveAccount()
            updatePage()
        }
    }
    
    // 保存账号更改
    func saveAccount() {
        let success = NSKeyedArchiver.archiveRootObject(accounts, toFile: AssetAccount.assetPath)
        if !success {
            print("save accounts failed")
        } else {
            print("save accounts success")
        }
    }
    
    // 更新页面元素
    func updatePage() {
        var bankShow = accounts[0].balance
        var wechatShow = accounts[1].balance
        var aliShow = accounts[2].balance
        
        // 修改页面显示
        for bill in billList {
            switch bill.account {
            case "银行卡":
                if bill.date.compare(accounts[0].lastUpdateTime).rawValue == 1 { bankShow  += bill.amount }
            case "微信":
                if bill.date.compare(accounts[1].lastUpdateTime).rawValue == 1 { wechatShow  += bill.amount }
            case "支付宝":
                if bill.date.compare(accounts[2].lastUpdateTime).rawValue == 1 { aliShow  += bill.amount }
            default: break
            }
        }
        
        var total = bankShow  + wechatShow + aliShow
        
        bank.text = String(bankShow)
        wechat.text = String(wechatShow)
        alipay.text = String(aliShow)
        totalBalance.text = String(total)
    }
    
    // 拉取本地订单
    func loadBills() {
        if let bills = NSKeyedUnarchiver.unarchiveObject(withFile: Bill.billPath) as? [Bill] {
            billList = bills
            print("load bills success")
        } else {
            print("load bills fail")
        }
    }
    
    @IBAction func editBankCard(_ sender: Any) { editAccount = 0 }
    
    @IBAction func editWechat(_ sender: Any) { editAccount = 1 }
    
    @IBAction func editAlipay(_ sender: Any) { editAccount = 2 }
    
    @IBAction func saveAccountChange(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? EditAssetViewController, let afterEditAsset  = sourceVC.toEditAccount{
            accounts[editAccount] = afterEditAsset
            updatePage()
            saveAccount()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desViewController = segue.destination as? EditAssetViewController {
            desViewController.toEditAccount = accounts[editAccount]
        }
    }
}
