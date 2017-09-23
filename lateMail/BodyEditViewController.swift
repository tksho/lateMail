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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 設定値読み込み
        let ud = UserDefaults.standard
        self.bodyTextView.text = ud.string(forKey: "body")
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
        ud.set(self.bodyTextView.text, forKey: "body")
        
        print("保存しました")
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
