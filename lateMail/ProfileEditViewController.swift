//
//  ProfileEditViewController.swift
//  lateMail
//
//  Created by Sho Takahashi on 2017/09/21.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit

class ProfileEditViewController: UIViewController {

    @IBOutlet var nameTextField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 設定値読み込み
        let ud = UserDefaults.standard
        self.nameTextField.text = ud.string(forKey: "name")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func save() {
        // 保存
        let ud = UserDefaults.standard
        ud.set(self.nameTextField.text, forKey: "name")
        
        print("保存しました")
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
