//
//  AddBillViewController.swift
//  accounting
//
//  Created by 李兴利 on 2020/12/16.
//  Copyright © 2020 group. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    // 储存将要返回的bill
    var editBill: Bill?

    var selectArray:Array = Array<String>()
    var selectedIndexArray:Array = Array<IndexPath>()
    
    let expenditureArray:Array = Array<String>()
    let incomeArray:Array = Array<String>()

    @IBOutlet weak var selectTypeView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated:true,completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectTypeView.delegate = self
        selectTypeView.dataSource = self 
        (selectTypeView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: 20, height: 20)
        //设置分类View单元格的水平间距
        (selectTypeView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = 5
        //设置分类View单元格的行间距
        (selectTypeView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 5
        //设置分类View的内边距
        (selectTypeView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset = UIEdgeInsets(top: 5,left: 20,bottom: 0,right: 20)

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectArray = expenditureArray
            break
        case 1:
            selectArray = incomeArray
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
        cell.cellStatusWithSelected(selected: ((selectedIndexArray.firstIndex(of:indexPath) != nil)))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.cellForItem(at: indexPath) as! SelectTypeCollectionViewCell
        if let i = selectedIndexArray.firstIndex(of: indexPath){
            selectedIndexArray.remove(at: i)
            cell.cellStatusWithSelected(selected: false)
        }else{
            selectedIndexArray.append(indexPath)
            cell.cellStatusWithSelected(selected: true)
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
