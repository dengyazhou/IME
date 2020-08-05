//
//  MultiUserWorkCompleteVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/4.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

extension Double {
    //截断 到小数点后某一位
    func truncate(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Double(Int(self * divisor)) / divisor
    }
}

class MultiUserWorkCompleteVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    private let _height_NavBar = Height_NavBar!
    private let _height_BottomBar = Height_BottomBar!
    
    var multiUserWorkVo: MultiUserWorkVo!
    
    var list: NSMutableArray!
    
    var _submitType: NSInteger = 0
    var _auditor: String?
    var _password: String?
    
    var _viewLoading: UIView!
    var _uploadImageView: UploadImageView!
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var textFieldTotal: UITextField!
    
    @IBOutlet weak var textFieldTotalBottom123: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let aa = 1.43.truncate(places: 1)
//        print("-----\(aa)------")
        
        self.heightNavBar.constant = _height_NavBar
        self.heightBottomBar.constant = _height_BottomBar
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW-34)/2, y: 180, width: 34, height: 34));
        self.view.addSubview(_viewLoading);
        _viewLoading.isHidden = true
        
        _uploadImageView = UploadImageView.uploadImage()
        _uploadImageView.frame = self.view.frame
        self.view.addSubview(_uploadImageView)
        _uploadImageView.isHidden = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.list = NSMutableArray.init()
        
        for vv in self.multiUserWorkVo.multiUserWorkItemList {
            let workTimeLogVo = vv as! WorkTimeLogVo
            
            let multiUserConfirmReportItemVo = MultiUserConfirmReportItemVo.init()
            let work = WorkTimeLogVo.init()
            work.siteCode = workTimeLogVo.siteCode
            work.operationCode = self.multiUserWorkVo.operationCode
            work.workUnitCode = self.multiUserWorkVo.workUnitCode
            work.confirmUser = workTimeLogVo.confirmUser
            work.productionControlNum = self.multiUserWorkVo.productionControlNum
            work.processOperationId = self.multiUserWorkVo.processOperationId
            work.confirmUserText = workTimeLogVo.confirmUserText
            
            multiUserConfirmReportItemVo.workTimeLogVo = work
            
            multiUserConfirmReportItemVo.completedQuantity = NSNumber.init(value: 0)
            multiUserConfirmReportItemVo.scrappedQuantity = NSNumber.init(value: 0) //当前工序报废数
            multiUserConfirmReportItemVo.repairQuantity = NSNumber.init(value: 0) //当前工序返修数
            multiUserConfirmReportItemVo.reworkStatus = NSNumber.init(value: 0)//返修状态 0 不返修  1 返修
        
            list.add(multiUserConfirmReportItemVo)
        }
        
        
        let total = self.multiUserWorkVo.planQuantity.doubleValue
        print("total------:\(total)")
        let arithmetic = (total/Double(self.list.count)).truncate(places: 1) //平均数
        print("arithmetic------:\(arithmetic)")
        for i in 0..<self.list.count {
            let multiUserConfirmReportItemVo = self.list[i] as! MultiUserConfirmReportItemVo
            if i == 0 {
                let completedQuantity = arithmetic*Double(self.list.count-1)
                multiUserConfirmReportItemVo.completedQuantity = NSNumber.init(value: total-completedQuantity)
            } else {
                multiUserConfirmReportItemVo.completedQuantity = NSNumber.init(value: arithmetic)
            }
        }
        
        self.tableView.register(UINib.init(nibName: "MultiUserWorkCompleteCell", bundle: nil), forCellReuseIdentifier: "multiUserWorkCompleteCell")
        self.tableView.register(UINib.init(nibName: "ScanMultiCompleteHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "scanMultiCompleteHeader")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView.init()
        
        textFieldTotal.addTarget(self, action: #selector(textFieldTotol(sender:)), for: UIControlEvents.editingChanged)
        textFieldTotal.delegate = self
        textFieldTotal.inputAccessoryView = self.addToolbar()
        
    }
    
    @objc func keyboardWillShow(note: NSNotification) {
        let keyBoardRect = note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        self.textFieldTotalBottom123.constant = keyBoardRect.size.height
    }
    @objc func keyboardWillHide(note: NSNotification) {
        self.textFieldTotalBottom123.constant = 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "scanMultiCompleteHeader") as! ScanMultiCompleteHeader
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "multiUserWorkCompleteCell", for: indexPath) as! MultiUserWorkCompleteCell
        cell.selectionStyle = .none
        
        let multiUserConfirmReportItemVo = self.list[indexPath.row] as! MultiUserConfirmReportItemVo
        
        cell.label.text = multiUserConfirmReportItemVo.workTimeLogVo.confirmUserText

        
        cell.textField.text = "\(multiUserConfirmReportItemVo.completedQuantity.doubleValue.truncate(places: 1))"
        cell.textField.addTarget(self, action: #selector(textField(sender:)), for: UIControlEvents.editingChanged)
        cell.textField.tag = indexPath.row
        cell.textField.inputAccessoryView = self.addToolbar()
        cell.textField.delegate = self
        
        //报废
        cell.textField1.text = "\(multiUserConfirmReportItemVo.scrappedQuantity.doubleValue.truncate(places: 1))"
        cell.textField1.addTarget(self, action: #selector(textField1(sender:)), for: UIControlEvents.editingChanged)
        cell.textField1.tag = indexPath.row
        cell.textField1.inputAccessoryView = self.addToolbar()
        cell.textField1.delegate = self
        
        //不良"
        cell.textField2.text = "\(multiUserConfirmReportItemVo.repairQuantity.doubleValue.truncate(places: 1))"
        cell.textField2.addTarget(self, action: #selector(textField2(sender:)), for: UIControlEvents.editingChanged)
        cell.textField2.tag = indexPath.row
        cell.textField2.inputAccessoryView = self.addToolbar()
        cell.textField2.delegate = self
        
        
        //报废
        var image0: String!
        if multiUserConfirmReportItemVo.scrappedQuantity.doubleValue > 0 {
            if (multiUserConfirmReportItemVo.scrappedCauseDetailVos != nil) {
                let arrayTemp = NSMutableArray.init()
                for temp in multiUserConfirmReportItemVo.scrappedCauseDetailVos {
                    let causeDetailVo = temp as! CauseDetailVo
                    if causeDetailVo.quantity.doubleValue > 0 {
                        arrayTemp.add(causeDetailVo)
                    }
                }
                if arrayTemp.count > 0 {
                    image0 = "picture2"
                } else {
                    image0 = "picture1"
                }
                
            } else {
                image0 = "picture1"
            }
        } else {
            image0 = "picture1"
        }
        cell.button.setImage(UIImage.init(named: image0), for: UIControlState.normal)
        cell.button.addTarget(self, action: #selector(buttonClick(_:)), for: UIControlEvents.touchUpInside)
        cell.button.tag = indexPath.row
        
        //不良
        var image1: String!
        if multiUserConfirmReportItemVo.repairQuantity.doubleValue > 0 {
            if (multiUserConfirmReportItemVo.repairCauseDetailVos != nil) {
                let arrayTemp = NSMutableArray.init()
                for temp in multiUserConfirmReportItemVo.repairCauseDetailVos {
                    let causeDetailVo = temp as! CauseDetailVo
                    if causeDetailVo.quantity.doubleValue > 0 {
                        arrayTemp.add(causeDetailVo)
                    }
                }
                if arrayTemp.count > 0 {
                    image1 = "picture2"
                } else {
                    image1 = "picture1"
                }
                
            } else {
                image1 = "picture1"
            }
        } else {
            image1 = "picture1"
        }
        cell.button1.setImage(UIImage.init(named: image1), for: UIControlState.normal)
        cell.button1.addTarget(self, action: #selector(buttonClick1(_:)), for: UIControlEvents.touchUpInside)
        cell.button1.tag = indexPath.row
        return cell
    }

    @objc func textField(sender: UITextField) {
        let multiUserConfirmReportItemVo = self.list[sender.tag] as! MultiUserConfirmReportItemVo
        
        if sender.text?.count ?? 0 > 0 {
            multiUserConfirmReportItemVo.completedQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            multiUserConfirmReportItemVo.completedQuantity = NSNumber.init(value: 0)
        }
        
        var total: Double = 0
        for i in 0..<self.list.count {
            let multiUserConfirmReportItemVo = self.list[i] as! MultiUserConfirmReportItemVo
            total = total + multiUserConfirmReportItemVo.completedQuantity.doubleValue
        }
        self.textFieldTotal.text = String.init(total)
    }
    
    //报废
    @objc func textField1(sender: UITextField) {
        let multiUserConfirmReportItemVo = self.list[sender.tag] as! MultiUserConfirmReportItemVo
        
        if (sender.text?.count)! > 0 {
            if sender.text != "0" {
                multiUserConfirmReportItemVo.scrappedQuantity = NSNumber.init(value: Double(sender.text!)!)
                multiUserConfirmReportItemVo.reworkStatus = NSNumber.init(value: 1);
            } else {
                multiUserConfirmReportItemVo.scrappedQuantity = NSNumber.init(value: 0)
                multiUserConfirmReportItemVo.reworkStatus = NSNumber.init(value: 0);
            }
        } else {
            multiUserConfirmReportItemVo.scrappedQuantity = NSNumber.init(value: 0)
            multiUserConfirmReportItemVo.reworkStatus = NSNumber.init(value: 0);
        }
    }
    //不良
    @objc func textField2(sender: UITextField) {
        let multiUserConfirmReportItemVo = self.list[sender.tag] as! MultiUserConfirmReportItemVo
        
        if (sender.text?.count)! > 0 {
            if sender.text != "0" {
                multiUserConfirmReportItemVo.repairQuantity = NSNumber.init(value: Double(sender.text!)!)
                multiUserConfirmReportItemVo.reworkStatus = NSNumber.init(value: 1);
            } else {
                multiUserConfirmReportItemVo.repairQuantity = NSNumber.init(value: 0)
                multiUserConfirmReportItemVo.reworkStatus = NSNumber.init(value: 0);
            }
        } else {
            multiUserConfirmReportItemVo.repairQuantity = NSNumber.init(value: 0)
            multiUserConfirmReportItemVo.reworkStatus = NSNumber.init(value: 0);
        }
    }
    
    @objc func textFieldTotol(sender: UITextField) {
        if sender.text?.count ?? 0 > 0 {
            let total = Double(sender.text!)!
            print("total------:\(total)")
            let arithmetic = (total/Double(self.list.count)).truncate(places: 1) //平均数
            print("arithmetic------:\(arithmetic)")
            for i in 0..<self.list.count {
                let multiUserConfirmReportItemVo = self.list[i] as! MultiUserConfirmReportItemVo
                if i == 0 {
                    let completedQuantity = arithmetic*Double(self.list.count-1)
                    multiUserConfirmReportItemVo.completedQuantity = NSNumber.init(value: total-completedQuantity)
                } else {
                    multiUserConfirmReportItemVo.completedQuantity = NSNumber.init(value: arithmetic)
                }
            }
        } else {
            for i in 0..<self.list.count {
                let multiUserConfirmReportItemVo = self.list[i] as! MultiUserConfirmReportItemVo
                 multiUserConfirmReportItemVo.completedQuantity = NSNumber.init(value: 0)
            }
        }
        
        self.tableView.reloadData()
    }
    
    
// MARK: - 保留一位小数
    func textField(_ textField:UITextField, shouldChangeCharactersIn range:NSRange, replacementString string:String) ->Bool{
        //新输入的
        if string.count == 0 {
            return true
        }
        //第一个参数，被替换字符串的range
        //第二个参数，即将键入或者粘贴的string
        //返回的是改变过后的新str，即textfield的新的文本内容

        let checkStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        //正则表达式（只支持两位小数）
        let regex = "^\\-?([1-9]\\d*|0)(\\.\\d{0,1})?$"
        //判断新的文本内容是否符合要求
        return self.isValid(checkStr: checkStr!, regex: regex)
    }
    //检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
    func isValid(checkStr:String, regex:String) ->Bool{
        let predicte = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicte.evaluate(with: checkStr)
    }
// MARK: - 保留一位小数
    
    
    //报废
    @objc func buttonClick(_ sender: UIButton) {
        let multiUserConfirmReportItemVo = self.list[sender.tag] as! MultiUserConfirmReportItemVo
        let vc = SelectScrapReasonVC.init()
        vc.typeUploadImageName = "scrappedPictureFiles"
        vc.productionControlNum = multiUserConfirmReportItemVo.workTimeLogVo.productionControlNum
        vc.processOperationId = multiUserConfirmReportItemVo.workTimeLogVo.processOperationId
        vc.stage = "IQC"
        vc.confirmUser = multiUserConfirmReportItemVo.workTimeLogVo.confirmUser
        
        if (multiUserConfirmReportItemVo.scrappedCauseDetailVos != nil) {
            NSLog("%@", "存在")
            vc.causeDetailVos = multiUserConfirmReportItemVo.scrappedCauseDetailVos.mutableCopy() as? NSMutableArray
        } else {
            NSLog("%@", "不存在")
        }
        
        vc.blockArrayCauseDetailVo = { causeDetailVos in
            
            multiUserConfirmReportItemVo.scrappedCauseDetailVos = causeDetailVos!
            self.tableView.reloadRows(at: [IndexPath.init(row: sender.tag, section: 0)], with: .none)
        }
        
        vc.quantity = multiUserConfirmReportItemVo.scrappedQuantity.doubleValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //不良
    @objc func buttonClick1(_ sender: UIButton) {
        let multiUserConfirmReportItemVo = self.list[sender.tag] as! MultiUserConfirmReportItemVo
        let vc = SelectScrapReasonVC.init()
        vc.typeUploadImageName = "repairPictureFiles"
        vc.productionControlNum = multiUserConfirmReportItemVo.workTimeLogVo.productionControlNum
        vc.processOperationId = multiUserConfirmReportItemVo.workTimeLogVo.processOperationId
        vc.stage = "IQC"
        vc.confirmUser = multiUserConfirmReportItemVo.workTimeLogVo.confirmUser
        
        if (multiUserConfirmReportItemVo.repairCauseDetailVos != nil) {
            NSLog("%@", "存在")
            vc.causeDetailVos = multiUserConfirmReportItemVo.repairCauseDetailVos.mutableCopy() as? NSMutableArray
        } else {
            NSLog("%@", "不存在")
        }
        
        vc.blockArrayCauseDetailVo = { causeDetailVos in
            multiUserConfirmReportItemVo.repairCauseDetailVos = causeDetailVos!
            self.tableView.reloadRows(at: [IndexPath.init(row: sender.tag, section: 0)], with: .none)
        }
        
        vc.quantity = multiUserConfirmReportItemVo.repairQuantity.doubleValue
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func buttonCheck(_ sender: Any) {
        var flag = false
        for vv in self.list {
            let multiUserConfirmReportItemVo = vv as! MultiUserConfirmReportItemVo
            if multiUserConfirmReportItemVo.completedQuantity.doubleValue == 0 {
                flag = true
            }
        }
        if flag {
            showAlertOrContinue(index: 1)//审核
        } else {
            _submitType = 1
            let loginModel = DatabaseTool.getLoginModel()
            let userBean = UserBean.mj_object(withKeyValues: loginModel?.ucenterUser)
            let siteCode = userBean?.enterpriseInfo.serialNo
            let personnerlCode = DatabaseTool.t_TpfPWTableGetPersonnelCode(withSiteCode: siteCode)
            if personnerlCode != "(null)" {//绑定了人员
                _auditor = personnerlCode
                showAlertViewPasswordAuthentification()
            } else {
                let vc = ScanEmployeeVC()
                vc.passwordAuthentificationCallBack { (str, needPassword) in
                    if needPassword == 1 {
                        self._auditor = str
                        self.perform(#selector(self.afterdyz), with: nil, afterDelay: 1)
                        self.showAlertViewPasswordAuthentification()
                    } else {
                        self._auditor = str
                        self.requestDoConfirmProduction()
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func afterdyz() {
        showAlertViewPasswordAuthentification()
    }
    
    func showAlertViewPasswordAuthentification() {
        let alertVC = UIAlertController(title: "交接班确认", message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "确认", style: .default, handler: { (action) in
            let str = alertVC.textFields?[0].text
            if let str = str {
                if str.count == 0 {
                    MyAlertCenter.default()?.postAlert(withMessage: "请输入密码")
                    return
                }
            }
            self._password = str
            self.requestDoConfirmProduction()
        }))
        alertVC.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alertVC.addTextField { (textField) in
            textField.placeholder = "审核人输入密码"
        }
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func buttonCommit(_ sender: Any) {
        var flag = false
        for vv in self.list {
            let multiUserConfirmReportItemVo = vv as! MultiUserConfirmReportItemVo
            if multiUserConfirmReportItemVo.completedQuantity.doubleValue == 0 {
                flag = true
            }
        }
        if flag {
            showAlertOrContinue(index: 0)//提交
        } else {
            _submitType = 0
            requestDoConfirmProduction()
        }
    }
    
    func showAlertOrContinue(index: NSInteger) {
        let alertVC = UIAlertController(title: "存在合格数量为0工单，是否继续提交？", message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "确认", style: .default, handler: { (action) in
            if index == 0 {//提交
                self._submitType = 0
                self.requestDoConfirmProduction()
            } else if index == 1 {//审核
                self._submitType = 1
                let loginModel = DatabaseTool.getLoginModel()
                let userBean = UserBean.mj_object(withKeyValues: loginModel?.ucenterUser)
                let siteCode = userBean?.enterpriseInfo.serialNo
                let personnerlCode = DatabaseTool.t_TpfPWTableGetPersonnelCode(withSiteCode: siteCode)
                if personnerlCode != "(null)" {//绑定了人员
                    self._auditor = personnerlCode
                    self.showAlertViewPasswordAuthentification()
                } else {
                    let vc = ScanEmployeeVC()
                    vc.passwordAuthentificationCallBack { (str, needPassword) in
                        if needPassword == 1 {
                            self._auditor = str
                            self.perform(#selector(self.afterdyz), with: nil, afterDelay: 1)
                            self.showAlertViewPasswordAuthentification()
                        } else {
                            self._auditor = str
                            self.requestDoConfirmProduction()
                        }
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }))
        alertVC.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func requestDoConfirmProduction() {
        for i in 0..<self.list.count {
//            let multiUserConfirmReportItemVo = self.list[i] as! MultiUserConfirmReportItemVo
//            //报废数
//            if multiUserConfirmReportItemVo.scrappedQuantity.doubleValue > 0 {
//                if (multiUserConfirmReportItemVo.scrappedCauseDetailVos != nil) {
//                    var total = 0.0
//                    for i in 0..<multiUserConfirmReportItemVo.scrappedCauseDetailVos.count {
//                        let causeDetailVo = multiUserConfirmReportItemVo.scrappedCauseDetailVos[i] as! CauseDetailVo
//                        total = total + causeDetailVo.quantity.doubleValue
//                    }
//                    if total > multiUserConfirmReportItemVo.scrappedQuantity.doubleValue {
//                        MyAlertCenter.default()?.postAlert(withMessage: "不得大于缺陷总数")
//                        return
//                    }
//                }
//            }
//            //不良数
//            if multiUserConfirmReportItemVo.repairQuantity.doubleValue > 0 {
//                if (multiUserConfirmReportItemVo.repairCauseDetailVos != nil) {
//                    var total = 0.0
//                    for i in 0..<multiUserConfirmReportItemVo.repairCauseDetailVos.count {
//                        let causeDetailVo = multiUserConfirmReportItemVo.repairCauseDetailVos[i] as! CauseDetailVo
//                        total = total + causeDetailVo.quantity.doubleValue
//                    }
//                    if total > multiUserConfirmReportItemVo.repairQuantity.doubleValue {
//                        MyAlertCenter.default()?.postAlert(withMessage: "不得大于缺陷总数")
//                        return
//                    }
//                }
//            }
        }
        
        _uploadImageView.isHidden = false
        _uploadImageView.prepare()
        
        let mesPostEntityBean = MesPostEntityBean.init()
        
        let multiUserConfirmReportVo = MultiUserConfirmReportVo.init()
        self.multiUserWorkVo.confirmSourceType = NSNumber.init(value: 9)
        multiUserConfirmReportVo.multiUserWorkVo = self.multiUserWorkVo
        
        for vv in self.list {
            let multiUserConfirmReportItemVo = vv as! MultiUserConfirmReportItemVo
//            if batchWorkItemReportVo.productionOperationVo.completedQuantity.doubleValue > batchWorkItemReportVo.productionOperationVo.unCompletedQuantity.doubleValue{
//                MyAlertCenter.default().postAlert(withMessage: "报工数大于计划数")
//                _viewLoading.isHidden = true
//                return
//            }
        }
        
        var imageArray:[UploadImageBean] = []
        for i in 0..<self.list.count {
            let multiUserConfirmReportItemVo = self.list[i] as! MultiUserConfirmReportItemVo
    
            //报废数
            if multiUserConfirmReportItemVo.scrappedQuantity.doubleValue > 0 {
                if (multiUserConfirmReportItemVo.scrappedCauseDetailVos != nil) {
                    let arrayTemp = NSMutableArray.init()
                    for temp in multiUserConfirmReportItemVo.scrappedCauseDetailVos {
                        let causeDetailVo = temp as! CauseDetailVo
                        if causeDetailVo.quantity.doubleValue > 0 {
                            for i in 0..<causeDetailVo.uploadImageBeanList.count {
                                let uploadImageBean = causeDetailVo.uploadImageBeanList[i] as! UploadImageBean
                                imageArray.append(uploadImageBean)
                            }
                            arrayTemp.add(causeDetailVo)
                        }
                    }
                    multiUserConfirmReportItemVo.scrappedCauseDetailVos = arrayTemp
                    for temp in multiUserConfirmReportItemVo.scrappedCauseDetailVos {
                        let causeDetailVo = temp as! CauseDetailVo
                        causeDetailVo.uploadImageBeanList = NSMutableArray.init()
                    }
                }
            }
            //不良数
            if multiUserConfirmReportItemVo.repairQuantity.doubleValue > 0 {
                if (multiUserConfirmReportItemVo.repairCauseDetailVos != nil) {
                    let arrayTemp = NSMutableArray.init()
                    for temp in multiUserConfirmReportItemVo.repairCauseDetailVos {
                        let causeDetailVo = temp as! CauseDetailVo
                        if causeDetailVo.quantity.doubleValue > 0 {
                            for i in 0..<causeDetailVo.uploadImageBeanList.count {
                                let uploadImageBean = causeDetailVo.uploadImageBeanList[i] as! UploadImageBean
                                imageArray.append(uploadImageBean)
                            }
                            arrayTemp.add(causeDetailVo)
                        }
                    }
                    multiUserConfirmReportItemVo.repairCauseDetailVos = arrayTemp
                    for temp in multiUserConfirmReportItemVo.repairCauseDetailVos {
                        let causeDetailVo = temp as! CauseDetailVo
                        causeDetailVo.uploadImageBeanList = NSMutableArray.init()
                    }
                }
            }
        }
        
        for i in 0..<self.list.count {
            let multiUserConfirmReportItemVo = self.list[i] as! MultiUserConfirmReportItemVo
//            multiUserConfirmReportItemVo.scrappedPictureAttachmentVoListDyz = NSMutableArray.init()
//            multiUserConfirmReportItemVo.repairPictureAttachmentVoListDyz = NSMutableArray.init()
        }
        
        multiUserConfirmReportVo.multiUserConfirmReportItemVos = self.list
        
        multiUserConfirmReportVo.multiUserWorkVo.auditor = _auditor != nil ? _auditor! : "";
        multiUserConfirmReportVo.multiUserWorkVo.password = _password != nil ? _password! : "";
        multiUserConfirmReportVo.multiUserWorkVo.submitType = NSNumber.init(value: _submitType)
        multiUserConfirmReportVo.multiUserWorkVo.loginType = UserDefaults.standard.object(forKey: "loginType") as! String
        
        
        mesPostEntityBean.entity = multiUserConfirmReportVo.mj_keyValues()
        let dic1 = mesPostEntityBean.mj_keyValues()
        let dic2 = ["data":String.toolSwiftGetJSONFromDictionary(dictionary: dic1!)]
        print(dic2)
        print(imageArray.count)
        
        //https://betamapi.imefuture.com/rs/mes/multiUserWork/doMultiUserConfirmProduction
        HttpMamager.postRequestImage(withURLString: DYZ_multiUserWork_doMultiUserConfirmProduction, parameters: dic2, uploadImageBean: imageArray, success: { (responseObjectModel) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean
            
            self._uploadImageView.isHidden = true
            
            if returnMsgBean.status == "SUCCESS" {
                MyAlertCenter.default().postAlert(withMessage: "提交成功")
                for vc in (self.navigationController?.viewControllers)! {
                    if vc is ScanTuZhiViewController {
                        self.navigationController?.popToViewController(vc, animated: true)
                        return
                    }
                }
                for vc in (self.navigationController?.viewControllers)! {
                    if vc is ZaiZhiGongDanVC {
                        self.navigationController?.popToViewController(vc, animated: true)
                        return
                    }
                }
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
        }, progress: { (progress: Progress?) in
            DispatchQueue.main.async {
                self._uploadImageView.progressView?.progress =  Float(progress?.fractionCompleted ?? 0)
                if progress?.fractionCompleted == 1 {
                    self._uploadImageView.loadFinish()
                }
            }
        }, fail: { (error) in
            self._uploadImageView.isHidden = true
        }, isKindOfModelClass: NSClassFromString("ReturnMsgBean"))
    }
    
    @IBAction func buttonGoHome(_ sender: Any) {
        for vc in (self.navigationController?.viewControllers)! {
            if vc is TpfMaiViewController {
                self.navigationController?.popToViewController(vc, animated: true)
                return
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        
        if self.multiUserWorkVo.status.intValue == 4 {
            for temp in (self.navigationController?.viewControllers)! {
                if temp is ZaiZhiGongDanVC {
                    self.navigationController?.popToViewController(temp, animated: true)
                    return
                }
            }
            for temp in (self.navigationController?.viewControllers)! {
                if temp is ScanZuoYeDanYuanViewController {
                    self.navigationController?.popToViewController(temp, animated: true)
                    return
                }
            }
            for temp in (self.navigationController?.viewControllers)! {
                if temp is ScanTuZhiViewController {
                    self.navigationController?.popToViewController(temp, animated: true)
                    return
                }
            }
        } else {
            self.navigationController?.popViewController(animated: true);
        }
        
    }
    
    func addToolbar() -> UIToolbar {
        let toolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 38))
        toolbar.tintColor = colorRGB(r: 0, g: 168, b: 255)
        let space = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let bar = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(textFieldDone))
        toolbar.items = [space, bar]
        return toolbar
    }
    
    @objc func textFieldDone() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        self.tableView.reloadData()
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
