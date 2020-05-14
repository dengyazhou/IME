//
//  WeiWaiSelectProcessVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class WeiWaiSelectSupplierVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var operationOutsourcingOrderVo: OperationOutsourcingOrderVo!
    
    var dataArray: Array<OperationOutsourcingSourceVo> = []
    
    var dataSupplierVo: Array<SupplierVo> = []
    
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    
    
    
    
    
    private var _viewLoading: UIView!
    
    
    
    @IBOutlet weak var labelTitle2: UILabel!
    @IBOutlet weak var labelTitle3: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelSupplierText: UILabel!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: 0, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        self.tableView.register(UINib.init(nibName: "WeiWaiSelectSupplierCell", bundle: nil), forCellReuseIdentifier: "weiWaiSelectSupplierCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        self.request()
    
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSupplierVo.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeiWaiSelectSupplierCell = tableView.dequeueReusableCell(withIdentifier: "weiWaiSelectSupplierCell", for: indexPath) as! WeiWaiSelectSupplierCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        
        let model = self.dataSupplierVo[indexPath.row]

        cell.label1.text = model.supplierCode
        cell.label2.text = model.supplierText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataSupplierVo[indexPath.row]
        let cell: WeiWaiSelectSupplierCell = tableView.cellForRow(at: indexPath) as! WeiWaiSelectSupplierCell
        
        
        var add = 0
        for item in self.dataSupplierVo {
            if item.isSelect {
                let cellTemp: WeiWaiSelectSupplierCell = tableView.cellForRow(at: IndexPath.init(row: add, section: 0)) as! WeiWaiSelectSupplierCell
                cellTemp.viewGb.backgroundColor = UIColor.white
            }
            add+=1
            item.isSelect = false;
        }
        
        model.isSelect = true
        if model.isSelect {
            cell.viewGb.backgroundColor = UIColor.gray
        }
    }
    

    
    @IBAction func buttonCommite(_ sender: Any) {
        _viewLoading.isHidden = false
        var model: SupplierVo?
        for item in self.dataSupplierVo {
            if item.isSelect {
                model = item
            }
        }
        if model == nil {
            MyAlertCenter.default().postAlert(withMessage: "请选择供应商")
            return
        }
        
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        
        var operationOutsourcingOrderVo = OperationOutsourcingOrderVo()
        operationOutsourcingOrderVo.siteCode = model?.siteCode
        operationOutsourcingOrderVo.supplierCode = model!.supplierCode
        
        var dataArrayTemp = NSMutableArray.init()
        
        
        for item in self.dataArray {
            var operationOutsourcingOrderItemVo = OperationOutsourcingOrderItemVo()
            operationOutsourcingOrderItemVo.siteCode = item.siteCode
            operationOutsourcingOrderItemVo.idDYZ = item.idDYZ
            operationOutsourcingOrderItemVo.projectNum = item.projectNum
            operationOutsourcingOrderItemVo.productionOrderNum = item.productionOrderNum
            operationOutsourcingOrderItemVo.productionControlNum = item.productionControlNum
            operationOutsourcingOrderItemVo.materialCode = item.materialCode
            operationOutsourcingOrderItemVo.materialUnitCode = item.materialUnitCode
            operationOutsourcingOrderItemVo.processOperationId = item.processOperationId
            operationOutsourcingOrderItemVo.operationCode = item.operationCode
            operationOutsourcingOrderItemVo.orderQuantity = item.orderQuantity
            operationOutsourcingOrderItemVo.sendQuantity = item.sendQuantity
            operationOutsourcingOrderItemVo.lastFlag = item.lastFlag

            dataArrayTemp.add(operationOutsourcingOrderItemVo)
        }
        
        operationOutsourcingOrderVo.operationOutsourcingOrderItemList = dataArrayTemp
        
        mesPostEntityBean.entity = operationOutsourcingOrderVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        
        
        HttpMamager.postRequest(withURLString: DYZ_mes_operationOutsourcing_saveOperationOutsourcingOrder, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean

            
            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {
                MyAlertCenter.default().postAlert(withMessage: "创建成功")
                for temp in (self.navigationController?.viewControllers)! {
                    if temp is TpfMaiViewController {
                        self.navigationController?.popToViewController(temp, animated: true)
                        return
                    }
                }
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
            
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnMsgBean"))
    }

    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func request() {
        _viewLoading.isHidden = false
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        let supplierVo: SupplierVo = SupplierVo.init()
        supplierVo.siteCode = siteCode
        
        mesPostEntityBean.entity = supplierVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        print(dic)
        
        HttpMamager.postRequest(withURLString: DYZ_mes_supplier_getSupplierVoList, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnListBean = responseObjectModel as! ReturnListBean
            
            self._viewLoading.isHidden = true
            if returnListBean.status == "SUCCESS" {
                for item in returnListBean.list {
                    let model = SupplierVo.mj_object(withKeyValues: item);
                    model?.isSelect = false
                    self.dataSupplierVo.append(model!)
                }
                self.tableView.reloadData()
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
            }
            
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
        
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
