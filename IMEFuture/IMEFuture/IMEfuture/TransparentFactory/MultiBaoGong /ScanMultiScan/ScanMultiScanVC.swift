//
//  ScanMultiScanVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/4.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class ScanMultiScanVC: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    private let _height_NavBar = Height_NavBar!
    private let _height_BottomBar = Height_BottomBar!
    var _viewLoading: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scanBaoGongCountLabel: UILabel!
    
    var _personnelVo: PersonnelVo!
    var _workUnitVo: WorkUnitVo!
    var _index: Int!
    var _batchWorkVos: [BatchWorkVo]! = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scanBaoGongCountLabel.text = "已扫描\(self._batchWorkVos.count)个作业单"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar
        self.heightBottomBar.constant = _height_BottomBar
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW-34)/2, y: 180, width: 34, height: 34));
        self.view.addSubview(_viewLoading);
        _viewLoading.isHidden = true
        
        self.textField.delegate = self

        self.tableView.register(UINib.init(nibName: "ScanMScanHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "scanMScanHeader")
        self.tableView.register(UINib.init(nibName: "ScanMScanCell", bundle: nil), forCellReuseIdentifier: "scanMScanCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView.init()
        

        addFlag(batchWorkVo: _batchWorkVos[0]) //给第一条记录加标记
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "scanMScanHeader") as! ScanMScanHeader
        
        return view
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _batchWorkVos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scanMScanCell", for: indexPath) as! ScanMScanCell
        cell.selectionStyle = .none
        
        let batchWorkVo = _batchWorkVos[indexPath.row]
        
        cell.label.text = batchWorkVo.productionControlNum
        
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(buttonDelete(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func buttonDelete(sender: UIButton) {
        let vc = UIAlertController.init(title: nil, message: "确认要删除该生产作业单吗?", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "确定", style: .default) { (act: UIAlertAction) in
            print(sender.tag)
            self._batchWorkVos.remove(at: sender.tag)
            self.tableView.reloadData()
            self.scanBaoGongCountLabel.text = "已扫描\(self._batchWorkVos.count)个作业单"
        }
        let action1 = UIAlertAction.init(title: "取消", style: .default, handler: nil)
        vc.addAction(action)
        vc.addAction(action1)
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        request(result: textField.text)
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }

    
    
    //MARK:扫描
    @IBAction func buttonScan(_ sender: Any) {
        let saoYiSao = SaoYiSaoVC.init()
        saoYiSao.scanTitle = "扫描图纸"
        saoYiSao.resultBlock = {(result: String?) -> Void in
            if let productionControlNum = result {
                self.request(result: productionControlNum)
            } else {
                MyAlertCenter.default().postAlert(withMessage: "请扫描图纸")
            }
        }
        self.present(saoYiSao, animated: true, completion: nil)
    }
    
    func request(result: String?) {
        _viewLoading.isHidden = false
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let operationVo = self._workUnitVo.operationVos[_index] as! OperationVo
        
        let mesPostEntityBean = MesPostEntityBean.init()
        let batchWorkVo = BatchWorkVo.init()
        batchWorkVo.siteCode = siteCode
        batchWorkVo.operationCode = operationVo.operationCode
        batchWorkVo.workUnitCode = self._workUnitVo.workUnitCode
        batchWorkVo.confirmUser = self._personnelVo.personnelCode
        batchWorkVo.productionControlNum = result
        mesPostEntityBean.entity = batchWorkVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_batchWork_chartScan, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnEntityBean = responseObjectModel as! ReturnEntityBean
            self._viewLoading.isHidden = true
            let batchWorkVo = BatchWorkVo.mj_object(withKeyValues: returnEntityBean.entity)
            
            if self._batchWorkVos.count == 0 {
                if batchWorkVo?.batchWorkNum != nil {
                    print("存在")
                    let vc = ZuoYeViewController.init()
                    vc.batchWorkNum = batchWorkVo?.batchWorkNum
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.addArray(returnEntityBean: returnEntityBean, batchWorkVo: batchWorkVo)
                }
            } else {
                if batchWorkVo?.batchWorkNum != nil {
                    print("存在")
                    MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
                } else {
                    self.addArray(returnEntityBean: returnEntityBean, batchWorkVo: batchWorkVo)
                }
            }
            self.scanBaoGongCountLabel.text = "已扫描\(self._batchWorkVos.count)个作业单"
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnEntityBean"))
    }
    
    func addArray(returnEntityBean: ReturnEntityBean!, batchWorkVo: BatchWorkVo?) {
        if returnEntityBean.status == "SUCCESS" {
            var aa = false
            for bat in self._batchWorkVos {
                if bat.productionControlNum == batchWorkVo?.productionControlNum {
                    aa = true
                }
            }
            if !aa {
                addFlag(batchWorkVo: batchWorkVo) //请选择报工记录类型
                self._batchWorkVos.append(batchWorkVo!)
                self.tableView.reloadData()
            } else {
                MyAlertCenter.default().postAlert(withMessage: "重复扫描")
            }
        } else {
            MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
        }
    }
    
    func addFlag(batchWorkVo: BatchWorkVo?) {
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean = MesPostEntityBean.init()
        let reportWorkProductionOrderConfirmVo = ReportWorkProductionOrderConfirmVo.init()
        reportWorkProductionOrderConfirmVo.siteCode = siteCode
        reportWorkProductionOrderConfirmVo.productionControlNum = batchWorkVo?.productionControlNum
        reportWorkProductionOrderConfirmVo.operationCode = batchWorkVo?.operationCode
        var array: NSMutableArray = NSMutableArray.init(object: reportWorkProductionOrderConfirmVo)
        mesPostEntityBean.entity = array.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_mes_productionOrderConfirm_validateWorkRecordType, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel) in
            let returnListBean = responseObjectModel as! ReturnListBean
            if returnListBean.status == "SUCCESS" {
                if returnListBean.list.count > 0 {
                    let temp = ReportWorkProductionOrderConfirmVo.mj_object(withKeyValues: returnListBean.list[0])
                    if (temp?.chooseWorkRecordTypeFlag != nil) {
                        if temp?.chooseWorkRecordTypeFlag.intValue == 1 {
                            let alertController = UIAlertController.init(title: "请选择报工记录类型", message: nil, preferredStyle: .actionSheet)
                            let action = UIAlertAction.init(title: "正常生产", style: .default, handler: { (action) in
                                batchWorkVo?.workRecordTypeDyz = NSNumber.init(value: 0)
                            })
                            let action1 = UIAlertAction.init(title: "返工返修", style: .default, handler: { (action) in
                                batchWorkVo?.workRecordTypeDyz = NSNumber.init(value: 1)
                            })
                            alertController.addAction(action)
                            alertController.addAction(action1)
                            self.present(alertController, animated: true, completion: nil)
                        } else {
                            //正常生产
                            batchWorkVo?.workRecordTypeDyz = NSNumber.init(value: 0)
                        }
                    }
                }
            }
        }, fail: { (error) in
            
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
    }
    
    //MARK:扫描完成
    @IBAction func buttonScanComplete(_ sender: Any) {
        _viewLoading.isHidden = false
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let operationVo = self._workUnitVo.operationVos[_index] as! OperationVo
        
        let mesPostEntityBean = MesPostEntityBean.init()
        let batchWorkVo = BatchWorkVo.init()
        batchWorkVo.siteCode = siteCode
        batchWorkVo.operationCode = operationVo.operationCode
        batchWorkVo.workUnitCode = self._workUnitVo.workUnitCode
        batchWorkVo.confirmUser = self._personnelVo.personnelCode

        batchWorkVo.batchWorkItemList = []
        for bat in _batchWorkVos {
            let workTimeLogVo = WorkTimeLogVo.init()
            workTimeLogVo.productionControlNum = bat.productionControlNum
            workTimeLogVo.workRecordType = bat.workRecordTypeDyz
            batchWorkVo.batchWorkItemList.add(workTimeLogVo)
        }

        batchWorkVo.batchWorkType = NSNumber.init(value: 1)
        mesPostEntityBean.entity = batchWorkVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        print(dic)
        
        HttpMamager.postRequest(withURLString: DYZ_batchWork_createBatchWork, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean
            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {
                let vc = ZuoYeViewController.init()
                vc.batchWorkNum = returnMsgBean.returnMsg
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnMsgBean"))
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
