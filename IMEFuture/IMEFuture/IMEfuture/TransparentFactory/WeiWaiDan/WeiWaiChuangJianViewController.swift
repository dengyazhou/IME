//
//  WeiWaiChuangJianViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class WeiWaiChuangJianViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    
    var operationOutsourcingOrderVo: OperationOutsourcingOrderVo!
    
    var dataArray: Array<OperationOutsourcingSourceVo> = []
    
    
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    
    
    
    private var _viewLoading: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var labelTitle2: UILabel!
    @IBOutlet weak var labelTitle3: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelSupplierText: UILabel!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: 0, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        self.tableView.register(UINib.init(nibName: "WeiWaiChuangJianCell", bundle: nil), forCellReuseIdentifier: "weiWaiChuangJianCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.textField.delegate = self
        
    
        
    }
    
    @objc func keyboardWillShow(note: NSNotification) {
        let keyBoardRect = note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0)
    }
    @objc func keyboardWillHide(note: NSNotification) {
        self.tableView.contentInset = UIEdgeInsets.zero
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.request(result: textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeiWaiChuangJianCell = tableView.dequeueReusableCell(withIdentifier: "weiWaiChuangJianCell", for: indexPath) as! WeiWaiChuangJianCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        let model = self.dataArray[indexPath.row]
        cell.label0.text = model.materialCode + "\n" + model.materialText + "\n" + model.productionControlNum
        cell.label1.text = "\(model.surplusQuantity)"
        cell.label2.text = model.operationText
        cell.textField.text = "\(model.sendQuantity)"

        
        cell.textField.tag = indexPath.row
        cell.textField.inputAccessoryView = self.addToolbar()

        cell.textField.addTarget(self, action: #selector(textFieldValueChange(sender:)), for: UIControlEvents.editingChanged)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController.init(title: "提示", message: "确认删除委外工序", preferredStyle: .alert)
        let actionCancel = UIAlertAction.init(title: "否", style: .cancel, handler: nil)
        let actionQueDing = UIAlertAction.init(title: "是", style: .default) { (action) in
           
            
            self.dataArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            
            
        }
        alert.addAction(actionCancel)
        alert.addAction(actionQueDing)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @objc func textFieldValueChange(sender: UITextField) {
        let model = self.dataArray[sender.tag]
        
        if sender.text?.count ?? 0 > 0 {
            if Double(sender.text!)! > model.surplusQuantity.doubleValue {
                sender.text = model.surplusQuantity.stringValue;
            }
            model.sendQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            model.sendQuantity = NSNumber.init()
        }
    }
    
    
    @IBAction func buttonScan(_ sender: Any) {
        let saoYiSao = SaoYiSaoVC.init()
        saoYiSao.scanTitle = "扫描委外单二维码"
        saoYiSao.resultBlock = {(result: String!) -> () in
            self.request(result: result)
        }
        self.present(saoYiSao, animated: true, completion: nil)
    }
    
    @IBAction func buttonComplete(_ sender: Any) {
        if self.dataArray.count == 0 {
            MyAlertCenter.default().postAlert(withMessage: "请添加委外工序")
            return
        }
        let vc = WeiWaiSelectSupplierVC();
        vc.dataArray = self.dataArray
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func request(result: String?) {
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
               
                for value in returnListBean.list {
                    let model = OperationOutsourcingSourceVo.mj_object(withKeyValues: value)
                    model?.sendQuantity = model?.surplusQuantity ?? NSNumber.init(value: 0)
                    
                    var flag: Bool = true
                    for containItem in self.dataArray {
                        if model?.idDYZ.intValue == containItem.idDYZ.intValue {
                            flag = false
                        }
                    }
                    if flag {
                        self.dataArray.append(model!)
                    }
                }
                
                self.tableView.reloadData()
                
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnListBean.returnMsg)
            }

        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.tableView.reloadData()
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
