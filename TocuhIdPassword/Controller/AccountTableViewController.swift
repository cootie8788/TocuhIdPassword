//
//  AccountTableViewController.swift
//  TocuhIdPassword
//
//  Created by 林沂諺 on 2018/7/8.
//  Copyright © 2018年 AppleCode. All rights reserved.
//

import UIKit
import KeychainSwift

class AccountTableViewController: UITableViewController {
    
    var accountItems = [AccountItem]()
    let keychain = KeychainSwift()
    var data: [AccountItem] = []
    
    @IBAction func goBack(segue: UIStoryboardSegue) {
        if let controller = segue.source as? EditTableViewController, let accountItem = controller.accountItem, let row = tableView.indexPathForSelectedRow?.row {
            
            accountItems[row] = accountItem
            let encoder = JSONEncoder()
            encoder.outputFormatting = .init()
            guard let data = try? encoder.encode(accountItems) else {
                assertionFailure("econder Fail")
                return
            }
            keychain.set(data, forKey: "accountItems")
            tableView.reloadData()
        }
        
    }
    
    @objc
    func updateAccountNoti(noti: Notification) {
        if let userInfo = noti.userInfo, let accountItem = userInfo[NotificationObjectKey.accountItem] as? AccountItem {
            accountItems.insert(accountItem, at: 0)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .init()
            guard let data = try? encoder.encode(accountItems) else {
                assertionFailure("econder Fail")
                return
            }
            keychain.set(data, forKey: "accountItems")
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .middle)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateAccountNoti(noti:)), name: .accountDidChaqnge, object: nil)
        let decoder = JSONDecoder()
        if let ggg = keychain.getData("accountItems") {
            
            if let data = try? decoder.decode([AccountItem].self, from: ggg) {
                for aaa in data{
                    accountItems.append(aaa)
                    
                }
            }
        }
    }
    
}
extension AccountTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AccountTableViewCell
        let aaa = accountItems[indexPath.row]
        cell.accountNameLabel?.text = aaa.accountname
        cell.accountLabel?.text = aaa.account
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        accountItems.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        keychain.delete("accountItems")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .init()
        guard let data = try? encoder.encode(accountItems) else {
            assertionFailure("econder Fail")
            return
        }
        keychain.set(data, forKey: "accountItems")
        
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailAccount" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailsTableViewController
                destinationController.accountItem = accountItems[indexPath.row]
            }
            
        }
        
    }    
}



















