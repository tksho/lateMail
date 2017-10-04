//
//  MailAddressEditViewController.swift
//  lateMail
//
//  Created by Sho Takahashi on 2017/09/21.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit

class MailAddressEditViewController: UIViewController {

    @IBOutlet var to1:UITextField!  // 宛先To1
    @IBOutlet var to2:UITextField!  // 宛先To2
    @IBOutlet var to3:UITextField!  // 宛先To3
    @IBOutlet var cc1:UITextField!  // 宛先cc1
    @IBOutlet var cc2:UITextField!  // 宛先cc2
    @IBOutlet var cc3:UITextField!  // 宛先cc3
    @IBOutlet var bcc1:UITextField! // 宛先bcc1
    @IBOutlet var bcc2:UITextField! // 宛先bcc1
    @IBOutlet var bcc3:UITextField! // 宛先bcc1
    var mail: Mail = Mail(title:"", body: "", fromName: "", to1: "", to2: "", to3: "", cc1: "", cc2: "", cc3: "", bcc1: "", bcc2: "", bcc3: "" )
    
    // キーボードをしまう（TextField以外の部分をタッチしたときに）
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 保存データ読み込み
        self.mail.loadFromUd()
        self.to1.text = self.mail.to1
        self.to2.text = self.mail.to2
        self.to3.text = self.mail.to3
        self.cc1.text = self.mail.cc1
        self.cc2.text = self.mail.cc2
        self.cc3.text = self.mail.cc3
        self.bcc1.text = self.mail.bcc1
        self.bcc2.text = self.mail.bcc2
        self.bcc3.text = self.mail.bcc3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //----------------------------------
    // 関数名：clickSaveBtn
    // 説明：保存ボタンが押された
    //----------------------------------
    @IBAction func clickSaveBtn() {
        
        // 保存
        self.mail.to1 = self.to1.text
        self.mail.to2 = self.to2.text
        self.mail.to3 = self.to3.text
        self.mail.cc1 = self.cc1.text
        self.mail.cc2 = self.cc2.text
        self.mail.cc3 = self.cc3.text
        self.mail.bcc1 = self.bcc1.text
        self.mail.bcc2 = self.bcc2.text
        self.mail.bcc3 = self.bcc3.text
        self.mail.saveToUd()
        
        self.dismiss(animated: true, completion: nil)
    }

    //----------------------------------
    // 関数名：clickCancelBtn
    // 説明：キャンセルボタンが押された
    //----------------------------------
    @IBAction func clickCancelBtn() {
        self.dismiss(animated: true, completion: nil)
    }


}
