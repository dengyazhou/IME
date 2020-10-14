//
//  ZuoYeViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/8.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class ZuoYeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let _height_NavBar = Height_NavBar!
    private let _height_BottomBar = Height_BottomBar!
    
    
    @objc var batchWorkNum: String!
    var batchWorkVo: BatchWorkVo!
    
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

        self.tableView.register(UINib.init(nibName: "ZuoYeDanYuanCell", bundle: nil), forCellReuseIdentifier: "zuoYeDanYuanCell")
        self.tableView.register(UINib.init(nibName: "ZuoYeDanYuanCell1", bundle: nil), forCellReuseIdentifier: "zuoYeDanYuanCell1") //第一行
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
        return _arrayL.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "zuoYeDanYuanCell1", for: indexPath) as! ZuoYeDanYuanCell1
            cell.viewTopLine.isHidden = true
            cell.viewBottomLine.isHidden = true
            cell.viewBottomLine15.isHidden = true

            cell.viewTopLine.isHidden = false
            cell.viewBottomLine15.isHidden = false
            cell.label0.text = _arrayR[indexPath.row]
            cell.label1.text = _arrayL[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "zuoYeDanYuanCell", for: indexPath) as! ZuoYeDanYuanCell
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
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let vc = SeeMoreViewController.init()
            vc.batchWorkItemList = self.batchWorkVo.batchWorkItemList
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //    MARK: 开始
    @IBAction func buttonKaiShi(_ sender: Any) {
        _viewLoading.isHidden = false
        let mesPostEntityBean = MesPostEntityBean.init()
        let batchWorkVo = BatchWorkVo.init()
        batchWorkVo.siteCode = self.batchWorkVo.siteCode
        batchWorkVo.batchWorkNum = self.batchWorkVo.batchWorkNum
        batchWorkVo.modifyUser = self.batchWorkVo.modifyUser
        batchWorkVo.status = NSNumber.init(value: 1)
        let array = [batchWorkVo] as NSArray
        mesPostEntityBean.entity = array.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        print(dic)
        
        HttpMamager.postRequest(withURLString: DYZ_batchWork_workLog, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
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
        self.buttonGoHome(sender)
    }
    //    MARK: 完工
    @IBAction func buttonWanGong(_ sender: Any) {
        //DYZ_batchWork_workLog
        
        let alertController = UIAlertController.init(title: "是否确认完工？", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let action0 = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            self._viewLoading.isHidden = false
            let mesPostEntityBean = MesPostEntityBean.init()
            let batchWorkVo = BatchWorkVo.init()
            batchWorkVo.siteCode = self.batchWorkVo.siteCode
            batchWorkVo.batchWorkNum = self.batchWorkVo.batchWorkNum
            batchWorkVo.modifyUser = self.batchWorkVo.modifyUser
            batchWorkVo.status = NSNumber.init(value: 4)
            let array = [batchWorkVo] as NSArray
            mesPostEntityBean.entity = array.mj_keyValues()
            let dic = mesPostEntityBean.mj_keyValues()
            HttpMamager.postRequest(withURLString: DYZ_batchWork_workLog, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
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
            let batchWorkVo = BatchWorkVo.init()
            batchWorkVo.siteCode = self.batchWorkVo.siteCode
            batchWorkVo.batchWorkNum = self.batchWorkVo.batchWorkNum
            batchWorkVo.modifyUser = self.batchWorkVo.modifyUser
            batchWorkVo.shutDownCauseCode = shutDownCauseVo.shutDownCauseCode // 暂停原因，多工单报工
            batchWorkVo.status = NSNumber.init(value: 2)
            let array = [batchWorkVo] as NSArray
            mesPostEntityBean.entity = array.mj_keyValues()
            let dic = mesPostEntityBean.mj_keyValues()
            HttpMamager.postRequest(withURLString: DYZ_batchWork_workLog, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
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
        self.view.addSubview(view!);
    }
    //    MARK: 继续
    @IBAction func buttonJiXu(_ sender: Any) {
        _viewLoading.isHidden = false
        let mesPostEntityBean = MesPostEntityBean.init()
        let batchWorkVo = BatchWorkVo.init()
        batchWorkVo.siteCode = self.batchWorkVo.siteCode
        batchWorkVo.batchWorkNum = self.batchWorkVo.batchWorkNum
        batchWorkVo.modifyUser = self.batchWorkVo.modifyUser
        batchWorkVo.status = NSNumber.init(value: 3)
        let array = [batchWorkVo] as NSArray
        mesPostEntityBean.entity = array.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_batchWork_continueWork, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
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
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean = MesPostEntityBean.init()
        let batchWorkVo = BatchWorkVo.init()
        batchWorkVo.siteCode = siteCode
        batchWorkVo.batchWorkNum = self.batchWorkNum
        mesPostEntityBean.entity = batchWorkVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_batchWork_getWorkTime, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnEntityBean = responseObjectModel as! ReturnEntityBean
            self._viewLoading.isHidden = true
            
            if returnEntityBean.status == "SUCCESS"{
                self.batchWorkVo = BatchWorkVo.mj_object(withKeyValues: returnEntityBean.entity)
                self.initButtonAndRequest(batchWorkVo: self.batchWorkVo)
                self.requestShutDownCauseListWithOperationCode(operationCode: self.batchWorkVo.operationCode)
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnEntityBean"))
    }
    
    func initButtonAndRequest(batchWorkVo: BatchWorkVo?) {
        self.buttonKaiShi.isHidden = true
        self.buttonWanGong.isHidden = true
        self.buttonQuXiao.isHidden = true
        self.buttonZanTing.isHidden = true
        self.buttonJiXu.isHidden = true

        if batchWorkVo?.status.intValue == 0 || batchWorkVo?.status.intValue == 5 {
            self.buttonKaiShi.isHidden = false
            self.buttonQuXiao.isHidden = false
            _secondsCountUp = 0
            self.countDownTimer.fireDate = NSDate.distantFuture//停
        } else if batchWorkVo?.status.intValue == 1 {
            self.buttonWanGong.isHidden = false
            self.buttonZanTing.isHidden = false
            _secondsCountUp = CLong(NSDate.init().timeIntervalSince(ToolTransition.date(from: batchWorkVo?.startDateTime)))*1000
            self.countDownTimer.fireDate = NSDate.distantPast//跑
        } else if batchWorkVo?.status.intValue == 2 {
            self.buttonWanGong.isHidden = false
            self.buttonJiXu.isHidden = false
            _secondsCountUp = CLong((batchWorkVo?.workTime)!)
            self.countDownTimer.fireDate = NSDate.distantFuture//停
        } else if batchWorkVo?.status.intValue == 3 {
            self.buttonWanGong.isHidden = false
            self.buttonZanTing.isHidden = false
            let actu = NSDate.init().timeIntervalSince(ToolTransition.date(from: batchWorkVo?.actualendDateTime))*1000
            
            let work = Double((batchWorkVo?.workTime)!)
            
            _secondsCountUp = CLong(actu + work)
            self.countDownTimer.fireDate = NSDate.distantPast//跑
        } else if batchWorkVo?.status.intValue == 4 {
            _secondsCountUp = 0;
            self.countDownTimer.fireDate = NSDate.distantFuture//停
            
            let vc = ScanMultiCompleteVC.init()
            vc.batchWorkVo = self.batchWorkVo
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        showTimeLabel()
        
        let workTimeLogVo = batchWorkVo?.batchWorkItemList[0] as! WorkTimeLogVo
        
        var planTime: Int = 0
        var planTime1: Double = 0
        var planString: String = ""
        if let plantimeTemp = batchWorkVo?.plannedHours {
            planTime = Int(plantimeTemp)
            planTime1 = (Double(plantimeTemp) - Double(planTime))*60
            planString = String(format: "%d小时%d分", planTime,Int(round(planTime1)))
        }

        let surplusTime: Int = Int((batchWorkVo?.surplusHours)!)
        let surplusTime1: Double = (Double((batchWorkVo?.surplusHours)!) - Double(surplusTime))*60
        
        if GlobalSettingManager.share().showPlanHour == 1 {
            self._arrayR = ["生产作业号","生产单元","操作员","本道工序","计划工时","剩余总工时"]
            self._arrayL = [workTimeLogVo.productionControlNum,(batchWorkVo?.workUnitText)!,(batchWorkVo?.confirmUserText)!,(batchWorkVo?.operationText)!,planString,String(format: "%d小时%02d分", surplusTime,Int(round(surplusTime1)))]
        } else {
            self._arrayR = ["生产作业号","生产单元","操作员","本道工序","剩余总工时"]
            self._arrayL = [workTimeLogVo.productionControlNum,(batchWorkVo?.workUnitText)!,(batchWorkVo?.confirmUserText)!,(batchWorkVo?.operationText)!,String(format: "%d小时%02d分", surplusTime,Int(round(surplusTime1)))]
        }
        
        self.tableView.reloadData()
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
    

    @IBAction func buttonGoHome(_ sender: Any) {
        for value in (self.navigationController?.viewControllers)! {
            if value.isKind(of: TpfMaiViewController.classForCoder()) {
                self.navigationController?.popToViewController(value, animated: true)
                break
            }
        }
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
