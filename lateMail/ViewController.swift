//
//  ViewController.swift
//  lateMail
//
//  Created by nttr on 2017/08/23.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit
import Accounts
import SlideMenuControllerSwift

class ViewController: UIViewController {

    @IBOutlet var shareBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //NavigationBarが半透明かどうか
        navigationController?.navigationBar.isTranslucent = false
        //NavigationBarの色を変更します
        navigationController?.navigationBar.barTintColor = UIColor(red: 129/255, green: 212/255, blue: 78/255, alpha: 1)
        //NavigationBarに乗っている部品の色を変更します
        navigationController?.navigationBar.tintColor = UIColor.white
        //バーの左側にボタンを配置します(ライブラリ特有)
        addLeftBarButtonWithImage(UIImage(named: "menu.png")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushActivityButton(sender: AnyObject) {
        let text = "sample text"
        let items = [text]
        
        // UIActivityViewControllerをインスタンス化
        let activityVc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // UIAcitivityViewControllerを表示
        self.present(activityVc, animated: true, completion: nil)
    }

}

