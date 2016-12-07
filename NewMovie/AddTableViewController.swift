//
//  AddTableViewController.swift
//  NewMovie
//
//  Created by 黃毓皓 on 2016/11/22.
//  Copyright © 2016年 ice elson. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController {

    
    @IBOutlet weak var addMovieName: UITextField!
    @IBOutlet weak var addCash: UITextField!
    @IBOutlet weak var showContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func addFinish(_ sender: Any) {
        let fileManager  = FileManager.default
        let docUrls = fileManager.urls(for:
            .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url  = docUrl?.appendingPathComponent("我的資料.txt")
        
        //判斷若gogoArray有值才執行（代表檔案路徑裡有資料）
        if var gogoArray = NSArray(contentsOf: url!)  {
        var usetest = gogoArray as! Array<Dictionary<String, String>>
        
        let newDIc = ["name":self.addMovieName.text!,"score":self.addCash.text!,"showContent":self.showContent.text!]
        //usetest陣列插入新的字典
        usetest.insert(newDIc, at: 0)
        
        (usetest as NSArray).write(to: url!, atomically: true)
//        let controller = self.navigationController?.viewControllers[0] as! FirstTableViewController
//            controller.nowRowsNumber = usetest.count
        }
         
        //若檔案路徑裡"沒有"資料,則執行此程式,新增資料進去
        else {
        let arrayDic = [["name":self.addMovieName.text!,"score":self.addCash.text!,"showContent":self.showContent.text!],["name":"影集1範本","score":"7","showContent":"影集1內容"],["name":"影集2範本","score":"9","showContent":"影集2內容"]]
        (arrayDic as NSArray).write(to: url!, atomically: true)
            let controller = self.navigationController?.viewControllers[0] as! FirstTableViewController
            print("現在陣列有幾筆資料:\(arrayDic.count)")
//           controller.nowRowsNumber = arrayDic.count
            
        }

        self.navigationController?.popViewController(animated: true)

    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }


}
