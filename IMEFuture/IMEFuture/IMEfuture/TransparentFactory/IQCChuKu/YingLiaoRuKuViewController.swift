//
//  YingLiaoRuKuViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/16.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class YingLiaoRuKuViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var arrayReqOutboundVo: [ReqOutboundVo]! = []
    var warehouseInOperator: String?
    
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    
    private var _viewLoading: UIView!
    
    @IBOutlet weak var viewZhong0: UIView!
    @IBOutlet weak var viewZhong1: UIView!
    
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
        
//        self.tableView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "cell")
        self.tableView.register(UINib.init(nibName: "IQCChuKuCell", bundle: nil), forCellReuseIdentifier: "iQCChuKuCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()

        
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        self.setAttributedString(text: "摄像头对准领料单二维码，\n点击扫描")//设置中间字颜色
        
        self.textField.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayReqOutboundVo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IQCChuKuCell = tableView.dequeueReusableCell(withIdentifier: "iQCChuKuCell", for: indexPath) as! IQCChuKuCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let reqOutboundVo = self.arrayReqOutboundVo[indexPath.row]
        
        if let str = reqOutboundVo.productionControlNum  { //先判断是否存在(nil)，再判断是否为空字符串("")
            if str.count > 0 {
                cell.label0.text = str
            } else {
                cell.label0.text = "--"
            }
        } else {
            cell.label0.text = "--"
        }
        
        cell.label1.text = reqOutboundVo.materialText
        cell.label2.text = reqOutboundVo.reqNum.stringValue
        cell.label3.text = reqOutboundVo.quantity.stringValue
        
        if let outNum = reqOutboundVo.outNum {
            cell.textField.text = outNum.stringValue
        } else {
            cell.textField.text = nil
        }
    
        cell.textField.addTarget(self, action: #selector(textFieldClick(sender:)), for: UIControlEvents.editingChanged)
        cell.textField.tag = indexPath.row
        cell.textField.inputAccessoryView = self.addToolbar()
    
        return cell
    }
    
    @objc func textFieldClick(sender: UITextField) {
        let reqOutboundVo = self.arrayReqOutboundVo[sender.tag]
        if sender.text?.count ?? 0 > 0 {
            reqOutboundVo.outNum = NSNumber.init(value: Double(sender.text!)!)
            if reqOutboundVo.outNum.doubleValue > reqOutboundVo.reqNum.doubleValue {
                MyAlertCenter.default().postAlert(withMessage: "出库数不能大于待入库数")
                sender.text = reqOutboundVo.reqNum.stringValue
                reqOutboundVo.outNum = NSNumber.init(value: Double(sender.text!)!)
            }
        } else {
            reqOutboundVo.outNum = nil
        }
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
        saoYiSao.scanTitle = "扫描领料单号"
        saoYiSao.resultBlock = {(result: String!) -> () in
            self.request(result: result)
        }
        self.present(saoYiSao, animated: true, completion: nil)
    }
    
    func request(result: String?) {
        _viewLoading.isHidden = false
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        let reqOutboundVo: ReqOutboundVo = ReqOutboundVo.init()
        reqOutboundVo.siteCode = siteCode
        reqOutboundVo.requisitionCode = result
        mesPostEntityBean.entity = reqOutboundVo.mj_keyValues() as! [AnyHashable : Any]
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        
        HttpMamager.postRequest(withURLString: DYZ_reqOutbound_selectRequisitions, parameters: dic, success: { (responseObjectModel : Any?) in
            let returnListBean: ReturnListBean = responseObjectModel as! ReturnListBean
            
            print(returnListBean.mj_JSONString()!)
            
            self._viewLoading.isHidden = true
            if returnListBean.status == "SUCCESS" {
                self.viewZhong0.isHidden = true
                self.viewBottom0.isHidden = true
                self.viewZhong1.isHidden = true
                self.viewBottom1.isHidden = true
                
                self.arrayReqOutboundVo = [];
                for value in returnListBean.list{
                    let reqOutboundVo :ReqOutboundVo = ReqOutboundVo.mj_object(withKeyValues: value)
                    self.arrayReqOutboundVo.append(reqOutboundVo)
                    self.textField.text = reqOutboundVo.requisitionCode
                }
                
                if self.arrayReqOutboundVo.count == 0 {
                    self.viewZhong0.isHidden = false
                    self.viewBottom0.isHidden = false
                } else {
                    self.viewZhong1.isHidden = false
                    self.viewBottom1.isHidden = false
                }
                
                
                self.tableView.reloadData()
                
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
            }
        }, fail: { (error : Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
        
    }
    
//    MARK:提交
    @IBAction func buttonCommit(_ sender: Any) {
        _viewLoading.isHidden = false
        let loginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel?.tpfUser)
        let userCode = tpfUser?.userCode
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean()
        var arrayTemp: [ReqOutboundVo] = []
        for value in self.arrayReqOutboundVo {
            if let outNum = value.outNum {
                
            } else {
                value.outNum = value.reqNum
            }
            value.operator = userCode
            value.toWarehouseOperator = warehouseInOperator
            value.useReplaceableMaterial = NSNumber.init(value: 0)
            arrayTemp.append(value)
        }
        mesPostEntityBean.entity = arrayTemp
        
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        
        HttpMamager.postRequest(withURLString: DYZ_reqOutbound_saveReqOutbound, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnMsgBean =  responseObjectModel as! ReturnMsgBean
            self._viewLoading.isHidden = true
            if returnMsgBean.returnCode.intValue == -888 {
                self.secondKaiShi();
            } else {
                if returnMsgBean.status == "SUCCESS" {
                    MyAlertCenter.default().postAlert(withMessage: "提交成功")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
                }
            }
            
            
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnMsgBean"))
    }
    
    func secondKaiShi() {
        let alertController = UIAlertController(title: "主件库存不足,是否使用替用物料出库？", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let action0 = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (action) in
            self._viewLoading.isHidden = false
            let loginModel = DatabaseTool.getLoginModel()
            let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel?.tpfUser)
            let userCode = tpfUser?.userCode
            
            let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean()
            var arrayTemp: [ReqOutboundVo] = []
            for value in self.arrayReqOutboundVo {
                if let outNum = value.outNum {
                    
                } else {
                    value.outNum = value.reqNum
                }
                value.operator = userCode
                value.toWarehouseOperator = self.warehouseInOperator
                value.useReplaceableMaterial = NSNumber.init(value: 1)
                arrayTemp.append(value)
            }
            mesPostEntityBean.entity = arrayTemp
            
            let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
            
            HttpMamager.postRequest(withURLString: DYZ_reqOutbound_saveReqOutbound, parameters: dic, success: { (responseObjectModel: Any?) in
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
        let action1 = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(action0)
        alertController.addAction(action1)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func setAttributedString(text: String) {
        let attributeStr: NSMutableAttributedString = NSMutableAttributedString.init(string: text)
        attributeStr.addAttribute(NSAttributedStringKey.foregroundColor, value: colorRGB(r: 0, g: 122, b: 254), range: NSMakeRange(5, text.count - 9))
        self.label.attributedText = attributeStr
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
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: UITableViewRowAnimation.none)
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
