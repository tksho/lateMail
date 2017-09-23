//
//  IntroEndViewController.swift
//  lateMail
//
//  Created by Sho Takahashi on 2017/09/24.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit

class IntroEndViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //----------------------------------
    // 関数名：finishIntroBtn
    // 説明：さっそくアプリを使うボタンが押された
    //----------------------------------
    @IBAction func finishIntroBtn(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "Slide")
        UIApplication.shared.keyWindow?.rootViewController = rootViewController
    }

}
