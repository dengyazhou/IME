//
//  ScanMTuZhiVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/4.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class ScanMTuZhiVC: UIViewController,UITextFieldDelegate {
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    var _viewLoading: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelEmployeeNum: UILabel!
    @IBOutlet weak var labelworkUnitText: UILabel!
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    
    
    
    var _personnelVo: PersonnelVo!
    var _workUnitVo: WorkUnitVo!
    var _index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW-34)/2, y: 180, width: 34, height: 34));
        self.view.addSubview(_viewLoading);
        _viewLoading.isHidden = true
        
        self.label.attributedText = toolSwiftAttributedString(text: "摄像头对准图纸二维码/工序流转卡，\n点击扫描")
        
        self.labelEmployeeNum.text = "员工："+self._personnelVo.personnelName
        self.labelworkUnitText.text = "生产单元："+self._workUnitVo.workUnitText
        self.textField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.request(result: textField.text)
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
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
        
        let operationVo = self._workUnitVo.operationVos[self._index] as! OperationVo
        
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
            if returnEntityBean.status == "SUCCESS" {
                if batchWorkVo?.batchWorkNum != nil {
                    print("存在")
                    let vc = ZuoYeViewController.init()
                    vc.batchWorkNum = batchWorkVo?.batchWorkNum
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    print("不存在")
                    let vc = ScanMultiScanVC.init()
                    vc._personnelVo = self._personnelVo
                    vc._workUnitVo = self._workUnitVo
                    vc._index = self._index
                    vc._batchWorkVos.append(batchWorkVo!)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnEntityBean"))
        
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
        let loginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel?.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        let personnelCode = DatabaseTool.t_TpfPWTableGetPersonnelCode(withSiteCode: siteCode)
        let workUnitCode = DatabaseTool.t_TpfPWTableGetWorkUnitCode(withSiteCode: siteCode)
        
        if ((!(personnelCode == "(null)"))&&(!(workUnitCode == "(null)"))) {
            for temp in (self.navigationController?.viewControllers)! {
                if temp is MultiZuoYeDanYuanLieBiao {
                    self.navigationController?.popToViewController(temp, animated: true)
                    return
                }
            }
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
                if temp is MultiZuoYeDanYuanLieBiao {
                    self.navigationController?.popToViewController(temp, animated: true)
                    return
                }
            }
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
