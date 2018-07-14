//
//  DetailsTableViewController.swift
//  TocuhIdPassword
//
//  Created by 林沂諺 on 2018/7/10.
//  Copyright © 2018年 AppleCode. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var detailAccountNameLabel: UILabel!
    
    @IBOutlet weak var detailAccountLabel: UILabel!
    
    @IBOutlet weak var detailPasswordLabel: UILabel!
    
    
    @IBOutlet weak var remarksLabel: UILabel!
 
    var accountItem: AccountItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailAccountNameLabel.text = accountItem?.accountname
        detailAccountLabel.text = accountItem?.account
        detailPasswordLabel.text = accountItem?.password
        remarksLabel.text = accountItem?.remarks
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! EditTableViewController
        
        controller.accountItem = accountItem
        
    }
    
    
}
