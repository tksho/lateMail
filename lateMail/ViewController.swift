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
        self.mail.title = self.mail.changeTitle(selectedReason, inTime: selectedTime)

        // 本文を置換
        self.mail.body = self.mail.changeBody(selectedReason, inTime: selectedTime)

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
        
        //メールを送信できるかチェック
        if MFMailComposeViewController.canSendMail() == false {
            let alert = UIAlertController(title: "エラー", message: "メーラーが見つかりません", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (okAction) in
                // OKボタンを押したときのアクション
                alert.dismiss(animated: true, completion: nil)
            })
            // アラート表示
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }

        // 保存データ読み込み
        self.mail.loadFromUd()
        let mailViewController = MFMailComposeViewController()

        // Toアドレスの指定
        var toRecipients = [String]()
        if self.mail.to1! != "" { toRecipients.append(self.mail.to1!) }
        if self.mail.to2! != "" { toRecipients.append(self.mail.to2!) }
        if self.mail.to3! != "" { toRecipients.append(self.mail.to3!) }

        // Ccアドレスの指定
        var CcRecipients = [String]()
        if self.mail.cc1! != "" { CcRecipients.append(self.mail.cc1!) }
        if self.mail.cc2! != "" { CcRecipients.append(self.mail.cc2!) }
        if self.mail.cc3! != "" { CcRecipients.append(self.mail.cc3!) }

        // Bccアドレスの指定
        var BccRecipients = [String]()
        if self.mail.bcc1! != "" { BccRecipients.append(self.mail.bcc1!) }
        if self.mail.bcc2! != "" { BccRecipients.append(self.mail.bcc2!) }
        if self.mail.bcc3! != "" { BccRecipients.append(self.mail.bcc3!) }

        mailViewController.mailComposeDelegate = self
        mailViewController.setToRecipients(toRecipients)    //Toアドレスの表示
        mailViewController.setCcRecipients(CcRecipients)    //Ccアドレスの表示
        mailViewController.setBccRecipients(BccRecipients)  //Bccアドレスの表示
        mailViewController.setSubject(self.mailTitleLabel.text!)                    // 件名
        mailViewController.setMessageBody(self.mailBodyLabel.text!, isHTML: false)  // 本文
        
        self.present(mailViewController, animated: true, completion: nil)
    }
    
    //----------------------------------
    // 関数名：clickSendOtherBtn
    // 説明：[その他]ボタンが押された
    //----------------------------------
    @IBAction func clickSendOtherBtn(_ sender: AnyObject) {
        
        // 本文をitemsにセット
        self.mail.loadFromUd()
        let text = self.mailBodyLabel.text!
        let items = [text]
        
        // UIActivityViewControllerを表示
        let activityVc = UIActivityViewController(activityItems: items, applicationActivities: nil)
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
        
        // 本文と件名を置換
        self.mail.title = self.mail.changeTitle(selectedReason, inTime: selectedTime)
        self.mail.body = self.mail.changeBody(selectedReason, inTime: selectedTime)
        
        // 表示用のメール件名と本文を作り表示
        self.mailTitleLabel.text = self.mail.dispTitle()
        self.mailBodyLabel.text = self.mail.dispBody()
        
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
        // タイトルをセット
        self.navigationItem.title = "かんたん本文作成"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

