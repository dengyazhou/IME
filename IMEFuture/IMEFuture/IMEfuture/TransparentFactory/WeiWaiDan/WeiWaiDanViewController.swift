//
//  WeiWaiDanViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class WeiWaiDanViewController: UIViewController, UITextFieldDelegate{

    private let _height_NavBar = Height_NavBar!
    private let _height_BottomBar = Height_BottomBar!
    
    private var index: Int! //默认值为nil
    
    
    private var _viewLoading: UIView!
    
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var lineLeftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
         UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar
        self.heightBottomBar.constant = _height_BottomBar
    
        
        self.index = 0;
        self.buttonLeft.setTitleColor(colorRGB(r: 0, g: 122, b: 254), for: UIControlState.normal)
        self.buttonRight.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.lineLeftConstraint.constant = 0;
        
        
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        self.setAttributedString(text: "摄像头对准委外单号，\n点击扫描")
        
        self.textField.delegate = self
    
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        let btn = sender as! UIButton
        self.index = btn.tag
        if self.index == 0 {
            self.buttonLeft.setTitleColor(colorRGB(r: 0, g: 122, b: 254), for: UIControlState.normal)
            self.buttonRight.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.lineLeftConstraint.constant = 0;
            self.setAttributedString(text: "摄像头对准委外单号，\n点击扫描")
        } else if self.index == 1 {
            self.buttonLeft.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonRight.setTitleColor(colorRGB(r: 0, g: 122, b: 254), for: UIControlState.normal)
            self.lineLeftConstraint.constant = kMainW/2.0;
            self.setAttributedString(text: "摄像头对准工序流转卡，\n点击扫描")
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.request(result: textField.text!)
        textField.resignFirstResponder()
        textField.text = nil
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
//    MARK: 扫描
    @IBAction func scan(_ sender: Any) {
        let saoYiSao = SaoYiSaoVC.init()
        saoYiSao.scanTitle = "扫描委外单二维码"
        saoYiSao.resultBlock = {(result: String!) -> () in
            self.request(result: result)
        }
        self.present(saoYiSao, animated: true, completion: nil)
    }
    
    func request(result: String?) {
        if self.index == 0 {//扫描委外单
            _viewLoading.isHidden = false
            let loginModel: LoginModel = DatabaseTool.getLoginModel()
            let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
            let siteCode = userBean?.enterpriseInfo.serialNo

            let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
            let operationOutsourcingOrderVo: OperationOutsourcingOrderVo = OperationOutsourcingOrderVo.init()
            operationOutsourcingOrderVo.siteCode = siteCode
            operationOutsourcingOrderVo.outsourcingCode = result ?? ""

            mesPostEntityBean.entity = operationOutsourcingOrderVo.mj_keyValues()
            let dic = mesPostEntityBean.mj_keyValues()
            print(dic)

            HttpMamager.postRequest(withURLString: DYZ_operationOutsourcing_getOperationOutsourcingOrder, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
                let returnEntityBean = responseObjectModel as! ReturnEntityBean
                
                self._viewLoading.isHidden = true
                if returnEntityBean.status == "SUCCESS" {
                    let operationOutsourcingOrderVo: OperationOutsourcingOrderVo = OperationOutsourcingOrderVo.mj_object(withKeyValues: returnEntityBean.entity)
                    if operationOutsourcingOrderVo.status.intValue == 1 || operationOutsourcingOrderVo.status.intValue == 2 || operationOutsourcingOrderVo.status.intValue == 3 { //1 创建 2 已发货 3 部分收货
                        let vc = WeiWaiFaHuoViewController.init()
                        vc.operationOutsourcingOrderVo = operationOutsourcingOrderVo;
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else if operationOutsourcingOrderVo.status.intValue == 4 { //4 已收货
                        MyAlertCenter.default().postAlert(withMessage: "该委外单已收货")
                    }
                } else {
                    MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
                }

            }, fail: { (error: Error?) in
                self._viewLoading.isHidden = true
            }, isKindOfModel: NSClassFromString("ReturnEntityBean"))
        } else if self.index == 1 {//创建委外单
            _viewLoading.isHidden = false
            let loginModel: LoginModel = DatabaseTool.getLoginModel()
            let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
            let siteCode = userBean?.enterpriseInfo.serialNo

            let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
            let operationOutsourcingSourceVo: OperationOutsourcingSourceVo = OperationOutsourcingSourceVo.init()
            operationOutsourcingSourceVo.siteCode = siteCode
            operationOutsourcingSourceVo.productionControlNum = result ?? ""

            mesPostEntityBean.entity = operationOutsourcingSourceVo.mj_keyValues()
            let dic = mesPostEntityBean.mj_keyValues()
            print(dic)

            HttpMamager.postRequest(withURLString: DYZ_mes_operationOutsourcing_getOperationOutsourcingSourceVosByControlNum, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
                let returnListBean = responseObjectModel as! ReturnListBean
                
                self._viewLoading.isHidden = true
                if returnListBean.status == "SUCCESS" {
                    let vc = WeiWaiChuangJianViewController()
                    for value in returnListBean.list {
                        let model = OperationOutsourcingSourceVo.mj_object(withKeyValues: value)
                        model?.sendQuantity = model?.surplusQuantity ?? NSNumber.init(value: 0)
                        vc.dataArray.append(model!)
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                } else {
                    MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
                }

            }, fail: { (error: Error?) in
                self._viewLoading.isHidden = true
            }, isKindOfModel: NSClassFromString("ReturnListBean"))
            
        }
        
    }
    
    func setAttributedString(text: String) {
        let attributeStr: NSMutableAttributedString = NSMutableAttributedString.init(string: text)
        attributeStr.addAttribute(NSAttributedStringKey.foregroundColor, value: colorRGB(r: 0, g: 122, b: 254), range: NSMakeRange(5, text.count - 9))
        self.label.attributedText = attributeStr
    }
    
    //    MARK:back
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
