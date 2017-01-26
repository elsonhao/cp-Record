//
//  FirstTableViewController.swift
//  NewMovie
//
//  Created by 黃毓皓 on 2016/11/22.
//  Copyright © 2016年 ice elson. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {

    var nowRowsNumber = 0
    var wholeImageName:String = ""
    var showImage:UIImage!
    @IBOutlet var myTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        let fileManager  = FileManager.default
        let docUrls = fileManager.urls(for:
            .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url  = docUrl?.appendingPathComponent("我的資料.txt")
        let url2  = docUrl?.appendingPathComponent("圖片檔名.txt")
        
        
        //如果有資料檔名.txt的資料
        if var gogoArray = NSArray(contentsOf: url!)  {
            if editingStyle == .delete
            {
                print("刪除文字資料")
                var usetest = gogoArray as! Array<Dictionary<String, String>>
                usetest.remove(at: indexPath.row)
                (usetest as NSArray).write(to: url!, atomically: true)
                nowRowsNumber = usetest.count
                //刪除圖檔名稱資料
                let array2 = NSArray(contentsOf: url2!)
                var arrayDelete = array2 as! Array<String>
                arrayDelete.remove(at: indexPath.row)
                (arrayDelete as NSArray).write(to: url2!, atomically: true)
                print("nowRowsNumber\(nowRowsNumber)")
                print("arrayDelete\(arrayDelete.count)")
                
                myTableView.reloadData()

            }
        }
            
        
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
        
        //用if let cellIndexNow = sender 的方式,是為了區隔goAdd,DetailSegue 所觸發的prepare方法
        if let cellIndexNow = sender {
            //傳入按下ㄌcell的indexpath.row
            let nowCellIndex = sender as! Int
            //讀取現有檔案"我的資料"
            let fileManager  = FileManager.default
            let docUrls = fileManager.urls(for:
                .documentDirectory, in: .userDomainMask)
            let docUrl = docUrls.first
            let url  = docUrl?.appendingPathComponent("我的資料.txt")
            let url2  = docUrl?.appendingPathComponent("圖片檔名.txt")
            //取得deatilTableController裡的資料
            let controller = segue.destination as! DetailTableViewController
            controller.DeatilNowIndex = nowCellIndex
            
            //判斷若url路徑裡有陣列資料的話才執行程式
            if var array2 = NSArray(contentsOf: url!) {
                 let dictest = array2[nowCellIndex]
                    let dictest5 =  dictest as! NSDictionary
                    controller.movie = dictest5["name"] as? String
                    controller.Score = dictest5["score"] as? String
                controller.Content = dictest5["showContent"] as? String
                //傳遞圖片
                if let nameArray = NSArray(contentsOf: url2!) {
                    let nameImage =  nameArray[nowCellIndex]
                    wholeImageName = nameImage as! String
                    print("有圖片名稱")
    
                }
                let url3 = docUrl?.appendingPathComponent(wholeImageName)
                if let image = UIImage(contentsOfFile: (url3?.path)!){
                    controller.movieImageName = image
                    
                    
                    print("傳遞圖片成功")
                }
                else{
                    controller.movieImageName  = UIImage(named: "1")
                    
                    print("no\n")
                }
                
                    print("傳遞到detailcontroller資料成功,我的檔案裡已有資料\n")
             
            }
        }
    }
    
    
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return nowRowsNumber
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! firstTableViewCell

        let fileManager  = FileManager.default
        let docUrls = fileManager.urls(for:
            .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url  = docUrl?.appendingPathComponent("我的資料.txt")

        
        
        //先讀取有沒有建立檔案url,有的話才繼續執行程式
        if let array2 = NSArray(contentsOf: url!){
            let dictest = array2[indexPath.row]
            let dictest5 =  dictest as! NSDictionary
            cell.labelShow.text = dictest5["name"] as? String
            cell.cpShow.text = "cp:" + (dictest5["score"] as? String)!
            print("indexpath\(indexPath.row)")
            print("讀取檔案成功")
            print("array2有資料嗎\(array2)")
        }
        
        
        
        
        
        

        
        
        
        
        let url2  = docUrl?.appendingPathComponent("圖片檔名.txt")
        
       // 先讀取圖片名稱
        if let nameArray = NSArray(contentsOf: url2!) {
            
                let nameImage =  nameArray[indexPath.row]
                wholeImageName = nameImage as! String
                print("有圖片名稱")
        }
        
        
        //抓取圖片
        
        let url3 = docUrl?.appendingPathComponent(wholeImageName)
        if let image = UIImage(contentsOfFile: (url3?.path)!){
           cell.ImageShow.image = image
      
            print("yes")
        }
        
        
        

        return cell
    }
    
    
    

}
