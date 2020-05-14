//
//  ScanXunJianRenYuanVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/4.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit


class ScanXunJianRenYuanVC: UIViewController, UITextFieldDelegate {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!

        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
 
        self.setAttributedString(text: "摄像头对准巡检人员二维码， \n点击扫描")//设置中间字颜色
        
        self.textField.delegate = self
        
        
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
    //    FIXME: 扫描
    //    TODO: 扫描
    @IBAction func buttonScan(_ sender: Any) {
        let saoYiSaoVC = SaoYiSaoVC()
        saoYiSaoVC.scanTitle = "扫描人员二维码"
        saoYiSaoVC.resultBlock = { (result: String!) -> () in
            let jsonData = result.data(using: String.Encoding.utf8)! as Data
    
//            let dic = (try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)) as! [AnyHashable : Any]
//            self.request(result: dic["personnelCode"] as! String)]
            
            let dic = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyHashable : Any]
            if let a = dic {
                self.request(result: a["personnelCode"] as? String)
            } else {
                self.request(result: "00000000")
            }
            
        }
        self.present(saoYiSaoVC, animated: true, completion: nil)
    }
    
    func request(result: String?) {
        _viewLoading.isHidden = false
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        let personnelVo: PersonnelVo = PersonnelVo.init()
        personnelVo.siteCode = siteCode
        personnelVo.personnelCode = result
        mesPostEntityBean.entity = personnelVo.mj_keyValues() as! [AnyHashable : Any]?
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        
        print(dic)
        
        HttpMamager.postRequest(withURLString: DYZ_scanRest_personnelScan, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnEntityBean: ReturnEntityBean  = responseObjectModel as! ReturnEntityBean
            
            self._viewLoading.isHidden = true
            if returnEntityBean.status == "SUCCESS" {
                let personnelVo: PersonnelVo = PersonnelVo.mj_object(withKeyValues: returnEntityBean.entity)
                
                let tpfXunJianViewController: TpfXunJianViewController = TpfXunJianViewController()
                tpfXunJianViewController.personnelVo = personnelVo
                self.navigationController?.pushViewController(tpfXunJianViewController, animated: true)
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnEntityBean"))
        
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
