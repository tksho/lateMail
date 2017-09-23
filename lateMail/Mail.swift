//
//  Mail.swift
//  lateMail
//
//  Created by Sho Takahashi on 2017/09/23.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit

class Mail: NSObject {
    var title: String!     // 件名
    var body: String!      // 本文
    var fromName: String!  // 差出人名
    var to1: String!       // 宛先To1
    var to2: String!       // 宛先To2
    var to3: String!       // 宛先To2
    var cc1: String!       // 宛先Cc1
    var cc2: String!       // 宛先Cc2
    var cc3: String!       // 宛先Cc3
    var bcc1: String!      // 宛先bcc1
    var bcc2: String!      // 宛先bcc2
    var bcc3: String!      // 宛先bcc3
    
    // 初期化
    init(title: String, body: String, fromName: String, to1: String, to2: String, to3: String, cc1: String, cc2: String, cc3: String, bcc1: String, bcc2: String, bcc3: String ) {
        self.title = title
        self.body = body
        self.fromName = fromName
        self.to1 = to1
        self.to2 = to2
        self.to3 = to3
        self.cc1 = cc1
        self.cc2 = cc2
        self.cc3 = cc3
        self.bcc1 = bcc1
        self.bcc2 = bcc2
        self.bcc3 = bcc3
    }
    
    //----------------------------------
    // 関数名：loadFromUd
    // 説明：UserDefaultへの保存情報をロード
    //----------------------------------
    func loadFromUd() {
        let ud = UserDefaults.standard
        self.title = ud.string(forKey: "title")
        self.body = ud.string(forKey: "body")
        self.fromName = ud.string(forKey: "fromName")
        self.to1 = ud.string(forKey: "to1")
        self.to2 = ud.string(forKey: "to2")
        self.to3 = ud.string(forKey: "to3")
        self.cc1 = ud.string(forKey: "cc1")
        self.cc2 = ud.string(forKey: "cc2")
        self.cc3 = ud.string(forKey: "cc3")
        self.bcc1 = ud.string(forKey: "bcc1")
        self.bcc2 = ud.string(forKey: "bcc2")
        self.bcc3 = ud.string(forKey: "bcc3")
    }

    //----------------------------------
    // 関数名：saveToUd
    // 説明：UserDefaultへメール全情報を保存
    //----------------------------------
    func saveToUd() {
        let ud = UserDefaults.standard
        ud.set(self.title, forKey: "title")
        ud.set(self.body, forKey: "body")
        ud.set(self.fromName, forKey: "fromName")
        ud.set(self.to1, forKey: "to1")
        ud.set(self.to2, forKey: "to2")
        ud.set(self.to3, forKey: "to3")
        ud.set(self.cc1, forKey: "cc1")
        ud.set(self.cc2, forKey: "cc2")
        ud.set(self.cc3, forKey: "cc3")
        ud.set(self.bcc1, forKey: "bcc1")
        ud.set(self.bcc2, forKey: "bcc2")
        ud.set(self.bcc3, forKey: "bcc3")
    }

    //----------------------------------
    // 関数名：changeTitle
    // 説明：引数の「理由」と「時間」で件名を書き換え
    //----------------------------------
    func changeTitle(inReason: String, inTime: String) -> String {
        // 件名取得
        let mutableTitle: NSMutableString = NSMutableString(string: self.title)
        
        // 「<名前></名前>」で囲われている文字を置換
        let ud = UserDefaults.standard
        let fromName = ud.string(forKey: "fromName")
        let fromNameLeftDelimiterIndex = mutableTitle.range(of: "<名前>")
        let fromNameRightDelimiterIndex = mutableTitle.range(of: "</名前>")
        let lengthOfNowFromName = fromNameRightDelimiterIndex.location -
            (fromNameLeftDelimiterIndex.location + fromNameLeftDelimiterIndex.length)
        let delRange = NSMakeRange(fromNameLeftDelimiterIndex.location+fromNameLeftDelimiterIndex.length, lengthOfNowFromName)
        if fromNameLeftDelimiterIndex.length != 0 && fromNameRightDelimiterIndex.length != 0 && fromName != nil {
            // 「<名前>」「</名前>」両方あれば置換実行
            mutableTitle.deleteCharacters(in: delRange)
            mutableTitle.insert(fromName!, at: fromNameLeftDelimiterIndex.location+fromNameLeftDelimiterIndex.length)
        }
        
        return String(mutableTitle)

    }
    
    //----------------------------------
    // 関数名：changeBody
    // 説明：引数の「理由」と「時間」で本文を書き換え
    //----------------------------------
    func changeBody(inReason: String, inTime: String) -> String {
    
        // 本文取得
        let mutableBody: NSMutableString = NSMutableString(string: self.body)
        
        // 「<理由></理由>」で囲われている文字を置換。
        let reasonLeftDelimiterIndex = mutableBody.range(of: "<理由>")
        let reasonRightDelimiterIndex = mutableBody.range(of: "</理由>")
        let lengthOfNowReason = reasonRightDelimiterIndex.location -
            (reasonLeftDelimiterIndex.location + reasonLeftDelimiterIndex.length)
        var delRange = NSMakeRange(reasonLeftDelimiterIndex.location+reasonLeftDelimiterIndex.length, lengthOfNowReason)
        if reasonLeftDelimiterIndex.length != 0 && reasonRightDelimiterIndex.length != 0 {
            // 「<理由>」「</理由>」両方あれば置換実行
            mutableBody.deleteCharacters(in: delRange)
            mutableBody.insert(inReason, at: reasonLeftDelimiterIndex.location+reasonLeftDelimiterIndex.length)
        }
        
        // 「<遅延時間></遅延時間>」で囲われている文字を置換
        let timeLeftDelimiterIndex = mutableBody.range(of: "<遅延時間>")
        let timeRightDelimiterIndex = mutableBody.range(of: "</遅延時間>")
        let lengthOfNowTime = timeRightDelimiterIndex.location -
            (timeLeftDelimiterIndex.location + timeLeftDelimiterIndex.length)
        delRange = NSMakeRange(timeLeftDelimiterIndex.location+timeLeftDelimiterIndex.length, lengthOfNowTime)
        if timeLeftDelimiterIndex.length != 0 && timeRightDelimiterIndex.length != 0 {
            // 「<遅延時間>」「</遅延時間>」両方あれば置換実行
            mutableBody.deleteCharacters(in: delRange)
            mutableBody.insert(inTime, at: timeLeftDelimiterIndex.location+timeLeftDelimiterIndex.length)
        }
        
        // 「<名前></名前>」で囲われている文字を置換
        let ud = UserDefaults.standard
        let fromName = ud.string(forKey: "fromName")
        let fromNameLeftDelimiterIndex = mutableBody.range(of: "<名前>")
        let fromNameRightDelimiterIndex = mutableBody.range(of: "</名前>")
        let lengthOfNowFromName = fromNameRightDelimiterIndex.location -
            (fromNameLeftDelimiterIndex.location + fromNameLeftDelimiterIndex.length)
        delRange = NSMakeRange(fromNameLeftDelimiterIndex.location+fromNameLeftDelimiterIndex.length, lengthOfNowFromName)
        if fromNameLeftDelimiterIndex.length != 0 && fromNameRightDelimiterIndex.length != 0 && fromName != nil {
            // 「<名前>」「</名前>」両方あれば置換実行
            mutableBody.deleteCharacters(in: delRange)
            mutableBody.insert(fromName!, at: fromNameLeftDelimiterIndex.location+fromNameLeftDelimiterIndex.length)
        }
        
        return String(mutableBody)

    }
    
    //----------------------------------
    // 関数名：dispBody
    // 説明：ユーザ表示用の本文（＝タグを除外した本文）を返却
    //----------------------------------
    func dispBody() -> String {
        var delWord: NSRange!
        var delRange: NSRange!

        // 本文取得
        let mutableBody: NSMutableString = NSMutableString(string: self.body)
        
        // 「名前」タグを削除
        delWord = mutableBody.range(of: "<名前>")
        if delWord.length != 0 {
            delRange = NSMakeRange(delWord.location, delWord.length)
            mutableBody.deleteCharacters(in: delRange)
        }
        // 「/名前」タグを削除
        delWord = mutableBody.range(of: "</名前>")
        if delWord.length != 0 {
            delRange = NSMakeRange(delWord.location, delWord.length)
            mutableBody.deleteCharacters(in: delRange)
        }
        // 「理由」タグを削除
        delWord = mutableBody.range(of: "<理由>")
        if delWord.length != 0 {
            delRange = NSMakeRange(delWord.location, delWord.length)
            mutableBody.deleteCharacters(in: delRange)
        }
        // 「/理由」タグを削除
        delWord = mutableBody.range(of: "</理由>")
        if delWord.length != 0 {
            delRange = NSMakeRange(delWord.location, delWord.length)
            mutableBody.deleteCharacters(in: delRange)
        }
        // 「遅延時間」タグを削除
        delWord = mutableBody.range(of: "<遅延時間>")
        if delWord.length != 0 {
            delRange = NSMakeRange(delWord.location, delWord.length)
            mutableBody.deleteCharacters(in: delRange)
        }
        // 「/遅延時間」タグを削除
        delWord = mutableBody.range(of: "</遅延時間>")
        if delWord.length != 0 {
            delRange = NSMakeRange(delWord.location, delWord.length)
            mutableBody.deleteCharacters(in: delRange)
        }
        
        return String(mutableBody)

    }
    
    //----------------------------------
    // 関数名：dispTitle
    // 説明：ユーザ表示用の件名（＝タグを除外した件名）を返却
    //----------------------------------
    func dispTitle() -> String {
        var delWord: NSRange!
        var delRange: NSRange!

        // 件名取得
        let mutableTitle: NSMutableString = NSMutableString(string: self.title)
        
        // 「名前」タグを削除
        delWord = mutableTitle.range(of: "<名前>")
        if delWord.length != 0 {
            delRange = NSMakeRange(delWord.location, delWord.length)
            mutableTitle.deleteCharacters(in: delRange)
        }
        // 「/名前」タグを削除
        delWord = mutableTitle.range(of: "</名前>")
        if delWord.length != 0 {
            delRange = NSMakeRange(delWord.location, delWord.length)
            mutableTitle.deleteCharacters(in: delRange)
        }
        // 「理由」タグを削除
        delWord = mutableTitle.range(of: "<理由>")
        if delWord.length != 0 {
            delRange = NSMakeRange(delWord.location, delWord.length)
            mutableTitle.deleteCharacters(in: delRange)
        }
        // 「/理由」タグを削除
        delWord = mutableTitle.range(of: "</理由>")
        if delWord.length != 0 {
            delRange = NSMakeRange(delWord.location, delWord.length)
            mutableTitle.deleteCharacters(in: delRange)
        }
        // 「遅延時間」タグを削除
        delWord = mutableTitle.range(of: "<遅延時間>")
        if delWord.length != 0 {
            delRange = NSMakeRange(delWord.location, delWord.length)
            mutableTitle.deleteCharacters(in: delRange)
        }
        // 「/遅延時間」タグを削除
        delWord = mutableTitle.range(of: "</遅延時間>")
        if delWord.length != 0 {
            delRange = NSMakeRange(delWord.location, delWord.length)
            mutableTitle.deleteCharacters(in: delRange)
        }

        return String(mutableTitle)
    }
}
