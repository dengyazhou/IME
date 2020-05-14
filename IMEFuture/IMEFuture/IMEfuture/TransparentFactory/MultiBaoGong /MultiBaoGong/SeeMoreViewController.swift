//
//  SeeMoreViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/13.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class SeeMoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var batchWorkItemList: NSMutableArray! = NSMutableArray.init()
    
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = Height_NavBar
        self.heightBottomBar.constant = Height_BottomBar
        
        self.tableView.register(UINib.init(nibName: "ZuoYeDanYuanCell", bundle: nil), forCellReuseIdentifier: "zuoYeDanYuanCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return batchWorkItemList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zuoYeDanYuanCell", for: indexPath) as! ZuoYeDanYuanCell
        cell.selectionStyle = .none
        
        let workTimeLogVo = batchWorkItemList[indexPath.row] as! WorkTimeLogVo
        cell.viewTopLine.isHidden = true
        cell.viewBottomLine.isHidden = true
        cell.viewBottomLine15.isHidden = true
        if indexPath.row == 0 {
            cell.viewTopLine.isHidden = false
            if batchWorkItemList.count == 1 {
                cell.viewBottomLine.isHidden = false
            } else {
                cell.viewBottomLine15.isHidden = false
            }
        } else if indexPath.row == batchWorkItemList.count-1 {
            cell.viewBottomLine.isHidden = false
        } else {
            cell.viewBottomLine15.isHidden = false
        }

        cell.label0.text = "生产作业号"
        cell.label1.text = workTimeLogVo.productionControlNum
        return cell
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
