//
//  YingLiaoRuKuViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/16.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class LingliaoCreateVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var arrayReqMaterialVo: [ReqMaterialVo]! = []
    var arrayWarehouseVo: [WarehouseVo]! = []
    var warehouseInOperator: String?
    var requisitionCode: String? //领料单号
    
    var warehouseCode: String? //仓库编号
    
    
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
    @IBOutlet weak var tableViewWarehouse: UITableView!
    
    @IBOutlet weak var labelWarehouseName: UILabel!
    
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
        
        self.tableView.register(UINib.init(nibName: "LingliaoCreateCell", bundle: nil), forCellReuseIdentifier: "lingliaoCreateCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()
        self.tableView.tag = 100
        
        self.tableViewWarehouse.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableViewWarehouse.delegate = self
        self.tableViewWarehouse.dataSource = self
        self.tableViewWarehouse.tableFooterView = UIView()
        self.tableViewWarehouse.tag = 101
        self.tableViewWarehouse.isHidden = true
        
        self.tableViewWarehouse.layer.borderWidth = 1
        self.tableViewWarehouse.layer.borderColor = colorRGB(r: 221, g: 221, b: 221).cgColor
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        self.setAttributedString(text: "摄像头对准领料单二维码，\n点击扫描")//设置中间字颜色
        
        self.textField.delegate = self
        
        self.request_warehouse_getWarehouseList()
        
    }
    
    //MARK: 点击仓库名 button
    @IBAction func buttonWarehouseClick(_ sender: Any) {
        self.tableViewWarehouse.isHidden = false
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 100 {
            return 77
        } else {
            return 44
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 100 {
            return self.arrayReqMaterialVo.count
        } else {
            return self.arrayWarehouseVo.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 100 {
            let cell: LingliaoCreateCell = tableView.dequeueReusableCell(withIdentifier: "lingliaoCreateCell", for: indexPath) as! LingliaoCreateCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            let reqMaterialVo = self.arrayReqMaterialVo[indexPath.row]
                        
            if reqMaterialVo.isSelect.intValue == 0 {
                 cell.imageView1?.image = UIImage(named: "multiselect_unchecked")
            } else {
                cell.imageView1?.image = UIImage(named: "multiselect_selected")
            }

            cell.label0.text = reqMaterialVo.materialCode
            cell.label1.text = reqMaterialVo.materialText
            cell.label2.text = reqMaterialVo.inventory.stringValue
            cell.label3.text = reqMaterialVo.planNum.stringValue

            cell.textField.text = reqMaterialVo.num.stringValue

            cell.textField.addTarget(self, action: #selector(textFieldClick(sender:)), for: UIControlEvents.editingChanged)
            cell.textField.tag = indexPath.row
            cell.textField.inputAccessoryView = self.addToolbar()
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            let model = self.arrayWarehouseVo[indexPath.row]
            cell.textLabel?.text = (model.warehouseText.count==0) ? "--" : model.warehouseText
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if tableView.tag == 100 {
            let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "删除") { (action:UITableViewRowAction, index:IndexPath) in
                
                
                self.arrayReqMaterialVo.remove(at: index.row)
                tableView.deleteRows(at: [index], with: UITableViewRowAnimation.none)
//                tableView.reloadData()
            }
            return [deleteAction]
        } else {
            return []
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 100 {//勾选，刷新
            let model = self.arrayReqMaterialVo[indexPath.row]
            model.isSelect = model.isSelect.intValue==0 ? NSNumber.init(value: 1) : NSNumber.init(value: 0);
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        } else {//调接口
            tableView.isHidden = true
            self.warehouseCode = self.arrayWarehouseVo[indexPath.row].warehouseCode
            self.labelWarehouseName.text = self.arrayWarehouseVo[indexPath.row].warehouseText
            self.request_refresh_requisition_selectReqMaterialByProjectForCreateRequisition()
        }
    }
    
    @objc func textFieldClick(sender: UITextField) {
        let reqMaterialVo = self.arrayReqMaterialVo[sender.tag]
        if sender.text?.count ?? 0 > 0 {
            reqMaterialVo.num = NSNumber.init(value: Double(sender.text!)!)
//            if reqOutboundVo.outNum.doubleValue > reqOutboundVo.reqNum.doubleValue {
//                MyAlertCenter.default().postAlert(withMessage: "出库数不能大于待入库数")
//                sender.text = reqOutboundVo.reqNum.stringValue
//                reqOutboundVo.outNum = NSNumber.init(value: Double(sender.text!)!)
//            }
        } else {
//            reqMaterialVo.num = nil
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count == 0 {
            MyAlertCenter.default()?.postAlert(withMessage: "请输入领料单号")
            textField.resignFirstResponder()
            return false
        }
        self.request_requisition_selectReqMaterialByProjectForCreateRequisition(result: textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
//    MARK: 扫描
    @IBAction func buttonScan(_ sender: Any) {
        let saoYiSao = SaoYiSaoVC()
        saoYiSao.scanTitle = "扫描领料单号"
        saoYiSao.resultBlock = {(result: String!) -> () in
            self.request_requisition_selectReqMaterialByProjectForCreateRequisition(result: result)
        }
        self.present(saoYiSao, animated: true, completion: nil)
    }
    
    // MARK: 查询仓库列表
    func request_warehouse_getWarehouseList() {
        _viewLoading.isHidden = false
        let loginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel?.tpfUser)
        let siteCode = tpfUser?.siteCode

        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean()
        let warehouseVo = WarehouseVo.init()
        warehouseVo.siteCode = siteCode
        mesPostEntityBean.entity = warehouseVo.mj_keyValues()

        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]

        HttpMamager.postRequest(withURLString: DYZ_warehouse_getWarehouseList, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnListBean: ReturnListBean = responseObjectModel as! ReturnListBean
            self._viewLoading.isHidden = true
            if returnListBean.status == "SUCCESS" {
                self.arrayWarehouseVo = [];
                for value in returnListBean.list{
                    let warehouseVo :WarehouseVo = WarehouseVo.mj_object(withKeyValues: value)
                    self.arrayWarehouseVo.append(warehouseVo)
                }
                if self.arrayWarehouseVo.count == 0 {
                    MyAlertCenter.default().postAlert(withMessage: "无仓库！！！")
                    return
                }
                self.warehouseCode = self.arrayWarehouseVo.first?.warehouseCode
                self.labelWarehouseName.text = self.arrayWarehouseVo.first?.warehouseText
                
                self.tableViewWarehouse.reloadData()
                self.request_requisition_selectReqMaterialByProjectForCreateRequisition(result: self.requisitionCode)
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
            }

        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
    }
    
    // MARK: 扫描 添加
    func request_requisition_selectReqMaterialByProjectForCreateRequisition(result: String?) {
        
        _viewLoading.isHidden = false
        let loginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel?.tpfUser)
        let siteCode = tpfUser?.siteCode
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean()
        let reqMaterialVo = ReqMaterialVo.init()
        reqMaterialVo.siteCode = siteCode
        if let warehouseCode = self.warehouseCode {
            reqMaterialVo.warehouseCode = warehouseCode
        }
        reqMaterialVo.productionControlNum = result!
        var array:[ReqMaterialVo] = []
        array.append(reqMaterialVo)
        mesPostEntityBean.entity = NSMutableArray.init(array: array).mj_keyValues()
        
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        
        HttpMamager.postRequest(withURLString: DYZ_requisition_selectReqMaterialByProjectForCreateRequisition, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnListBean: ReturnListBean = responseObjectModel as! ReturnListBean
            self._viewLoading.isHidden = true
            if returnListBean.status == "SUCCESS" {
                self.viewZhong0.isHidden = true
                self.viewBottom0.isHidden = true
                self.viewZhong1.isHidden = true
                self.viewBottom1.isHidden = true
                
                for value in returnListBean.list{
                    let model :ReqMaterialVo = ReqMaterialVo.mj_object(withKeyValues: value)
                    var isHave = true
                    for item in self.arrayReqMaterialVo {
                        if model.productionControlNum == item.productionControlNum {
                            isHave = false
                            break
                        }
                    }
                    if model.inventory.doubleValue > model.planNum.doubleValue {
                        model.num = model.planNum
                    } else {
                        model.num = model.inventory
                    }
                    
                    if isHave {
                        self.arrayReqMaterialVo.append(model)
                    }
                }
                
                if self.arrayReqMaterialVo.count == 0 {
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
            
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
    }
    
    // MARK: 换仓库 刷新
    func request_refresh_requisition_selectReqMaterialByProjectForCreateRequisition() {
        _viewLoading.isHidden = false
        let loginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel?.tpfUser)
        let siteCode = tpfUser?.siteCode
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean()
        let reqMaterialVo = ReqMaterialVo.init()
        reqMaterialVo.siteCode = siteCode
        
        var array:[ReqMaterialVo] = []
        for index in 0..<self.arrayReqMaterialVo.count {
            let model = ReqMaterialVo.init()
            if index == 0 {
                model.siteCode = siteCode
                if let warehouseCode = self.warehouseCode {
                    model.warehouseCode = warehouseCode
                } else {
                    MyAlertCenter.default()?.postAlert(withMessage: "没有仓库")
                    return
                }
            }
            model.productionControlNum = self.arrayReqMaterialVo[index].productionControlNum
            array.append(model)
        }
        mesPostEntityBean.entity = NSMutableArray.init(array: array).mj_keyValues()
        
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        
        HttpMamager.postRequest(withURLString: DYZ_requisition_selectReqMaterialByProjectForCreateRequisition, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnListBean: ReturnListBean = responseObjectModel as! ReturnListBean
            self._viewLoading.isHidden = true
            if returnListBean.status == "SUCCESS" {
                self.viewZhong0.isHidden = true
                self.viewBottom0.isHidden = true
                self.viewZhong1.isHidden = true
                self.viewBottom1.isHidden = true
                
                self.arrayReqMaterialVo = []
                for value in returnListBean.list{
                    let model :ReqMaterialVo = ReqMaterialVo.mj_object(withKeyValues: value)
                    if model.inventory.doubleValue > model.planNum.doubleValue {
                        model.num = model.planNum
                    } else {
                        model.num = model.inventory
                    }
                    self.arrayReqMaterialVo.append(model)
                }
                
                if self.arrayReqMaterialVo.count == 0 {
                    self.viewZhong0.isHidden = false
                    self.viewBottom0.isHidden = false
                } else {
                    self.viewZhong1.isHidden = false
                    self.viewBottom1.isHidden = false
                }
                
                self.tableView.reloadData()
            } else {
                self.arrayReqMaterialVo = []
                self.tableView.reloadData()
                MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
            }
            
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
    }
    
    
//    MARK:创建
    @IBAction func buttonCommit(_ sender: Any) {
        
        _viewLoading.isHidden = false
        let loginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel?.tpfUser)
        let siteCode = tpfUser?.siteCode
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean()
        let reqMaterialVo = ReqMaterialVo.init()
        reqMaterialVo.siteCode = siteCode
        
        var array:[ReqMaterialVo] = []
        for index in 0..<self.arrayReqMaterialVo.count {
            let model = ReqMaterialVo.init()
            let value = self.arrayReqMaterialVo[index]
            if index == 0 {
                model.siteCode = siteCode
                if let warehouseCode = self.warehouseCode {
                    model.warehouseCode = warehouseCode
                } else {
                    MyAlertCenter.default()?.postAlert(withMessage: "没有仓库")
                    return
                }
            }
            model.productionControlNum = value.productionControlNum
            model.projectNum = value.projectNum
            model.productionOrderNum = value.productionOrderNum
            model.materialCode = value.materialCode
            model.planNum = value.planNum
            model.num = value.num
        
            
            if value.isSelect.intValue == 1 {
                if model.num.intValue == 0 {
                    MyAlertCenter.default()?.postAlert(withMessage: "领料数不能为零")
                    _viewLoading.isHidden = true
                    return
                }
                array.append(model)
            }
        }
        mesPostEntityBean.entity = NSMutableArray.init(array: array).mj_keyValues()
        
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        
        HttpMamager.postRequest(withURLString: DYZ_requisition_createRequisition, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnMsgBean: ReturnMsgBean = responseObjectModel as! ReturnMsgBean
            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {
                self.createSuccess(returnMsg: returnMsgBean.returnMsg)
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
            
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnMsgBean"))
    }
    
    func createSuccess(returnMsg: String?) {
        let alertController = UIAlertController(title: "创建成功", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let action0 = UIAlertAction.init(title: "去领料", style: UIAlertActionStyle.default) { (action) in
            let vc = YingLiaoRuKuViewController()
            vc.requisitionCode = returnMsg
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let action1 = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
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
