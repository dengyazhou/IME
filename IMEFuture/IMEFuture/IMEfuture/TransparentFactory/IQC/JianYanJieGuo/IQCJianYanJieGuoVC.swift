//
//  IQCJianYanJieGuoVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/19.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class IQCJianYanJieGuoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    /**
     0:收货质检入库
     
     1:收货质检
     2:入库
     
     3:收货
     4:质检
     5:入库
    */
    var status: Int!
    
    @IBOutlet weak var labelTitle: UILabel!//标题
    @IBOutlet weak var button: UIButton!//底部按钮，权限在外面已经判断了，在这里就可以直接提交
    
    var materialArrivedOrderDetailVo: MaterialArrivedOrderDetailVo!
    
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    
    var _viewLoading: UIView!
    var _uploadImageView: UploadImageView!
    
    private var boolDaoHuoShu: Bool = true
    private var boolBuHeGeShu: Bool = false
    private var boolRangBuJieShou: Bool = false
    private var boolBaoFeiShu: Bool = false
    private var boolRuKuShu: Bool = false
    
    var arrayCauseCode: NSMutableArray = []
    var arrayDateImageView1: NSMutableArray = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        if status == 0 {
            self.labelTitle.text = "质检入库"
            self.materialArrivedOrderDetailVo.receivedQuantity = self.materialArrivedOrderDetailVo.planQuantity //到货数 默认等于 计划数
            self.materialArrivedOrderDetailVo.qualifiedQuantity = self.materialArrivedOrderDetailVo.receivedQuantity //合格数 默认等于 到货数
        } else if status == 1 {
            self.labelTitle.text = "收货质检"
            self.materialArrivedOrderDetailVo.receivedQuantity = self.materialArrivedOrderDetailVo.planQuantity //到货数 默认等于 计划数
            self.materialArrivedOrderDetailVo.qualifiedQuantity = self.materialArrivedOrderDetailVo.receivedQuantity //合格数 默认等于 到货数
        } else if status == 2 {
            self.labelTitle.text = "入库"
        } else if status == 3 {
            self.labelTitle.text = "收货"
            self.materialArrivedOrderDetailVo.receivedQuantity = self.materialArrivedOrderDetailVo.planQuantity //到货数 默认等于 计划数
        } else if status == 4 {
            self.labelTitle.text = "质检"
            self.materialArrivedOrderDetailVo.qualifiedQuantity = self.materialArrivedOrderDetailVo.receivedQuantity //合格数 默认等于 到货数
        } else if status == 5 {
            self.labelTitle.text = "入库"
        }
        self.button.setTitle(self.labelTitle.text, for: UIControl.State.normal)
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        _uploadImageView = UploadImageView.uploadImage()
        _uploadImageView.frame = self.view.frame
         self.view.addSubview(_uploadImageView)
        _uploadImageView.isHidden = true
        
//        self.tableView .register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.register(UINib.init(nibName: "IQCJYJGCell", bundle: nil), forCellReuseIdentifier: "iQCJYJGCell")
        self.tableView.register(UINib.init(nibName: "IQCJYJGCell1", bundle: nil), forCellReuseIdentifier: "iQCJYJGCell1")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    @objc func keyboardWillShow(note: NSNotification) {
        let keyBoardRect = note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0)
    }
    @objc func keyboardWillHide(note: NSNotification) {
        self.tableView.contentInset = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "iQCJYJGCell", for: indexPath) as! IQCJYJGCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.label0.text = "编号："+self.materialArrivedOrderDetailVo.materialCode
            cell.label1.text = "物料名称："+self.materialArrivedOrderDetailVo.materialText
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "iQCJYJGCell1", for: indexPath) as! IQCJYJGCell1
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.viewDaoHuoShu.isHidden = true
            cell.viewZhiJianShu.isHidden = true
            cell.viewRuKuShu.isHidden = true
            cell.viewHeGeShu.isHidden = true
            cell.viewBuHeGeShu.isHidden = true
            cell.viewQueXianReson.isHidden = true
            cell.viewRangBuJieShou.isHidden = true
            cell.viewRangBuReson.isHidden = true
            cell.viewBaoFeiShu.isHidden = true
            cell.viewBaoFeiReson.isHidden = true
            cell.viewXuLieZhuiZong.isHidden = true
            cell.viewGengGaiXuLieHao.isHidden = true
            
            if status == 0 {
                //"质检入库"
                cell.viewDaoHuoShu.isHidden = false
                cell.viewHeGeShu.isHidden = false
                cell.viewBuHeGeShu.isHidden = false
                cell.viewRangBuJieShou.isHidden = false
                cell.viewRangBuReson.isHidden = false
                cell.viewBaoFeiShu.isHidden = false
                cell.viewBaoFeiReson.isHidden = false
                
                
                cell.viewQueXianReson.isHidden = true
                if self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue > 0 {
                    cell.viewQueXianReson.isHidden = false
                }
            } else if status == 1 {
                //"收货质检"
                cell.viewDaoHuoShu.isHidden = false
                cell.viewHeGeShu.isHidden = false
                cell.viewBuHeGeShu.isHidden = false
                cell.viewRangBuJieShou.isHidden = false
                cell.viewRangBuReson.isHidden = false
                cell.viewBaoFeiShu.isHidden = false
                cell.viewBaoFeiReson.isHidden = false
                
                cell.viewQueXianReson.isHidden = true
                if self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue > 0 {
                    cell.viewQueXianReson.isHidden = false
                }
            } else if status == 2 {
                //"入库"
                cell.viewDaoHuoShu.isHidden = false
                cell.textFieldDaoHuoShu.isEnabled = false
                cell.viewZhiJianShu.isHidden = false
                cell.viewRuKuShu.isHidden = false
            } else if status == 3 {
                //"收货"
                cell.viewDaoHuoShu.isHidden = false
            } else if status == 4 {
                //"质检"
                cell.viewDaoHuoShu.isHidden = false
                cell.textFieldDaoHuoShu.isEnabled = false
                cell.viewHeGeShu.isHidden = false
                cell.viewBuHeGeShu.isHidden = false
                cell.viewRangBuJieShou.isHidden = false
                cell.viewRangBuReson.isHidden = false
                cell.viewBaoFeiShu.isHidden = false
                cell.viewBaoFeiReson.isHidden = false
                
                cell.viewQueXianReson.isHidden = true
                if self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue > 0 {
                    cell.viewQueXianReson.isHidden = false
                }
            } else if status == 5 {
                //"入库"
                cell.viewDaoHuoShu.isHidden = false
                cell.textFieldDaoHuoShu.isEnabled = false
                cell.viewZhiJianShu.isHidden = false
                cell.viewRuKuShu.isHidden = false
            }
            
            if self.boolDaoHuoShu == true {
                if self.materialArrivedOrderDetailVo.receivedQuantity.doubleValue != 0 {
                    cell.textFieldDaoHuoShu.text = "\(NSNumber.init(value: self.materialArrivedOrderDetailVo.receivedQuantity.doubleValue))"
                } else {
                    cell.textFieldDaoHuoShu.text = "0"
                }
            } else {
                cell.textFieldDaoHuoShu.text = nil
            }
            
            cell.textFieldDaoHuoShu.addTarget(self, action: #selector(textFieldDaoHuoShuClick(sender:)), for: UIControlEvents.editingChanged)
            cell.textFieldDaoHuoShu.inputAccessoryView = self.addToolbar()
            
            //质检数
            cell.labelZhiJianShu.text = "\(self.materialArrivedOrderDetailVo.qualifiedQuantity.doubleValue)"
            
            //入库数
            if self.boolRuKuShu == true {
                if self.materialArrivedOrderDetailVo.inStockQuantity.doubleValue != 0 {
                    cell.textFieldRuKuShu.text = "\(NSNumber.init(value: self.materialArrivedOrderDetailVo.inStockQuantity.doubleValue))"
                } else {
                    cell.textFieldRuKuShu.text = "0"
                }
            } else {
                cell.textFieldRuKuShu.text = nil
            }
            
            cell.textFieldRuKuShu.addTarget(self, action: #selector(textFieldRuKuShuClick(sender:)), for: UIControlEvents.editingChanged)
            cell.textFieldRuKuShu.inputAccessoryView = self.addToolbar()
            
            //合格数
            cell.labelHeGeShu.text = "\(self.materialArrivedOrderDetailVo.qualifiedQuantity.doubleValue)"
        
            //不合格数
            if self.boolBuHeGeShu == true {
                if self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue != 0 {
                    cell.textFieldBuHeGeShu.text = "\(NSNumber.init(value: self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue))"
                } else {
                    cell.textFieldBuHeGeShu.text = "0"
                }
            } else {
                cell.textFieldBuHeGeShu.text = nil
            }
            cell.textFieldBuHeGeShu.addTarget(self, action: #selector(textFieldBuHeGeShuClick(sender:)), for: UIControlEvents.editingChanged)
            cell.textFieldBuHeGeShu.inputAccessoryView = self.addToolbar()
                        
            cell.buttonQueXianYuanYing.isHidden = true
            cell.buttonQueXianYuanYingXuanZe.isHidden = true
            
            if self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue > 0 {
                if (self.materialArrivedOrderDetailVo!.scrappedCauseDetailVos != nil) {
                    let arrayTemp = NSMutableArray.init()
                    for temp in self.materialArrivedOrderDetailVo.scrappedCauseDetailVos {
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
            
            //让步接收
            if self.boolRangBuJieShou == true {
                if self.materialArrivedOrderDetailVo.concessionQuantity.doubleValue != 0 {
                    cell.textFieldRangBuJieShou.text = "\(NSNumber.init(value: self.materialArrivedOrderDetailVo.concessionQuantity.doubleValue))"
                } else {
                    cell.textFieldRangBuJieShou.text = "0"
                }
            } else {
                cell.textFieldRangBuJieShou.text = nil
            }
            
            cell.textFieldRangBuJieShou.addTarget(self, action: #selector(textFieldRangBuJieShouClick(sender:)), for: UIControlEvents.editingChanged)
            cell.textFieldRangBuJieShou.inputAccessoryView = self.addToolbar()
            
        
            //报废数
            if self.boolBaoFeiShu == true {
                if self.materialArrivedOrderDetailVo.scrappedQuantity.doubleValue != 0 {
                    cell.textFieldBaoFeiShu.text = "\(NSNumber.init(value: self.materialArrivedOrderDetailVo.scrappedQuantity.doubleValue))"
                } else {
                    cell.textFieldBaoFeiShu.text = "0"
                }
            } else {
                cell.textFieldBaoFeiShu.text = nil
            }
            
            cell.textFieldBaoFeiShu.addTarget(self, action: #selector(textFieldBaoFeiShuClick(sender:)), for: UIControlEvents.editingChanged)
            cell.textFieldBaoFeiShu.inputAccessoryView = self.addToolbar()
            
            cell.textFieldRangBuReson.text = self.materialArrivedOrderDetailVo.concessionCause
            cell.textFieldRangBuReson.addTarget(self, action: #selector(textFieldRangBuResonClick(sender:)), for: UIControlEvents.editingChanged)
            cell.textFieldRangBuReson.inputAccessoryView = self.addToolbar()
            cell.textFieldRangBuReson.isEnabled = true
            
            cell.textFieldBaoFeiReson.text = self.materialArrivedOrderDetailVo.scrappedCause
            cell.textFieldBaoFeiReson.addTarget(self, action: #selector(textFieldBaoFeiResonClick(sender:)), for: UIControlEvents.editingChanged)
            cell.textFieldBaoFeiReson.inputAccessoryView = self.addToolbar()
            cell.textFieldBaoFeiReson.isEnabled = true
            
            /**
             0:收货质检入库
             
             1:收货质检
             2:入库
             
             3:收货
             4:质检
             5:入库
            */
            if (status == 0 || status == 2 || status == 5) {
                cell.viewXuLieZhuiZong.isHidden = false
                if self.materialArrivedOrderDetailVo.hasModelSequence.intValue == 1 {
                    cell.viewGengGaiXuLieHao.isHidden = false
                } else {
                    cell.viewGengGaiXuLieHao.isHidden = true
                }
            }
            
            let imageName = self.materialArrivedOrderDetailVo.hasModelSequence.intValue == 1 ? "multiselect_selected":"multiselect_unchecked"
            cell.buttonCheck.setImage(UIImage.init(named: imageName), for: UIControl.State.normal)
            cell.buttonCheck.addTarget(self, action: #selector(buttonCheckClick(sender:)), for: UIControl.Event.touchUpInside)
            
            cell.buttonGengGaiXuLieHao.addTarget(self, action: #selector(buttonGengGaiXuLieHao(sender:)), for: UIControl.Event.touchUpInside)
            
            return cell
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
//        //不用设置大小，只设置颜色，就OK 只在plain下可以这样
//        let view = UIView()
//        view.backgroundColor = UIColor.clear
//        return view;
        return nil
    }
    
    @objc func textFieldDaoHuoShuClick(sender: UITextField) {
        if sender.text?.count ?? 0 > 0 {
            self.boolDaoHuoShu = true
            self.materialArrivedOrderDetailVo.receivedQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            self.boolDaoHuoShu = false
            self.materialArrivedOrderDetailVo.receivedQuantity = NSNumber.init(value: 0)
        }
        let double0: Double = self.materialArrivedOrderDetailVo.receivedQuantity.doubleValue - self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue - self.materialArrivedOrderDetailVo.concessionQuantity.doubleValue - self.materialArrivedOrderDetailVo.scrappedQuantity.doubleValue
        self.materialArrivedOrderDetailVo.qualifiedQuantity = NSNumber.init(value: double0)
    }
    
    //入库数
    @objc func textFieldRuKuShuClick(sender: UITextField) {
        if sender.text?.count ?? 0 > 0 {
            self.boolRuKuShu = true
            self.materialArrivedOrderDetailVo.inStockQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            self.boolRuKuShu = false
            self.materialArrivedOrderDetailVo.inStockQuantity = NSNumber.init(value: 0)
        }
    }
    
    @objc func textFieldBuHeGeShuClick(sender: UITextField) {
        
        if sender.text?.count ?? 0 > 0 {
            self.boolBuHeGeShu = true
            self.materialArrivedOrderDetailVo.unQqualifiedQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            self.boolBuHeGeShu = false
            self.materialArrivedOrderDetailVo.unQqualifiedQuantity = NSNumber.init(value: 0)
        }
        let double0: Double = self.materialArrivedOrderDetailVo.receivedQuantity.doubleValue - self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue - self.materialArrivedOrderDetailVo.concessionQuantity.doubleValue - self.materialArrivedOrderDetailVo.scrappedQuantity.doubleValue
        self.materialArrivedOrderDetailVo.qualifiedQuantity = NSNumber.init(value: double0)
    }
    @objc func textFieldBaoFeiShuClick(sender: UITextField) {
        if sender.text?.count ?? 0 > 0 {
            self.boolBaoFeiShu = true
            self.materialArrivedOrderDetailVo.scrappedQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            self.boolBaoFeiShu = false
            self.materialArrivedOrderDetailVo.scrappedQuantity = NSNumber.init(value: 0)
        }
        let double0: Double = self.materialArrivedOrderDetailVo.receivedQuantity.doubleValue - self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue - self.materialArrivedOrderDetailVo.concessionQuantity.doubleValue - self.materialArrivedOrderDetailVo.scrappedQuantity.doubleValue
        self.materialArrivedOrderDetailVo.qualifiedQuantity = NSNumber.init(value: double0)
    }
    
    
    
    @objc func textFieldRangBuResonClick(sender: UITextField) {
        self.materialArrivedOrderDetailVo.concessionCause = sender.text
    }
    
    @objc func textFieldBaoFeiResonClick(sender: UITextField) {
        self.materialArrivedOrderDetailVo.scrappedCause = sender.text
    }
    
    @objc func buttonQueXianYuanYingQingXuanZe(sender: UIButton) {
        let vc = SelectScrapReasonVC.init()
        vc.typeUploadImageName = "defectPictureFiles"
        vc.stage = "IQC"
        vc.materialCode = self.materialArrivedOrderDetailVo.materialCode
        if (self.materialArrivedOrderDetailVo!.scrappedCauseDetailVos != nil) {
            NSLog("%@", "存在")
            vc.causeDetailVos = self.materialArrivedOrderDetailVo.scrappedCauseDetailVos.mutableCopy() as? NSMutableArray
        } else {
            NSLog("%@", "不存在")
        }
        
        vc.blockArrayCauseDetailVo = { causeDetailVos in
            self.materialArrivedOrderDetailVo.scrappedCauseDetailVos = causeDetailVos
            self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .none)
        }
        
        vc.quantity = self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    @objc func textFieldRangBuJieShouClick(sender: UITextField) {
        if sender.text?.count ?? 0 > 0 {
             self.boolRangBuJieShou = true
            self.materialArrivedOrderDetailVo.concessionQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
             self.boolRangBuJieShou = false
            self.materialArrivedOrderDetailVo.concessionQuantity = NSNumber.init(value: 0)
        }
        let double0: Double = self.materialArrivedOrderDetailVo.planQuantity.doubleValue - self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue - self.materialArrivedOrderDetailVo.concessionQuantity.doubleValue
        self.materialArrivedOrderDetailVo.qualifiedQuantity = NSNumber.init(value: double0)
    }
    
    @objc func buttonCheckClick(sender: UIButton) {
        self.materialArrivedOrderDetailVo.hasModelSequence = self.materialArrivedOrderDetailVo.hasModelSequence.intValue == 1 ? NSNumber.init(value: 0) : NSNumber.init(value: 1)
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: UITableViewRowAnimation.none)
    }
    
    @objc func buttonGengGaiXuLieHao(sender: UIButton) {
        let vc = XuLieHaoXiuGaiVC.init()
        vc.materialCode = self.materialArrivedOrderDetailVo.materialCode
        vc.materialText = self.materialArrivedOrderDetailVo.materialText
        let quantity = self.materialArrivedOrderDetailVo.qualifiedQuantity.doubleValue + self.materialArrivedOrderDetailVo.concessionQuantity.doubleValue
        vc.quantity = NSNumber.init(value: quantity)
        
        if (self.materialArrivedOrderDetailVo.modelSequenceList != nil) {
            vc.arrayModelSequenceVo = self.materialArrivedOrderDetailVo.modelSequenceList.mutableCopy() as! [ModelSequenceVo]
        }
        vc.buttonSaveCallBack { (abc: [ModelSequenceVo]) in
            self.materialArrivedOrderDetailVo.modelSequenceList = NSMutableArray.init(array: abc)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    MARK: 提交
    @IBAction func buttonCommit(_ sender: Any) {
        var statusTemp = 333
        if status == 0 {
            //质检入库
            statusTemp = 333
        } else if status == 1 {
            //收货质检
            statusTemp = 22
        } else if status == 2 {
            //入库
            statusTemp = 3
        } else if status == 3 {
            //收货
            statusTemp = 1
        } else if status == 4 {
            //质检
            statusTemp = 2
        } else if status == 5 {
            //入库
            statusTemp = 3
        }
        
        if statusTemp == 1 {
            // 收货
//            for value in self.arrayMaterialArrivedOrderDetailVo {
//                value.receivedQuantity = value.planQuantity
//            }
            if (self.materialArrivedOrderDetailVo.receivedQuantity == nil) {
                MyAlertCenter.default()?.postAlert(withMessage: "收货数 必填")
                return
            }
        } else if statusTemp == 2 {
            // 质检
            
        } else if statusTemp == 22 {
            // 收货质检
//            for value in self.arrayMaterialArrivedOrderDetailVo {
//                value.receivedQuantity = value.planQuantity
//            }
            if (self.materialArrivedOrderDetailVo.receivedQuantity == nil) {
                MyAlertCenter.default()?.postAlert(withMessage: "收货数 必填")
                return
            }
        } else if statusTemp == 3 {
            // 入库
//            for value in self.arrayMaterialArrivedOrderDetailVo {
//                value.inStockQuantity = value.planQuantity
//            }
            if (self.materialArrivedOrderDetailVo.inStockQuantity == nil) {
                MyAlertCenter.default()?.postAlert(withMessage: "入库数 必填")
                return
            }
        } else if statusTemp == 333 {
            // 收货质检入库
//            for value in self.arrayMaterialArrivedOrderDetailVo {
//                value.receivedQuantity = value.planQuantity
//                value.inStockQuantity = value.planQuantity
//            }
            let double0: Double = self.materialArrivedOrderDetailVo.qualifiedQuantity.doubleValue + self.materialArrivedOrderDetailVo.concessionQuantity.doubleValue
            self.materialArrivedOrderDetailVo.inStockQuantity = NSNumber.init(value: double0)
            if (self.materialArrivedOrderDetailVo.receivedQuantity == nil) {
                MyAlertCenter.default()?.postAlert(withMessage: "收货数 必填")
                return
            }
            if (self.materialArrivedOrderDetailVo.inStockQuantity == nil) {
                MyAlertCenter.default()?.postAlert(withMessage: "入库数 必填")
                return
            }
        }
        
        
        
        
        if self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue > self.materialArrivedOrderDetailVo.receivedQuantity.doubleValue {
            MyAlertCenter.default().postAlert(withMessage: "不合格数不能大于到货数")
            return;
        }
        if self.materialArrivedOrderDetailVo.concessionQuantity.doubleValue > self.materialArrivedOrderDetailVo.receivedQuantity.doubleValue {
            MyAlertCenter.default().postAlert(withMessage: "让步数不能大于到货数")
            return;
        }
        if self.materialArrivedOrderDetailVo.scrappedQuantity.doubleValue > self.materialArrivedOrderDetailVo.receivedQuantity.doubleValue {
            MyAlertCenter.default().postAlert(withMessage: "报废数不能大于到货数")
            return;
        }
        
        if self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue > 0 {
            if (self.materialArrivedOrderDetailVo!.scrappedCauseDetailVos != nil) {
                var total = 0.0
                for i in 0..<self.materialArrivedOrderDetailVo.scrappedCauseDetailVos.count {
                    let causeDetailVo = self.materialArrivedOrderDetailVo.scrappedCauseDetailVos[i] as! CauseDetailVo
                    total = total + causeDetailVo.quantity.doubleValue
                }
                if total > self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue {
                    MyAlertCenter.default()?.postAlert(withMessage: "不得大于缺陷总数")
                    return
                }
            }
        }
        
        _uploadImageView.isHidden = false
        _uploadImageView.prepare()
        
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean()
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel.tpfUser)
        let userCode = tpfUser?.userCode
        

        self.materialArrivedOrderDetailVo.status = NSNumber.init(value: statusTemp)
        self.materialArrivedOrderDetailVo.receivedUser = userCode
        let materialArrivedOrderDetailVo: MaterialArrivedOrderDetailVo = self.materialArrivedOrderDetailVo
        
        var imageArray:[UploadImageBean] = []
        
        if self.materialArrivedOrderDetailVo.unQqualifiedQuantity.doubleValue > 0 {
            if (self.materialArrivedOrderDetailVo!.scrappedCauseDetailVos != nil) {
                let arrayTemp = NSMutableArray.init()
                for temp in self.materialArrivedOrderDetailVo.scrappedCauseDetailVos {
                    let causeDetailVo = temp as! CauseDetailVo
                    if causeDetailVo.quantity.doubleValue > 0 {
                        for i in 0..<causeDetailVo.uploadImageBeanList.count {
                            let uploadImageBean = causeDetailVo.uploadImageBeanList[i] as! UploadImageBean
                            imageArray.append(uploadImageBean)
                        }
                        arrayTemp.add(causeDetailVo)
                    }
                }
                self.materialArrivedOrderDetailVo.scrappedCauseDetailVos = arrayTemp
                
                for temp in self.materialArrivedOrderDetailVo.scrappedCauseDetailVos {
                    let causeDetailVo = temp as! CauseDetailVo
                    causeDetailVo.uploadImageBeanList = NSMutableArray.init()
                }
            }
        }
        
        mesPostEntityBean.entity = materialArrivedOrderDetailVo.mj_keyValues() as! [AnyHashable : Any]!
        let dic1 = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        let dic = ["data":getJSONStringFromDictionary(dictionary: dic1 as NSDictionary)];
        
        print(getJSONStringFromDictionary(dictionary: dic1 as NSDictionary))
        
        HttpMamager.postRequestImage(withURLString: DYZ_materialArrivedOrder_updateMaterialArrivedOrderDetailForCheck, parameters: dic, uploadImageBean: imageArray, success: { (responseObjectModel: Any?) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean
            
            self._uploadImageView.isHidden = true
            
            if returnMsgBean.status == "SUCCESS" {
                MyAlertCenter.default().postAlert(withMessage: "提交成功")
                self.materialArrivedOrderDetailVo.status = NSNumber.init(value: 1)
                self.navigationController?.popViewController(animated: true)
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
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: UITableViewRowAnimation.none)
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
