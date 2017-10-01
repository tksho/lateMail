//
//  LeftViewController.swift
//  lateMail
//
//  Created by nttr on 2017/08/30.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var leftMenuList = ["名前設定","メール宛先設定","自動作成設定"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // TableViewの不要行を消す
        tableView.tableFooterView = UIView()
    }
    
    // メニューがクリックされたら画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if( leftMenuList[indexPath.row] == "名前設定" ) {
            self.performSegue(withIdentifier: "toProfileEdit", sender: nil)
        }
        else if( leftMenuList[indexPath.row] == "メール宛先設定" ) {
            self.performSegue(withIdentifier: "toMailAddressEdit", sender: nil)
        }
        else if( leftMenuList[indexPath.row] == "自動作成設定" ) {
            self.performSegue(withIdentifier: "toAutoSetting", sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Cellの高さを決める
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell")!
        cell.textLabel?.text = leftMenuList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftMenuList.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
