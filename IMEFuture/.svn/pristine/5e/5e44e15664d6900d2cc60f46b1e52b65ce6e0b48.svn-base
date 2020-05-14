//
//  TpfXunJianViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class TpfXunJianViewController: UIViewController {
    
    var personnelVo: PersonnelVo!
    
    
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    
    private var _viewLoading: UIView!
    
    private var isLR:Bool = true //左右 左：true 右：false
    
    

    
    @IBOutlet weak var buttonTuZhi: UIButton!
    @IBOutlet weak var buttonZuoYeDanYuan: UIButton!
    @IBOutlet weak var buttonLineCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var labelBottom: UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!
        
        self.initButtonLine()
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        self.labelTop.text = self.personnelVo.personnelName
        self.labelBottom.text = "编号：" + self.personnelVo.personnelCode
        
        
        
    }

    //MARK: 扫描
    @IBAction func buttonScan(_ sender: Any) {
        if isLR {
            //图纸
            let saoYiSaoVC: SaoYiSaoVC = SaoYiSaoVC()
            saoYiSaoVC.scanTitle = "扫描图纸二维码"
            saoYiSaoVC.resultBlock = { (result: String!) -> Void in
                self.requestTuZhi(result: result)
            }
            self.present(saoYiSaoVC, animated: true, completion: nil)
        } else {
            //作业单元
            let saoYiSaoVC: SaoYiSaoVC = SaoYiSaoVC()
            saoYiSaoVC.scanTitle = "扫描作业单元二维码"
            saoYiSaoVC.resultBlock = { (result: String!) -> Void in
                let jsonData = result.data(using: String.Encoding.utf8)! as Data
                let dic = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyHashable : Any]
                
                if let a = dic {
                    self.requestZuoYeDuanYuan(result: a["workUnitCode"] as? String)
                } else {
                    self.requestZuoYeDuanYuan(result: "00000000")
                }
                
            }
            self.present(saoYiSaoVC, animated: true, completion: nil)
        }
    }
    
    func requestTuZhi(result: String) {
        _viewLoading.isHidden = false
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean = MesPostEntityBean()
        let routingInspectionVo = RoutingInspectionVo()
        routingInspectionVo.siteCode = siteCode!
        routingInspectionVo.productionControlNum = result
        routingInspectionVo.routingUserCode = personnelVo.personnelCode
//        routingInspectionVo.siteCode = "A00000501"
//        routingInspectionVo.productionControlNum = "SFC_201807090001"
//        routingInspectionVo.routingUserCode = "A001"
        mesPostEntityBean.entity = routingInspectionVo.mj_keyValues() as! [AnyHashable : Any]
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        print(dic)
        
        HttpMamager.postRequest(withURLString: DYZ_routingInspection_getRoutingInspectionListByProductionControlNum, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnListBean: ReturnListBean = responseObjectModel as! ReturnListBean
            
            self._viewLoading.isHidden = true
            if returnListBean.status == "SUCCESS" {
                var array = [RoutingInspectionVo]()
                for value in returnListBean.list {
                    let routingInspectionVo = RoutingInspectionVo.mj_object(withKeyValues: value)
                    array.append(routingInspectionVo!)
                }
                
                let tuZhiJiaGongXiangQingVC: TuZhiJiaGongXiangQingVC = TuZhiJiaGongXiangQingVC()
                tuZhiJiaGongXiangQingVC.arryRoutingInspectionVo = array
                self.navigationController?.pushViewController(tuZhiJiaGongXiangQingVC, animated: true)
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
    }
    
    
    func requestZuoYeDuanYuan(result: String?) {
        _viewLoading.isHidden = false
        
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean = MesPostEntityBean()
        let routingInspectionVo = RoutingInspectionVo()
        routingInspectionVo.siteCode = siteCode!
        routingInspectionVo.workUnitCode = result
        routingInspectionVo.routingUserCode = personnelVo.personnelCode
//        routingInspectionVo.siteCode = "A00000501"
//        routingInspectionVo.workUnitCode = "U001"
//        routingInspectionVo.routingUserCode = "A001"
        mesPostEntityBean.entity = routingInspectionVo.mj_keyValues() as! [AnyHashable : Any]
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        print(dic)
        
        HttpMamager.postRequest(withURLString: DYZ_routingInspection_getRoutingInspectionListByWorkUnitCode, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnListBean: ReturnListBean = responseObjectModel as! ReturnListBean
            
            self._viewLoading.isHidden = true
            if returnListBean.status == "SUCCESS" {
                var array = [RoutingInspectionVo]()
                for value in returnListBean.list {
                    let routingInspectionVo = RoutingInspectionVo.mj_object(withKeyValues: value)
                    array.append(routingInspectionVo!)
                }
                
                let zuoYeDanYuanJiaGongXiangQingVC: ZuoYeDanYuanJiaGongXiangQingVC = ZuoYeDanYuanJiaGongXiangQingVC()
                zuoYeDanYuanJiaGongXiangQingVC.arryRoutingInspectionVo = array
                self.navigationController?.pushViewController(zuoYeDanYuanJiaGongXiangQingVC, animated: true)
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
        
    }
    
    //MARK: 扫描图纸 扫描作业单元
    @IBAction func buttonClick(_ sender: UIButton) {
        if sender.tag == 0 {
            
            self.isLR = true
        } else if sender.tag == 1 {
            
            self.isLR = false
        }
        self.initButtonLine()
    }
    
    //MARK: 更换人员
    @IBAction func buttonGengHuanRenYuan(_ sender: Any) {
        self.back(sender)
    }
    
    func initButtonLine() {
        if isLR {
            self.buttonTuZhi.setTitleColor(colorRGB(r: 0, g: 122, b: 254), for:  UIControlState.normal)
            self.buttonZuoYeDanYuan.setTitleColor(colorRGB(r: 102, g: 102, b: 102), for: UIControlState.normal)
            self.buttonLineCenterX.constant = 0;
            self.setAttributedString(text: "摄像头对准图纸二维码， \n点击扫描")
        } else {
            self.buttonTuZhi.setTitleColor(colorRGB(r: 102, g: 102, b: 120), for: UIControlState.normal)
            self.buttonZuoYeDanYuan.setTitleColor(colorRGB(r: 0, g: 122, b: 254), for: UIControlState.normal)
            self.buttonLineCenterX.constant = kMainW/2;
            self.setAttributedString(text: "摄像头对准作业单元二维码， \n点击扫描")
        }
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
