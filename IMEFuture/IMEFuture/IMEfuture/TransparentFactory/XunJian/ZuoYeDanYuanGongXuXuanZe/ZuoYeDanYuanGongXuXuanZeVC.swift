//
//  ZuoYeDanYuanGongXuXuanZeVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/9.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class ZuoYeDanYuanGongXuXuanZeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let _height_NavBar = Height_NavBar
    var routingInspectionVo: RoutingInspectionVo!
    var arrayProcessOperationVo: [ProcessOperationVo]!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.heightNavBar.constant = _height_NavBar!
        self.tableView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.tableFooterView = UIView()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayProcessOperationVo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let processOperationVo = self.arrayProcessOperationVo[indexPath.row]
        cell.textLabel?.text = processOperationVo.operationText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
        let processOperationVo = self.arrayProcessOperationVo[indexPath.row]
        
        let vc = XunJianTiJiaoVC()
        vc.routingInspectionVo = self.routingInspectionVo
        vc.operationText = processOperationVo.operationText
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
