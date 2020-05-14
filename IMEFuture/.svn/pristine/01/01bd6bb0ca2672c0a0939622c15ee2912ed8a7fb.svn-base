//
//  TuZhiJiaGongXiangQingVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class TuZhiJiaGongXiangQingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private let _height_NavBar = Height_NavBar

    var arryRoutingInspectionVo: [RoutingInspectionVo]!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.heightNavBar.constant = _height_NavBar!
        
        self.tableView.register(UINib.init(nibName: "TuZJGXQingCell", bundle: nil), forCellReuseIdentifier: "tuZJGXQingCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()
//        self.tableView.estimatedRowHeight = 60
//        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arryRoutingInspectionVo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TuZJGXQingCell = tableView.dequeueReusableCell(withIdentifier: "tuZJGXQingCell", for: indexPath) as! TuZJGXQingCell
        let routingInspectionVo: RoutingInspectionVo = self.arryRoutingInspectionVo[indexPath.row]
        cell.labelL01.text = routingInspectionVo.productionControlNum
        cell.labelL02.text = routingInspectionVo.materialText
        cell.labelR01.text = routingInspectionVo.operationText
        cell.labelR02.text = routingInspectionVo.controlQuantity.stringValue
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let routingInspectionVo = self.arryRoutingInspectionVo[indexPath.row]
        let vc = XunJianTiJiaoVC()
        vc.routingInspectionVo = routingInspectionVo
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
