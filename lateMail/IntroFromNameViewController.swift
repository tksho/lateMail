//
//  IntroFromNameViewController.swift
//  lateMail
//
//  Created by Sho Takahashi on 2017/09/23.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit

class IntroFromNameViewController: UIViewController {

    @IBOutlet var fromNameTextField:UITextField!
    var mail: Mail = Mail(title:"", body: "", fromName: "", to1: "", to2: "", to3: "", cc1: "", cc2: "", cc3: "", bcc1: "", bcc2: "", bcc3: "" )

    //----------------------------------
    // 関数名：clickNextBtn
    // 説明：次へボタンが押された
    //----------------------------------
    @IBAction func clickNextBtn(){
        // 入力値を保存
        if fromNameTextField.text != "" {
            self.mail.fromName = fromNameTextField.text
            self.mail.saveToUd()
        }
        // イントロ最後画面へ遷移
        self.performSegue(withIdentifier: "toIntroAddress", sender: nil)
 
    }

    //----------------------------------
    // 関数名：clickSkipBtn
    // 説明：skipボタンが押された
    //----------------------------------
    @IBAction func clickSkipBtn(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "Slide")
        UIApplication.shared.keyWindow?.rootViewController = rootViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 保存データ読み込み
        mail.loadFromUd()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
