//
//  MonthPickerController.swift
//  accounting
//
//  Created by 叶锦浩 on 2020/12/20.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit
class MonthPickerController: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    private var enabledMonth = [String]()
    // 选择回调
    private var didAfterRowSelected: (Int) -> Void = {_ in }
    
    // 相应协议配置
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return enabledMonth.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return enabledMonth[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didAfterRowSelected(row)
    }
    
    // 暴露数据设置接口
    func setEnabledMonths(EnabledMonths data: [String]) {
        enabledMonth = data
    }
    
    // 配置选择回调
    func setSelectedCallback(didAfterRowSelected: @escaping (Int) -> Void) {
        self.didAfterRowSelected = didAfterRowSelected
    }
}
