//
//  OverviewTableViewController.swift
//  TocuhIdPassword
//
//  Created by 林沂諺 on 2018/7/7.
//  Copyright © 2018年 AppleCode. All rights reserved.
//

import UIKit



class OverviewTableViewController: UITableViewController {
    
    
    var accountItems:Array = [AccountItem]()
    
    
    @IBAction func goBack(segue: UIStoryboardSegue) {
        if let controller = segue.source as? EditTableViewController, let accountItem = controller.accountItem, let row = tableView.indexPathForSelectedRow?.row {
            accountItems[row] = accountItem
            tableView.reloadData()
            
        }
        
    }
    
    @objc func updateAccountNoti(noti: Notification) {
        if let userInfo = noti.userInfo, let accountItem = userInfo[NotificationObjectKey.accountItem] as? AccountItem {
            accountItems.insert(accountItem, at: 0)
            let accountDics = accountItems.map { (accountItem) ->  [String: Any]  in
                return ["accountname": accountItem.accountname, "account": accountItem.account, "password": accountItem.password, "remarks": accountItem.remarks]

            }
            UserDefaults.setValue(accountDics, forKey: "accountItems")
            let indexPath = IndexPath(row:
                0, section: 0)
            tableView.insertRows(at: [indexPath], with: .middle)
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
       
        if let accountItems = userDefaults.array(forKey: "accountItems") as? [[String: Any]] {
            self.accountItems = accountItems.compactMap({ accountDic  -> AccountItem? in
                if let accountname = accountDic["accountname"] as? String,
                   let account = accountDic["account"] as? String,
                   let password = accountDic["password"] as? String,
                    let remarks = accountDic["remarks"] as? String {
                    
                    return AccountItem(accountname: accountname, account: account, password: password, remarks: remarks)
                }else{
                    return nil
                }
                
              
            })
        
      
        NotificationCenter.default.addObserver(self, selector: #selector(updateAccountNoti(noti:)) , name: .accountItemdidChange, object: nil)
        
      
        }
        
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
        return accountItems.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OverviewTableViewCell
        let accountItem = accountItems[indexPath.row]
        cell.accountNameLabel.text = accountItem.accountname
        cell.accountLabel.text = accountItem.account

        return cell
    }


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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controleler = segue.destination as? EditTableViewController
            if let row = tableView.indexPathForSelectedRow?.row {
                controleler?.accountItem = accountItems[row]
                
            }
    }
    

}
