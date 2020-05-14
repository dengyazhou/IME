//
//  MultiZuoYeDanYuanLieBiao.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/10.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class MultiZuoYeDanYuanLieBiao: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let height_NavBar = Height_NavBar!
    
    var operations: NSMutableArray! = NSMutableArray.init()
    var callBack: ((Int) -> Void)?

    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = height_NavBar
        
        self.tableView.register(UINib.init(nibName: "ZuoYeDanYuanLBCell", bundle: nil), forCellReuseIdentifier: "zuoYeDanYuanLBCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView.init()
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.operations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zuoYeDanYuanLBCell", for: indexPath) as! ZuoYeDanYuanLBCell
        let operationVo = self.operations[indexPath.row] as! OperationVo
        cell.label0.text = "\(indexPath.row)"
        cell.label1.text = operationVo.operationCode
        cell.label2.text = operationVo.operationText
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        callBack!(indexPath.row)
    }
    
    @IBAction func back(_ sender: Any) {
        let loginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel?.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        let personnelCode = DatabaseTool.t_TpfPWTableGetPersonnelCode(withSiteCode: siteCode)
        let workUnitCode = DatabaseTool.t_TpfPWTableGetWorkUnitCode(withSiteCode: siteCode)
        
        if ((!(personnelCode == "(null)"))&&(!(workUnitCode == "(null)"))) {
            for temp in (self.navigationController?.viewControllers)! {
                if temp is TpfMaiViewController {
                    self.navigationController?.popToViewController(temp, animated: true)
                    return
                }
            }
        } else if ((!(personnelCode == "(null)"))&&((workUnitCode == "(null)"))) {
            self.navigationController?.popViewController(animated: true)
            return
        } else if (((personnelCode == "(null)"))&&(!(workUnitCode == "(null)"))) {
            for temp in (self.navigationController?.viewControllers)! {
                if temp is ScanMYuanGongVC {
                    self.navigationController?.popToViewController(temp, animated: true)
                    return
                }
            }
        } else if (((personnelCode == "(null)"))&&((workUnitCode == "(null)"))) {
            self.navigationController?.popViewController(animated: true)
            return
        }
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
