//
//  MailAddressEditViewController.swift
//  lateMail
//
//  Created by Sho Takahashi on 2017/09/21.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit

class MailAddressEditViewController: UIViewController {

    @IBOutlet var to1:UITextField!
    @IBOutlet var to2:UITextField!
    @IBOutlet var to3:UITextField!
    @IBOutlet var cc1:UITextField!
    @IBOutlet var cc2:UITextField!
    @IBOutlet var cc3:UITextField!
    @IBOutlet var bcc1:UITextField!
    @IBOutlet var bcc2:UITextField!
    @IBOutlet var bcc3:UITextField!
    var mail: Mail = Mail(title:"", body: "", fromName: "", to1: "", to2: "", to3: "", cc1: "", cc2: "", cc3: "", bcc1: "", bcc2: "", bcc3: "" )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 保存データ読み込み
        self.mail.loadFromUd()
        
        // 設定値読み込み
        self.to1.text = self.mail.to1! as String
        self.to2.text = self.mail.to2! as String
        self.to3.text = self.mail.to3! as String
        self.cc1.text = self.mail.cc1! as String
        self.cc2.text = self.mail.cc2! as String
        self.cc3.text = self.mail.cc3! as String
        self.bcc1.text = self.mail.bcc1! as String
        self.bcc2.text = self.mail.bcc2! as String
        self.bcc3.text = self.mail.bcc3! as String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func save() {
        // 保存
        self.mail.to1 = self.to1.text as! NSMutableString
        self.mail.to2 = self.to2.text as! NSMutableString
        self.mail.to3 = self.to3.text as! NSMutableString
        self.mail.cc1 = self.cc1.text as! NSMutableString
        self.mail.cc2 = self.cc2.text as! NSMutableString
        self.mail.cc3 = self.cc3.text as! NSMutableString
        self.mail.bcc1 = self.bcc1.text as! NSMutableString
        self.mail.bcc2 = self.bcc2.text as! NSMutableString
        self.mail.bcc3 = self.bcc3.text as! NSMutableString
        self.mail.saveToUd()
        
        self.dismiss(animated: true, completion: nil)
    }

}
