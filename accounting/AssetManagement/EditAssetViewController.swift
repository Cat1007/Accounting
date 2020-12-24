//
//  EditAssetViewController.swift
//  accounting
//
//  Created by Apple on 2020/12/23.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class EditAssetViewController: UIViewController,UITextFieldDelegate {
    var toEditAccount: AssetAccount?

    let toeditAsset = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        accountName.text = toEditAccount!.name
        balanceField.text = String(toEditAccount!.balance)
        balanceField.delegate = self
        saveBtn.isEnabled = false
        if toEditAccount!.name == "银行卡"{
            accountImage.image = UIImage(named: "BankCard.png")
        }
        else if toEditAccount!.name == "微信"{
            accountImage.image = UIImage(named: "WEIXIN.png")
        }
        else if toEditAccount!.name == "支付宝"{
            accountImage.image = UIImage(named: "AliPay.png")
        }
        

    }

    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var balanceField: UITextField!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var accountImage: UIImageView!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("change")
        if let newBalance = Float(balanceField.text!) {
            toEditAccount?.balance = newBalance
            toEditAccount?.lastUpdateTime = Date()
            saveBtn.isEnabled = true
        } else {
            // 不合法值
            saveBtn.isEnabled = false
        }
        balanceField.resignFirstResponder()
        return true
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
