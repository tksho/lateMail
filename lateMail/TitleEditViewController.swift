//
//  TitleEditViewController.swift
//  lateMail
//
//  Created by Sho Takahashi on 2017/09/21.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit

class TitleEditViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    var mail: Mail = Mail(title:"", body: "", fromName: "", to1: "", to2: "", to3: "", cc1: "", cc2: "", cc3: "", bcc1: "", bcc2: "", bcc3: "" )
    
    // キーボードをしまう（TextField以外の部分をタッチしたときに）
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // ナビゲーションバー右上に[保存]ボタン設置
        let rightSaveButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(TitleEditViewController.clickSaveBtn))
        self.navigationItem.rightBarButtonItem = rightSaveButton
        
        // 保存データ読み込み
        self.mail.loadFromUd()
        self.titleTextField.text = self.mail.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //----------------------------------
    // 関数名：clickSaveBtn
    // 説明：保存ボタンが押された
    //----------------------------------
    @IBAction func clickSaveBtn() {
        // 保存
        self.mail.title = self.titleTextField.text
        self.mail.saveToUd()
        
        print("保存しました")

        self.dismiss(animated: true, completion: nil)
    }
    
}
