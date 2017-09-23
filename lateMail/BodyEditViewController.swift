//
//  BodyEditViewController.swift
//  lateMail
//
//  Created by Sho Takahashi on 2017/09/21.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit

class BodyEditViewController: UIViewController {

    @IBOutlet var bodyTextView: UITextView!
    var mail: Mail = Mail(title:"", body: "", fromName: "", to1: "", to2: "", to3: "", cc1: "", cc2: "", cc3: "", bcc1: "", bcc2: "", bcc3: "" )

    override func viewDidLoad() {
        super.viewDidLoad()

        // 保存データ読み込み
        self.mail.loadFromUd()
        self.bodyTextView.text = self.mail.body
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //----------------------------------
    // 関数名：clickCancelBtn
    // 説明：キャンセルボタンが押された
    //----------------------------------
    @IBAction func clickCancelBtn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //----------------------------------
    // 関数名：clickSaveBtn
    // 説明：保存ボタンが押された
    //----------------------------------
    @IBAction func clickSaveBtn() {
        // 保存
        self.mail.body = self.bodyTextView.text
        self.mail.saveToUd()
        
        print("保存しました")
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
