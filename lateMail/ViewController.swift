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
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate{

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

    //----------------------------------
    // 関数名：clickBtn_SendByMail
    // 説明：[メール]ボタンが押された
    //----------------------------------
    @IBAction func clickBtn_SendByMail() {
        print("mail")
        //メールを送信できるかチェック
        if MFMailComposeViewController.canSendMail()==false {
            print("Email Send Failed")
            return
        }
        
        var mailViewController = MFMailComposeViewController()
        let toRecipients = ["to@1gmail.com","tksho112@gmail.com"] //Toのアドレス指定
        let CcRecipients = ["cc@1gmail.com","Cc2@1gmail.com"] //Ccのアドレス指定
        let BccRecipients = ["Bcc@1gmail.com","Bcc2@1gmail.com"] //Bccのアドレス指定
        
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject("メールの件名")
        mailViewController.setToRecipients(toRecipients) //Toアドレスの表示
        mailViewController.setCcRecipients(CcRecipients) //Ccアドレスの表示
        mailViewController.setBccRecipients(BccRecipients) //Bccアドレスの表示
        mailViewController.setMessageBody("メールの本文", isHTML: false)
        
        self.present(mailViewController, animated: true, completion: nil)
    }

    
    //----------------------------------
    // 関数名：mailComposeController
    // 説明：メールを送信しない場合のクローズ処理
    //----------------------------------
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("キャンセル")
        case .saved:
            print("下書き保存")
        case .sent:
            print("送信成功")
        default:
            print("送信失敗")
        }
        dismiss(animated: true, completion: nil)
    }
    
    //----------------------------------
    // 関数名：clickBtn_SendByOther
    // 説明：[その他]ボタンが押された
    //----------------------------------
    @IBAction func clickBtn_SendByOther(sender: AnyObject) {
        let text = "sample text"
        let items = [text]
        
        // UIActivityViewControllerをインスタンス化
        let activityVc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // UIAcitivityViewControllerを表示
        self.present(activityVc, animated: true, completion: nil)
    }

}

