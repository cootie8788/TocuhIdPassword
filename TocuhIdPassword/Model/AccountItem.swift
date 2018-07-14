//
//  AccountItem.swift
//  TocuhIdPassword
//
//  Created by 林沂諺 on 2018/7/7.
//  Copyright © 2018年 AppleCode. All rights reserved.
//

import Foundation

struct AccountItem:Codable{
    var accountname:String
    var account:String
    var password:String
    var remarks: String

}

//class AccountItem: Codable {
//    var accountname:String
//    var account:String
//    var password:String
//    var remarks: String
//    init(accountname:String, account:String, password:String, remarks: String) {
//        self.accountname = accountname
//        self.account = account
//        self.password = password
//        self.remarks = remarks
//
//    }
//
//}

