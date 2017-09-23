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

    @IBOutlet var reason:UISegmentedControl!
    @IBOutlet var time:UISegmentedControl!
    @IBOutlet var mailBodyLabel:UILabel!
    @IBOutlet var mailTitleLabel:UILabel!
    var mail: Mail = Mail(title:"", body: "", fromName: "", to1: "", to2: "", to3: "", cc1: "", cc2: "", cc3: "", bcc1: "", bcc2: "", bcc3: "" )
    
    //----------------------------------
    // 関数名：segmentedControlChanged
    // 説明：理由or時間が指定された
    //----------------------------------
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {

        var selectedReason: String = ""
        var selectedTime: String = ""
        
        // 選択されている理由と時間を取得
        let resonSelectedIndex  = reason.selectedSegmentIndex
        let timeSelectedIndex   = time.selectedSegmentIndex
        selectedReason  = reason.titleForSegment(at: resonSelectedIndex)!
        selectedTime    = time.titleForSegment(at: timeSelectedIndex)!

        // 件名を置換
        self.mail.title = self.mail.changeTitle(inReason: selectedReason, inTime: selectedTime)

        // 本文を置換
        self.mail.body = self.mail.changeBody(inReason: selectedReason, inTime: selectedTime)

        // 表示用のメール本文を作り表示
        self.mailBodyLabel.text = self.mail.dispBody()
        
        // 表示用のメール件名を作り表示
        self.mailTitleLabel.text = self.mail.dispTitle()
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
    // 関数名：clickSendMailBtn
    // 説明：[メール]ボタンが押された
    //----------------------------------
    @IBAction func clickSendMailBtn() {
        print("mail")
        //メールを送信できるかチェック
        if MFMailComposeViewController.canSendMail()==false {
            print("Email Send Failed")
            return
        }
        
        let mailViewController = MFMailComposeViewController()
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
    // 関数名：clickSendOtherBtn
    // 説明：[その他]ボタンが押された
    //----------------------------------
    @IBAction func clickSendOtherBtn(sender: AnyObject) {
        let text = "sample text"
        let items = [text]
        
        // UIActivityViewControllerをインスタンス化
        let activityVc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // UIAcitivityViewControllerを表示
        self.present(activityVc, animated: true, completion: nil)
    }

    //----------------------------------
    // 関数名：clickTitleEditBtn
    // 説明：件名の[編集]ボタンが押された
    //----------------------------------
    @IBAction func clickTitleEditBtn() {
        self.performSegue(withIdentifier: "toTitleEdit", sender: nil)
    }

    //----------------------------------
    // 関数名：clickBodyEditBtn
    // 説明：本文の[編集]ボタンが押された
    //----------------------------------
    @IBAction func clickBodyEditBtn() {
        self.performSegue(withIdentifier: "toBodyEdit", sender: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        // 保存データ読み込み
        self.mail.loadFromUd()
        
        var selectedReason: String = ""
        var selectedTime: String = ""
        
        // 選択されている理由と時間を取得
        let resonSelectedIndex  = reason.selectedSegmentIndex
        let timeSelectedIndex   = time.selectedSegmentIndex
        selectedReason  = reason.titleForSegment(at: resonSelectedIndex)!
        selectedTime    = time.titleForSegment(at: timeSelectedIndex)!
        
        // 本文を置換
        self.mail.body = self.mail.changeBody(inReason: selectedReason, inTime: selectedTime)

        // 件名を置換
        self.mail.title = self.mail.changeTitle(inReason: selectedReason, inTime: selectedTime)
        
        // 表示用のメール本文を作り表示
        self.mailBodyLabel.text = self.mail.dispBody()
        
        // 表示用のメール件名を作り表示
        self.mailTitleLabel.text = self.mail.dispTitle()
        
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationBarが半透明かどうか
        navigationController?.navigationBar.isTranslucent = false
        // NavigationBarの色を変更します
        navigationController?.navigationBar.barTintColor = UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1)
        // NavigationBarに乗っている部品の色を変更します
        navigationController?.navigationBar.tintColor = UIColor.white
        // バーの左側にボタンを配置します(ライブラリ特有)
        addLeftBarButtonWithImage(UIImage(named: "menu.png")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

