//
//  AccountTableViewCell.swift
//  TocuhIdPassword
//
//  Created by 林沂諺 on 2018/7/9.
//  Copyright © 2018年 AppleCode. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    @IBOutlet weak var accountNameLabel: UILabel!
    
    @IBOutlet weak var accountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
