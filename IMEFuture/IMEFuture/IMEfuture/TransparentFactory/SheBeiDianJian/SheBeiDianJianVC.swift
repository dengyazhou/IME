    //
//  SheBeiDianJianVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit
    import AVFoundation

class SheBeiDianJianVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    private var imagePicker: UIImagePickerController!
    
    var arraySpotCheckUpLogVo: [SpotCheckUpLogVo]! = []
    
    private var _arrayDateImageView0: [Data] = []
    
    private let _height_NavBar = Height_NavBar!
    private let _height_BottomBar = Height_BottomBar!
    
    private var _viewLoading: UIView!
    
    @IBOutlet weak var viewZhong0: UIView!
    @IBOutlet weak var viewZhong1: UIView!
    
    @IBOutlet weak var viewBottom0: UIView!
    @IBOutlet weak var viewBottom1: UIView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar1: NSLayoutConstraint!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.heightNavBar.constant = _height_NavBar
        self.heightBottomBar.constant = _height_BottomBar
        self.heightBottomBar1.constant = _height_BottomBar
        
//        self.viewZhong0.isHidden = true
//        self.viewBottom0.isHidden = true
        self.viewZhong1.isHidden = true
        self.viewBottom1.isHidden = true
        
        self.tableView.register(UINib.init(nibName: "IQCJYJGCell", bundle: nil), forCellReuseIdentifier: "iQCJYJGCell")
        self.tableView.register(UINib.init(nibName: "SheBeiDianJianCell", bundle: nil), forCellReuseIdentifier: "sheBeiDianJianCell")
        self.tableView.register(UINib.init(nibName: "OQCcell", bundle: nil), forCellReuseIdentifier: "oQCcell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        self.setAttributedString(text: "摄像头对准作业单元二维码，\n点击扫描")
        
        self.textField.delegate = self
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  section == 0 {
            return 1
        } else {
            return self.arraySpotCheckUpLogVo.count + 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  indexPath.section == 0 {
            let cell: IQCJYJGCell = tableView.dequeueReusableCell(withIdentifier: "iQCJYJGCell", for: indexPath) as! IQCJYJGCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let spotCheckUpLogVo = self.arraySpotCheckUpLogVo.first
            if let spot = spotCheckUpLogVo {
                cell.label0.text = "设备编码：" + spot.equipmentCode
                cell.label1.text = "设备名称：" + spot.equipmentText
            }
            
            return cell
        } else {
            if indexPath.row < self.arraySpotCheckUpLogVo.count {
                let cell: SheBeiDianJianCell = tableView.dequeueReusableCell(withIdentifier: "sheBeiDianJianCell", for: indexPath) as! SheBeiDianJianCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let spotCheckUpLogVo = self.arraySpotCheckUpLogVo[indexPath.row]
                cell.label.text = spotCheckUpLogVo.spotName
                
                
                for view in cell.contentView.subviews {
                    if view.tag == 100 {
                        view.removeFromSuperview()
                    }
                }
                
                let view = YZSwitch.init(frame: CGRect(x: kMainW-84-15, y: (44-28)/2.0, width: 84, height: 28), with: spotCheckUpLogVo.result.int32Value) { ( type: Int32) in
                    spotCheckUpLogVo.result = NSNumber.init(value: type)
                }
                view?.tag = 100
                cell.contentView.addSubview(view!)
                
//                if spotCheckUpLogVo.result.intValue == 0 {
//                    cell.switch1.setOn(false, animated: false)
//                } else {
//                    cell.switch1.setOn(true, animated: false)
//                }
                
                cell.switch1.tag = indexPath.row
                cell.switch1.addTarget(self, action: #selector(switchAction(sender:)), for: UIControlEvents.valueChanged)
                
                return cell
            } else {
                let cell: OQCcell = tableView.dequeueReusableCell(withIdentifier: "oQCcell", for: indexPath) as! OQCcell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                
                cell.view40.isHidden = true
                cell.view41.isHidden = true
                cell.view42.isHidden = true
                if _arrayDateImageView0.count == 0 {
                    
                } else if _arrayDateImageView0.count == 1 {
                    cell.view40.isHidden = false
                    cell.imageView40.image = UIImage.init(data: _arrayDateImageView0[0] as! Data)
                } else if _arrayDateImageView0.count == 2 {
                    cell.view40.isHidden = false
                    cell.view41.isHidden = false
                    cell.imageView40.image = UIImage.init(data: _arrayDateImageView0[0] as! Data)
                    cell.imageView41.image = UIImage.init(data: _arrayDateImageView0[1] as! Data)
                } else if (_arrayDateImageView0.count == 3) {
                    cell.view40.isHidden = false
                    cell.view41.isHidden = false
                    cell.view42.isHidden = false
                    cell.imageView40.image = UIImage.init(data: _arrayDateImageView0[0] as! Data)
                    cell.imageView41.image = UIImage.init(data: _arrayDateImageView0[1] as! Data)
                    cell.imageView42.image = UIImage.init(data: _arrayDateImageView0[2] as! Data)
                }
                
                cell.button43.addTarget(self, action: #selector(addImage(sender:)), for: UIControlEvents.touchUpInside)
                
                cell.button40.addTarget(self, action: #selector(buttonClickChaKanDaTu(sender:)), for: UIControlEvents.touchUpInside)
                cell.button41.addTarget(self, action: #selector(buttonClickChaKanDaTu(sender:)), for: UIControlEvents.touchUpInside)
                cell.button42.addTarget(self, action: #selector(buttonClickChaKanDaTu(sender:)), for: UIControlEvents.touchUpInside)
                
                return cell
            }
        }
    }
    
    @objc func switchAction(sender: UISwitch) {
        let spotCheckUpLogVo = self.arraySpotCheckUpLogVo[sender.tag]
        if (sender.isOn) {
            
            spotCheckUpLogVo.result = NSNumber.init(value: 1)
        } else {
            
            spotCheckUpLogVo.result = NSNumber.init(value: 0)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        } else if section == 1 {
            return 30;
        } else {
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else if section == 1 {
            let view = UIView.init()
//            view.backgroundColor = UIColor.red
            
            let label = UIButton.init(frame: CGRect(x: 15, y: 0, width: kMainW-15, height: 30))
            label.setTitle("点检项", for: UIControlState.normal)
            label.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            label.setTitleColor(colorRGB(r: 153, g: 153, b: 153), for: UIControlState.normal)
            label.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
//            label.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
            view.addSubview(label)
            
            let viewLineBottom = UIView.init(frame: CGRect(x: 0, y: 29.5, width: kMainW, height: 0.5))
            viewLineBottom.backgroundColor = colorLine
            view.addSubview(viewLineBottom)
            
            return view
        } else {
            return nil
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.request(result: textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
//    MARK:扫描
    @IBAction func buttonScan(_ sender: Any) {
        let saoYiSao = SaoYiSaoVC()
        saoYiSao.scanTitle = "扫描作业单元"
        saoYiSao.resultBlock = {(result: String!) -> () in
            let jsonData = result.data(using: String.Encoding.utf8)
            let dic = try? JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyHashable : Any]
            if let a = dic {
                self.request(result: a["workUnitCode"] as? String)
            } else {
                self.request(result: nil)
            }
        }
        self.present(saoYiSao, animated: true, completion: nil)
    }
    
    func request(result: String?) {
        
        _viewLoading.isHidden = false
        self.textField.text = result
        
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        let spotCheckUpLogVo: SpotCheckUpLogVo = SpotCheckUpLogVo.init()
        spotCheckUpLogVo.siteCode = siteCode
        spotCheckUpLogVo.workUnitCode = result
        mesPostEntityBean.entity = spotCheckUpLogVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        HttpMamager.postRequest(withURLString: DYZ_spotCheckUpLog_selectSpotCheckUpLog, parameters: dic, success: { (responseObjectModel : Any?) in
            let returnListBean: ReturnListBean = responseObjectModel as! ReturnListBean
            self._viewLoading.isHidden = true
            if returnListBean.status == "SUCCESS" {
                self.viewZhong0.isHidden = true
                self.viewBottom0.isHidden = true
                self.viewZhong1.isHidden = true
                self.viewBottom1.isHidden = true
                
                self.arraySpotCheckUpLogVo = [];
                for value in returnListBean.list{
                    let spotCheckUpLogVo:SpotCheckUpLogVo = SpotCheckUpLogVo.mj_object(withKeyValues: value)
                    spotCheckUpLogVo.result = NSNumber.init(value: 1)
                    self.arraySpotCheckUpLogVo.append(spotCheckUpLogVo)
//                    self.textField.text = spotCheckUpLogVo.workUnitCode
                }
                
                if self.arraySpotCheckUpLogVo.count == 0 {
                    self.viewZhong0.isHidden = false
                    self.viewBottom0.isHidden = false
                } else {
                    self.viewZhong1.isHidden = false
                    self.viewBottom1.isHidden = false
                }
                
                self.tableView.reloadData()
            } else {
                self.textField.text = nil
                MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
            }
            
            
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
        
    }
    
//    MARK:提交
    @IBAction func buttonCommit(_ sender: Any) {
        _viewLoading.isHidden = false
        let loginModel = DatabaseTool.getLoginModel()
        
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel?.tpfUser)
        let siteCode = tpfUser?.siteCode
        let userCode = tpfUser?.userCode
    
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean()
        
        var arrayTemp: [SpotCheckUpLogVo] = []
        for value in self.arraySpotCheckUpLogVo {
            value.siteCode = siteCode
            value.operationUserCode = userCode
            arrayTemp.append(value)
        }
        
        mesPostEntityBean.entity = arrayTemp
        
        let jsonStr = mesPostEntityBean.mj_JSONString()
        
        let dic = ["data":jsonStr!]
        
        var uploadImageArray: [UploadImageBean] = []
        for data in _arrayDateImageView0 {
            let uploadImageBean = UploadImageBean.init()
            uploadImageBean.data = data
            uploadImageBean.name = "spotFiles"
            
            let formatter = DateFormatter.init()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let strDate = formatter.string(from: Date.init())
            uploadImageBean.fileName = strDate+".png"
            
            uploadImageBean.mimeType = "image/png"
            uploadImageArray.append(uploadImageBean)
        }
        
        HttpMamager.postRequestImage(withURLString: DYZ_spotCheckUpLog_updateSpotCheckUpLog, parameters: dic, uploadImageBean: uploadImageArray, success: { (responseObjectModel: Any?) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean
            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {

                MyAlertCenter.default().postAlert(withMessage: "提交成功")
                self.navigationController?.popViewController(animated: true)
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
                
            }
        }, progress: { (progress) in
            
        }, fail: { (error: Error?) in

        }, isKindOfModelClass: NSClassFromString("ReturnMsgBean"))

        
    }
    
    @objc func addImage(sender: UIButton) {
        if _arrayDateImageView0.count >= 3 {
            MyAlertCenter.default().postAlert(withMessage: "最多添加3张图片")
            return
        }
        
        let alertController: UIAlertController = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let action0: UIAlertAction = UIAlertAction.init(title: "拍照", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            let authStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
            if authStatus == AVAuthorizationStatus.restricted || authStatus == AVAuthorizationStatus.denied {
                self.imagePicker = UIImagePickerController()
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.imagePicker.delegate = self
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
                
                let alertController = UIAlertController.init(title: "请在iPhone的“设置－隐私”选项中，允许智造家访问你的摄像机和麦克风", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) in
                    self.imagePicker .dismiss(animated: true, completion: nil)
                })
                alertController.addAction(action)
                self.imagePicker.present(alertController, animated: true, completion: nil)
            } else {
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                    self.imagePicker = UIImagePickerController()
                    self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                    self.imagePicker.delegate = self
                    self.imagePicker.allowsEditing = false
                    self.present(self.imagePicker, animated: true, completion: nil)
                } else {
                    print("手机不支持相机")
                }
            }
        }
        let action1: UIAlertAction = UIAlertAction.init(title: "从手机相册选择", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                self.imagePicker = UIImagePickerController()
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.imagePicker.delegate = self
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        let action2: UIAlertAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        action0.setValue(UIColor.black, forKey: "titleTextColor")
        action1.setValue(UIColor.black, forKey: "titleTextColor")
        action2.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(action0)
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let size: CGSize = CGSize(width: 640, height: 640)
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let data: Data = UIImageJPEGRepresentation(newImage!, 1)!
        _arrayDateImageView0.append(data)
        self.tableView.reloadRows(at: [IndexPath.init(row: self.arraySpotCheckUpLogVo.count, section: 1)], with: UITableViewRowAnimation.none)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonClickChaKanDaTu(sender: UIButton) {
        let tpfShanChuTuPianVC: TpfShanChuTuPianVC = TpfShanChuTuPianVC()
        tpfShanChuTuPianVC.arrayDataImage = NSMutableArray.init(array: self._arrayDateImageView0)
        tpfShanChuTuPianVC.index = sender.tag
        tpfShanChuTuPianVC.buttonBackBlock = {(arrayDataImage: NSMutableArray!) -> () in
            self._arrayDateImageView0 = arrayDataImage as! [Data]
            self.tableView.reloadRows(at: [IndexPath.init(row: self.arraySpotCheckUpLogVo.count, section: 1)], with: UITableViewRowAnimation.none)
        }
        self.navigationController?.pushViewController(tpfShanChuTuPianVC, animated: true)
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
