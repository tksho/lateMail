//
//  SlideViewController.swift
//  lateMail
//
//  Created by nttr on 2017/08/30.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class SlideViewController: SlideMenuController {
    
    override func awakeFromNib() {
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "Main")
        let leftVC = storyboard?.instantiateViewController(withIdentifier: "Left")
        //UIViewControllerにはNavigationBarは無いためUINavigationControllerを生成しています。
        let navigationController = UINavigationController(rootViewController: mainVC!)
        //ライブラリ特有のプロパティにセット
        mainViewController = navigationController
        leftViewController = leftVC
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
