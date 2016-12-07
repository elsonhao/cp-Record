//
//  FirstTableViewController.swift
//  NewMovie
//
//  Created by 黃毓皓 on 2016/11/22.
//  Copyright © 2016年 ice elson. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {

    var nowRowsNumber = 2
    @IBOutlet var myTableView: UITableView!
    var dicArray = [["name":"影集1範本","score":"7","showContent":"影集1範本內容"],["name":"影集2範本","score":"9","showContent":"影集2範本內容"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 假設程式從背景移除的話,當再次進入app時要先決定檔案裡的資料數目有幾個,以決定要呈現的cell列數
        let fileManager  = FileManager.default
        let docUrls = fileManager.urls(for:
            .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url  = docUrl?.appendingPathComponent("我的資料.txt")
        
        //判斷若url路徑裡有陣列資料的話才執行程式
        if let array2 = NSArray(contentsOf: url!) {
            print("執行viewwillappear時\(array2.count)")
           nowRowsNumber = (array2.count)
        }
        print("reload data")
        myTableView.reloadData()
    }
    @IBAction func goAdd(_ sender: Any) {
        self.performSegue(withIdentifier: "goAdd", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "DetailSegue", sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cellIndexNow = sender {
            //傳入按下ㄌcell的indexpath.row
            let nowCellIndex = sender as! Int
            //讀取現有檔案"我的資料"
            let fileManager  = FileManager.default
            let docUrls = fileManager.urls(for:
                .documentDirectory, in: .userDomainMask)
            let docUrl = docUrls.first
            let url  = docUrl?.appendingPathComponent("我的資料.txt")
            //取得deatilTableController裡的資料
            let controller = segue.destination as! DetailTableViewController
            //判斷若url路徑裡有陣列資料的話才執行程式
            if var array2 = NSArray(contentsOf: url!) {
                 let dictest = array2[nowCellIndex]
                    let dictest5 =  dictest as! NSDictionary
                    controller.movie = dictest5["name"] as? String
                    controller.Score = dictest5["score"] as? String
                controller.Content = dictest5["showContent"] as? String
                    print("傳遞到detailcontroller資料成功,我的檔案裡已有資料")
                
            }else{
                let nowDicArray = dicArray[nowCellIndex]
                controller.movie = nowDicArray["name"]
                controller.Score = nowDicArray["score"]
                
                controller.Content = nowDicArray["showContent"]
                print("傳遞到detailcontroller資料成功,我的檔案裡沒有資料")
            }
        }
    }
    
    
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nowRowsNumber
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! firstTableViewCell

        let fileManager  = FileManager.default
        let docUrls = fileManager.urls(for:
            .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url  = docUrl?.appendingPathComponent("我的資料.txt")
        let array2 = NSArray(contentsOf: url!)
        print("array2有資料嗎\(array2)")
        //先讀取有沒有建立檔案了,有的話才繼續執行程式
        if let dictest = array2?[indexPath.row]  {
        let dictest5 =  dictest as! NSDictionary
        cell.labelShow.text = dictest5["name"] as? String
        
            print("讀取檔案成功")
        }else{  //若沒有讀取到檔案則執行此程式
            cell.labelShow.text = dicArray[indexPath.row]["name"]
            print("讀取檔案失敗")
        }
        

        return cell
    }
    
    
    

}
