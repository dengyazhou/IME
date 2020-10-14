//
//  PadMultiUserWorkViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/8.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class PadMultiUserWorkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let _height_NavBar = Height_NavBar!
    private let _height_BottomBar = Height_BottomBar!
    
    
    @objc var multiUserWorkNum: String!
    var multiUserWorkVo: MultiUserWorkVo!
    var productionControlVo: ProductionControlVo!
    
    var _arrayR: [String]! = []
    var _arrayL: [String]! = []
    
    var _secondsCountUp: CLong = 0
    var _dataArray: [ShutDownCauseVo]! = []//暂停原因

    private var _viewLoading: UIView!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var timeLabel: UILabel!

    var countDownTimer: Timer!
    
    @IBOutlet weak var buttonKaiShi: UIButton!
    @IBOutlet weak var buttonQuXiao: UIButton!
    @IBOutlet weak var buttonWanGong: UIButton!
    @IBOutlet weak var buttonZanTing: UIButton!
    @IBOutlet weak var buttonJiXu: UIButton!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    
    var swiftCallback = {()->() in
        
    }
    
    @objc func didBecomeActive() {
        
        self.request()
    }

    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        if parent == nil {
            if countDownTimer != nil {
                countDownTimer.invalidate()
                countDownTimer = nil;
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar
        self.heightBottomBar.constant = _height_BottomBar
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true

        self.tableView.register(UINib.init(nibName: "PadSingleUserWorkZuoYeDanYuanImageCell", bundle: nil), forCellReuseIdentifier: "padSingleUserWorkZuoYeDanYuanImageCell")
        self.tableView.register(UINib.init(nibName: "ZuoYeDanYuanCell", bundle: nil), forCellReuseIdentifier: "zuoYeDanYuanCell")
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView.init()
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.bounces = false

        self.request()
        
        self.countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownAction), userInfo: nil, repeats: true)
        self.countDownTimer.fireDate = Date.distantFuture
    }
    
    @objc func countDownAction() {
        _secondsCountUp += 1000
        showTimeLabel()
    }
    
    func showTimeLabel() {
        let str_hour = String(format: "%02ld", _secondsCountUp/1000/3600)
        let str_minute = String(format: "%02ld", (_secondsCountUp/1000%3600)/60)
        let str_second = String(format: "%02ld", _secondsCountUp/1000%60)
        let format_time = "\(str_hour):\(str_minute):\(str_second)"
        self.timeLabel.text = format_time
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return _arrayL.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "padSingleUserWorkZuoYeDanYuanImageCell", for: indexPath) as! PadSingleUserWorkZuoYeDanYuanImageCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            if self.productionControlVo != nil {
                if self.productionControlVo.drawingPreviewVoList != nil {
                    if self.productionControlVo.drawingPreviewVoList.count > 0 {
                        let drawingPreviewVo = self.productionControlVo.drawingPreviewVoList[0] as! DrawingPreviewVo
                        cell.imageView1?.sd_setImage(with: URL.init(string: drawingPreviewVo.mediumPreviewUrl), completed: nil)
                    } else {
                        cell.imageView1?.image = UIImage.init(named: "img_nopicture")
                    }
                } else {
                    cell.imageView1?.image = UIImage.init(named: "img_nopicture")
                }
            } else {
                cell.imageView1?.image = UIImage.init(named: "img_nopicture")
            }
            
            cell.imageButton?.addTarget(self, action: #selector(buttonImageClick(sender:)), for: UIControl.Event.touchUpInside)

            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "zuoYeDanYuanCell", for: indexPath) as! ZuoYeDanYuanCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.viewTopLine.isHidden = true
            cell.viewBottomLine.isHidden = true
            cell.viewBottomLine15.isHidden = true
            if indexPath.row == _arrayR.count-1 {
                cell.viewBottomLine.isHidden = false
            } else {
                cell.viewBottomLine15.isHidden = false
            }
            cell.label0.text = _arrayR[indexPath.row]
            cell.label1.text = _arrayL[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
 
        
    }
    
    @objc func buttonImageClick(sender: UIButton) {
        if self.productionControlVo != nil {
            if self.productionControlVo.drawingPreviewVoList != nil {
                if self.productionControlVo.drawingPreviewVoList.count > 0 {
                    let vc = PadCheckBigImageViewController.init()
                    vc.productionControlNum = self.productionControlVo.productionControlNum
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //    MARK: 开始
    @IBAction func buttonKaiShi(_ sender: Any) {
        _viewLoading.isHidden = false
        let mesPostEntityBean = MesPostEntityBean.init()
        let multiUserWorkVo = MultiUserWorkVo.init()
        multiUserWorkVo.siteCode = self.multiUserWorkVo.siteCode
        multiUserWorkVo.multiUserWorkNum = self.multiUserWorkVo.multiUserWorkNum
        multiUserWorkVo.status = NSNumber.init(value: 1)
        let array = [multiUserWorkVo] as NSArray
        mesPostEntityBean.entity = array.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        print(dic)
        
        HttpMamager.postRequest(withURLString: DYZ_multiUserWork_workLog, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean
            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {
                self.request()
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnMsgBean"))
        
    }
    //    MARK: 取消
    @IBAction func buttonQuXiao(_ sender: Any) {
        for value in (self.navigationController?.viewControllers)! {
            if value.isKind(of: TpfMaiViewController.classForCoder()) {
                self.navigationController?.popToViewController(value, animated: true)
                break
            }
        }
    }
    //    MARK: 完工
    @IBAction func buttonWanGong(_ sender: Any) {
        let alertController = UIAlertController.init(title: "是否确认完工？", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let action0 = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            self._viewLoading.isHidden = false
            let mesPostEntityBean = MesPostEntityBean.init()
            let multiUserWorkVo = MultiUserWorkVo.init()
            multiUserWorkVo.siteCode = self.multiUserWorkVo.siteCode
            multiUserWorkVo.multiUserWorkNum = self.multiUserWorkVo.multiUserWorkNum
            multiUserWorkVo.status = NSNumber.init(value: 4)
            let array = [multiUserWorkVo] as NSArray
            mesPostEntityBean.entity = array.mj_keyValues()
            let dic = mesPostEntityBean.mj_keyValues()
            HttpMamager.postRequest(withURLString: DYZ_multiUserWork_workLog, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
                let returnMsgBean = responseObjectModel as! ReturnMsgBean
                self._viewLoading.isHidden = true
                if returnMsgBean.status == "SUCCESS" {
                    self.request()
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
    //    MARK: 暂停
    @IBAction func buttonZanTing(_ sender: Any) {
        
        let view = TpfBaoGongReasonView.init(frame: self.view.frame, withData: _dataArray)
        view?.block1Confirm = {(model: Any?)->() in
            let shutDownCauseVo = model as! ShutDownCauseVo
            self._viewLoading.isHidden = false
            let mesPostEntityBean = MesPostEntityBean.init()
            let multiUserWorkVo = MultiUserWorkVo.init()
            multiUserWorkVo.siteCode = self.multiUserWorkVo.siteCode
            multiUserWorkVo.multiUserWorkNum = self.multiUserWorkVo.multiUserWorkNum
            multiUserWorkVo.status = NSNumber.init(value: 2)
            multiUserWorkVo.shutDownCauseCode = shutDownCauseVo.shutDownCauseCode
            let array = [multiUserWorkVo] as NSArray
            mesPostEntityBean.entity = array.mj_keyValues()
            let dic = mesPostEntityBean.mj_keyValues()
            HttpMamager.postRequest(withURLString: DYZ_multiUserWork_workLog, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
                let returnMsgBean = responseObjectModel as! ReturnMsgBean
                self._viewLoading.isHidden = true
                if returnMsgBean.status == "SUCCESS" {
                    self.request()
                } else {
                    MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
                }
            }, fail: { (error: Error?) in
                self._viewLoading.isHidden = true
            }, isKindOfModel: NSClassFromString("ReturnMsgBean"))
        }
        self.view.addSubview(view!)
    }
    //    MARK: 继续
    @IBAction func buttonJiXu(_ sender: Any) {
        _viewLoading.isHidden = false
        let mesPostEntityBean = MesPostEntityBean.init()
        let multiUserWorkVo = MultiUserWorkVo.init()
        multiUserWorkVo.siteCode = self.multiUserWorkVo.siteCode
        multiUserWorkVo.multiUserWorkNum = self.multiUserWorkVo.multiUserWorkNum
        multiUserWorkVo.status = NSNumber.init(value: 3)
        let array = [multiUserWorkVo] as NSArray
        mesPostEntityBean.entity = array.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_multiUserWork_continueWork, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean
            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {
                self.request()
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnMsgBean"))
    }
    
    func request() {
        _viewLoading.isHidden = false
        
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel.tpfUser)
        let siteCode = tpfUser?.siteCode
        
        let mesPostEntityBean = MesPostEntityBean.init()
        let multiUserWorkVo = MultiUserWorkVo.init()
        multiUserWorkVo.siteCode = siteCode
        multiUserWorkVo.multiUserWorkNum = self.multiUserWorkNum
        mesPostEntityBean.entity = multiUserWorkVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_multiUserWork_getWorkTime, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnEntityBean = responseObjectModel as! ReturnEntityBean
            self._viewLoading.isHidden = true
            
            if returnEntityBean.status == "SUCCESS"{
                self.multiUserWorkVo = MultiUserWorkVo.mj_object(withKeyValues: returnEntityBean.entity)
                self.initButtonAndRequest(multiUserWorkVo: self.multiUserWorkVo)
                self.requestShutDownCauseListWithOperationCode(operationCode: self.multiUserWorkVo.operationCode)
                self.requestSelectProductionControlVo()
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnEntityBean"))
    }
    
    func initButtonAndRequest(multiUserWorkVo: MultiUserWorkVo?) {
        self.buttonKaiShi.isHidden = true
        self.buttonWanGong.isHidden = true
        self.buttonQuXiao.isHidden = true
        self.buttonZanTing.isHidden = true
        self.buttonJiXu.isHidden = true

        if multiUserWorkVo?.status.intValue == 0 || multiUserWorkVo?.status.intValue == 5 {
            self.buttonKaiShi.isHidden = false
            self.buttonQuXiao.isHidden = false
            _secondsCountUp = 0
            self.countDownTimer.fireDate = NSDate.distantFuture//停
        } else if multiUserWorkVo?.status.intValue == 1 {
            self.buttonWanGong.isHidden = false
            self.buttonZanTing.isHidden = false
            _secondsCountUp = CLong(NSDate.init().timeIntervalSince(ToolTransition.date(from: multiUserWorkVo?.startDateTime)))*1000
            self.countDownTimer.fireDate = NSDate.distantPast//跑
        } else if multiUserWorkVo?.status.intValue == 2 {
            self.buttonWanGong.isHidden = false
            self.buttonJiXu.isHidden = false
            _secondsCountUp = CLong((multiUserWorkVo?.workTime)!)
            self.countDownTimer.fireDate = NSDate.distantFuture//停
        } else if multiUserWorkVo?.status.intValue == 3 {
            self.buttonWanGong.isHidden = false
            self.buttonZanTing.isHidden = false
            let actu = NSDate.init().timeIntervalSince(ToolTransition.date(from: multiUserWorkVo?.actualendDateTime))*1000
            
            let work = Double((multiUserWorkVo?.workTime)!)
            
            _secondsCountUp = CLong(actu + work)
            self.countDownTimer.fireDate = NSDate.distantPast//跑
        } else if multiUserWorkVo?.status.intValue == 4 {
            _secondsCountUp = 0;
            self.countDownTimer.fireDate = NSDate.distantFuture//停
                        
            let vc = PadMultiUserWorkCompleteVC.init()
            vc.multiUserWorkVo = self.multiUserWorkVo
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        showTimeLabel()
        
        //拼接操作人
        var allConfirmUserText: String? = ""        
        for i in 0..<(multiUserWorkVo?.multiUserWorkItemList.count)! {
            let workTimeLogVo: WorkTimeLogVo? = multiUserWorkVo?.multiUserWorkItemList[i] as? WorkTimeLogVo
            if i == (multiUserWorkVo?.multiUserWorkItemList.count)!-1 {
                allConfirmUserText = allConfirmUserText! + (workTimeLogVo?.confirmUserText)!
            } else {
                allConfirmUserText = allConfirmUserText! + (workTimeLogVo?.confirmUserText)! + ","
            }
        }

        self._arrayR = ["生产作业号","项目编号","项目名称","物料名称","订单数量","当前工序","作业单元","操作人","剩余天数","客户交期"]
        self._arrayL = [(multiUserWorkVo?.productionControlNum) != nil ? (multiUserWorkVo?.productionControlNum)! : "",
                        (multiUserWorkVo?.projectNum) != nil ? (multiUserWorkVo?.projectNum)! : "",
                        (multiUserWorkVo?.projectName) != nil ? (multiUserWorkVo?.projectName)! : "",
                        (multiUserWorkVo?.materialText) != nil ? (multiUserWorkVo?.materialText)! : "",
                        (multiUserWorkVo?.planQuantity) != nil ? (multiUserWorkVo?.planQuantity.stringValue)! : "",
                        (multiUserWorkVo?.operationText) != nil ? (multiUserWorkVo?.operationText)! : "",
                        (multiUserWorkVo?.workUnitText) != nil ? (multiUserWorkVo?.workUnitText)! : "",
                        allConfirmUserText!,
                        (multiUserWorkVo?.remainingDays) != nil ? (multiUserWorkVo?.remainingDays)! : "",
                        (multiUserWorkVo?.requirementDate) != nil ? (multiUserWorkVo?.requirementDate)! : "",]
        
        self.tableView.reloadData()
    }
    
    func requestSelectProductionControlVo() {
        let loginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel?.tpfUser)
        let siteCode = tpfUser?.siteCode
        
        let mesPostEntityBean = MesPostEntityBean.init()
        let productionControlVo = ProductionControlVo.init()
        productionControlVo.siteCode = siteCode
        productionControlVo.productionControlNum = self.multiUserWorkVo.productionControlNum
        
        mesPostEntityBean.entity = productionControlVo.mj_keyValues()
        
        let dic = mesPostEntityBean.mj_keyValues()
        
        HttpMamager.postRequest(withURLString: DYZ_productionControl_selectProductionControlVo, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnEntityBean = responseObjectModel as! ReturnEntityBean
            
            if returnEntityBean.status == "SUCCESS"{
                let model = ProductionControlVo.mj_object(withKeyValues: returnEntityBean.entity)
                self.productionControlVo = model
                self.tableView.reloadData()
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
            }
        }, fail: { (error: Error?) in
      
        }, isKindOfModel: NSClassFromString("ReturnEntityBean"))
    }
    
    func requestShutDownCauseListWithOperationCode(operationCode: String?) {
        _viewLoading.isHidden = false
        
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel.tpfUser)
        let siteCode = tpfUser?.siteCode
        
        let mesPostEntityBean = MesPostEntityBean.init()
        let shutDownCauseVo = ShutDownCauseVo.init()
        shutDownCauseVo.siteCode = siteCode
        shutDownCauseVo.operationCode = operationCode
        mesPostEntityBean.entity = shutDownCauseVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_workRest_shutDownCauseList, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnListBean = responseObjectModel as! ReturnListBean
            self._viewLoading.isHidden = true
            
            if returnListBean.status == "SUCCESS"{
                var dataArray = [ShutDownCauseVo]()
                for i in 0..<returnListBean.list.count {
                    let dictemp = returnListBean.list[i]
                    let tep = ShutDownCauseVo.mj_object(withKeyValues: dictemp)
                    dataArray.append(tep!)
                }
                self._dataArray = dataArray
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
        
    }
    
    @IBAction func back(_ sender: Any) {
        swiftCallback()
        self.navigationController?.popViewController(animated: true)
    }
    
    //最后要记得移除通知
    deinit {
        // 移除通知
        
        NotificationCenter.default.removeObserver(self)
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
