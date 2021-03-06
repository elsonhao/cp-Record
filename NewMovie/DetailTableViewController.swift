//
//  DetailTableViewController.swift
//  NewMovie
//
//  Created by 黃毓皓 on 2016/11/23.
//  Copyright © 2016年 ice elson. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    var movie:String!
    var Score:String!
    var Content:String!
    var movieImageName:UIImage!
    var DeatilNowIndex:Int!
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UITextField!
    @IBOutlet weak var movieScore: UITextField!
    @IBOutlet weak var movieContent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        movieName.text = movie
        movieScore.text = Score
        movieContent.text = Content
        movieImage.image = movieImageName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let Editcontroller = segue.destination as! EditTableViewController
        Editcontroller.EditMovie = movie
        Editcontroller.EditScore = Score
        Editcontroller.EditContent = Content
        Editcontroller.EditImageName = movieImageName
        Editcontroller.nowIndexNumber = DeatilNowIndex
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
