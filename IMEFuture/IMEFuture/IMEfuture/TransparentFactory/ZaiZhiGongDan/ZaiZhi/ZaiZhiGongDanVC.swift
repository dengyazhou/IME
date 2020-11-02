//
//  ZaiZhiGongDanVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

enum TableViewType: Int {
    case SingleWork = 100
    case MultipleWork
    case MultiUserWork
}

enum WorkType: Int {
    case Single = 10
    case Multiple
    case MultiUser
}

class ZaiZhiGongDanVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @objc var confirmUser: String?
    
    var arrayWorkingOrderVO: [WorkingOrderVO]! = []
    var arrayBatchWorkVo: [BatchWorkVo]! = []
    var arrayMultiUserWorkVo: [MultiUserWorkVo]! = []
    
    
    private let _height_NavBar = Height_NavBar!
    private let _height_BottomBar = Height_BottomBar!

    private var workType = WorkType.Single.rawValue
    
    @IBOutlet weak var buttonSingleWork: UIButton!//单工单
    @IBOutlet weak var buttonMultipleWork: UIButton!//多工单
    @IBOutlet weak var buttonMultiUserWork: UIButton!//多人工单
    
    @IBOutlet weak var viewBottom: UIView!//批量开始 和 批量暂停
    @IBOutlet weak var viewBottom1: UIView!//单工单 批量 和 取消
    @IBOutlet weak var viewBottom2: UIView!//多工单 批量 和 取消
    
    @IBOutlet weak var buttonPiLiangSingle: UIButton!//单工单 批量开始&&批量暂停
    @IBOutlet weak var buttonPiLiangMultiple: UIButton!//单工单 批量开始&&批量暂停
    
    var _dataArray: [ShutDownCauseVo]! = []//暂停原因
    
    private var _viewLoading: UIView!
    
    @IBOutlet weak var tableViewSingle: UITableView!
    @IBOutlet weak var tableViewMultiple: UITableView!
    @IBOutlet weak var tableViewMultiUser: UITableView!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar1: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar2: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestRefeshSingleWork()
        self.requestRefeshMultipleWork()
        self.requestRefeshMultiUserWork()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.heightNavBar.constant = _height_NavBar
        self.heightBottomBar.constant = _height_BottomBar
        self.heightBottomBar1.constant = _height_BottomBar
        self.heightBottomBar2.constant = _height_BottomBar
        self.viewBottom1.isHidden = true
        self.viewBottom2.isHidden = true
        self.buttonPiLiangSingle.setTitle("0", for: UIControlState.normal)
        self.buttonPiLiangMultiple.setTitle("0", for: UIControlState.normal)
        
        self.tableViewSingle.register(UINib.init(nibName: "ZaiZhiGongDanCell", bundle: nil), forCellReuseIdentifier: "zaiZhiGongDanCell")
        self.tableViewSingle.register(UINib.init(nibName: "ZaiZhiGongDanCell1", bundle: nil), forCellReuseIdentifier: "zaiZhiGongDanCell1")
        self.tableViewSingle.delegate = self
        self.tableViewSingle.dataSource = self
        self.tableViewSingle.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableViewSingle.tableFooterView = UIView()
        self.tableViewSingle.estimatedRowHeight = 60
        self.tableViewSingle.rowHeight = UITableViewAutomaticDimension
        self.tableViewSingle.tag = TableViewType.SingleWork.rawValue
        
        self.tableViewMultiple.register(UINib.init(nibName: "ZaiZhiGongDanCell", bundle: nil), forCellReuseIdentifier: "zaiZhiGongDanCell")
        self.tableViewMultiple.register(UINib.init(nibName: "ZaiZhiGongDanCell1", bundle: nil), forCellReuseIdentifier: "zaiZhiGongDanCell1")
        self.tableViewMultiple.delegate = self
        self.tableViewMultiple.dataSource = self
        self.tableViewMultiple.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableViewMultiple.tableFooterView = UIView()
        self.tableViewMultiple.estimatedRowHeight = 60
        self.tableViewMultiple.rowHeight = UITableViewAutomaticDimension
        self.tableViewMultiple.tag = TableViewType.MultipleWork.rawValue
        
        self.tableViewMultiUser.register(UINib.init(nibName: "ZaiZhiGongDanCell", bundle: nil), forCellReuseIdentifier: "zaiZhiGongDanCellMultiUser")
        self.tableViewMultiUser.delegate = self
        self.tableViewMultiUser.dataSource = self
        self.tableViewMultiUser.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableViewMultiUser.tableFooterView = UIView()
        self.tableViewMultiUser.estimatedRowHeight = 60
        self.tableViewMultiUser.rowHeight = UITableViewAutomaticDimension
        self.tableViewMultiUser.tag = TableViewType.MultiUserWork.rawValue
        
        showTableViewAndChangeButtonColorWithTableViewType(type: workType)
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
//        DispatchQueue.global(qos: .default).async {
//            self.request1()
//        }
        self.request1()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == TableViewType.SingleWork.rawValue {
            return self.arrayWorkingOrderVO.count
        } else if tableView.tag == TableViewType.MultipleWork.rawValue {
            return self.arrayBatchWorkVo.count
        } else if tableView.tag == TableViewType.MultiUserWork.rawValue {
            return self.arrayMultiUserWorkVo.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == TableViewType.SingleWork.rawValue {
            let workingOrderVO = self.arrayWorkingOrderVO[indexPath.row]
            if self.buttonPiLiangSingle.currentTitle == "批量开始" {
                let cell: ZaiZhiGongDanCell1 = tableView.dequeueReusableCell(withIdentifier: "zaiZhiGongDanCell1", for: indexPath) as! ZaiZhiGongDanCell1
                cell.label0.text = workingOrderVO.productionControlNum
                cell.label1.text = workingOrderVO.workUnitCode
                cell.label2.text = workingOrderVO.materialText
                //报工记录状态-1：开始，2：暂停，3：继续，4：完成，5：报工
                cell.label3.isHidden = true
                cell.label4.isHidden = true
                cell.label5.isHidden = true
//                if workingOrderVO.status.intValue == 1 {//开始
//                    cell.label3.isHidden = false//生产中
//                } else if workingOrderVO.status.intValue == 2 {//暂停
//                    cell.label4.isHidden = false//暂停
//                } else if workingOrderVO.status.intValue == 3 {//继续
//                    cell.label3.isHidden = false//生产中
//                } else if workingOrderVO.status.intValue == 4 {//完成
//                    cell.label5.isHidden = false//完工未提交
//                } else if workingOrderVO.status.intValue == 5 {//报工
//
//                }
                cell.imageView1.image = UIImage.init(named: "ime_icon_no")
                if workingOrderVO.status.intValue == 1 || workingOrderVO.status.intValue == 3{//开始
                    cell.label3.isHidden = false//生产中
                } else if workingOrderVO.status.intValue == 2 {//暂停
                    cell.label4.isHidden = false//暂停
                    if workingOrderVO.isNO == "YES" {
                        cell.imageView1.image = UIImage.init(named: "ime_icon_yes")
                    }
                } else if workingOrderVO.status.intValue == 4 {//完成
                    cell.label5.isHidden = false//完工未提交
                } else if workingOrderVO.status.intValue == 5 {//报工
                    
                }
                return cell
            } else if self.buttonPiLiangSingle.currentTitle == "批量暂停" {
                let cell: ZaiZhiGongDanCell1 = tableView.dequeueReusableCell(withIdentifier: "zaiZhiGongDanCell1", for: indexPath) as! ZaiZhiGongDanCell1
                cell.label0.text = workingOrderVO.productionControlNum
                cell.label1.text = workingOrderVO.workUnitCode
                cell.label2.text = workingOrderVO.materialText
                cell.label3.isHidden = true
                cell.label4.isHidden = true
                cell.label5.isHidden = true
                cell.imageView1.image = UIImage.init(named: "ime_icon_no")
                if workingOrderVO.status.intValue == 1 || workingOrderVO.status.intValue == 3 {
                    cell.label3.isHidden = false//生产中
                    if workingOrderVO.isNO == "YES" {
                        cell.imageView1.image = UIImage.init(named: "ime_icon_yes")
                    }
                } else if workingOrderVO.status.intValue == 2 {
                    cell.label4.isHidden = false//暂停
                } else if workingOrderVO.status.intValue == 4 {
                    cell.label5.isHidden = false//完工未提交
                } else if workingOrderVO.status.intValue == 5 {
                    
                }
                return cell
            } else {
                let cell: ZaiZhiGongDanCell = tableView.dequeueReusableCell(withIdentifier: "zaiZhiGongDanCell", for: indexPath) as! ZaiZhiGongDanCell
                cell.label0.text = workingOrderVO.productionControlNum
                cell.label1.text = workingOrderVO.workUnitCode
                cell.label2.text = workingOrderVO.materialText
                cell.label3.isHidden = true
                cell.label4.isHidden = true
                cell.label5.isHidden = true
                if workingOrderVO.status.intValue == 1 || workingOrderVO.status.intValue == 3{
                    cell.label3.isHidden = false//生产中
                } else if workingOrderVO.status.intValue == 2 {
                    cell.label4.isHidden = false//暂停
                } else if workingOrderVO.status.intValue == 4 {
                    cell.label5.isHidden = false//完工未提交
                } else if workingOrderVO.status.intValue == 5 {
                    
                }
                return cell
            }
        } else if tableView.tag == TableViewType.MultipleWork.rawValue {
            let batchWorkVo = self.arrayBatchWorkVo[indexPath.row]
            if self.buttonPiLiangMultiple.currentTitle == "批量开始" {
                let cell: ZaiZhiGongDanCell1 = tableView.dequeueReusableCell(withIdentifier: "zaiZhiGongDanCell1", for: indexPath) as! ZaiZhiGongDanCell1
                let workTimeLogVo: WorkTimeLogVo = batchWorkVo.batchWorkItemList[0] as! WorkTimeLogVo
                cell.label0.text = workTimeLogVo.productionControlNum
                cell.label1.text = batchWorkVo.workUnitCode
                cell.label2.text = workTimeLogVo.materialText
                //报工记录状态-1：开始，2：暂停，3：继续，4：完成，5：报工
                cell.label3.isHidden = true
                cell.label4.isHidden = true
                cell.label5.isHidden = true
//                if workingOrderVO.status.intValue == 1 {//开始
//                    cell.label3.isHidden = false//生产中
//                } else if workingOrderVO.status.intValue == 2 {//暂停
//                    cell.label4.isHidden = false//暂停
//                } else if workingOrderVO.status.intValue == 3 {//继续
//                    cell.label3.isHidden = false//生产中
//                } else if workingOrderVO.status.intValue == 4 {//完成
//                    cell.label5.isHidden = false//完工未提交
//                } else if workingOrderVO.status.intValue == 5 {//报工
//
//                }
                cell.imageView1.image = UIImage.init(named: "ime_icon_no")
                if batchWorkVo.status.intValue == 1 || batchWorkVo.status.intValue == 3{//开始
                    cell.label3.isHidden = false//生产中
                } else if batchWorkVo.status.intValue == 2 {//暂停
                    cell.label4.isHidden = false//暂停
                    if batchWorkVo.isNO == "YES" {
                        cell.imageView1.image = UIImage.init(named: "ime_icon_yes")
                    }
                } else if batchWorkVo.status.intValue == 4 {//完成
                    cell.label5.isHidden = false//完工未提交
                } else if batchWorkVo.status.intValue == 5 {//报工
                    
                }
                return cell
            } else if self.buttonPiLiangMultiple.currentTitle == "批量暂停" {
                let cell: ZaiZhiGongDanCell1 = tableView.dequeueReusableCell(withIdentifier: "zaiZhiGongDanCell1", for: indexPath) as! ZaiZhiGongDanCell1
                let workTimeLogVo: WorkTimeLogVo = batchWorkVo.batchWorkItemList[0] as! WorkTimeLogVo
                cell.label0.text = workTimeLogVo.productionControlNum
                cell.label1.text = batchWorkVo.workUnitCode
                cell.label2.text = workTimeLogVo.materialText
                cell.label3.isHidden = true
                cell.label4.isHidden = true
                cell.label5.isHidden = true
                cell.imageView1.image = UIImage.init(named: "ime_icon_no")
                if batchWorkVo.status.intValue == 1 || batchWorkVo.status.intValue == 3 {
                    cell.label3.isHidden = false//生产中
                    if batchWorkVo.isNO == "YES" {
                        cell.imageView1.image = UIImage.init(named: "ime_icon_yes")
                    }
                } else if batchWorkVo.status.intValue == 2 {
                    cell.label4.isHidden = false//暂停
                } else if batchWorkVo.status.intValue == 4 {
                    cell.label5.isHidden = false//完工未提交
                } else if batchWorkVo.status.intValue == 5 {
                    
                }
                return cell
            } else {
                let cell: ZaiZhiGongDanCell = tableView.dequeueReusableCell(withIdentifier: "zaiZhiGongDanCell", for: indexPath) as! ZaiZhiGongDanCell
                let workTimeLogVo: WorkTimeLogVo = batchWorkVo.batchWorkItemList[0] as! WorkTimeLogVo
                cell.label0.text = workTimeLogVo.productionControlNum
                cell.label1.text = batchWorkVo.workUnitCode
                cell.label2.text = workTimeLogVo.materialText
                cell.label3.isHidden = true
                cell.label4.isHidden = true
                cell.label5.isHidden = true
                if batchWorkVo.status.intValue == 1 || batchWorkVo.status.intValue == 3{
                    cell.label3.isHidden = false//生产中
                } else if batchWorkVo.status.intValue == 2 {
                    cell.label4.isHidden = false//暂停
                } else if batchWorkVo.status.intValue == 4 {
                    cell.label5.isHidden = false//完工未提交
                } else if batchWorkVo.status.intValue == 5 {
                    
                }
                return cell
            }
        } else if tableView.tag == TableViewType.MultiUserWork.rawValue {
            let multiUserWorkVo = self.arrayMultiUserWorkVo[indexPath.row]
            
            let cell: ZaiZhiGongDanCell = tableView.dequeueReusableCell(withIdentifier: "zaiZhiGongDanCellMultiUser", for: indexPath) as! ZaiZhiGongDanCell
            cell.label0.text = multiUserWorkVo.productionControlNum
            cell.label1.text = multiUserWorkVo.workUnitCode
            cell.label2.text = multiUserWorkVo.materialText
            cell.label3.isHidden = true
            cell.label4.isHidden = true
            cell.label5.isHidden = true
            if multiUserWorkVo.status.intValue == 1 || multiUserWorkVo.status.intValue == 3{
                cell.label3.isHidden = false//生产中
            } else if multiUserWorkVo.status.intValue == 2 {
                cell.label4.isHidden = false//暂停
            } else if multiUserWorkVo.status.intValue == 4 {
                cell.label5.isHidden = false//完工未提交
            } else if multiUserWorkVo.status.intValue == 5 {
                
            }
            return cell
        } else {
            let cell = UITableViewCell.init()
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.tag == TableViewType.SingleWork.rawValue {
            let workingOrderVO = self.arrayWorkingOrderVO[indexPath.row]
            
            if self.buttonPiLiangSingle.currentTitle == "批量开始" {
                if workingOrderVO.status.intValue == 2 {//暂停
                    if workingOrderVO.isNO == "NO" {
                        workingOrderVO.isNO = "YES"
                    } else if workingOrderVO.isNO == "YES" {
                        workingOrderVO.isNO = "NO"
                    }
                }
                self.tableViewSingle.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
            } else if self.buttonPiLiangSingle.currentTitle == "批量暂停" {//开始
                if workingOrderVO.status.intValue == 1 || workingOrderVO.status.intValue == 3{
                    if workingOrderVO.isNO == "NO" {
                        workingOrderVO.isNO = "YES"
                    } else if workingOrderVO.isNO == "YES" {
                        workingOrderVO.isNO = "NO"
                    }
                }
                self.tableViewSingle.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
            } else {
                let zuoYeDanYuanViewController = ZuoYeDanYuanViewController()
                zuoYeDanYuanViewController.planTime = workingOrderVO.planTime;
                zuoYeDanYuanViewController.surplusTime = workingOrderVO.surplusTime;
                zuoYeDanYuanViewController.workUnitText = workingOrderVO.workUnitText;
                zuoYeDanYuanViewController.operationText = workingOrderVO.operationText;
                zuoYeDanYuanViewController.operationTextNext = workingOrderVO.operationTextNext;
                zuoYeDanYuanViewController.productionControlNum = workingOrderVO.productionControlNum;
                zuoYeDanYuanViewController.workUnitCode = workingOrderVO.workUnitCode;
                zuoYeDanYuanViewController.operationCode = workingOrderVO.operationCode;
                zuoYeDanYuanViewController.processOperationId = workingOrderVO.processOperationId;
                zuoYeDanYuanViewController.confirmFlag = workingOrderVO.confirmFlag;
                
                zuoYeDanYuanViewController.confirmUser = workingOrderVO.personnelCode;
                zuoYeDanYuanViewController.productionOrderNum = workingOrderVO.productionOrderNum;
                zuoYeDanYuanViewController.requirementDate = workingOrderVO.requirementDate;
                zuoYeDanYuanViewController.personnelName = workingOrderVO.personnelName;
                

                
                self.navigationController?.pushViewController(zuoYeDanYuanViewController, animated: true)
            }
        } else if tableView.tag == TableViewType.MultipleWork.rawValue {
            let batchWorkVo = self.arrayBatchWorkVo[indexPath.row]
            
            if self.buttonPiLiangMultiple.currentTitle == "批量开始" {
                if batchWorkVo.status.intValue == 2 {//暂停
                    if batchWorkVo.isNO == "NO" {
                        batchWorkVo.isNO = "YES"
                    } else if batchWorkVo.isNO == "YES" {
                        batchWorkVo.isNO = "NO"
                    }
                }
                self.tableViewMultiple.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
            } else if self.buttonPiLiangMultiple.currentTitle == "批量暂停" {//开始
                if batchWorkVo.status.intValue == 1 || batchWorkVo.status.intValue == 3{
                    if batchWorkVo.isNO == "NO" {
                        batchWorkVo.isNO = "YES"
                    } else if batchWorkVo.isNO == "YES" {
                        batchWorkVo.isNO = "NO"
                    }
                }
                self.tableViewMultiple.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
            } else {
                let vc = ZuoYeViewController.init()
                vc.batchWorkNum = batchWorkVo.batchWorkNum
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if tableView.tag == TableViewType.MultiUserWork.rawValue {
            let multiUserWorkVo = self.arrayMultiUserWorkVo[indexPath.row]
            let vc = MultiUserWorkViewController.init()
            vc.multiUserWorkNum = multiUserWorkVo.multiUserWorkNum
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = colorRGB(r: 250, g: 250, b: 250)
        
        let label = UILabel.init()
        view.addSubview(label)
        label.mas_makeConstraints { (make: MASConstraintMaker?) in
            make?.left.mas_equalTo()(15)
            make?.centerY.mas_equalTo()(view.mas_centerY)
        }
        label.text = "作业号/物料"
        label.textColor = colorRGB(r: 102, g: 102, b: 102)
        label.font = UIFont.systemFont(ofSize: 14)
        
        let labelRight = UILabel.init()
        view.addSubview(labelRight)
        labelRight.mas_makeConstraints { (make: MASConstraintMaker?) in
            make?.right.mas_equalTo()(-15)
            make?.centerY.mas_equalTo()(view.mas_centerY)
        }
        labelRight.text = "加工单元/状态"
        labelRight.textColor = colorRGB(r: 102, g: 102, b: 102)
        labelRight.font = UIFont.systemFont(ofSize: 14)
        
        let viewLine =  UIView.init()
        view.addSubview(viewLine)
        viewLine.mas_makeConstraints { (make: MASConstraintMaker?) in
            make?.left.mas_equalTo()(0)
            make?.top.mas_equalTo()(0)
            make?.right.mas_equalTo()(0)
            make?.height.mas_equalTo()(0.5)
        }
        viewLine.backgroundColor = colorLine
        
        let viewLineBottom =  UIView.init()
        view.addSubview(viewLineBottom)
        viewLineBottom.mas_makeConstraints { (make: MASConstraintMaker?) in
            make?.left.mas_equalTo()(0)
            make?.bottom.mas_equalTo()(0)
            make?.right.mas_equalTo()(0)
            make?.height.mas_equalTo()(0.5)
        }
        viewLineBottom.backgroundColor = colorLine
        
        return view
    }
    
//    MARK:单工单
    @IBAction func buttonSingleWork(_ sender: Any) {
        
        self.viewBottom2.isHidden = true
        
        if self.buttonPiLiangSingle.currentTitle == "批量开始" || self.buttonPiLiangMultiple.currentTitle == "批量暂停" {
            self.viewBottom.isHidden = true
            self.viewBottom1.isHidden = false
        } else {
            self.viewBottom.isHidden = false
            self.viewBottom1.isHidden = true
        }
        
        workType = WorkType.Single.rawValue
        showTableViewAndChangeButtonColorWithTableViewType(type: workType)
    }
    
//    MARK:多工单
    @IBAction func buttonMultipleWork(_ sender: Any) {
        self.viewBottom1.isHidden = true
        
        if self.buttonPiLiangMultiple.currentTitle == "批量开始" || self.buttonPiLiangMultiple.currentTitle == "批量暂停" {
            self.viewBottom.isHidden = true
            self.viewBottom2.isHidden = false
        } else {
            self.viewBottom.isHidden = false
            self.viewBottom2.isHidden = true
        }

        workType = WorkType.Multiple.rawValue
        showTableViewAndChangeButtonColorWithTableViewType(type: workType)
    }

//    MARK:多人工单
    @IBAction func buttonMultiUserWork(_ sender: Any) {

        self.viewBottom.isHidden = true
        self.viewBottom1.isHidden = true
        self.viewBottom2.isHidden = true
        workType = WorkType.MultiUser.rawValue
        showTableViewAndChangeButtonColorWithTableViewType(type: workType)
    }
    
    
    //MARK:批量开始->(批量开始 取消)
    @IBAction func buttonStart(_ sender: Any) {
        self.viewBottom.isHidden = true
        if workType == WorkType.Single.rawValue {
            for workingOrderVO in self.arrayWorkingOrderVO {
                if workingOrderVO.status.intValue == 2 {//暂停
                    workingOrderVO.isNO = "YES"
                } else {
                    workingOrderVO.isNO = "NO"
                }
            }
            self.viewBottom1.isHidden = false
            self.buttonPiLiangSingle.setTitle("批量开始", for: UIControlState.normal)
            self.tableViewSingle.reloadData()
        }
        
        if workType == WorkType.Multiple.rawValue {
            for batchWorkVo in self.arrayBatchWorkVo {
                if batchWorkVo.status.intValue == 2 {//暂停
                    batchWorkVo.isNO = "YES"
                } else {
                    batchWorkVo.isNO = "NO"
                }
            }
            self.viewBottom2.isHidden = false
            self.buttonPiLiangMultiple.setTitle("批量开始", for: UIControlState.normal)
            self.tableViewMultiple.reloadData()
        }
    }
    //MARK:批量暂停->(批量暂停 取消)
    @IBAction func buttonSuspend(_ sender: Any) {
        self.viewBottom.isHidden = true
        if workType == WorkType.Single.rawValue {
            for workingOrderVO in self.arrayWorkingOrderVO {
                if workingOrderVO.status.intValue == 1 || workingOrderVO.status.intValue == 3 {//暂停
                    workingOrderVO.isNO = "YES"
                } else {
                    workingOrderVO.isNO = "NO"
                }
            }
            self.viewBottom1.isHidden = false
            self.buttonPiLiangSingle.setTitle("批量暂停", for: UIControlState.normal)
            self.tableViewSingle.reloadData()
        }
        
        if workType == WorkType.Multiple.rawValue {
            for batchWorkVo in self.arrayBatchWorkVo {
                if batchWorkVo.status.intValue == 1 || batchWorkVo.status.intValue == 3 {//暂停
                    batchWorkVo.isNO = "YES"
                } else {
                    batchWorkVo.isNO = "NO"
                }
            }
            self.viewBottom2.isHidden = false
            self.buttonPiLiangMultiple.setTitle("批量暂停", for: UIControlState.normal)
            self.tableViewMultiple.reloadData()
        }
    }
    
//    MARK: 批量开始 或 批量暂停
    @IBAction func buttonClick(_ sender: Any) {
        let sender = sender as! UIButton
        if workType == WorkType.Single.rawValue {
            var arrayTemp: [Any]! = []
            for workingOrderVO in self.arrayWorkingOrderVO {
                if workingOrderVO.isNO == "YES" {
                    arrayTemp.append(workingOrderVO)
                }
            }
            if arrayTemp.count == 0 {
                self.alertdYZ()
                return
            }
            
            if sender.currentTitle == "批量开始" {
                self.requestSinglePiliangKaiShi()
            } else if sender.currentTitle == "批量暂停" {
                self.requestSinglePiliangZanTing()
            }
        }
        if workType == WorkType.Multiple.rawValue {
            var arrayTemp: [Any]! = []
            for batchWorkVo in self.arrayBatchWorkVo {
                if batchWorkVo.isNO == "YES" {
                    arrayTemp.append(batchWorkVo)
                }
            }
            if arrayTemp.count == 0 {
                self.alertdYZ()
                return
            }
            
            if sender.currentTitle == "批量开始" {
                self.requestMultiplePiliangKaiShi()
            } else if sender.currentTitle == "批量暂停" {
                self.requestMultiplePiliangZanTing()
            }
        }
    }
    
//    MARK:取消
    @IBAction func buttonQuXiao(_ sender: Any) {
        self.viewBottom.isHidden = false
    
        if workType == WorkType.Single.rawValue {
            self.viewBottom1.isHidden = true
            self.buttonPiLiangSingle.setTitle("0", for: UIControlState.normal)
            self.tableViewSingle.reloadData()
        }
        if workType == WorkType.Multiple.rawValue {
            self.viewBottom2.isHidden = true
            self.buttonPiLiangMultiple.setTitle("0", for: UIControlState.normal)
            self.tableViewMultiple.reloadData()
        }
    }
    
    //MARK:单工单批量开始接口
    func requestSinglePiliangKaiShi() {
    
        self._viewLoading.isHidden = false
        let loginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel?.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean = MesPostEntityBean.init()
        var arrayTemp: [WorkTimeLogVo]! = []
        for workingOrderVO in self.arrayWorkingOrderVO {
            if workingOrderVO.isNO == "YES" {
                let workTimeLogVo = WorkTimeLogVo.init()
                workTimeLogVo.siteCode = siteCode
                workTimeLogVo.logId = workingOrderVO.logId
                workTimeLogVo.productionControlNum = workingOrderVO.productionControlNum
                workTimeLogVo.processOperationId = workingOrderVO.processOperationId
                workTimeLogVo.workUnitCode = workingOrderVO.workUnitCode
                workTimeLogVo.operationCode = workingOrderVO.operationCode
                workTimeLogVo.confirmUser = workingOrderVO.personnelCode
                workTimeLogVo.actualendDateTime = ToolTransition.string(from: Date.init())
                workTimeLogVo.imeiCode = "123"
                
                arrayTemp.append(workTimeLogVo)
            }
        }
        
        if arrayTemp.count == 0 {
            self.alertdYZ()
            self._viewLoading.isHidden = true
            return
        }
        mesPostEntityBean.entity = arrayTemp
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        
        HttpMamager.postRequest(withURLString: DYZ_workRest_continueWork, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean
//            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {
                
                self.requestRefeshSingleWork()
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnMsgBean"))
        
    }
    
    //MARK:单工单批量暂停接口
    func requestSinglePiliangZanTing() {
        let view = TpfBaoGongReasonView.init(frame: self.view.frame, withData: _dataArray)
        view?.block1Confirm = {(model: Any?)->() in
            let shutDownCauseVo = model as! ShutDownCauseVo
            self._viewLoading.isHidden = false
            let loginModel = DatabaseTool.getLoginModel()
            let userBean = UserBean.mj_object(withKeyValues: loginModel?.ucenterUser)
            let siteCode = userBean?.enterpriseInfo.serialNo
            let mesPostEntityBean = MesPostEntityBean.init()
            var arrayTemp: [WorkTimeLogVo]! = []
            for workingOrderVO in self.arrayWorkingOrderVO {
                if workingOrderVO.isNO == "YES" {
                    let workTimeLogVo = WorkTimeLogVo.init()
                    workTimeLogVo.siteCode = siteCode
                    workTimeLogVo.logId = workingOrderVO.logId
                    workTimeLogVo.startDateTime = workingOrderVO.startDateTime
                    workTimeLogVo.actualendDateTime = ToolTransition.string(from: Date.init())
                    workTimeLogVo.productionControlNum = workingOrderVO.productionControlNum;
                    workTimeLogVo.workUnitCode = workingOrderVO.workUnitCode
                    workTimeLogVo.operationCode = workingOrderVO.operationCode
                    workTimeLogVo.confirmUser = workingOrderVO.personnelCode
                    let secondsCountUp = CLong(NSDate.init().timeIntervalSince(ToolTransition.date(from: workingOrderVO.startDateTime)))
                    workTimeLogVo.workTime = NSNumber.init(value: secondsCountUp)
                    workTimeLogVo.processOperationId = workingOrderVO.processOperationId;
                    workTimeLogVo.shutDownCauseCode = shutDownCauseVo.shutDownCauseCode
                    workTimeLogVo.status = NSNumber.init(value: 2)
                    arrayTemp.append(workTimeLogVo)
                }
            }
            if arrayTemp.count == 0 {
                self.alertdYZ()
                self._viewLoading.isHidden = true
                return
            }
            mesPostEntityBean.entity = arrayTemp
            let dic1 = mesPostEntityBean.mj_keyValues()
            let dic = ["data":String.toolSwiftGetJSONFromDictionary(dictionary: dic1!)]
            
            HttpMamager.postRequestImage(withURLString: DYZ_workRest_workLog, parameters: dic, uploadImageBean: nil, success: { (responseObjectModel: Any?) in
                let returnListBean = responseObjectModel as! ReturnListBean
                //                self._viewLoading.isHidden = true
                if returnListBean.status == "SUCCESS" {
                    self.requestRefeshSingleWork()
                } else {
                    MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
                }
                
            }, progress: nil, fail: { (error: Error?) in
                self._viewLoading.isHidden = true
            }, isKindOfModelClass: NSClassFromString("ReturnListBean"))
        }
        self.view.addSubview(view!)
    }
    
    //MARK:多工单批量开始接口
    func requestMultiplePiliangKaiShi() {
        self._viewLoading.isHidden = false
        
        let mesPostEntityBean = MesPostEntityBean.init()
        var arrayTemp: [BatchWorkVo]! = []
        for batchWorkVo in self.arrayBatchWorkVo {
            if batchWorkVo.isNO == "YES" {
                let batchWorkVo1 = BatchWorkVo.init()
                batchWorkVo1.siteCode = batchWorkVo.siteCode
                batchWorkVo1.batchWorkNum = batchWorkVo.batchWorkNum
                batchWorkVo1.modifyUser = batchWorkVo.modifyUser
                batchWorkVo1.status = NSNumber.init(value: 3)
                arrayTemp.append(batchWorkVo1)
            }
        }
        
        if arrayTemp.count == 0 {
            self.alertdYZ()
            self._viewLoading.isHidden = true
            return
        }
        mesPostEntityBean.entity = arrayTemp
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        
        HttpMamager.postRequest(withURLString: DYZ_batchWork_continueWork, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean
            //            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {
                
                self.requestRefeshMultipleWork()
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnMsgBean"))
    }
    
    //MARK:多工单批量暂停接口
    func requestMultiplePiliangZanTing() {
        self._viewLoading.isHidden = false
        
        let mesPostEntityBean = MesPostEntityBean.init()
        var arrayTemp: [BatchWorkVo]! = []
        for batchWorkVo in self.arrayBatchWorkVo {
            if batchWorkVo.isNO == "YES" {
                let batchWorkVo1 = BatchWorkVo.init()
                batchWorkVo1.siteCode = batchWorkVo.siteCode
                batchWorkVo1.batchWorkNum = batchWorkVo.batchWorkNum
                batchWorkVo1.modifyUser = batchWorkVo.modifyUser
                batchWorkVo1.status = NSNumber.init(value: 2)
                arrayTemp.append(batchWorkVo1)
            }
        }
        if arrayTemp.count == 0 {
            self.alertdYZ()
            self._viewLoading.isHidden = true
            return
        }
        mesPostEntityBean.entity = arrayTemp
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        HttpMamager.postRequest(withURLString: DYZ_batchWork_workLog, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnListBean = responseObjectModel as! ReturnListBean
            //                self._viewLoading.isHidden = true
            if returnListBean.status == "SUCCESS" {
                self.requestRefeshMultipleWork()
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
            }
            
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
    }
    
    func alertdYZ() {
        let alertController = UIAlertController.init(title: "未勾选任何选项！", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(action)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    /*
     * 根据workType，显示tabelView和改变button图片及颜色
     */
    func showTableViewAndChangeButtonColorWithTableViewType(type: Int) {
        if type == WorkType.Single.rawValue {
            self.tableViewSingle.isHidden = false
            self.tableViewMultiple.isHidden = true
            self.tableViewMultiUser.isHidden = true
            self.buttonSingleWork.setImage(UIImage.init(named: "single_work2"), for: UIControlState.normal)
            self.buttonSingleWork.setTitleColor(colorRGB(r: 0, g: 122, b: 254), for: UIControlState.normal)
            self.buttonMultipleWork.setImage(UIImage.init(named: "multiple_work1"), for: UIControlState.normal)
            self.buttonMultipleWork.setTitleColor(colorRGB(r: 20, g: 20, b: 20), for: UIControlState.normal)
            self.buttonMultiUserWork.setImage(UIImage.init(named: "multiple_work1"), for: UIControlState.normal)
            self.buttonMultiUserWork.setTitleColor(colorRGB(r: 20, g: 20, b: 20), for: UIControlState.normal)
        } else if type == WorkType.Multiple.rawValue {
            self.tableViewSingle.isHidden = true
            self.tableViewMultiple.isHidden = false
            self.tableViewMultiUser.isHidden = true
            self.buttonSingleWork.setImage(UIImage.init(named: "single_work1"), for: UIControlState.normal)
            self.buttonSingleWork.setTitleColor(colorRGB(r: 20, g: 20, b: 20), for: UIControlState.normal)
            self.buttonMultipleWork.setImage(UIImage.init(named: "multiple_work2"), for: UIControlState.normal)
            self.buttonMultipleWork.setTitleColor(colorRGB(r: 0, g: 122, b: 254), for: UIControlState.normal)
            self.buttonMultiUserWork.setImage(UIImage.init(named: "multiple_work1"), for: UIControlState.normal)
            self.buttonMultiUserWork.setTitleColor(colorRGB(r: 20, g: 20, b: 20), for: UIControlState.normal)
        } else if type == WorkType.MultiUser.rawValue {
            self.tableViewSingle.isHidden = true
            self.tableViewMultiple.isHidden = true
            self.tableViewMultiUser.isHidden = false
            self.buttonSingleWork.setImage(UIImage.init(named: "single_work1"), for: UIControlState.normal)
            self.buttonSingleWork.setTitleColor(colorRGB(r: 20, g: 20, b: 20), for: UIControlState.normal)
            self.buttonMultipleWork.setImage(UIImage.init(named: "multiple_work1"), for: UIControlState.normal)
            self.buttonMultipleWork.setTitleColor(colorRGB(r: 20, g: 20, b: 20), for: UIControlState.normal)
            self.buttonMultiUserWork.setImage(UIImage.init(named: "multiple_work2"), for: UIControlState.normal)
            self.buttonMultiUserWork.setTitleColor(colorRGB(r: 0, g: 122, b: 254), for: UIControlState.normal)
        }
    }
    
    //MARK:缺陷原因
    func request1() {
        let loginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel?.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean = MesPostEntityBean.init()
        let shutDownCauseVo = ShutDownCauseVo.init()
        shutDownCauseVo.siteCode = siteCode
        mesPostEntityBean.entity = shutDownCauseVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        HttpMamager.postRequest(withURLString: DYZ_workRest_shutDownCauseList, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnListBean = responseObjectModel as! ReturnListBean

            if returnListBean.status == "SUCCESS" {
                self._dataArray = []
                for value in returnListBean.list {
                    let shutDownCauseVo: ShutDownCauseVo = ShutDownCauseVo.mj_object(withKeyValues: value)
                    self._dataArray.append(shutDownCauseVo)
                }
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
            }
        }, fail: { (error: Error?) in

        }, isKindOfModel: NSClassFromString("ReturnListBean"))
    }
    
    //MARK:单工单获取列表
    func requestRefeshSingleWork() {
        _viewLoading.isHidden = false
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        let workTimeLogVo: WorkTimeLogVo = WorkTimeLogVo.init()
        workTimeLogVo.siteCode = siteCode
        workTimeLogVo.confirmUser = self.confirmUser
        workTimeLogVo.workTimeLogType = NSNumber.init(value: 1)
        mesPostEntityBean.entity = workTimeLogVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_workingOrder_getWorkingOrderList, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnListBean = responseObjectModel as! ReturnListBean
            self._viewLoading.isHidden = true
            if returnListBean.status == "SUCCESS" {
                self.arrayWorkingOrderVO = [];
                for value in returnListBean.list {
                    let workingOrderVO = WorkingOrderVO.mj_object(withKeyValues: value)
                    workingOrderVO?.isNO = "NO"
                    self.arrayWorkingOrderVO.append(workingOrderVO!)
                }
                if self.arrayWorkingOrderVO.count == 0 {
//                    MyAlertCenter.default().postAlert(withMessage: "单工单没有相关数据")
                }
                self.tableViewSingle.reloadData()
                
                self.showTableViewAndChangeButtonColorWithTableViewType(type: self.workType)
                
                self.buttonPiLiangSingle.setTitle("0", for: UIControlState.normal)
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
            }
            
        }, fail: { (error: Error?) in
            
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
    }
    
    //MARK:多工单获取列表
    func requestRefeshMultipleWork() {
        _viewLoading.isHidden = false
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        let batchWorkVo = BatchWorkVo.init()
        batchWorkVo.siteCode = siteCode
        batchWorkVo.confirmUser = self.confirmUser
        batchWorkVo.batchWorkType = NSNumber.init(value: 1)
        mesPostEntityBean.entity = batchWorkVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_batchWork_getBatchWorkingOrders, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnListBean = responseObjectModel as! ReturnListBean
            self._viewLoading.isHidden = true
            if returnListBean.status == "SUCCESS" {
                self.arrayBatchWorkVo = []
                for value in returnListBean.list {
                    let batchWorkVo = BatchWorkVo.mj_object(withKeyValues: value)
                    batchWorkVo?.isNO = "NO"
                    self.arrayBatchWorkVo.append(batchWorkVo!)
                }
                if self.arrayBatchWorkVo.count == 0 {
//                    MyAlertCenter.default().postAlert(withMessage: "多工单没有相关数据")
                }
                
                self.tableViewMultiple.reloadData()
                self.showTableViewAndChangeButtonColorWithTableViewType(type: self.workType)
                
                self.buttonPiLiangMultiple.setTitle("0", for: UIControlState.normal)
            }
        }, fail: { (error: Error?) in
            
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
    }
    
    //MARK:多人工单获取列表
    func requestRefeshMultiUserWork() {
        _viewLoading.isHidden = false
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel.tpfUser)
        let siteCode = tpfUser?.siteCode
            
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        
        let pager = PagerBean.init()
        pager.page = NSNumber.init(value: 1)
        pager.pageSize = NSNumber.init(value: 10)
        mesPostEntityBean.pager = pager
        
        let workTimeLogVo: WorkTimeLogVo = WorkTimeLogVo.init()
        workTimeLogVo.siteCode = siteCode
        workTimeLogVo.confirmUser = self.confirmUser
        mesPostEntityBean.entity = workTimeLogVo.mj_keyValues()
        
        let dic = mesPostEntityBean.mj_keyValues()
        
        HttpMamager.postRequest(withURLString: DYZ_multiUserWork_getMultiWorkingOrders, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
                let returnListBean = responseObjectModel as! ReturnListBean
                self._viewLoading.isHidden = true
                if returnListBean.status == "SUCCESS" {
                    self.arrayMultiUserWorkVo = [];
                    for value in returnListBean.list {
                        let multiUserWorkVo = MultiUserWorkVo.mj_object(withKeyValues: value)
                        self.arrayMultiUserWorkVo.append(multiUserWorkVo!)
                    }
                    if self.arrayMultiUserWorkVo.count == 0 {
    //                    MyAlertCenter.default().postAlert(withMessage: "多人工单没有相关数据")
                    }
                    self.tableViewMultiUser.reloadData()
                    
                    self.showTableViewAndChangeButtonColorWithTableViewType(type: self.workType)
                    
                } else {
                    MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
                }
                
        }, fail: { (error: Error?) in
                
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
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
