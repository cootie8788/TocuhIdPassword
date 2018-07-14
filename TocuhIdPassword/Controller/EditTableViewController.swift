//
//  EditTableViewController.swift
//  TocuhIdPassword
//
//  Created by 林沂諺 on 2018/7/8.
//  Copyright © 2018年 AppleCode. All rights reserved.
//

import UIKit
import KeychainSwift

struct  NotificationObjectKey {
    static let accountItem = " accountItem"
}

class EditTableViewController: UITableViewController {
    
    var accountItem: AccountItem?
    
    
    @IBOutlet weak var accountNameTextField: UITextField!
    
    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var remarksTextView: UITextView!
    
    @IBOutlet weak var accountNameLabel: UILabel!
    
    @IBOutlet weak var accountLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBAction func goBackPage(_ sender: UIBarButtonItem) {
       self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if let accountItem = accountItem {
            accountNameTextField.text = accountItem.accountname
            accountTextField.text = accountItem.account
            passwordTextField.text = accountItem.password
            remarksTextView.text = accountItem.remarks
            
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        guard let name = accountNameTextField.text, name.count > 0 else {
            accountNameLabel.text = "請輸入帳號名稱!"
            return
        }
        guard let account = accountTextField.text, account.count > 0 else {
            accountLabel.text = "請輸入帳號!"
            return
        }
        guard let password = passwordTextField.text, password.count > 0 else {
            passwordLabel.text = "請輸入密碼!"
            return
        }
        guard let remarks = remarksTextView.text else {
            return
        }

        
//        let remarks = remarksTextView.text ?? ""
        
        
        
        if accountItem == nil {
            accountItem = AccountItem(accountname: name, account: account, password: password, remarks: remarks)
            view.endEditing(true)
            
            dismiss(animated: true) {
                NotificationCenter.default.post(name: .accountDidChaqnge, object: nil, userInfo: [NotificationObjectKey.accountItem: self.accountItem!])
            }
        }else{
            accountItem?.accountname = name
            accountItem?.account = account
            accountItem?.password = password
            accountItem?.remarks = remarks
            performSegue(withIdentifier: "goBack", sender: nil)
        }
    }
    
}

extension Notification.Name {
    static let accountDidChaqnge = Notification.Name("accountDidChaqnge")
}

