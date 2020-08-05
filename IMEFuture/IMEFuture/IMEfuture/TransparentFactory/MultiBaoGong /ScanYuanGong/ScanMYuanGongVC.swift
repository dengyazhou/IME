//
//  ScanMYuanGongVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/3.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class ScanMYuanGongVC: UIViewController, UITextFieldDelegate{
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    var _viewLoading: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let loginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel?.tpfUser)
        let siteCode = tpfUser?.siteCode
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! + "/Array_PersonnelVo_"+siteCode!+".data"
        let array = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [PersonnelVo]
        
        if !(array != nil) {
            print("不存在")
        } else if array?.count == 0 {
            print("====0")
        } else if array?.count == 1 {
            print("====1")
            let personnelVo = array?.first
            self.request(result: personnelVo?.personnelCode)
        } else {
            print("====2")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW-34)/2, y: 180, width: 34, height: 34));
        self.view.addSubview(_viewLoading);
        _viewLoading.isHidden = true
        
        self.label.attributedText = toolSwiftAttributedString(text: "摄像头对准员工二维码，\n点击扫描")
    
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
        saoYiSao.scanTitle = "扫描员工码"
        saoYiSao.resultBlock = {(result: String?) -> Void in
            print(result)
            let jsonData = result?.data(using: String.Encoding.utf8)
            let dic = try? JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyHashable : Any]
            if let a = dic {
                if let personnelCode = a["personnelCode"] as? String {
                    self.request(result: personnelCode)
                } else {
                    MyAlertCenter.default().postAlert(withMessage: "请扫描员工码")
                }
            } else {
                MyAlertCenter.default().postAlert(withMessage: "请扫描员工码")
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
        let personnelVo = PersonnelVo.init()
        personnelVo.siteCode = siteCode
        personnelVo.personnelCode = result
        mesPostEntityBean.entity = personnelVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
//        print(dic)
        HttpMamager.postRequest(withURLString: DYZ_scan_personnelScan, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnEntityBean = responseObjectModel as! ReturnEntityBean
            self._viewLoading.isHidden = true
            let personnelVo = PersonnelVo.mj_object(withKeyValues: returnEntityBean.entity)
            if returnEntityBean.status == "SUCCESS" {
                let vc = ScanMZuoYeDanYuanVC.init()
                vc._personnelVo = personnelVo
                self.navigationController?.pushViewController(vc, animated: true)
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
