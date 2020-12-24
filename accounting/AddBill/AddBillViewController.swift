//
//  AddBillViewController.swift
//  accounting
//
//  Created by 李兴利 on 2020/12/16.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource,UITextViewDelegate {
    
    //解决软键盘遮盖输入框问题
    //记录 self.view 的原始 origin.y
//    private var originY: CGFloat = 0
    //正在输入的UITextField
//    private var editingText: UITextField?
    
    // 储存将要返回的bill
    var editBill: Bill?

    let expenditureArray:Array = ["三餐","交通","学习","衣服","日用品","医疗","娱乐","旅行","住房","请客送礼","零食","话费网费","汽车/加油","水电煤","其它"]
    let incomeArray:Array = ["工资","生活费","外快","股票基金","其他"]
    let accountArray:Array = ["支付宝","微信","银行卡"]
    
    var selectArray:Array = Array<String>()
    var selectType:String = String()
    
    var selectedIndexPath = IndexPath(row: 0, section: 0)
    
    var account:String = String()
    var remarks:String = String()
    var amount:Float = Float()
    var date:Date = Date()
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var selectTypeView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var timeSelect: UIDatePicker!
    @IBOutlet weak var accountSelect: UIPickerView!
    @IBOutlet weak var remarksTextField: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var amountTextField: UITextField!
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated:true,completion:nil)
    }
    @IBAction func accountTap(_ sender: UITapGestureRecognizer) {
        accountSelect.isHidden = !accountSelect.isHidden
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
//        date = timeSelect.date
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "yyyy年MM月dd日"
////        date = dateFormatter.string(from: rawDate)
//        amount = Float(amountLabel.text!)!
//        if remarks == ""{
//            editBill = Bill(amount: amount, date: date, type: selectType, account: account, remark: nil)
//        }else{
//            editBill = Bill(amount: amount, date: date, type: selectType, account: account, remark: remarks)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        date = timeSelect.date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy年MM月dd日"
//        date = dateFormatter.string(from: rawDate)
        amount = Float(amountLabel.text!)!
        if(segmentedControl.selectedSegmentIndex == 0){
            amount = -amount
        }
//        print("amount: \(amount)")
        if remarks == ""{
            editBill = Bill(amount: amount, date: date, type: selectType, account: account, remark: nil)
        }else{
            editBill = Bill(amount: amount, date: date, type: selectType, account: account, remark: remarks)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectTypeView.delegate = self
        selectTypeView.dataSource = self
        accountSelect.delegate = self
        accountSelect.dataSource = self
        amountTextField.delegate = self
        remarksTextField.delegate = self
        
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
        selectType = selectArray[0]
        print(selectType)
        accountSelect.isHidden = true
        account = accountArray[0]
        accountLabel.text = account
        
        //金额输入框样式
        amountLabel.textColor = UIColor.systemRed
        amountTextField.keyboardType = UIKeyboardType.decimalPad
        //金额输入监听事件
        amountTextField.addTarget(self, action: #selector(amountTextChanged(_:)), for: .allEditingEvents)
        
        //备注样式
        remarksTextField.layer.borderWidth = 1
        remarksTextField.layer.borderColor = UIColor(red:234/255,green:234/255,blue:234/255,alpha:1).cgColor
        remarksTextField.layer.cornerRadius = 6
        remarksTextField.returnKeyType = UIReturnKeyType.done
        
        //添加按钮默认禁用
        saveButton.isEnabled = false
        
        timeSelect.maximumDate = UTCTime(date: nil).date
        
        //键盘弹出监听，解决键盘挡住输入框的问题
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    //键盘弹起
//    @objc func keyboardWillAppear(notification: NSNotification) {
//        // 获得软键盘的高
//        let keyboardinfo = notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey]
//        let keyboardheight:CGFloat = (keyboardinfo as AnyObject).cgRectValue.size.height
//
//        //计算输入框和软键盘的高度差
//        self.originY = self.view.frame.origin.y
//        let rect = self.editingText!.convert(self.editingText!.bounds, to: self.view)
//        let y = self.view.bounds.height - rect.origin.y - self.editingText!.bounds.height - keyboardheight
//
//        //设置中心点偏移
//        UIView.animate(withDuration: 0.5) {
//            if y < 0 {
//                self.view.frame.origin.y = (self.originY + y)
//            }
//        }
//    }
    
    //键盘落下
//    @objc func keyboardWillDisappear(notification:NSNotification){
//        //软键盘收起的时候恢复原始偏移
//        UIView.animate(withDuration: 0.5) {
//            self.view.frame.origin.y = self.originY
//        }
//    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        self.selectedIndexPath = IndexPath(row: 0, section: 0)
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectArray = expenditureArray
            amountLabel.textColor = UIColor.systemRed
            self.selectTypeView.reloadData()
            self.selectTypeView.layoutIfNeeded()
            selectType = selectArray[0]
//            let defaultIndex = IndexPath(row: 0, section: 0)
//            let cell = selectTypeView.cellForItem(at: defaultIndex) as! SelectTypeCollectionViewCell
//            cell.cellStatusWithSelected(selected: true)
            print(selectType)
            break
        case 1:
            selectArray = incomeArray
            amountLabel.textColor = UIColor.systemGreen
            self.selectTypeView.reloadData()
            self.selectTypeView.layoutIfNeeded()
            selectType = selectArray[0]
//            let defaultIndex = IndexPath(row: 0, section: 0)
//            let cell = selectTypeView.cellForItem(at: defaultIndex) as! SelectTypeCollectionViewCell
//            cell.cellStatusWithSelected(selected: true)
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
        let defaultIndex = IndexPath(row: 0, section: 0)
        let firstcell = selectTypeView.cellForItem(at: defaultIndex) as! SelectTypeCollectionViewCell
        firstcell.cellStatusWithSelected(selected: false)
        
        self.selectedIndexPath = indexPath
        
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
   
    // cell出现
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath == self.selectedIndexPath {
            (cell as! SelectTypeCollectionViewCell).isSelected = true
            (cell as! SelectTypeCollectionViewCell).cellStatusWithSelected(selected: true)
        }
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
    
    // MARK: - TextField
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //退格单独处理
        if string == "" {
            return true
        }
        //到达上限
        if amountTextField.text!.count == 8 {
            return false
        }
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        print(newString)
        //正则表达式 最多保留两位小数
//        let expression = "^(([1-9]{1}\\d*)|(0{1}))(\\.\\d{1,2})?$"
        let expression = "^[0-9]*(?:\\.[0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.caseInsensitive)
        let result = regex.matches(in: newString, options: [], range: NSMakeRange(0, newString.count))
        print(result)
        if result.count == 0{
            return false
        }else{
            if amountTextField.text == "0"{
                if newString == "0."{
                    return true
                }
                amountTextField.text = String(newString[newString.index(before: newString.endIndex)])
                amountLabel.text = amountTextField.text
                return false
            }
            if newString != ""{
                if newString[newString.startIndex] == "."{
                    amountTextField.text = "0"
                    print(newString)
                }
                if newString[newString.index(before: newString.endIndex)] == "."{
                    print(newString)
                }
            }
            return true
        }
    }
    
    //监听金额
    @objc func amountTextChanged(_ textField:UITextField){
        amountLabel.text = (textField.text == "") ? "0": amountTextField.text
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        amountTextField.resignFirstResponder()
        remarksTextField.resignFirstResponder()
        if(amountLabel.text! == "0" || amountLabel.text! == "0." || amountLabel.text! == "0.0" ){
            saveButton.isEnabled = false
        }else{
            saveButton.isEnabled = true
        }
    }
    
    // MARK: - TextView
    func textViewDidChange(_ textView: UITextView) {
        remarks = remarksTextField.text
        return
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //退格单独处理
        if text == ""{
            return true
        }
        //return按钮
        if text == "\n"{
            self.view?.endEditing(false)
            return true
        }
        //到达上限
        if remarksTextField.text.count == 15 {
            return false
        }
        return true
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
