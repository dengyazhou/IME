//
//  XunJianTiJiaoVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/9.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit
import AVFoundation

class XunJianTiJiaoVC: UIViewController, UITableViewDelegate, UITableViewDataSource , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    
    var _viewLoading: UIView!
    var _uploadImageView: UploadImageView!
    
    var routingInspectionVo: RoutingInspectionVo!
    var operationText: String!
    
    var arrayCauseCode: NSMutableArray = []

    var arrayDateImageView1: NSMutableArray = []
    
    private var _arrayDateImageView0: NSMutableArray = []
    
    private var bool001: Bool = false
    private var bool002: Bool = false
    
    private var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        _uploadImageView = UploadImageView.uploadImage()
        _uploadImageView.frame = self.view.frame
         self.view.addSubview(_uploadImageView)
        _uploadImageView.isHidden = true
        
        self.routingInspectionVo.routingCompletedQuantity = NSNumber.init(value: 0)
        self.routingInspectionVo.routingScrapQuantity = NSNumber.init(value: 0)
        self.routingInspectionVo.isRepairFlag = NSNumber.init(value: 0)
        
        
        self.tableView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "cell")
        self.tableView.register(UINib.init(nibName: "XunJianTJCell0", bundle: nil), forCellReuseIdentifier: "xunJianTJCell0")
        self.tableView.register(UINib.init(nibName: "XunJianTJCell", bundle: nil), forCellReuseIdentifier: "xunJianTJCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()
        
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
    
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell :XunJianTJCell0 = tableView.dequeueReusableCell(withIdentifier: "xunJianTJCell0", for: indexPath) as! XunJianTJCell0
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.label01.text = "\(self.routingInspectionVo.routingCompletedQuantity.intValue + self.routingInspectionVo.routingScrapQuantity.intValue)"
            
            if self.bool001 == true {
                if self.routingInspectionVo.routingCompletedQuantity.doubleValue != 0 {
                    cell.textField01.text = "\(NSNumber.init(value: self.routingInspectionVo.routingCompletedQuantity.intValue))"
                } else {
                    cell.textField01.text = "0"
                }
            } else {
                cell.textField01.text = nil
            }
            
            cell.textField01.addTarget(self, action: #selector(textField0Click(sender:)), for: UIControlEvents.editingChanged)
            cell.textField01.inputAccessoryView = self.addToolbar()
            
            if self.bool002 == true {
                if self.routingInspectionVo.routingScrapQuantity.doubleValue != 0 {
                    cell.textField02.text = "\(NSNumber.init(value: self.routingInspectionVo.routingScrapQuantity.intValue))"
                } else {
                    cell.textField02.text = "0"
                }
            } else {
                cell.textField02.text = nil
            }
            
            cell.textField02.addTarget(self, action: #selector(textField1Click(sender:)), for: UIControlEvents.editingChanged)
            cell.textField02.inputAccessoryView = self.addToolbar()
            
            cell.view3.isHidden = true
            cell.view4.isHidden = true
            if self.routingInspectionVo.routingScrapQuantity.doubleValue > 0 {
                cell.view3.isHidden = false
                cell.view4.isHidden = false
            }
            
            cell.buttonQueXianYuanYing.isHidden = true
            cell.buttonQueXianYuanYingXuanZe.isHidden = true
            
            if self.routingInspectionVo.routingScrapQuantity.doubleValue > 0 {
                if (self.routingInspectionVo!.scrappedCauseDetailVos != nil) {
                    let arrayTemp = NSMutableArray.init()
                    for temp in self.routingInspectionVo.scrappedCauseDetailVos {
                        let causeDetailVo = temp as! CauseDetailVo
                        if causeDetailVo.quantity.doubleValue > 0 {
                            arrayTemp.add(causeDetailVo)
                        }
                    }
                    
                    cell.buttonQueXianYuanYing.isHidden = false
                    cell.buttonQueXianYuanYing.setTitle("已选择\(arrayTemp.count)种", for: UIControlState.normal)
                } else {
                    cell.buttonQueXianYuanYingXuanZe.isHidden = false
                }
            }
            
        
            cell.buttonQueXianYuanYing.addTarget(self, action: #selector(buttonQueXianYuanYingQingXuanZe(sender:)), for: UIControlEvents.touchUpInside)
            cell.buttonQueXianYuanYingXuanZe.addTarget(self, action: #selector(buttonQueXianYuanYingQingXuanZe(sender:)), for: UIControlEvents.touchUpInside)
            
            cell.buttonShiFouFanXiu.isHidden = true
            cell.buttonShiFouFanXiuQingXuanZe.isHidden = true
            if self.routingInspectionVo.isRepairFlag.intValue == 2 {
                cell.buttonShiFouFanXiuQingXuanZe.isHidden = false
            } else {
                cell.buttonShiFouFanXiu.isHidden = false
                cell.buttonShiFouFanXiu.setTitle(self.routingInspectionVo.isRepairFlag.intValue==1 ? "是" : "否", for: UIControlState.normal)
            }
            cell.buttonShiFouFanXiu.addTarget(self, action: #selector(buttonShiFouFanXiu(sender:)), for: UIControlEvents.touchUpInside)
            cell.buttonShiFouFanXiuQingXuanZe.addTarget(self, action: #selector(buttonShiFouFanXiu(sender:)), for: UIControlEvents.touchUpInside)
            
            cell.arrayDateImage = _arrayDateImageView0 as! [UploadImageBean]
            cell.collectionView.reloadData()
            cell.buttonClickChaKanDaTuBlock { (rowYZ) in
                self.buttonClickChaKanDaTu(index: rowYZ)
            }
            cell.buttonAddImageBlock {
                self.addImage()
            }
            
            return cell
        } else {
            let cell :XunJianTJCell = tableView.dequeueReusableCell(withIdentifier: "xunJianTJCell", for: indexPath) as! XunJianTJCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.label0.text = "生产作业号：" + self.routingInspectionVo.productionControlNum
            if let operationText = self.operationText {
                cell.label1.text = "工序名称：" + operationText
            } else {
                cell.label1.text = "工序名称："
            }
            cell.label2.text = "物料名称：" + self.routingInspectionVo.materialText
            cell.label3.text = "作业数量：" + self.routingInspectionVo.controlQuantity.stringValue
            cell.label4.text = "完工数量：" + self.routingInspectionVo.qualifiedQuantity.stringValue
            cell.label5.text = "巡检人：" + self.routingInspectionVo.routingUserCode
            return cell
        }
    }
    
    @objc func textField0Click(sender: UITextField) {
        if sender.text?.count ?? 0 > 0 {
            self.bool001 = true
            self.routingInspectionVo.routingCompletedQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            self.bool001 = false
            self.routingInspectionVo.routingCompletedQuantity = NSNumber.init(value: 0)
        }
    }
    @objc func textField1Click(sender: UITextField) {
        if sender.text?.count ?? 0 > 0 {
            self.bool002 = true
            self.routingInspectionVo.routingScrapQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            self.bool002 = false
            self.routingInspectionVo.routingScrapQuantity = NSNumber.init(value: 0)
        }
        
    }
    @objc func buttonShiFouFanXiu(sender: UIButton) {
        let alertController: UIAlertController = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let action: UIAlertAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        let action1: UIAlertAction = UIAlertAction.init(title: "是", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            self.routingInspectionVo.isRepairFlag = NSNumber.init(value: 1)
            self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: UITableViewRowAnimation.none)
        }
        let action2: UIAlertAction = UIAlertAction.init(title: "否", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            self.routingInspectionVo.isRepairFlag = NSNumber.init(value: 0)
            self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: UITableViewRowAnimation.none)
        }
        alertController.addAction(action)
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func addImage() {
        if _arrayDateImageView0.count >= 10 {
            MyAlertCenter.default().postAlert(withMessage: "最多添加10张图片")
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
        
        var uploadImageBean: UploadImageBean = UploadImageBean()
        uploadImageBean.data = data
        uploadImageBean.name = "pictureFiles"
        var formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var strDate = formatter.string(from: Date.init())
        uploadImageBean.fileName = strDate + ".png"
        uploadImageBean.mimeType = "image/png"
        
        
        _arrayDateImageView0.add(uploadImageBean)
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: UITableViewRowAnimation.none)
        
        self.dismiss(animated: true, completion: nil)
    }
    
//    MARK: 缺陷原因
    @objc func buttonQueXianYuanYingQingXuanZe(sender: UIButton) {

        let vc = SelectScrapReasonVC.init()
        vc.typeUploadImageName = "defectPictureFiles"
        vc.stage = "IQC"
        vc.materialCode = self.routingInspectionVo.materialCode
        if (self.routingInspectionVo!.scrappedCauseDetailVos != nil) {
            NSLog("%@", "存在")
            vc.causeDetailVos = self.routingInspectionVo.scrappedCauseDetailVos.mutableCopy() as? NSMutableArray
        } else {
            NSLog("%@", "不存在")
        }
        vc.blockArrayCauseDetailVo = { causeDetailVos in
            self.routingInspectionVo.scrappedCauseDetailVos = causeDetailVos
            self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .none)
        }
        
        vc.quantity = self.routingInspectionVo.routingScrapQuantity.doubleValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func buttonClickChaKanDaTu(index: NSInteger) {
        let vc: TpfCheckBigPictureAndDeletePictureVC = TpfCheckBigPictureAndDeletePictureVC()
        vc.arrayUploadImageBean = _arrayDateImageView0
        vc.index = index
        vc.buttonBackBlock = {() in
            self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: UITableViewRowAnimation.none)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    MARK:提交
    @IBAction func buttonCommit(_ sender: Any) {
        if self.bool001 == true {
            if self.routingInspectionVo.routingCompletedQuantity.doubleValue > self.routingInspectionVo.qualifiedQuantity.doubleValue {
                MyAlertCenter.default().postAlert(withMessage: "合格数不能大于完工数")
                return;
            }
        } else {
            MyAlertCenter.default().postAlert(withMessage: "请输入合格数")
            return
        }
        
        
        if self.bool002 == true {
            if self.routingInspectionVo.routingScrapQuantity.doubleValue > self.routingInspectionVo.qualifiedQuantity.doubleValue {
                MyAlertCenter.default().postAlert(withMessage: "报废数不能大于完工数")
                return;
            }
        } else {
            MyAlertCenter.default().postAlert(withMessage: "请输入合格数")
            return
        }
        
        if self.routingInspectionVo.routingScrapQuantity.doubleValue > 0 {
            if (self.routingInspectionVo!.scrappedCauseDetailVos != nil) {
                var total = 0.0
                for i in 0..<self.routingInspectionVo.scrappedCauseDetailVos.count {
                    let causeDetailVo = self.routingInspectionVo.scrappedCauseDetailVos[i] as! CauseDetailVo
                    total = total + causeDetailVo.quantity.doubleValue
                }
                if total > self.routingInspectionVo.routingScrapQuantity.doubleValue {
                    MyAlertCenter.default()?.postAlert(withMessage: "不得大于缺陷总数")
                    return
                }
                
            }
        }
        
        _uploadImageView.isHidden = false
        _uploadImageView.prepare()
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean()
        let routingInspectionVo: RoutingInspectionVo = self.routingInspectionVo
        routingInspectionVo.routingDate = ToolTransition.string(from: Date())
        
        var imageArray:[UploadImageBean] = []
        
        for i in 0..<_arrayDateImageView0.count {
            let uploadImageBean = _arrayDateImageView0[i] as! UploadImageBean
            imageArray.append(uploadImageBean)
        }
        
        if self.routingInspectionVo.routingScrapQuantity.doubleValue > 0 {
            if (self.routingInspectionVo!.scrappedCauseDetailVos != nil) {
                let arrayTemp = NSMutableArray.init()
                for temp in self.routingInspectionVo.scrappedCauseDetailVos {
                    let causeDetailVo = temp as! CauseDetailVo
                    if causeDetailVo.quantity.doubleValue > 0 {
                        for i in 0..<causeDetailVo.uploadImageBeanList.count {
                            let uploadImageBean = causeDetailVo.uploadImageBeanList[i] as! UploadImageBean
                            imageArray.append(uploadImageBean)
                        }
                        arrayTemp.add(causeDetailVo)
                    }
                }
                routingInspectionVo.scrappedCauseDetailVos = arrayTemp
                
                for temp in routingInspectionVo.scrappedCauseDetailVos {
                    let causeDetailVo = temp as! CauseDetailVo
                    causeDetailVo.uploadImageBeanList = NSMutableArray.init()
                }
            }
        }
        
        
        
        mesPostEntityBean.entity = routingInspectionVo.mj_keyValues() as! [AnyHashable : Any]!
        let dic1 = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        let dic = ["data":getJSONStringFromDictionary(dictionary: dic1 as NSDictionary)]
        print(dic)
        
    
        HttpMamager.postRequestImage(withURLString: DYZ_routingInspection_updateRoutingInspectionProduction, parameters: dic, uploadImageBean: imageArray, success: { (responseObjectModel) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean
            self._uploadImageView.isHidden = true
            if returnMsgBean.status == "SUCCESS" {
                MyAlertCenter.default().postAlert(withMessage: "巡检成功")

                for value in (self.navigationController?.viewControllers)!{
                    if value.isMember(of: ScanXunJianRenYuanVC.classForCoder()) {
                        self.navigationController?.popToViewController(value, animated: true)
                        break
                    }
                }

            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
        }, progress: { (progress) in
            DispatchQueue.main.async {
                self._uploadImageView.progressView?.progress =  Float(progress?.fractionCompleted ?? 0)
                if progress?.fractionCompleted == 1 {
                    self._uploadImageView.loadFinish()
                }
            }
        }, fail: { (error) in
             self._uploadImageView.isHidden = true
        }, isKindOfModelClass: NSClassFromString("ReturnMsgBean"))
        
    }
    
    func addToolbar() -> UIToolbar {
        let toolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 38))
        toolbar.tintColor = colorRGB(r: 0, g: 168, b: 255)
        let space = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let bar = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(textFieldDone))
        toolbar.items = [space, bar]
        return toolbar
    }
    
    @objc func textFieldDone() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: UITableViewRowAnimation.none)
    }
    
    func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
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
