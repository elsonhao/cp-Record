//
//  AddTableViewController.swift
//  NewMovie
//
//  Created by 黃毓皓 on 2016/11/22.
//  Copyright © 2016年 ice elson. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate {
     var timeArray = [String]()
    var imageTransfer:UIImage!
    @IBOutlet weak var MyImage: UIImageView!
    @IBOutlet weak var addMovieName: UITextField!
    @IBOutlet weak var addCash: UITextField!
    @IBOutlet weak var showContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tapGesture = UITapGestureRecognizer(target:self, action:#selector(imagePressed))
        MyImage.isUserInteractionEnabled = true // this line is important
        MyImage.addGestureRecognizer(tapGesture)
    }
    
    func imagePressed(){
        print("image touch")
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true,
                     completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageTransfer = image
        MyImage.image = image
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addFinish(_ sender: Any) {
        let fileManager  = FileManager.default
        let docUrls = fileManager.urls(for:
            .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url  = docUrl?.appendingPathComponent("我的資料.txt")
        //
        let interval = Date.timeIntervalSinceReferenceDate
        let name = "\(interval).jpg"
        let url2 =  docUrl?.appendingPathComponent("圖片檔名.txt")
        let url3 =  docUrl?.appendingPathComponent(name)
        
        //如果有圖片檔名.txt的資料
        
        if var happy = NSArray(contentsOf: url2!) {
            var imageNameArray = happy as! Array<String>
            imageNameArray.insert(name, at: 0)
            
            (imageNameArray as NSArray).write(to: url2!, atomically: true)
            print("已有圖片檔名,再新增圖片名字進去")
            
            //判斷如果使用者有選取圖片,並設定好imageTransfer
            if let hasImage = imageTransfer{
                let data = UIImageJPEGRepresentation(imageTransfer, 0.9)
                try! data?.write(to: url3!)
                print("使用者有選擇照片")
            }else{
                let defaultImage = UIImage(named: "1")
                let data = UIImageJPEGRepresentation(defaultImage!, 0.9)
                try! data?.write(to: url3!)
                print("使用者沒有選擇照片,使用預設圖片")
            }
            
            
            
            
        }
        //如果沒有圖片檔名.txt
        else{
            //寫入圖片檔名url2
            timeArray.insert(name, at: 0)
            (timeArray as NSArray).write(to: url2!, atomically: true)
            
            if let hasImage = imageTransfer{
                let data = UIImageJPEGRepresentation(imageTransfer, 0.9)
                try! data?.write(to: url3!)
                
            }else{
                let defaultImage = UIImage(named: "1")
                let data = UIImageJPEGRepresentation(defaultImage!, 0.9)
                try! data?.write(to: url3!)
                print("使用預設圖片2")
            }
            
        }
        

       
        
        //若檔案路徑裡"有"資料,則讀取資料並插入新的資料
        if var gogoArray = NSArray(contentsOf: url!)  {
        var usetest = gogoArray as! Array<Dictionary<String, String>>
        
        let newDIc = ["name":self.addMovieName.text!,"score":self.addCash.text!,"showContent":self.showContent.text!]
        //usetest陣列插入新的字典
        usetest.insert(newDIc, at: 0)
        
        (usetest as NSArray).write(to: url!, atomically: true)

        }
         
        //若檔案路徑裡"沒有"資料,則執行此程式,新增資料進去
        else {
        let arrayDic = [["name":self.addMovieName.text!,"score":self.addCash.text!,"showContent":self.showContent.text!]]
        (arrayDic as NSArray).write(to: url!, atomically: true)           
            print("現在陣列有幾筆資料:\(arrayDic.count)")
            
        }

        self.navigationController?.popViewController(animated: true)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addMovieName.resignFirstResponder()
        addCash.resignFirstResponder()
        return true
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
