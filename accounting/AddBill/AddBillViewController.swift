//
//  AddBillViewController.swift
//  accounting
//
//  Created by 李兴利 on 2020/12/16.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    // 储存将要返回的bill
    var editBill: Bill?

    let expenditureArray:Array = ["三餐","交通","学习","衣服","日用品","医疗","娱乐","旅行","住房","请客送礼","零食","话费网费","汽车/加油","水电煤","其它"]
    let incomeArray:Array = ["工资","生活费","外快","股票基金","其他"]
    let accountArray:Array = ["支付宝","微信","银行卡"]
    
    var selectArray:Array = Array<String>()
    var selectType:String = String()
    var account:String = String()
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var selectTypeView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var timeSelect: UIDatePicker!
    @IBOutlet weak var accountSelect: UIPickerView!
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated:true,completion:nil)
    }
    @IBAction func accountTap(_ sender: UITapGestureRecognizer) {
        accountSelect.isHidden = !accountSelect.isHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectTypeView.delegate = self
        selectTypeView.dataSource = self
        accountSelect.delegate = self
        accountSelect.dataSource = self
        
        //设置分类只能单选
        selectTypeView.allowsMultipleSelection = false
        (selectTypeView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: 20, height: 20)
        //设置分类View单元格的水平间距
        (selectTypeView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = 5
        //设置分类View单元格的行间距
        (selectTypeView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 5
        //设置分类View的内边距
        (selectTypeView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset = UIEdgeInsets(top: 5,left: 20,bottom: 0,right: 20)
        
        selectArray = expenditureArray
        accountSelect.isHidden = true
        account = accountArray[0]
        accountLabel.text = account
        amountLabel.textColor = UIColor.systemRed
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectArray = expenditureArray
            amountLabel.textColor = UIColor.systemRed
            self.selectTypeView.reloadData()
//            self.selectTypeView.layoutIfNeeded()
            selectType = selectArray[0]
            print(selectType)
            break
        case 1:
            selectArray = incomeArray
            amountLabel.textColor = UIColor.systemGreen
            self.selectTypeView.reloadData()
//            self.selectTypeView.layoutIfNeeded()
            selectType = selectArray[0]
            print(selectType)
            break
        default:
            break
        }
    }

    // MARK：- UICollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectTypeCell", for: indexPath) as! SelectTypeCollectionViewCell
        cell.cellLabel.text = selectArray[indexPath.row]
        cell.cellStatusWithSelected(selected: false)
        return cell
    }
    
    //选中
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.cellForItem(at: indexPath) as! SelectTypeCollectionViewCell
        cell.isSelected = true
        selectType = cell.cellLabel.text!
        print(selectType)
        cell.cellStatusWithSelected(selected: true)
    }
    
    //取消选中
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectTypeCollectionViewCell
        cell.isSelected = false
        cell.cellStatusWithSelected(selected: false)
    }
    
   
    
    // MARK: - UIPickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //配置选项个数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accountArray.count
    }
    
    //配置选项内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return accountArray[row]
    }
    
    //配置事件选择
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        account = accountArray[row]
        accountLabel.text = account
        print(account)
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
