//
//  IQCRuKuViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/16.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class IQCRuKuViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var arrayMaterialArrivedOrderDetailVo: [MaterialArrivedOrderDetailVo]! = []
    
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    
    private var _viewLoading: UIView!
    
    private var minStatus: NSInteger!
    
    @IBOutlet weak var labelTitle: UILabel! //标题
    @IBOutlet weak var batchButton: UIButton! //批量操作按钮
    
    private var globalRequestStr: String?
    
    
    @IBOutlet weak var viewZhong0: UIView!
    @IBOutlet weak var viewZhong1: UIView!
    @IBOutlet weak var labelGongYingShang: UILabel!
    
    
    @IBOutlet weak var viewBottom0: UIView!
    @IBOutlet weak var viewBottom1: UIView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar1: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        if (self.globalRequestStr != nil) {
            self.request(result: self.globalRequestStr)
        }
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!
        self.heightBottomBar1.constant = _height_BottomBar!
        
//        self.viewZhong0.isHidden = true
//        self.viewBottom0.isHidden = true
        self.viewZhong1.isHidden = true
        self.viewBottom1.isHidden = true
        
        self.batchButton.layer.cornerRadius = 5
        self.batchButton.layer.borderWidth = 1
        self.batchButton.layer.borderColor = UIColor.black.cgColor
        
//        self.tableView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "cell")
        self.tableView.register(UINib.init(nibName: "IQCRuKuCell", bundle: nil), forCellReuseIdentifier: "iQCRuKuCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()
//        self.tableView.estimatedRowHeight = 60
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        self.setAttributedString(text: "摄像头对准收货单二维码，\n点击扫描")//设置中间字颜色
        
        self.textField.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMaterialArrivedOrderDetailVo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IQCRuKuCell = tableView.dequeueReusableCell(withIdentifier: "iQCRuKuCell", for: indexPath) as! IQCRuKuCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let materialArrivedOrderDetailVo = self.arrayMaterialArrivedOrderDetailVo[indexPath.row]
        cell.label0.text = materialArrivedOrderDetailVo.materialCode
        cell.label1.text = materialArrivedOrderDetailVo.materialText
        
        let imageName = materialArrivedOrderDetailVo.hasModelSequence.intValue == 1 ? "multiselect_selected":"multiselect_unchecked"
        cell.buttonCheck.setImage(UIImage.init(named: imageName), for: UIControl.State.normal)
        cell.buttonCheck.addTarget(self, action: #selector(buttonCheckClick(sender:)), for: UIControl.Event.touchUpInside)
        cell.buttonCheck.tag = indexPath.row
        cell.buttonCheck.isEnabled = self.initButtonCanClickWithStatus(status: materialArrivedOrderDetailVo.status.intValue)
        
        cell.label2.text = materialArrivedOrderDetailVo.planQuantity.stringValue
        
        cell.label3.text = self.initCellLabelWithStatus(status: materialArrivedOrderDetailVo.status.intValue)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let statusTemp = self.tableViewdidSelect(row: indexPath.row)
        if statusTemp != 999 {
            let vc = IQCJianYanJieGuoVC()
            vc.materialArrivedOrderDetailVo = self.arrayMaterialArrivedOrderDetailVo[indexPath.row].mutableCopy() as? MaterialArrivedOrderDetailVo
            vc.status = statusTemp
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func buttonCheckClick(sender: UIButton) {
        let materialArrivedOrderDetailVo = self.arrayMaterialArrivedOrderDetailVo[sender.tag]
        materialArrivedOrderDetailVo.hasModelSequence = materialArrivedOrderDetailVo.hasModelSequence.intValue == 1 ? NSNumber.init(value: 0) : NSNumber.init(value: 1)
        self.tableView.reloadRows(at: [IndexPath.init(row: sender.tag, section: 0)], with: UITableViewRowAnimation.none)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.request(result: textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
//    MARK: 扫描
    @IBAction func buttonScan(_ sender: Any) {
//        print("\(#function)");
        let saoYiSao = SaoYiSaoVC()
        saoYiSao.scanTitle = "扫描收货单号"
        saoYiSao.resultBlock = {(result: String!) -> () in
            self.request(result: result)
        }
        self.present(saoYiSao, animated: true, completion: nil)
    }
    
    func request(result: String?) {
        self.globalRequestStr = result
        _viewLoading.isHidden = false
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        let materialArrivedOrderDetailVo: MaterialArrivedOrderDetailVo = MaterialArrivedOrderDetailVo.init()
        materialArrivedOrderDetailVo.siteCode = siteCode
        materialArrivedOrderDetailVo.arrivedOrderNum = result
        mesPostEntityBean.entity = materialArrivedOrderDetailVo.mj_keyValues() as! [AnyHashable : Any]
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        
        HttpMamager.postRequest(withURLString: DYZ_materialArrivedOrder_materialArrivedOrderDetailList, parameters: dic, success: { (responseObjectModel : Any?) in
            let returnEntityBean: ReturnListBean = responseObjectModel as! ReturnListBean
            
            self._viewLoading.isHidden = true
            if returnEntityBean.status == "SUCCESS" {
                self.viewZhong0.isHidden = true
                self.viewBottom0.isHidden = true
                self.viewZhong1.isHidden = true
                self.viewBottom1.isHidden = true
                
                self.arrayMaterialArrivedOrderDetailVo = [];
                for value in returnEntityBean.list{
                    let materialArrivedOrderDetailVo:MaterialArrivedOrderDetailVo = MaterialArrivedOrderDetailVo.mj_object(withKeyValues: value)
                    
                    if materialArrivedOrderDetailVo.hasModelSequence == nil {
                        materialArrivedOrderDetailVo.hasModelSequence = NSNumber.init(value: 0)
                    }
                    
                    self.arrayMaterialArrivedOrderDetailVo.append(materialArrivedOrderDetailVo)
                    if let supplierText = materialArrivedOrderDetailVo.supplierText  {
                        self.labelGongYingShang.text = "供应商-"+supplierText
                    } else {
                        self.labelGongYingShang.text = "供应商-"
                    }
                    
                    self.textField.text = materialArrivedOrderDetailVo.arrivedOrderNum
                }
                
                if self.arrayMaterialArrivedOrderDetailVo.count == 0 {
                    self.viewZhong0.isHidden = false
                    self.viewBottom0.isHidden = false
                    
                    self.labelTitle.text = "IQC"
                } else {
                    self.viewZhong1.isHidden = false
                    self.viewBottom1.isHidden = false
                    
                    self.minStatus = self.getMinStatus(array: self.arrayMaterialArrivedOrderDetailVo)
                    self.labelTitle.text = self.initLabelTitleWithStatus(status: self.minStatus)
                    self.batchButton.setTitle(self.initBatchButtonTitleWithStatus(status: self.minStatus), for: UIControl.State.normal)
                    self.batchButton.isEnabled = self.setBatchButtonEnable(array: self.arrayMaterialArrivedOrderDetailVo, minStatus: self.minStatus)
                    if self.batchButton.isEnabled {
                        self.batchButton.backgroundColor = UIColor.white
                    } else {
                        self.batchButton.backgroundColor = UIColor.gray
                    }
                
                }
                
                self.tableView.reloadData()
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
            }
        }, fail: { (error : Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
    }
    
    // MARK: 获取最小状态
    func getMinStatus(array: [MaterialArrivedOrderDetailVo]) -> NSInteger {
        var status: NSInteger = 3
        for value in array {
            if status > value.status.intValue {
                status = value.status.intValue
            }
            if status == 0 {
                break
            }
        }
        return status
    }
    
    // MARK: 设置标题
    func initLabelTitleWithStatus(status: NSInteger) -> String {
        // IQC入库
        // IQCRECEIVING:IQC收货
        // IQCQC       :IQC质检
        // IQCINSTOCK  :IQC入库
        
        /**
        * 检验状态                                                一步                     二步                     三步
        *0:创建                          待收货             收货质检入库                                        收货
        *1:已收货                      待检验                                            收货质检                 质检
        *2:已质检                      待入库                                               入库                     入库
        *3:已入库                      已入库                  入库                      入库                     入库
        * */
        
        var str: String!
        if GlobalSettingManager.share().iQCPattern == 1 {
            if status == 0 || status == 1 || status == 2 {
                str = "收货质检入库"
            } else if status == 3 {
                str = "入库"
            }
        } else if GlobalSettingManager.share().iQCPattern == 2 {
            if status == 0 || status == 1 {
                str = "收货质检"
            } else if status == 2 {
                str = "入库"
            } else if status == 3 {
                str = "入库"
            }
        } else if GlobalSettingManager.share().iQCPattern == 3 {
            if status == 0 {
                str = "收货"
            } else if status == 1 {
                str = "质检"
            } else if status == 2 {
                str = "入库"
            } else if status == 3 {
                str = "入库"
            }
        }
        return str
    }
    

    // MARK: 设置Cell状态
    func initCellLabelWithStatus(status: NSInteger) -> String {
        // IQC入库
        // IQCRECEIVING:IQC收货
        // IQCQC       :IQC质检
        // IQCINSTOCK  :IQC入库
        
        /**
        * 检验状态                                                一步                     二步                     三步
        *0:创建                          待收货                                                                         待收货
        *1:已收货                      待检验                                             待检验                  待检验
        *2:已质检                      待入库                 待入库                 待入库                  待入库
        *3:已入库                      已入库                 已入库                 已入库                  已入库
        * */
        var str: String!
        if GlobalSettingManager.share().iQCPattern == 1 {
            if status == 0 || status == 1 || status == 2 {
                str = "待入库"
            } else if status == 3 {
                str = "已入库"
            }
        } else if GlobalSettingManager.share().iQCPattern == 2 {
            if status == 0 || status == 1 {
                str = "待检验"
            } else if status == 2 {
                str = "待入库"
            } else if status == 3 {
                str = "已入库"
            }
        } else if GlobalSettingManager.share().iQCPattern == 3 {
            if status == 0 {
                str = "待收货"
            } else if status == 1 {
                str = "待检验"
            } else if status == 2 {
                str = "待入库"
            } else if status == 3 {
                str = "已入库"
            }
        }
        return str
    }
    
    func initButtonCanClickWithStatus(status: NSInteger) -> Bool {
        var isCan: Bool!
        if GlobalSettingManager.share().iQCPattern == 1 {
            if status == 0 || status == 1 || status == 2 {
                isCan = true
            } else if status == 3 {
                isCan = false
            }
        } else if GlobalSettingManager.share().iQCPattern == 2 {
            if status == 0 || status == 1 {
                isCan = false
            } else if status == 2 {
                isCan = true
            } else if status == 3 {
                isCan = false
            }
        } else if GlobalSettingManager.share().iQCPattern == 3 {
            if status == 0 {
                isCan = false
            } else if status == 1 {
                isCan = false
            } else if status == 2 {
                isCan = true
            } else if status == 3 {
                isCan = false
            }
        }
        return isCan
    }
    
    
    // MARK: 设置批量操作按钮 文字
    func initBatchButtonTitleWithStatus(status: NSInteger) -> String {
        // IQC入库
        // IQCRECEIVING:IQC收货
        // IQCQC       :IQC质检
        // IQCINSTOCK  :IQC入库
        
        /**
        * 检验状态                                                一步                     二步                     三步
        *0:创建                          待收货                                                                         批量收货
        *1:已收货                      待检验                                            批量质检               批量质检
        *2:已质检                      待入库               批量入库               批量入库               批量入库
        *3:已入库                      已入库               批量入库               批量入库               批量入库
        * */
        var str: String!
        if GlobalSettingManager.share().iQCPattern == 1 {
            if status == 0 || status == 1 || status == 2 {
                str = "批量入库"
            } else if status == 3 {
                str = "批量入库"
            }
        } else if GlobalSettingManager.share().iQCPattern == 2 {
            if status == 0 || status == 1 {
                str = "批量质检"
            } else if status == 2 {
                str = "批量入库"
            } else if status == 3 {
                str = "批量入库"
            }
        } else if GlobalSettingManager.share().iQCPattern == 3 {
            if status == 0 {
                str = "批量收货"
            } else if status == 1 {
                str = "批量质检"
            } else if status == 2 {
                str = "批量入库"
            } else if status == 3 {
                str = "批量入库"
            }
        }
        return str
    }
    
    
    // MARK: 设置批量操作按钮 是否可操作
    func setBatchButtonEnable(array:[MaterialArrivedOrderDetailVo], minStatus: NSInteger) -> Bool {
        var flag = false
        for value in array {
            if minStatus != value.status.intValue {
                // 只要有一种状态不等于最小状态，就说明有不一样的，所以就没法操作
                flag = true
                break
            }
        }
        if flag == true {
            return false;
        }
        
        var enbale = false
        
        // IQC入库
        // IQCRECEIVING:IQC收货
        // IQCQC       :IQC质检
        // IQCINSTOCK  :IQC入库
        if GlobalSettingManager.share().iQCPattern == 1 {
            if minStatus == 0 || minStatus == 1 || minStatus == 2 {
                //批量入库
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCRECEIVING") && GlobalSettingManager.share().userRoleAuthorities.contains("IQCQC") && GlobalSettingManager.share().userRoleAuthorities.contains("IQCINSTOCK") {
                    enbale = true
                } else {
                    enbale = false
                }
            } else if minStatus == 3 {
                enbale = false
            }
        } else if GlobalSettingManager.share().iQCPattern == 2 {
            if minStatus == 0 || minStatus == 1 {
                //批量质检
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCRECEIVING") && GlobalSettingManager.share().userRoleAuthorities.contains("IQCQC") {
                    enbale = true
                } else {
                    enbale = false
                }
            } else if minStatus == 2 {
                //批量入库
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCINSTOCK") {
                    enbale = true
                } else {
                    enbale = false
                }
            } else if minStatus == 3 {
                enbale = false
            }
        } else if GlobalSettingManager.share().iQCPattern == 3 {
            if minStatus == 0 {
                //批量收货
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCRECEIVING") {
                    enbale = true
                } else {
                    enbale = false
                }
            } else if minStatus == 1 {
                //批量质检
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCQC") {
                    enbale = true
                } else {
                    enbale = false
                }
            } else if minStatus == 2 {
                //批量入库
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCINSTOCK") {
                    enbale = true
                } else {
                    enbale = false
                }
            } else if minStatus == 3 {
                enbale = false
            }
        }
        return enbale
    }
    
    
//    MARK: 批量操作按钮 点击
    @IBAction func buttonCommit(_ sender: Any) {
        var statusTemp = 333
        if GlobalSettingManager.share().iQCPattern == 1 {
            if minStatus == 0 || minStatus == 1 || minStatus == 2 {
                //批量入库
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCRECEIVING") && GlobalSettingManager.share().userRoleAuthorities.contains("IQCQC") && GlobalSettingManager.share().userRoleAuthorities.contains("IQCINSTOCK") {
                    statusTemp = 333
                }
            }
        } else if GlobalSettingManager.share().iQCPattern == 2 {
            if minStatus == 0 || minStatus == 1 {
                //批量质检
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCRECEIVING") && GlobalSettingManager.share().userRoleAuthorities.contains("IQCQC") {
                    statusTemp = 22
                }
            } else if minStatus == 2 {
                //批量入库
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCINSTOCK") {
                    statusTemp = 3
                }
            }
        } else if GlobalSettingManager.share().iQCPattern == 3 {
            if minStatus == 0 {
                //批量收货
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCRECEIVING") {
                    statusTemp = 1
                }
            } else if minStatus == 1 {
                //批量质检
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCQC") {
                    statusTemp = 2
                }
            } else if minStatus == 2 {
                //批量入库
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCINSTOCK") {
                    statusTemp = 3
                }
            }
        }
        
        
        
        
        _viewLoading.isHidden = false
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean()
        
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel.tpfUser)
        let userCode = tpfUser?.userCode
        
        
        
        if statusTemp == 1 {
            // 收货
            for value in self.arrayMaterialArrivedOrderDetailVo {
                value.receivedQuantity = value.planQuantity
            }
        } else if statusTemp == 2 {
            // 质检
            for value in self.arrayMaterialArrivedOrderDetailVo {
                value.qualifiedQuantity = value.receivedQuantity
            }
        } else if statusTemp == 22 {
            // 收货质检
            for value in self.arrayMaterialArrivedOrderDetailVo {
                value.receivedQuantity = value.planQuantity
                value.qualifiedQuantity = value.receivedQuantity
            }
        } else if statusTemp == 3 {
            // 入库
            for value in self.arrayMaterialArrivedOrderDetailVo {
                let double0: Double = value.qualifiedQuantity.doubleValue + value.concessionQuantity.doubleValue
                value.inStockQuantity = NSNumber.init(value: double0)
            }
        } else if statusTemp == 333 {
            // 收货质检入库
            for value in self.arrayMaterialArrivedOrderDetailVo {
                value.receivedQuantity = value.planQuantity
                value.inStockQuantity = value.planQuantity
                value.qualifiedQuantity = value.planQuantity
            }
        }
        
        
        for value in self.arrayMaterialArrivedOrderDetailVo {
            value.receivedUser = userCode
            value.status = NSNumber.init(value: statusTemp)
        }
        
        
        mesPostEntityBean.entity = self.arrayMaterialArrivedOrderDetailVo
        
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dic, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        print(JSONString)

        HttpMamager.postRequest(withURLString: DYZ_materialArrivedOrder_updateMaterialArrivedOrderDetails, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnMsgBean =  responseObjectModel as! ReturnMsgBean
            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {
                MyAlertCenter.default().postAlert(withMessage: "提交成功")
                self.navigationController?.popViewController(animated: true)
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }

        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnMsgBean"))
    }
    
    //MARK: tableView点击每一行，权限判断
    func tableViewdidSelect(row: Int) -> Int{
        var statusTemp = 999
        let value = self.arrayMaterialArrivedOrderDetailVo[row]
        if GlobalSettingManager.share().iQCPattern == 1 {
            if value.status == 0 || value.status == 1 || value.status == 2 {
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCRECEIVING") && GlobalSettingManager.share().userRoleAuthorities.contains("IQCQC") && GlobalSettingManager.share().userRoleAuthorities.contains("IQCINSTOCK") {
                    statusTemp = 0
                } else {
                    MyAlertCenter.default()?.postAlert(withMessage: "没有”收货质检入库“权限")
                }
            } else if value.status == 3 {
                //已入库 不让点击
            }
        } else if GlobalSettingManager.share().iQCPattern == 2 {
            if value.status == 0 || value.status == 1 {
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCRECEIVING") && GlobalSettingManager.share().userRoleAuthorities.contains("IQCQC") {
                   statusTemp = 1
                } else {
                    MyAlertCenter.default()?.postAlert(withMessage: "没有”收货质检“权限")
                }
            } else if value.status == 2 {
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCINSTOCK") {
                   statusTemp = 2
                } else {
                    MyAlertCenter.default()?.postAlert(withMessage: "没有”入库“权限")
                }
            } else if value.status == 3 {
               //已入库 不让点击
            }
        } else if GlobalSettingManager.share().iQCPattern == 3 {
            if value.status == 0 {
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCRECEIVING") {
                    statusTemp = 3
                } else {
                    MyAlertCenter.default()?.postAlert(withMessage: "没有”收货“权限")
                }
            } else if value.status == 1 {
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCQC") {
                    statusTemp = 4
                } else {
                    MyAlertCenter.default()?.postAlert(withMessage: "没有”质检“权限")
                }
            } else if value.status == 2 {
                if GlobalSettingManager.share().userRoleAuthorities.contains("IQCINSTOCK") {
                   statusTemp = 5
                } else {
                    MyAlertCenter.default()?.postAlert(withMessage: "没有”入库“权限")
                }
            } else if value.status == 3 {
                //已入库 不让点击
            }
        }
        
        return statusTemp
    }
    
    func setAttributedString(text: String) {
        let attributeStr: NSMutableAttributedString = NSMutableAttributedString.init(string: text)
        attributeStr.addAttribute(NSAttributedStringKey.foregroundColor, value: colorRGB(r: 0, g: 122, b: 254), range: NSMakeRange(5, text.count - 9))
        self.label.attributedText = attributeStr
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
