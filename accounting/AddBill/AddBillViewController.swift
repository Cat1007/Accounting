//
//  AddBillViewController.swift
//  accounting
//
//  Created by 李兴利 on 2020/12/16.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController {

    @IBOutlet weak var expenditrueView: UIView!
    @IBOutlet weak var incomeView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated:true,completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expenditrueView.isHidden = false
        incomeView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            expenditrueView.isHidden = false
            incomeView.isHidden = true
        case 1:
            expenditrueView.isHidden = true
            incomeView.isHidden = false
        default:
            break
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
