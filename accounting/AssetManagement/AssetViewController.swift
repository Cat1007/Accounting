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
    

    @IBOutlet weak var bank: UILabel!
    @IBOutlet weak var wechat: UILabel!
    @IBOutlet weak var alipay: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initAccount()
        // Do any additional setup after loading the view.
    }
    
    // 初始化账号
    func initAccount() {
        if let localAccounts = NSKeyedUnarchiver.unarchiveObject(withFile: AssetAccount.assetPath) as? [AssetAccount] {
            accounts = localAccounts
            // 进行对应余额的计算
            
            // 修改页面显示
            bank.text = String(accounts[0].balance)
            wechat.text = String(accounts[1].balance)
            alipay.text = String(accounts[2].balance)
            print("load account success")
        } else {
            // 新建三个账号
            accounts.append(AssetAccount(name: "银行卡", balance: 0))
            accounts.append(AssetAccount(name: "微信", balance: 0))
            accounts.append(AssetAccount(name: "支付宝", balance: 0))
            saveAccount()
            // 修改页面显示
            bank.text = String(accounts[0].balance)
            wechat.text = String(accounts[1].balance)
            alipay.text = String(accounts[2].balance)
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
    
    @IBAction func editBankCard(_ sender: Any) { editAccount = 0 }
    
    @IBAction func editWechat(_ sender: Any) { editAccount = 1 }
    
    @IBAction func editAlipay(_ sender: Any) { editAccount = 2 }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desViewController = segue.destination as? EditAssetViewController {
            desViewController.toEditAccount = accounts[editAccount]
        }
    }
}
