//
//  OQCViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit
import AVFoundation

class OQCViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var imagePicker: UIImagePickerController!
    
    var arrayMaterialOutgoingOrderDetailInventoryLotnumVo : [MaterialOutgoingOrderDetailInventoryLotnumVo]! = []
    
    var requestStr: String?
    
    private var _arrayDateImageView0: [Data] = []
    
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    
    private var _viewLoading: UIView!
    
    @IBOutlet weak var viewZhong0: UIView!
    @IBOutlet weak var viewZhong1: UIView!
    @IBOutlet weak var labelkehu: UILabel!
    
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
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!
        self.heightBottomBar1.constant = _height_BottomBar!
        
//        self.viewZhong0.isHidden = true
//        self.viewBottom0.isHidden = true
        self.viewZhong1.isHidden = true
        self.viewBottom1.isHidden = true
        
        
        self.tableView.register(UINib.init(nibName: "OQCCell0", bundle: nil), forCellReuseIdentifier: "oQCCell0")
        self.tableView.register(UINib.init(nibName: "OQCcell", bundle: nil), forCellReuseIdentifier: "oQCcell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension

        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true

        self.setAttributedString(text: "摄像头对准发货单二维码，\n点击扫描")//设置中间字颜色
        
        self.textField.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMaterialOutgoingOrderDetailInventoryLotnumVo.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < self.arrayMaterialOutgoingOrderDetailInventoryLotnumVo.count {
            let cell: OQCCell0 = tableView.dequeueReusableCell(withIdentifier: "oQCCell0", for: indexPath) as! OQCCell0
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            let materialOutgoingOrderDetailVo = self.arrayMaterialOutgoingOrderDetailInventoryLotnumVo[indexPath.row]
            cell.label0.text = materialOutgoingOrderDetailVo.projectNum
            cell.label1.text = materialOutgoingOrderDetailVo.materialText
            cell.labelBatch.text = materialOutgoingOrderDetailVo.lotNum
                
            cell.label2.text = materialOutgoingOrderDetailVo.planQuantity.stringValue
            
            
            cell.label3.isHidden = true
            cell.label4.isHidden = true
            
            if  materialOutgoingOrderDetailVo.status.intValue == 1 {//已检验
                cell.label4.isHidden = false
            } else {//待检验
                cell.label3.isHidden = false
            }
            return cell
        } else {
            let cell: OQCcell = tableView.dequeueReusableCell(withIdentifier: "oQCcell", for: indexPath) as! OQCcell
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userInfo = UserInfoVo.mj_object(withKeyValues: loginModel.tpfUser)

        let model = MaterialOutgoingOrderCheckVo()
        model.siteCode = userInfo!.siteCode
        model.outgoingOrderNum = self.requestStr!
        model.operatorUser = userInfo!.userCode
        model.materialOutgoingOrderDetailInventoryLotnumVoList = [self.arrayMaterialOutgoingOrderDetailInventoryLotnumVo[indexPath.row]]
        
        let vc = OQCJianYanJieGuoVC()
        vc.materialOutgoingOrderCheckVo = model
        
        let entity = vc.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
        
        if entity.status.intValue == 0 {
            entity.actualQuantity = entity.planQuantity
            entity.qualifiedQuantity = entity.actualQuantity

            entity.unQualifiedQuantity = NSNumber.init(value: 0)
            entity.checkQuantity = entity.actualQuantity
        } else {
//            if var actualQuantity = entity.actualQuantity {
//
//            } else {
//                entity.actualQuantity = 0
//            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
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
    @IBAction func buttonScan(_ sender: Any) {
        let saoyiSao = SaoYiSaoVC()
        saoyiSao.scanTitle = "扫描发货单号"
        saoyiSao.resultBlock = {(result: String!) -> () in
            //http://192.168.66.198:9090/gateway/rest/mes/materialOutgoingOrder/getMaterialOutgoingOrderDetailList/A00000499/OO_201907080001
            if let temp = result {
                let arr = temp.components(separatedBy: "/")
                self.request(result: arr.last)
            } else {
                self.request(result: nil)
            }
            
        }
        self.present(saoyiSao, animated: true, completion: nil)
    }
    
    func request(result: String?) {
        
        
        _viewLoading.isHidden = false
        
        self.requestStr = result
        
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean: MesPostEntityBean =  MesPostEntityBean.init()
        let materialOutgoingOrderDetailVo: MaterialOutgoingOrderDetailVo = MaterialOutgoingOrderDetailVo.init()
        materialOutgoingOrderDetailVo.siteCode = siteCode
        materialOutgoingOrderDetailVo.outgoingOrderNum = result
        mesPostEntityBean.entity = materialOutgoingOrderDetailVo.mj_keyValues() as! [AnyHashable : Any]
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        
        HttpMamager.postRequest(withURLString: DYZ_materialOutgoingOrder_getMaterialOutgoingOrderDetailList, parameters: dic, success: { (responseObjectModel: Any?) in
            let returnEntityBean: ReturnListBean = responseObjectModel as! ReturnListBean
            
            self._viewLoading.isHidden = true
            if returnEntityBean.status == "SUCCESS" {
                self.viewZhong0.isHidden = true
                self.viewBottom0.isHidden = true
                self.viewZhong1.isHidden = true
                self.viewBottom1.isHidden = true
                
                self.arrayMaterialOutgoingOrderDetailInventoryLotnumVo = []
                for value in returnEntityBean.list {
                    let model: MaterialOutgoingOrderDetailInventoryLotnumVo = MaterialOutgoingOrderDetailInventoryLotnumVo.mj_object(withKeyValues: value)
                    self.arrayMaterialOutgoingOrderDetailInventoryLotnumVo.append(model)
                    
                    self.labelkehu.text = "客户-"+model.supplierText
                    self.textField.text = result
                    
                }
                
                if self.arrayMaterialOutgoingOrderDetailInventoryLotnumVo.count == 0 {
                    self.viewZhong0.isHidden = false
                    self.viewBottom0.isHidden = false
                } else {
                    self.viewZhong1.isHidden = false
                    self.viewBottom1.isHidden = false
                }
                
                self.tableView.reloadData()
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
            }
            
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
        
    }
    
    //MARK: 批量提交
    @IBAction func buttonCommit(_ sender: Any) {
        _viewLoading.isHidden = false
        
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userInfo = UserInfoVo.mj_object(withKeyValues: loginModel.tpfUser)
        
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean()
        let materialOutgoingOrderCheckVo = MaterialOutgoingOrderCheckVo()
        materialOutgoingOrderCheckVo.siteCode = userInfo!.siteCode
        materialOutgoingOrderCheckVo.outgoingOrderNum = self.requestStr!
        materialOutgoingOrderCheckVo.operatorUser = userInfo!.userCode
//        materialOutgoingOrderCheckVo.causeCodes
        
        
        var arrayTemp: [MaterialOutgoingOrderDetailInventoryLotnumVo] = []
        for value in self.arrayMaterialOutgoingOrderDetailInventoryLotnumVo {
            if value.status.intValue == 0 {
                value.actualQuantity = NSNumber.init(value: floor(value.planQuantity.doubleValue)) //向下取整
                value.qualifiedQuantity = NSNumber.init(value: floor(value.planQuantity.doubleValue)) //向下取整
                value.unQualifiedQuantity = 0
                value.checkQuantity = NSNumber.init(value: value.qualifiedQuantity.doubleValue + value.unQualifiedQuantity.doubleValue)
                arrayTemp.append(value)
            }
        }
        if arrayTemp.count == 0 {
            MyAlertCenter.default().postAlert(withMessage: "已全部检验，请勿重复提交")
            _viewLoading.isHidden = true
            return
        }
        
        
        
        materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList =  NSMutableArray.init(array: arrayTemp)
        
        
        if self.arrayMaterialOutgoingOrderDetailInventoryLotnumVo.count > 0 {
            let temp:MaterialOutgoingOrderDetailInventoryLotnumVo = self.arrayMaterialOutgoingOrderDetailInventoryLotnumVo.first!;
            materialOutgoingOrderCheckVo.sourceFlag = temp.sourceFlag;
        }
                
        mesPostEntityBean.entity = materialOutgoingOrderCheckVo.mj_keyValues() as! [AnyHashable : Any]!
        let jsonStr = mesPostEntityBean.mj_JSONString()
        let dic = ["data":jsonStr!]
        
        var uploadImageArray: [UploadImageBean] = []
        for data in _arrayDateImageView0 {
            let uploadImageBean = UploadImageBean.init()
            uploadImageBean.data = data
            uploadImageBean.name = "outgoingFiles"
            
            let formatter = DateFormatter.init()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let strDate = formatter.string(from: Date.init())
            uploadImageBean.fileName = strDate+".png"
            
            uploadImageBean.mimeType = "image/png"
            uploadImageArray.append(uploadImageBean)
        }
        
        HttpMamager.postRequestImage(withURLString: DYZ_materialOutgoingOrder_updateMaterialOutgoingOrderDetails, parameters: dic, uploadImageBean: uploadImageArray, success: { (responseObjectModel: Any?) in
            
            let returnMsgBean = responseObjectModel as! ReturnMsgBean
            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {
                var aa: Bool = false
                for value in self.arrayMaterialOutgoingOrderDetailInventoryLotnumVo {
                    if value.status.intValue == 0 {//待检验
                        aa = true
                    }
                }
                if aa == true {
                    MyAlertCenter.default().postAlert(withMessage: "提交成功")
                } else {
                    MyAlertCenter.default().postAlert(withMessage: "已全部提交，无需重复提交")
                }
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
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: UITableViewRowAnimation.none)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonClickChaKanDaTu(sender: UIButton) {
        let tpfShanChuTuPianVC: TpfShanChuTuPianVC = TpfShanChuTuPianVC()
        tpfShanChuTuPianVC.arrayDataImage = NSMutableArray.init(array: self._arrayDateImageView0)
        tpfShanChuTuPianVC.index = sender.tag
        tpfShanChuTuPianVC.buttonBackBlock = {(arrayDataImage: NSMutableArray!) -> () in
            self._arrayDateImageView0 = arrayDataImage as! [Data]
            self.tableView.reloadRows(at: [IndexPath.init(row: self.arrayMaterialOutgoingOrderDetailInventoryLotnumVo.count, section: 0)], with: UITableViewRowAnimation.none)
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
