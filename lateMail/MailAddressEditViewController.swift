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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 設定値読み込み
        let ud = UserDefaults.standard
        self.to1.text = ud.string(forKey: "to1")
        self.to2.text = ud.string(forKey: "to2")
        self.to3.text = ud.string(forKey: "to3")
        self.cc1.text = ud.string(forKey: "cc1")
        self.cc2.text = ud.string(forKey: "cc2")
        self.cc3.text = ud.string(forKey: "cc3")
        self.bcc1.text = ud.string(forKey: "bcc1")
        self.bcc2.text = ud.string(forKey: "bcc2")
        self.bcc3.text = ud.string(forKey: "bcc3")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func save() {
        // 保存
        let ud = UserDefaults.standard
        ud.set(self.to1.text, forKey: "to1")
        ud.set(self.to2.text, forKey: "to2")
        ud.set(self.to3.text, forKey: "to3")
        ud.set(self.cc1.text, forKey: "cc1")
        ud.set(self.cc2.text, forKey: "cc2")
        ud.set(self.cc3.text, forKey: "cc3")
        ud.set(self.bcc1.text, forKey: "bcc1")
        ud.set(self.bcc2.text, forKey: "bcc2")
        ud.set(self.bcc3.text, forKey: "bcc3")
        
        self.dismiss(animated: true, completion: nil)
    }

}
