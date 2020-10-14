//
//  OQCJianYanJieGuoVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class OQCJianYanJieGuoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var materialOutgoingOrderCheckVo: MaterialOutgoingOrderCheckVo!
    
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    
    var _viewLoading: UIView!
    var _uploadImageView: UploadImageView!
    
    private var bool001: Bool = true
    private var bool002: Bool = false
    private var bool003: Bool = false
    
    var arrayDateImageView1: NSMutableArray = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
        if model.status.intValue == 1 {
            self.viewBottom.isHidden = true
        } else {
            self.viewBottom.isHidden = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!
        let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
        model.causeCodes = [];
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        
        _uploadImageView = UploadImageView.uploadImage()
        _uploadImageView.frame = self.view.frame
         self.view.addSubview(_uploadImageView)
        _uploadImageView.isHidden = true
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.register(UINib.init(nibName: "OQCJYJGCell", bundle: nil), forCellReuseIdentifier: "oQCJYJGCell")
        self.tableView.register(UINib.init(nibName: "OQCJYJGCell1", bundle: nil), forCellReuseIdentifier: "oQCJYJGCell1")
        self.tableView.register(UINib.init(nibName: "OQCLabelAndTextFieldCell", bundle: nil), forCellReuseIdentifier: "oQCLabelAndTextFieldCell")
        self.tableView.register(UINib.init(nibName: "OQCLabelAndLabelCell", bundle: nil), forCellReuseIdentifier: "oQCLabelAndLabelCell")
        self.tableView.register(UINib.init(nibName: "OQCLabelAndTextFieldCell1", bundle: nil), forCellReuseIdentifier: "oQCLabelAndTextFieldCell1")
        self.tableView.register(UINib.init(nibName: "OQCLabelAndButtonCell", bundle: nil), forCellReuseIdentifier: "oQCLabelAndButtonCell")
        self.tableView.register(UINib.init(nibName: "OQCLabelAndTextFieldCell2", bundle: nil), forCellReuseIdentifier: "oQCLabelAndTextFieldCell2")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()
//        self.tableView.estimatedRowHeight = 44
//        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 5
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  indexPath.section == 0{
            return 125
        } else if indexPath.section == 1 {
            let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
            if indexPath.row == 2 {
                if model.sourceFlag.intValue == 1 {
                    return 0
                } else {
                    return 44
                }
            } else if indexPath.row == 3 {
                if model.status.intValue == 1 {//已检验
                    return 0
                } else {//待检验
                    if model.unQualifiedQuantity.doubleValue > 0 {
                        return 44
                    } else {
                        return 0
                    }
                }
            } else {
                return 44
            }
        } else {
            return 0;
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: OQCJYJGCell = tableView.dequeueReusableCell(withIdentifier: "oQCJYJGCell", for: indexPath) as! OQCJYJGCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
            cell.label0.text = "项目编号：" + model.projectNum
            cell.label1.text = "物料名称：" + model.materialText
            cell.labelBatch.text = "批次：" + model.lotNum
            cell.label2.text = "发货数量：" + model.planQuantity.stringValue
            return cell
        } else {
            if indexPath.row == 0 {
                let cell: OQCLabelAndTextFieldCell = tableView.dequeueReusableCell(withIdentifier: "oQCLabelAndTextFieldCell", for: indexPath) as! OQCLabelAndTextFieldCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.label0.text = "实发数"
                cell.textField0.placeholder = "请输入实发数"
                let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
                if model.status.intValue == 1 {//已检验
                    if model.actualQuantity.doubleValue != 0 {
                        cell.textField0.text = "\(NSNumber.init(value: model.actualQuantity.intValue))"
                    } else {
                        cell.textField0.text = "0"
                    }
                    cell.textField0.isEnabled = false
                } else {//待检验
                    if self.bool001 == true {
                        if model.actualQuantity.doubleValue != 0 {
                            cell.textField0.text = "\(NSNumber.init(value: model.actualQuantity.intValue))"
                        } else {
                            cell.textField0.text = "0"
                        }
                    } else {
                        cell.textField0.text = nil
                    }
                    cell.textField0.isEnabled = true
                }
                
                cell.textField0.addTarget(self, action: #selector(textField0Click(sender:)), for: UIControlEvents.editingChanged)
                cell.textField0.inputAccessoryView = self.addToolbar()
                return cell
            } else if indexPath.row == 1 {
                let cell: OQCLabelAndLabelCell = tableView.dequeueReusableCell(withIdentifier: "oQCLabelAndLabelCell", for: indexPath) as! OQCLabelAndLabelCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                
                let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
                cell.label0.text = "合格数"
                cell.label1.text = "\(model.qualifiedQuantity.intValue)"
                return cell
            } else if indexPath.row == 2 {
                
                let cell: OQCLabelAndTextFieldCell1 = tableView.dequeueReusableCell(withIdentifier: "oQCLabelAndTextFieldCell1", for: indexPath) as! OQCLabelAndTextFieldCell1
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.label0.text = "不合格数"
                cell.textField0.placeholder = "请输入不合格数量"
                let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
                if model.sourceFlag.intValue == 1 {
                    cell.isHidden = true
                } else {
                    cell.isHidden = false
                }
                
                if model.status.intValue == 1 {//已检验
                    if model.unQualifiedQuantity.doubleValue != 0 {
                        cell.textField0.text = "\(NSNumber.init(value: model.unQualifiedQuantity.intValue))"
                    } else {
                        cell.textField0.text = "0"
                    }
                    cell.textField0.isEnabled = false
                } else {//待检验
                    if self.bool002 == true {
                        if model.unQualifiedQuantity.doubleValue != 0 {
                            cell.textField0.text = "\(NSNumber.init(value: model.unQualifiedQuantity.intValue))"
                        } else {
                            cell.textField0.text = "0"
                        }
                    } else {
                        cell.textField0.text = nil
                    }
                    cell.textField0.isEnabled = true
                }
                
                cell.textField0.addTarget(self, action: #selector(textField1Click(sender:)), for: UIControlEvents.editingChanged)
                cell.textField0.inputAccessoryView = self.addToolbar()
                return cell
            } else if indexPath.row == 3 {
                let cell: OQCLabelAndButtonCell = tableView.dequeueReusableCell(withIdentifier: "oQCLabelAndButtonCell", for: indexPath) as! OQCLabelAndButtonCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
                if model.status.intValue == 1 {//已检验
                    cell.isHidden = true
                } else {//待检验
                    cell.isHidden = true
                    if model.unQualifiedQuantity.doubleValue > 0 {
                        cell.isHidden = false
                    }
                }
                
                cell.buttonQueXianYuanYing.isHidden = true
                cell.buttonQueXianYuanYingXuanZe.isHidden = true
                
                if ((self.materialOutgoingOrderCheckVo?.scrappedCauseDetailVos) != nil) {
                    let arrayTemp = NSMutableArray.init()
                    for temp in self.materialOutgoingOrderCheckVo.scrappedCauseDetailVos {
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
                cell.buttonQueXianYuanYing.addTarget(self, action: #selector(buttonQueXianYuanYingQingXuanZe(sender:)), for: UIControlEvents.touchUpInside)
                cell.buttonQueXianYuanYingXuanZe.addTarget(self, action: #selector(buttonQueXianYuanYingQingXuanZe(sender:)), for: UIControlEvents.touchUpInside)

                return cell
            } else {
                let cell: OQCLabelAndTextFieldCell2 = tableView.dequeueReusableCell(withIdentifier: "oQCLabelAndTextFieldCell2", for: indexPath) as! OQCLabelAndTextFieldCell2
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.label0.text = "检验数"
                cell.textField0.placeholder = "请输入检验数"
                let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
//                if model.status.intValue == 1 {//已检验
//                    if model.checkQuantity.doubleValue != 0 {
//                        cell.textField0.text = "\(NSNumber.init(value: model.checkQuantity.intValue))"
//                    } else {
//                        cell.textField0.text = "0"
//                    }
//                    cell.textField0.isEnabled = false
//                } else {//待检验
//                    if self.bool003 == true {
//                        if model.checkQuantity.doubleValue != 0 {
//                            cell.textField0.text = "\(NSNumber.init(value: model.checkQuantity.intValue))"
//                        } else {
//                            cell.textField0.text = "0"
//                        }
//                    } else {
//                        cell.textField0.text = nil
//                    }
//                }
                
                cell.textField0.isEnabled = false
                cell.textField0.text = "\(NSNumber.init(value: model.checkQuantity.intValue))"
                
                cell.textField0.addTarget(self, action: #selector(textField4Click(sender:)), for: UIControlEvents.editingChanged)
                cell.textField0.inputAccessoryView = self.addToolbar()
                return cell
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    @objc func textField0Click(sender: UITextField) {
        let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
        if sender.text?.count ?? 0 > 0 {
            self.bool001 = true
            model.actualQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            self.bool001 = false
            model.actualQuantity = NSNumber.init(value: 0)
        }
        
        if model.actualQuantity.doubleValue > model.planQuantity.doubleValue {
            model.actualQuantity = model.planQuantity
        }
        
        
        let double0: Double = model.actualQuantity.doubleValue - model.unQualifiedQuantity.doubleValue
        model.qualifiedQuantity = NSNumber.init(value: double0)
        
        model.checkQuantity = model.actualQuantity
        self.tableView.reloadRows(at: [IndexPath.init(row: 3, section: 1)], with: UITableViewRowAnimation.none)
    }
    
    @objc func textField1Click(sender: UITextField) {
        let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
        if sender.text?.count ?? 0 > 0 {
            self.bool002 = true
            model.unQualifiedQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            self.bool002 = false
            model.unQualifiedQuantity = NSNumber.init(value: 0)
        }
        if model.unQualifiedQuantity.doubleValue > model.actualQuantity.doubleValue {
            model.unQualifiedQuantity = model.actualQuantity
        }
        let double0: Double = model.actualQuantity.doubleValue - model.unQualifiedQuantity.doubleValue
        model.qualifiedQuantity = NSNumber.init(value: double0)
        
        model.checkQuantity = model.actualQuantity
        self.tableView.reloadRows(at: [IndexPath.init(row: 3, section: 1)], with: UITableViewRowAnimation.none)
    }
    
    @objc func buttonQueXianYuanYingQingXuanZe(sender: UIButton) {
        //需要验证
        let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo

        let vc = SelectScrapReasonVC.init()
        vc.typeUploadImageName = "defectFiles"
        vc.stage = "OQC"
        vc.materialCode = model.materialCode
        if ((self.materialOutgoingOrderCheckVo?.scrappedCauseDetailVos) != nil) {
            vc.causeDetailVos = self.materialOutgoingOrderCheckVo.scrappedCauseDetailVos.mutableCopy() as? NSMutableArray
        } else {
            NSLog("%@", "不存在")
        }
        vc.blockArrayCauseDetailVo = { causeDetailVos in
            self.materialOutgoingOrderCheckVo.scrappedCauseDetailVos = causeDetailVos!
            self.tableView.reloadRows(at: [IndexPath.init(row: 3, section: 1)], with: .none)
            
        }
        vc.quantity = model.unQualifiedQuantity.doubleValue
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func textField4Click(sender: UITextField) {
        let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
        if sender.text?.count ?? 0 > 0 {
            self.bool003 = true
            model.checkQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            self.bool003 = false
            model.checkQuantity = NSNumber.init(value: 0)
        }
        if model.checkQuantity.doubleValue > model.actualQuantity.doubleValue {
            model.checkQuantity = model.actualQuantity
        }
        let double0: Double = model.actualQuantity.doubleValue - model.unQualifiedQuantity.doubleValue - model.checkQuantity.doubleValue
        model.qualifiedQuantity = NSNumber.init(value: double0)
    }
    
    
    
//    MARK: 提交
    @IBAction func buttonCommit(_ sender: Any) {
        let model = self.materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList[0] as! MaterialOutgoingOrderDetailInventoryLotnumVo
        
        if model.unQualifiedQuantity.doubleValue > model.planQuantity.doubleValue {
            MyAlertCenter.default().postAlert(withMessage: "不合格数不能大于发货数")
            return;
        }
        if model.checkQuantity.doubleValue > model.planQuantity.doubleValue {
            MyAlertCenter.default().postAlert(withMessage: "检验数不能大于发货数")
            return;
        }
        
        if model.unQualifiedQuantity.doubleValue > 0 {
            if ((self.materialOutgoingOrderCheckVo?.scrappedCauseDetailVos) != nil) {
                var total = 0.0
                for i in 0..<self.materialOutgoingOrderCheckVo.scrappedCauseDetailVos.count {
                    let causeDetailVo = self.materialOutgoingOrderCheckVo.scrappedCauseDetailVos[i] as! CauseDetailVo
                    total = total + causeDetailVo.quantity.doubleValue
                }
                if total > model.unQualifiedQuantity.doubleValue {
                    MyAlertCenter.default()?.postAlert(withMessage: "不得大于缺陷总数")
                    return
                }
            }
        }
        
        _uploadImageView.isHidden = false
        _uploadImageView.prepare()
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        
        let materialOutgoingOrderCheckVo = MaterialOutgoingOrderCheckVo()
        materialOutgoingOrderCheckVo.siteCode = self.materialOutgoingOrderCheckVo.siteCode
        materialOutgoingOrderCheckVo.outgoingOrderNum = self.materialOutgoingOrderCheckVo.outgoingOrderNum
        materialOutgoingOrderCheckVo.operatorUser = self.materialOutgoingOrderCheckVo.operatorUser
        materialOutgoingOrderCheckVo.sourceFlag = model.sourceFlag
        

        
        var arrayTemp: [MaterialOutgoingOrderDetailInventoryLotnumVo] = []
        
        model.actualQuantity = NSNumber.init(value: floor(model.actualQuantity.doubleValue))
        model.qualifiedQuantity = NSNumber.init(value: floor(model.qualifiedQuantity.doubleValue))
        model.checkQuantity = NSNumber.init(value: floor(model.checkQuantity.doubleValue))
        model.planQuantity = NSNumber.init(value: floor(model.planQuantity.doubleValue))
        
        arrayTemp.append(model)
        
        materialOutgoingOrderCheckVo.materialOutgoingOrderDetailInventoryLotnumVoList = NSMutableArray.init(array: arrayTemp)
        
        var imageArray:[UploadImageBean] = []
        
        if model.unQualifiedQuantity.doubleValue > 0 {
            if ((self.materialOutgoingOrderCheckVo?.scrappedCauseDetailVos) != nil) {
                let arrayTemp = NSMutableArray.init()
                for temp in self.materialOutgoingOrderCheckVo.scrappedCauseDetailVos {
                    let causeDetailVo = temp as! CauseDetailVo
                    if causeDetailVo.quantity.doubleValue > 0 {
                        for i in 0..<causeDetailVo.uploadImageBeanList.count {
                            let uploadImageBean = causeDetailVo.uploadImageBeanList[i] as! UploadImageBean
                            imageArray.append(uploadImageBean)
                        }
                        arrayTemp.add(causeDetailVo)
                    }
                }
                materialOutgoingOrderCheckVo.scrappedCauseDetailVos = arrayTemp
                for temp in materialOutgoingOrderCheckVo.scrappedCauseDetailVos {
                    let causeDetailVo = temp as! CauseDetailVo
                    causeDetailVo.uploadImageBeanList = NSMutableArray.init()
                }
            }
        }

        
        mesPostEntityBean.entity = materialOutgoingOrderCheckVo.mj_keyValues() as! [AnyHashable : Any]!
        let jsonStr = mesPostEntityBean.mj_JSONString() //model - object
        
        let dic = ["data":jsonStr!]
    
        
        HttpMamager.postRequestImage(withURLString: DYZ_materialOutgoingOrder_updateMaterialOutgoingOrderDetailForCheck, parameters: dic, uploadImageBean: imageArray, success: { (responseObjectModel: Any?) in
            
            let returnMsgBean: ReturnMsgBean = ReturnMsgBean.mj_object(withKeyValues: responseObjectModel)
            
            self._uploadImageView.isHidden = true
            if returnMsgBean.status == "SUCCESS" {
                MyAlertCenter.default().postAlert(withMessage: "提交成功")
                model.status = NSNumber.init(value: 1)
                self.navigationController?.popViewController(animated: true)
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
        },progress: { (progress) in
            DispatchQueue.main.async {
                self._uploadImageView.progressView?.progress =  Float(progress?.fractionCompleted ?? 0)
                if progress?.fractionCompleted == 1 {
                    self._uploadImageView.loadFinish()
                }
            }
        }, fail: { (error: Error?) in
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
//        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: UITableViewRowAnimation.none)
        self.tableView.reloadSections([1], with: UITableViewRowAnimation.none)
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
