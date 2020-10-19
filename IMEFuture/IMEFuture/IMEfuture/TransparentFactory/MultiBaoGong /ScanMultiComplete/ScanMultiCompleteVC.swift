//
//  ScanMultiCompleteVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/4.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class ScanMultiCompleteVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    private let _height_NavBar = Height_NavBar!
    private let _height_BottomBar = Height_BottomBar!
    
    var batchWorkVo: BatchWorkVo!
    
    var list: NSMutableArray!
    
    var _submitType: NSInteger = 0
    var _auditor: String?
    var _password: String?
    
    var _viewLoading: UIView!
    var _uploadImageView: UploadImageView!
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar
        self.heightBottomBar.constant = _height_BottomBar
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW-34)/2, y: 180, width: 34, height: 34));
        self.view.addSubview(_viewLoading);
        _viewLoading.isHidden = true
        
        _uploadImageView = UploadImageView.uploadImage()
        _uploadImageView.frame = self.view.frame
        self.view.addSubview(_uploadImageView)
        _uploadImageView.isHidden = true
        
        self.list = NSMutableArray.init()
        
        for vv in self.batchWorkVo.batchWorkItemList {
            let workTimeLogVo = vv as! WorkTimeLogVo
            let batchWorkItemReportVo = BatchWorkItemReportVo.init()
            let productionOperationVo = ProductionOperationVo.init()
            productionOperationVo.siteCode = workTimeLogVo.siteCode
            productionOperationVo.productionControlNum = workTimeLogVo.productionControlNum
            productionOperationVo.unCompletedQuantity = workTimeLogVo.unfinishedQuantity//当前工序未报工数
            productionOperationVo.processOperationId = workTimeLogVo.processOperationId
            productionOperationVo.operationCode = workTimeLogVo.operationCode
            if workTimeLogVo.unfinishedQuantity != nil && workTimeLogVo.unfinishedQuantity.doubleValue != 0{
                productionOperationVo.completedQuantity = workTimeLogVo.unfinishedQuantity//当前工序已报工数
            } else {
                productionOperationVo.completedQuantity = NSNumber.init(value: 0)
            }
            productionOperationVo.scrappedQuantity = NSNumber.init(value: 0) //当前工序报废数
            productionOperationVo.repairQuantity = NSNumber.init(value: 0) //当前工序返修数
            batchWorkItemReportVo.productionOperationVo = productionOperationVo
            batchWorkItemReportVo.workRecordType = workTimeLogVo.workRecordType
            batchWorkItemReportVo.reworkStatus = NSNumber.init(value: 0)//返修状态 0 不返修  1 返修
            batchWorkItemReportVo.scrappedPictureAttachmentVoListDyz = NSMutableArray.init()
            batchWorkItemReportVo.repairPictureAttachmentVoListDyz = NSMutableArray.init()
            batchWorkItemReportVo.scrappedCauseList = NSMutableArray.init()
            batchWorkItemReportVo.repairCauseList = NSMutableArray.init()
            list.add(batchWorkItemReportVo)
        }
        
        self.tableView.register(UINib.init(nibName: "ScanMultiCompleteCell", bundle: nil), forCellReuseIdentifier: "scanMultiCompleteCell")
        self.tableView.register(UINib.init(nibName: "ScanMultiCompleteHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "scanMultiCompleteHeader")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView.init()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "scanMultiCompleteCell", for: indexPath) as! ScanMultiCompleteCell
        cell.selectionStyle = .none
        
        let batchWorkItemReportVo = self.list[indexPath.row] as! BatchWorkItemReportVo
        
        cell.label.text = batchWorkItemReportVo.productionOperationVo.productionControlNum
        cell.label1.text = batchWorkItemReportVo.productionOperationVo.operatorCode
        
        cell.textField.text = batchWorkItemReportVo.productionOperationVo.completedQuantity.stringValue
        cell.textField.addTarget(self, action: #selector(textField(sender:)), for: UIControlEvents.editingChanged)
        cell.textField.tag = indexPath.row
        cell.textField.inputAccessoryView = self.addToolbar()
        
        //报废
        cell.textField1.text = batchWorkItemReportVo.productionOperationVo.scrappedQuantity.stringValue
        cell.textField1.addTarget(self, action: #selector(textField1(sender:)), for: UIControlEvents.editingChanged)
        cell.textField1.tag = indexPath.row
        cell.textField1.inputAccessoryView = self.addToolbar()
        
        //不良
        cell.textField2.text = batchWorkItemReportVo.productionOperationVo.repairQuantity.stringValue
        cell.textField2.addTarget(self, action: #selector(textField2(sender:)), for: UIControlEvents.editingChanged)
        cell.textField2.tag = indexPath.row
        cell.textField2.inputAccessoryView = self.addToolbar()
        
        
        //报废
        var image0: String!
        if batchWorkItemReportVo.productionOperationVo.scrappedQuantity.doubleValue > 0 {
            if (batchWorkItemReportVo.scrappedCauseDetailVos != nil) {
                let arrayTemp = NSMutableArray.init()
                for temp in batchWorkItemReportVo.scrappedCauseDetailVos {
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
        if batchWorkItemReportVo.productionOperationVo.repairQuantity.doubleValue > 0 {
            if (batchWorkItemReportVo.repairCauseDetailVos != nil) {
                let arrayTemp = NSMutableArray.init()
                for temp in batchWorkItemReportVo.repairCauseDetailVos {
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
        let batchWorkItemReportVo = self.list[sender.tag] as! BatchWorkItemReportVo
        
        if sender.text?.count ?? 0 > 0 {
            batchWorkItemReportVo.productionOperationVo.completedQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            batchWorkItemReportVo.productionOperationVo.completedQuantity = NSNumber.init(value: 0)
        }
    }
    //报废
    @objc func textField1(sender: UITextField) {
        let batchWorkItemReportVo = self.list[sender.tag] as! BatchWorkItemReportVo
        
        if (sender.text?.count)! > 0 {
            if sender.text != "0" {
                batchWorkItemReportVo.productionOperationVo.scrappedQuantity = NSNumber.init(value: Double(sender.text!)!)
                batchWorkItemReportVo.reworkStatus = NSNumber.init(value: 1);
            } else {
                batchWorkItemReportVo.productionOperationVo.scrappedQuantity = NSNumber.init(value: 0)
                batchWorkItemReportVo.reworkStatus = NSNumber.init(value: 0);
            }
        } else {
            batchWorkItemReportVo.productionOperationVo.scrappedQuantity = NSNumber.init(value: 0)
            batchWorkItemReportVo.reworkStatus = NSNumber.init(value: 0);
        }
    }
    //不良
    @objc func textField2(sender: UITextField) {
        let batchWorkItemReportVo = self.list[sender.tag] as! BatchWorkItemReportVo
        
        if (sender.text?.count)! > 0 {
            if sender.text != "0" {
                batchWorkItemReportVo.productionOperationVo.repairQuantity = NSNumber.init(value: Double(sender.text!)!)
                batchWorkItemReportVo.reworkStatus = NSNumber.init(value: 1);
            } else {
                batchWorkItemReportVo.productionOperationVo.repairQuantity = NSNumber.init(value: 0)
                batchWorkItemReportVo.reworkStatus = NSNumber.init(value: 0);
            }
        } else {
            batchWorkItemReportVo.productionOperationVo.repairQuantity = NSNumber.init(value: 0)
            batchWorkItemReportVo.reworkStatus = NSNumber.init(value: 0);
        }
    }
    
    //报废
    @objc func buttonClick(_ sender: UIButton) {
        let batchWorkItemReportVo = self.list[sender.tag] as! BatchWorkItemReportVo
        let vc = SelectScrapReasonVC.init()
        vc.typeUploadImageName = "defectPictureFiles"
        vc.productionControlNum = batchWorkItemReportVo.productionOperationVo.productionControlNum
        vc.processOperationId = batchWorkItemReportVo.productionOperationVo.processOperationId
        vc.stage = "IQC"
        vc.productionControlNumAndprocessOperationId = batchWorkItemReportVo.productionOperationVo.productionControlNum + batchWorkItemReportVo.productionOperationVo.processOperationId
        
        if (batchWorkItemReportVo.scrappedCauseDetailVos != nil) {
            NSLog("%@", "存在")
            vc.causeDetailVos = batchWorkItemReportVo.scrappedCauseDetailVos.mutableCopy() as? NSMutableArray
        } else {
            NSLog("%@", "不存在")
        }
        
        vc.blockArrayCauseDetailVo = { causeDetailVos in
            batchWorkItemReportVo.scrappedCauseDetailVos = causeDetailVos
            self.tableView.reloadRows(at: [IndexPath.init(row: sender.tag, section: 0)], with: .none)
        }
        
        vc.quantity = batchWorkItemReportVo.productionOperationVo.scrappedQuantity.doubleValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //不良
    @objc func buttonClick1(_ sender: UIButton) {
        let batchWorkItemReportVo = self.list[sender.tag] as! BatchWorkItemReportVo
        let vc = SelectScrapReasonVC.init()
        vc.typeUploadImageName = "repairPictureFiles"
        vc.productionControlNum = batchWorkItemReportVo.productionOperationVo.productionControlNum
        vc.processOperationId = batchWorkItemReportVo.productionOperationVo.processOperationId
        vc.stage = "IQC"
        vc.productionControlNumAndprocessOperationId = batchWorkItemReportVo.productionOperationVo.productionControlNum + batchWorkItemReportVo.productionOperationVo.processOperationId
        
        if (batchWorkItemReportVo.repairCauseDetailVos != nil) {
            NSLog("%@", "存在")
            vc.causeDetailVos = batchWorkItemReportVo.repairCauseDetailVos.mutableCopy() as? NSMutableArray
        } else {
            NSLog("%@", "不存在")
        }
        
        vc.blockArrayCauseDetailVo = { causeDetailVos in
            batchWorkItemReportVo.repairCauseDetailVos = causeDetailVos
            self.tableView.reloadRows(at: [IndexPath.init(row: sender.tag, section: 0)], with: .none)
        }
        
        vc.quantity = batchWorkItemReportVo.productionOperationVo.repairQuantity.doubleValue
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func buttonCheck(_ sender: Any) {
        var flag = false
        for vv in self.list {
            let batchWorkItemReportVo = vv as! BatchWorkItemReportVo
            if batchWorkItemReportVo.productionOperationVo.completedQuantity.doubleValue == 0 {
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
            let batchWorkItemReportVo = vv as! BatchWorkItemReportVo
            if batchWorkItemReportVo.productionOperationVo.completedQuantity.doubleValue == 0 {
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
            let batchWorkItemReportVo = self.list[i] as! BatchWorkItemReportVo
            //报废数
            if batchWorkItemReportVo.productionOperationVo.scrappedQuantity.doubleValue > 0 {
                if (batchWorkItemReportVo.scrappedCauseDetailVos != nil) {
                    var total = 0.0
                    for i in 0..<batchWorkItemReportVo.scrappedCauseDetailVos.count {
                        let causeDetailVo = batchWorkItemReportVo.scrappedCauseDetailVos[i] as! CauseDetailVo
                        total = total + causeDetailVo.quantity.doubleValue
                    }
                    if total > batchWorkItemReportVo.productionOperationVo.scrappedQuantity.doubleValue {
                        MyAlertCenter.default()?.postAlert(withMessage: "不得大于缺陷总数")
                        return
                    }
                }
            }
            //不良数
            if batchWorkItemReportVo.productionOperationVo.repairQuantity.doubleValue > 0 {
                if (batchWorkItemReportVo.repairCauseDetailVos != nil) {
                    var total = 0.0
                    for i in 0..<batchWorkItemReportVo.repairCauseDetailVos.count {
                        let causeDetailVo = batchWorkItemReportVo.repairCauseDetailVos[i] as! CauseDetailVo
                        total = total + causeDetailVo.quantity.doubleValue
                    }
                    if total > batchWorkItemReportVo.productionOperationVo.repairQuantity.doubleValue {
                        MyAlertCenter.default()?.postAlert(withMessage: "不得大于缺陷总数")
                        return
                    }
                }
            }
        }
        
        _uploadImageView.isHidden = false
        _uploadImageView.prepare()
        
        let mesPostEntityBean = MesPostEntityBean.init()
        let batchConfirmPeportVo = BatchConfirmReportVo.init()
        batchConfirmPeportVo.batchWorkVo = self.batchWorkVo
        
//        for vv in self.list {
//            let batchWorkItemReportVo = vv as! BatchWorkItemReportVo
//            if batchWorkItemReportVo.productionOperationVo.completedQuantity.doubleValue > batchWorkItemReportVo.productionOperationVo.unCompletedQuantity.doubleValue{
//                MyAlertCenter.default().postAlert(withMessage: "报工数大于计划数")
//                return
//            }
//        }
        
        
        var imageArray:[UploadImageBean] = []
        for i in 0..<self.list.count {
            let batchWorkItemReportVo = self.list[i] as! BatchWorkItemReportVo
    
            //报废数
            if batchWorkItemReportVo.productionOperationVo.scrappedQuantity.doubleValue > 0 {
                if (batchWorkItemReportVo.scrappedCauseDetailVos != nil) {
                    let arrayTemp = NSMutableArray.init()
                    for temp in batchWorkItemReportVo.scrappedCauseDetailVos {
                        let causeDetailVo = temp as! CauseDetailVo
                        if causeDetailVo.quantity.doubleValue > 0 {
                            for i in 0..<causeDetailVo.uploadImageBeanList.count {
                                let uploadImageBean = causeDetailVo.uploadImageBeanList[i] as! UploadImageBean
                                imageArray.append(uploadImageBean)
                            }
                            arrayTemp.add(causeDetailVo)
                        }
                    }
                    batchWorkItemReportVo.scrappedCauseDetailVos = arrayTemp
                    for temp in batchWorkItemReportVo.scrappedCauseDetailVos {
                        let causeDetailVo = temp as! CauseDetailVo
                        causeDetailVo.uploadImageBeanList = NSMutableArray.init()
                    }
                }
            }
            //不良数
            if batchWorkItemReportVo.productionOperationVo.repairQuantity.doubleValue > 0 {
                if (batchWorkItemReportVo.repairCauseDetailVos != nil) {
                    let arrayTemp = NSMutableArray.init()
                    for temp in batchWorkItemReportVo.repairCauseDetailVos {
                        let causeDetailVo = temp as! CauseDetailVo
                        if causeDetailVo.quantity.doubleValue > 0 {
                            for i in 0..<causeDetailVo.uploadImageBeanList.count {
                                let uploadImageBean = causeDetailVo.uploadImageBeanList[i] as! UploadImageBean
                                imageArray.append(uploadImageBean)
                            }
                            arrayTemp.add(causeDetailVo)
                        }
                    }
                    batchWorkItemReportVo.repairCauseDetailVos = arrayTemp
                    for temp in batchWorkItemReportVo.repairCauseDetailVos {
                        let causeDetailVo = temp as! CauseDetailVo
                        causeDetailVo.uploadImageBeanList = NSMutableArray.init()
                    }
                }
            }
        }
        
        for i in 0..<self.list.count {
            let batchWorkItemReportVo = self.list[i] as! BatchWorkItemReportVo
            batchWorkItemReportVo.scrappedPictureAttachmentVoListDyz = NSMutableArray.init()
            batchWorkItemReportVo.repairPictureAttachmentVoListDyz = NSMutableArray.init()
        }
        
        batchConfirmPeportVo.batchWorkItemReportVos = self.list
        
        batchConfirmPeportVo.batchWorkVo.auditor = _auditor;
        batchConfirmPeportVo.batchWorkVo.password = _password;
        batchConfirmPeportVo.batchWorkVo.submitType = NSNumber.init(value: _submitType)
        batchConfirmPeportVo.batchWorkVo.loginType = UserDefaults.standard.object(forKey: "loginType") as! String
        
        
        mesPostEntityBean.entity = batchConfirmPeportVo.mj_keyValues()
        let dic1 = mesPostEntityBean.mj_keyValues()
        let dic2 = ["data":String.toolSwiftGetJSONFromDictionary(dictionary: dic1!)]
        print(dic2)
        
        HttpMamager.postRequestImage(withURLString: DYZ_batchProductionOrderConfirm_doConfirmProduction, parameters: dic2, uploadImageBean: imageArray, success: { (responseObjectModel) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean
            
            self._uploadImageView.isHidden = true
            
            if returnMsgBean.status == "SUCCESS" {
                MyAlertCenter.default().postAlert(withMessage: "提交成功")
                for vc in (self.navigationController?.viewControllers)! {
                    if vc is ScanMYuanGongVC {
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
        
        if self.batchWorkVo.status.intValue == 4 {
            for temp in (self.navigationController?.viewControllers)! {
                if temp is ZaiZhiGongDanVC {
                    self.navigationController?.popToViewController(temp, animated: true)
                    return
                }
            }
            for temp in (self.navigationController?.viewControllers)! {
                if temp is ScanMultiScanVC {
                    self.navigationController?.popToViewController(temp, animated: true)
                    return
                }
            }
            for temp in (self.navigationController?.viewControllers)! {
                if temp is ScanMTuZhiVC {
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
