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

    @IBOutlet var mailTitle:UITextView!
    @IBOutlet var mailBody:UITextView!
    @IBOutlet var reason:UISegmentedControl!
    @IBOutlet var time:UISegmentedControl!
    @IBOutlet var mailBodyLabel:UILabel!
    var ud_to1: String = ""
    var ud_to2: String = ""
    var ud_to3: String = ""
    var ud_cc1: String = ""
    var ud_cc2: String = ""
    var ud_cc3: String = ""
    var ud_bcc1: String = ""
    var ud_bcc2: String = ""
    var ud_bcc3: String = ""
    var ud_name: String = ""
    var ud_title: String = ""
    var ud_body: String = ""
    
    //----------------------------------
    // 関数名：segmentedControlChanged
    // 説明：理由or時間が指定された
    //----------------------------------
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {

        print("segmentedControlChanged")

        var selectedReason: String = ""
        var selectedTime: String = ""
        
        // 選択されている理由と時間を取得
        let resonSelectedIndex  = reason.selectedSegmentIndex
        let timeSelectedIndex   = time.selectedSegmentIndex
        selectedReason  = reason.titleForSegment(at: resonSelectedIndex)!
        selectedTime    = time.titleForSegment(at: timeSelectedIndex)!

        // 本文を置換
        self.mailBody.text = self.changeMailBody(inReason:selectedReason, inTime:selectedTime)
    }
 
    //----------------------------------
    // 関数名：changeMailBody
    // 説明：現在選択されている理由と時間でメール本文を書き換え
    //----------------------------------
    func changeMailBody(inReason: String, inTime: String) -> String {
        // 本文取得
        let body: NSMutableString = NSMutableString(string: self.mailBody.text)
        
        // 「<理由></理由>」で囲われている文字を置換
        let reasonLeftDelimiterIndex = body.range(of: "<理由>")
        let reasonRightDelimiterIndex = body.range(of: "</理由>")
        let lengthOfNowReason = reasonRightDelimiterIndex.location -
                                (reasonLeftDelimiterIndex.location + reasonLeftDelimiterIndex.length)
        var delRange = NSMakeRange(reasonLeftDelimiterIndex.location+reasonLeftDelimiterIndex.length, lengthOfNowReason)
        body.deleteCharacters(in: delRange)
        body.insert(inReason, at: reasonLeftDelimiterIndex.location+reasonLeftDelimiterIndex.length)

        // 「<遅延時間></遅延時間>」で囲われている文字を置換
        let timeLeftDelimiterIndex = body.range(of: "<遅延時間>")
        let timeRightDelimiterIndex = body.range(of: "</遅延時間>")
        let lengthOfNowTime = timeRightDelimiterIndex.location -
            (timeLeftDelimiterIndex.location + timeLeftDelimiterIndex.length)
        delRange = NSMakeRange(timeLeftDelimiterIndex.location+timeLeftDelimiterIndex.length, lengthOfNowTime)
        body.deleteCharacters(in: delRange)
        body.insert(inTime, at: timeLeftDelimiterIndex.location+timeLeftDelimiterIndex.length)

        return String(body)
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
        
        // 設定読み込み
        let ud = UserDefaults.standard
        self.ud_title = ud.string(forKey: "title")! // 件名
        self.mailTitle.text = self.ud_title
        
        var selectedReason: String = ""
        var selectedTime: String = ""
        
        // 選択されている理由と時間を取得
        let resonSelectedIndex  = reason.selectedSegmentIndex
        let timeSelectedIndex   = time.selectedSegmentIndex
        selectedReason  = reason.titleForSegment(at: resonSelectedIndex)!
        selectedTime    = time.titleForSegment(at: timeSelectedIndex)!
        
        // 本文取得
        let body: NSMutableString = NSMutableString(string: self.mailBody.text)
        
        // 「名前」タグを削除
        var delWord = body.range(of: "<名前>")
        var delRange = NSMakeRange(delWord.location, delWord.length)
        body.deleteCharacters(in: delRange)

        // 「/名前」タグを削除
        delWord = body.range(of: "</名前>")
        delRange = NSMakeRange(delWord.location, delWord.length)
        body.deleteCharacters(in: delRange)

        // 「理由」タグを削除
        delWord = body.range(of: "<理由>")
        delRange = NSMakeRange(delWord.location, delWord.length)
        body.deleteCharacters(in: delRange)

        // 「/理由」タグを削除
        delWord = body.range(of: "</理由>")
        delRange = NSMakeRange(delWord.location, delWord.length)
        body.deleteCharacters(in: delRange)

        // 「遅延時間」タグを削除
        delWord = body.range(of: "<遅延時間>")
        delRange = NSMakeRange(delWord.location, delWord.length)
        body.deleteCharacters(in: delRange)

        // 「/遅延時間」タグを削除
        delWord = body.range(of: "</遅延時間>")
        delRange = NSMakeRange(delWord.location, delWord.length)
        body.deleteCharacters(in: delRange)

        self.mailBodyLabel.text = String(body)
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

