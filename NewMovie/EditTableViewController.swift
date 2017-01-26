//
//  EditTableViewController.swift
//  NewMovie
//
//  Created by 黃毓皓 on 2016/11/24.
//  Copyright © 2016年 ice elson. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate {

    var EditContent:String!
    var EditMovie:String!
    var EditScore:String!
    var EditImageName:UIImage!
    var nowIndexNumber:Int!
    var imageTransfer:UIImage!
    
    @IBOutlet weak var inputContent: UITextView!
    @IBOutlet weak var inputScore: UITextField!
    @IBOutlet weak var inputNmae: UITextField!
    @IBOutlet weak var myImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputNmae.text = EditMovie
        inputScore.text = EditScore
        inputContent.text = EditContent
        myImage.image = EditImageName
        
        let tapGesture = UITapGestureRecognizer(target:self, action:#selector(imagePressed))
        myImage.isUserInteractionEnabled = true // this line is important
        myImage.addGestureRecognizer(tapGesture)
        
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
        myImage.image = image
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func EditFinish(_ sender: Any) {
        let fileManager  = FileManager.default
        let docUrls = fileManager.urls(for:
            .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url  = docUrl?.appendingPathComponent("我的資料.txt")
        
        
        let url2 =  docUrl?.appendingPathComponent("圖片檔名.txt")

        
        
        //判斷如果有圖片檔名
        if var happy = NSArray(contentsOf: url2!) {
            var imageNameArray = happy as! Array<String>
            let imageNowName = imageNameArray[nowIndexNumber]
            let url3 =  docUrl?.appendingPathComponent(imageNowName)
//            (imageNameArray as NSArray).write(to: url2!, atomically: true)
//            print("已有圖片檔名,再新增圖片名字進去")
            
            //判斷如果使用者有選取圖片,並設定好imageTransfer
            if let hasImage = imageTransfer{
                let data = UIImageJPEGRepresentation(imageTransfer, 0.9)
                try! data?.write(to: url3!)
                print("使用者有選擇照片")
            }else{
                let defaultImage = EditImageName
                let data = UIImageJPEGRepresentation(defaultImage!, 0.9)
                try! data?.write(to: url3!)
                print("使用者沒有選擇照片,使用預設圖片")
            }
          
        }
           // 如果沒有圖片檔名.txt

        
        
        //若檔案路徑裡"有"資料,則讀取資料並修改後傳回去
        if var gogoArray = NSArray(contentsOf: url!)  {
            var usetest = gogoArray as! Array<Dictionary<String, String>>
           
            usetest[nowIndexNumber] = ["name":self.inputNmae.text!,"score":self.inputScore.text!,"showContent":self.inputContent.text!]
            
            (usetest as NSArray).write(to: url!, atomically: true)
            
        }
            
            //若檔案路徑裡"沒有"資料,則執行此程式,新增資料進去

        
       self.navigationController?.popToRootViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputNmae.resignFirstResponder()
        inputScore.resignFirstResponder()
        return true
    }

//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        
//
//        return cell
//    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
