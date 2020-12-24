//
//  EditAssetViewController.swift
//  accounting
//
//  Created by Apple on 2020/12/23.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class EditAssetViewController: UIViewController {

    let toeditAsset = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        print(toeditAsset)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var initialAccount: UITextField!

    /*
    //保存
    func saveContacts(){
        let success = NSKeyedArchiver.archiveRootObject(initialAccount, toFile: userPath)
        if !success{
            print("failed...")
        }
    }
    
    //加载
    func loadContacts(){
        if let initAccount = NSKeyedUnarchiver.unarchiveObject(withFile: contactInfo.userPath) as?
            [contactInfo]{
            contactList = contacts
            print("load file successful")
        }
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
