//
//  IntroBeginViewController.swift
//  lateMail
//
//  Created by Sho Takahashi on 2017/09/30.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit

class IntroBeginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //----------------------------------
    // 関数名：clickNextBtn
    // 説明：次へボタンが押された
    //----------------------------------
    @IBAction func clickNextBtn(){
        // イントロ次画面へ遷移
        self.performSegue(withIdentifier: "toIntroFromName", sender: nil)
        
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


}
