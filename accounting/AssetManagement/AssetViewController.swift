//
//  AssetViewController.swift
//  accounting
//
//  Created by Apple on 2020/12/23.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class AssetViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        initAccount()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var salaryCard: UILabel!
    @IBOutlet weak var Wechat: UILabel!
    @IBOutlet weak var Alipay: UILabel!
    /*关于三个label的加减和初始化*/
    func initAccount(){
        
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
