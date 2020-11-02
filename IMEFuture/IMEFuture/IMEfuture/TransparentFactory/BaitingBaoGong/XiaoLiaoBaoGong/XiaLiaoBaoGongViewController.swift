//
//  XiaLiaoBaoGongViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/24.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class XiaLiaoBaoGongViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var blankingWorkTimeLogVo: BlankingWorkTimeLogVo!
    
    
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
    
    @objc func didBecomeActive() {
        
        self.request()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        if countDownTimer != nil {
            countDownTimer.invalidate()
            countDownTimer = nil;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownAction), userInfo: nil, repeats: true)
        self.countDownTimer.fireDate = Date.distantFuture
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = Height_NavBar
        self.heightBottomBar.constant = Height_BottomBar
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: Height_NavBar, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        self.tableView.register(UINib.init(nibName: "ZuoYeDanYuanCell", bundle: nil), forCellReuseIdentifier: "zuoYeDanYuanCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView.init()
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.bounces = false
        
        self.request()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "zuoYeDanYuanCell", for: indexPath) as! ZuoYeDanYuanCell
        
        cell.viewTopLine.isHidden = true
        cell.viewBottomLine.isHidden = true
        cell.viewBottomLine15.isHidden = true
        if indexPath.row == 0 {
            cell.viewTopLine.isHidden = false
            cell.viewBottomLine15.isHidden = false
        } else if indexPath.row == _arrayR.count-1 {
            cell.viewBottomLine.isHidden = false
        } else {
            cell.viewBottomLine15.isHidden = false
        }
        cell.label0.text = _arrayR[indexPath.row]
        cell.label1.text = _arrayL[indexPath.row]
        return cell
    }
    
    //    MARK: 开始
    @IBAction func buttonKaiShi(_ sender: Any) {
        _viewLoading.isHidden = false
        let mesPostEntityBean = MesPostEntityBean.init()
        let blankingWorkTimeLogVo = BlankingWorkTimeLogVo.init()
        blankingWorkTimeLogVo.siteCode = self.blankingWorkTimeLogVo.siteCode
        blankingWorkTimeLogVo.blankingCode = self.blankingWorkTimeLogVo.blankingCode
        blankingWorkTimeLogVo.status = NSNumber.init(value: 1)
        blankingWorkTimeLogVo.workUnitCode = self.blankingWorkTimeLogVo.workUnitCode
        blankingWorkTimeLogVo.confirmUser = self.blankingWorkTimeLogVo.confirmUser
        let array = [blankingWorkTimeLogVo] as NSArray
        mesPostEntityBean.entity = array.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        print(dic)
        
        HttpMamager.postRequest(withURLString: DYZ_blankingWork_workLog, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
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
        
        let alertController = UIAlertController.init(title: "是否确认完工？", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let action0 = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            self._viewLoading.isHidden = false
            let mesPostEntityBean = MesPostEntityBean.init()
            let blankingWorkTimeLogVo = BlankingWorkTimeLogVo.init()
            blankingWorkTimeLogVo.siteCode = self.blankingWorkTimeLogVo.siteCode
            blankingWorkTimeLogVo.blankingCode = self.blankingWorkTimeLogVo.blankingCode
            blankingWorkTimeLogVo.status = NSNumber.init(value: 4)
            let array = [blankingWorkTimeLogVo] as NSArray
            mesPostEntityBean.entity = array.mj_keyValues()
            let dic = mesPostEntityBean.mj_keyValues()
            HttpMamager.postRequest(withURLString: DYZ_blankingWork_workLog, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
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
        _viewLoading.isHidden = false
        let mesPostEntityBean = MesPostEntityBean.init()
        let blankingWorkTimeLogVo = BlankingWorkTimeLogVo.init()
        blankingWorkTimeLogVo.siteCode = self.blankingWorkTimeLogVo.siteCode
        blankingWorkTimeLogVo.blankingCode = self.blankingWorkTimeLogVo.blankingCode
        blankingWorkTimeLogVo.status = NSNumber.init(value: 2)
        let array = [blankingWorkTimeLogVo] as NSArray
        mesPostEntityBean.entity = array.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_blankingWork_workLog, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
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
    //    MARK: 继续
    @IBAction func buttonJiXu(_ sender: Any) {
        _viewLoading.isHidden = false
        let mesPostEntityBean = MesPostEntityBean.init()
        let blankingWorkTimeLogVo = BlankingWorkTimeLogVo.init()
        blankingWorkTimeLogVo.siteCode = self.blankingWorkTimeLogVo.siteCode
        blankingWorkTimeLogVo.blankingCode = self.blankingWorkTimeLogVo.blankingCode
        blankingWorkTimeLogVo.status = NSNumber.init(value: 3)
        let array = [blankingWorkTimeLogVo] as NSArray
        mesPostEntityBean.entity = array.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_blankingWork_continueWork, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
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
        let blankingWorkTimeLogVo = BlankingWorkTimeLogVo.init()
        blankingWorkTimeLogVo.siteCode = siteCode
        blankingWorkTimeLogVo.blankingCode = self.blankingWorkTimeLogVo.blankingCode
        blankingWorkTimeLogVo.operationCode = self.blankingWorkTimeLogVo.operationCode
        blankingWorkTimeLogVo.confirmUser = self.blankingWorkTimeLogVo.confirmUser
        blankingWorkTimeLogVo.workUnitCode = self.blankingWorkTimeLogVo.workUnitCode
        mesPostEntityBean.entity = blankingWorkTimeLogVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_blankingWork_getWorkTime, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnEntityBean = responseObjectModel as! ReturnEntityBean
            self._viewLoading.isHidden = true
            
            if returnEntityBean.status == "SUCCESS"{
                
                self.blankingWorkTimeLogVo = BlankingWorkTimeLogVo.mj_object(withKeyValues: returnEntityBean.entity)
                
                self.initButtonAndRequest(blankingWorkTimeLogVo: self.blankingWorkTimeLogVo)
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnEntityBean"))
    }
    
    func initButtonAndRequest(blankingWorkTimeLogVo: BlankingWorkTimeLogVo?) {
        self.buttonKaiShi.isHidden = true
        self.buttonWanGong.isHidden = true
        self.buttonQuXiao.isHidden = true
        self.buttonZanTing.isHidden = true
        self.buttonJiXu.isHidden = true
        
        if blankingWorkTimeLogVo?.status.intValue == 0 || blankingWorkTimeLogVo?.status.intValue == 5 {
            self.buttonKaiShi.isHidden = false
            self.buttonQuXiao.isHidden = false
            _secondsCountUp = 0
            self.countDownTimer.fireDate = NSDate.distantFuture//停
        } else if blankingWorkTimeLogVo?.status.intValue == 1 {
            self.buttonWanGong.isHidden = false
            self.buttonZanTing.isHidden = false
            _secondsCountUp = CLong(NSDate.init().timeIntervalSince(ToolTransition.date(from: blankingWorkTimeLogVo?.startDateTime)))*1000
            self.countDownTimer.fireDate = NSDate.distantPast//跑
        } else if blankingWorkTimeLogVo?.status.intValue == 2 {
            self.buttonWanGong.isHidden = false
            self.buttonJiXu.isHidden = false
            _secondsCountUp = CLong((blankingWorkTimeLogVo?.workTime)!)
            self.countDownTimer.fireDate = NSDate.distantFuture//停
        } else if blankingWorkTimeLogVo?.status.intValue == 3 {
            self.buttonWanGong.isHidden = false
            self.buttonZanTing.isHidden = false
            let actu = NSDate.init().timeIntervalSince(ToolTransition.date(from: blankingWorkTimeLogVo?.actualendDateTime))*1000
            
            let work = Double((blankingWorkTimeLogVo?.workTime)!)
            
            _secondsCountUp = CLong(actu + work)
            self.countDownTimer.fireDate = NSDate.distantPast//跑
        } else if blankingWorkTimeLogVo?.status.intValue == 4 {
            _secondsCountUp = 0;
            self.countDownTimer.fireDate = NSDate.distantFuture//停
            
            let vc = XiaLiaoCompleteVC.init()
            vc.blankingWorkTimeLogVo = self.blankingWorkTimeLogVo
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        showTimeLabel()
        
        let planTime: Int = Int((blankingWorkTimeLogVo?.planWorkTime)!)
        let planTime1: Double = (Double((blankingWorkTimeLogVo?.planWorkTime)!) - Double(planTime))*60

        
        
        let surplusTime: Int = Int((blankingWorkTimeLogVo?.surplusTime)!)
        let surplusTime1: Double = (Double((blankingWorkTimeLogVo?.surplusTime)!) - Double(surplusTime))*60
        if GlobalSettingManager.share().showPlanHour == 1 {
            self._arrayR =  ["下料单号","生产单元","操作员","本道工序","计划工时","剩余总工时"]
            self._arrayL = [blankingWorkTimeLogVo?.blankingCode,blankingWorkTimeLogVo?.workUnitText,blankingWorkTimeLogVo?.confirmUserText,blankingWorkTimeLogVo?.operationText,String(format: "%d小时%d分", planTime,Int(round(planTime1))),String(format: "%d小时%02d分", surplusTime,Int(round(surplusTime1)))] as? [String]
        } else {
            self._arrayR =  ["下料单号","生产单元","操作员","本道工序"]
            self._arrayL = [blankingWorkTimeLogVo?.blankingCode,blankingWorkTimeLogVo?.workUnitText,blankingWorkTimeLogVo?.confirmUserText,blankingWorkTimeLogVo?.operationText] as? [String]
        }
        
        self.tableView.reloadData()
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

}
