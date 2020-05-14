//
//  ScanMZuoYeDanYuanVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/3.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class ScanMZuoYeDanYuanVC: UIViewController, UITextFieldDelegate {
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    var _viewLoading: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelEmployeeNum: UILabel!
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    
    
    var _personnelVo: PersonnelVo!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let loginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel?.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        let workUnitCode = DatabaseTool.t_TpfPWTableGetWorkUnitCode(withSiteCode: siteCode)
        if !(workUnitCode! == "(null)") {
            NSLog("(null):存在");
            self.request(result: workUnitCode)
        } else {
            NSLog("(null):不存在");
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW-34)/2, y: 180, width: 34, height: 34));
        self.view.addSubview(_viewLoading);
        _viewLoading.isHidden = true
        
        self.label.attributedText = toolSwiftAttributedString(text: "摄像头对准作业单元二维码，\n点击扫描")
        
        self.labelEmployeeNum.text = "员工："+self._personnelVo.personnelName
        
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
    
    //MARK:扫描
    @IBAction func buttonScan(_ sender: Any) {
        let saoYiSao = SaoYiSaoVC.init()
        saoYiSao.scanTitle = "扫描作业单元"
        saoYiSao.resultBlock = {(result: String?) -> Void in
            let jsonData = result?.data(using: String.Encoding.utf8)
            let dic = try? JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyHashable : Any]
            if let a = dic {
                if let workUnitCode = a["workUnitCode"] as? String {
                    
                    let loginModel = DatabaseTool.getLoginModel()
                    let userBean = UserBean.mj_object(withKeyValues: loginModel?.ucenterUser)
                    let siteCode = userBean?.enterpriseInfo.serialNo
                    let workUnitCode1 = DatabaseTool.t_TpfPWTableGetWorkUnitCode(withSiteCode: siteCode)
                    if !(workUnitCode1! == "(null)") {
                        if workUnitCode1 != workUnitCode {
                            MyAlertCenter.default().postAlert(withMessage: "绑定作业单元和当前作业单元不一致")
                            return
                        }
                    } else {
                    
                    }
                    
                    self.request(result: workUnitCode)
                } else {
                    MyAlertCenter.default().postAlert(withMessage: "请扫描作业单元")
                }
            } else {
                MyAlertCenter.default().postAlert(withMessage: "请扫描作业单元")
            }
        }
        self.present(saoYiSao, animated: true, completion: nil)
    }
    
    func request(result: String?) {
        _viewLoading.isHidden = false
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean = MesPostEntityBean.init()
        let workUnitVo = WorkUnitVo.init()
        workUnitVo.siteCode = siteCode
        workUnitVo.workUnitCode = result
        mesPostEntityBean.entity = workUnitVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_batchWork_workUnitScan, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnEntityBean = responseObjectModel as! ReturnEntityBean
            self._viewLoading.isHidden = true
            let workUnitVo = WorkUnitVo.mj_object(withKeyValues: returnEntityBean.entity)
            if returnEntityBean.status == "SUCCESS" {
                if workUnitVo?.operationVos.count == 1 {
                    let vc = ScanMTuZhiVC.init()
                    vc._personnelVo = self._personnelVo
                    vc._workUnitVo = workUnitVo
                    vc._index = 0
                    self.navigationController?.pushViewController(vc, animated: true)
                } else if (workUnitVo?.operationVos.count)! > 1 {
                    let vc = MultiZuoYeDanYuanLieBiao.init()
                    vc.operations = workUnitVo?.operationVos
                    vc.callBack = {(index: Int) in
                        let vc = ScanMTuZhiVC.init()
                        vc._personnelVo = self._personnelVo
                        vc._workUnitVo = workUnitVo
                        vc._index = index
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    MyAlertCenter.default().postAlert(withMessage: "没有作业单元")
                }
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnEntityBean"))
    }
    
    //MARK:返回首页
    @IBAction func buttonGoHome(_ sender: Any) {
        for vc in (self.navigationController?.viewControllers)! {
//            print(vc)
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
        if !(personnelCode == "(null)") {
            for temp in (self.navigationController?.viewControllers)! {
                if temp is TpfMaiViewController {
                    self.navigationController?.popToViewController(temp, animated: true)
                    return
                }
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
        
        
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
