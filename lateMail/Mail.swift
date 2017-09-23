//
//  Mail.swift
//  lateMail
//
//  Created by Sho Takahashi on 2017/09/23.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit

class Mail: NSObject {
    var title: NSMutableString!     // 件名
    var body: NSMutableString!      // 本文
    var fromName: NSMutableString!  // 差出人名
    var to1: NSMutableString!       // 宛先To1
    var to2: NSMutableString!       // 宛先To2
    var to3: NSMutableString!       // 宛先To2
    var cc1: NSMutableString!       // 宛先Cc1
    var cc2: NSMutableString!       // 宛先Cc2
    var cc3: NSMutableString!       // 宛先Cc3
    var bcc1: NSMutableString!      // 宛先bcc1
    var bcc2: NSMutableString!      // 宛先bcc2
    var bcc3: NSMutableString!      // 宛先bcc3
    
    // 初期化
    init(title: NSMutableString, body: NSMutableString, fromName: NSMutableString, to1: NSMutableString, to2: NSMutableString, to3: NSMutableString, cc1: NSMutableString, cc2: NSMutableString, cc3: NSMutableString, bcc1: NSMutableString, bcc2: NSMutableString, bcc3: NSMutableString ) {
        self.title = title
        self.body = body
        self.fromName = fromName
        self.to1 = to1
        self.to2 = to2
        self.to3 = to3
        self.cc1 = cc1
        self.cc2 = cc2
        self.cc3 = cc3
        self.bcc1 = bcc1
        self.bcc2 = bcc2
        self.bcc3 = bcc3
    }
    
    // udから読み込み
    func loadFromUd() {
        let ud = UserDefaults.standard
        self.title = ud.string(forKey: "title") as! NSMutableString
        self.body = ud.string(forKey: "body") as! NSMutableString
        self.fromName = ud.string(forKey: "fromName") as? NSMutableString
        self.to1 = ud.string(forKey: "to1") as! NSMutableString
        self.to2 = ud.string(forKey: "to2") as! NSMutableString
        self.to3 = ud.string(forKey: "to3") as! NSMutableString
        self.cc1 = ud.string(forKey: "cc1") as! NSMutableString
        self.cc2 = ud.string(forKey: "cc2") as! NSMutableString
        self.cc3 = ud.string(forKey: "cc3") as! NSMutableString
        self.bcc1 = ud.string(forKey: "bcc1") as! NSMutableString
        self.bcc2 = ud.string(forKey: "bcc2") as! NSMutableString
        self.bcc3 = ud.string(forKey: "bcc3") as! NSMutableString
    }

    // udに保存
    func saveToUd() {
        let ud = UserDefaults.standard
        ud.set(self.title, forKey: "title")
        ud.set(self.body, forKey: "body")
        ud.set(self.fromName, forKey: "fromName")
        ud.set(self.to1, forKey: "to1")
        ud.set(self.to2, forKey: "to2")
        ud.set(self.to3, forKey: "to3")
        ud.set(self.cc1, forKey: "cc1")
        ud.set(self.cc2, forKey: "cc2")
        ud.set(self.cc3, forKey: "cc3")
        ud.set(self.bcc1, forKey: "bcc1")
        ud.set(self.bcc2, forKey: "bcc2")
        ud.set(self.bcc3, forKey: "bcc3")
    }
}
