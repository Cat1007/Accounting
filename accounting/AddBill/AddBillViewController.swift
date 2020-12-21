//
//  AddBillViewController.swift
//  accounting
//
//  Created by 李兴利 on 2020/12/16.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController {
    // 储存将要返回的bill
    var editBill: Bill?

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated:true,completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
