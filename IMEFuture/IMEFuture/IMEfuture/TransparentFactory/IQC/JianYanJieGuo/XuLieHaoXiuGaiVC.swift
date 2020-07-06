//
//  XuLieHaoXiuGaiVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/6/28.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

import UIKit

class XuLieHaoXiuGaiVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var materialCode: String!
    var materialText: String!
    var quantity: NSNumber!//double
    
    
    var arrayModelSequenceVo = [ModelSequenceVo]()
    
    var callBack: (([ModelSequenceVo])->Void)?
    
    private var _viewLoading: UIView!

    
    
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.heightNavBar.constant = Height_NavBar!
        self.heightBottomBar.constant = Height_BottomBar!
        
        
        self.tableView.register(UINib.init(nibName: "IQCJYJGCell", bundle: nil), forCellReuseIdentifier: "iQCJYJGCell")
        self.tableView.register(UINib.init(nibName: "XuLieHaoCell", bundle: nil), forCellReuseIdentifier: "xuLieHaoCell")
        self.tableView.register(UINib.init(nibName: "XuLieHao1Cell", bundle: nil), forCellReuseIdentifier: "xuLieHao1Cell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: Height_NavBar!, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        
        if self.arrayModelSequenceVo.isEmpty {
            self.initRequest()
        }
    }
    
    func initRequest() {
        _viewLoading.isHidden = false
        
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean = MesPostEntityBean.init()
        let modelSequenceVo = ModelSequenceVo.init()
        modelSequenceVo.siteCode = siteCode
        modelSequenceVo.modelCode = self.materialCode
        modelSequenceVo.quantity = self.quantity
        mesPostEntityBean.entity = modelSequenceVo.mj_keyValues() as! [AnyHashable:Any]
        let dic = mesPostEntityBean.mj_keyValues() as! [AnyHashable : Any]
        
        HttpMamager.postRequest(withURLString: DYZ_mes_modelSequence_preGeneratedModelSequence, parameters: dic, success: { (responseObjectModel) in
            let returnListBean = responseObjectModel as! ReturnListBean
            
            self._viewLoading.isHidden = true
            
            if returnListBean.status == "SUCCESS" {
                self.arrayModelSequenceVo = []
                for value in returnListBean.list {
                    let item: ModelSequenceVo = ModelSequenceVo.mj_object(withKeyValues: value)
                    self.arrayModelSequenceVo.append(item)
                }
                
                self.tableView.reloadData()
                
            }
            
        }, fail: { (error) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnListBean"))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number: Int
        if section == 0 {
            number = 1
        } else if section == 1 {
            number = 1
        } else {
            number = self.arrayModelSequenceVo.count
        }
        return number
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height: CGFloat
        if section == 0 {
            height = 0.1
        } else if section == 1 {
            height = 10
        } else {
            height = 0.4
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "iQCJYJGCell", for: indexPath) as! IQCJYJGCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.label0.text = "编号："+self.materialCode
            cell.label1.text = "物料名称："+self.materialText
            
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "xuLieHaoCell", for: indexPath) as! XuLieHaoCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.label0.text = "序号"
            cell.label1.text = "序列号"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "xuLieHao1Cell", for: indexPath) as! XuLieHao1Cell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let model = self.arrayModelSequenceVo[indexPath.row]
            cell.label0.text = "\(indexPath.row+1)"
            cell.textFielf0.text = model.sequenceNum
            
            cell.textFielf0.addTarget(self, action: #selector(textFieldXuLieHaoXiuGai(sender:)), for: UIControl.Event.editingChanged)
            cell.textFielf0.tag = indexPath.row
            cell.textFielf0.inputAccessoryView = self.addToolbar()
            
            return cell
        }
    }
    
    @objc func textFieldXuLieHaoXiuGai(sender: UITextField) {
        let model = self.arrayModelSequenceVo[sender.tag]
        model.sequenceNum = sender.text ?? ""
    }

    @IBAction func buttonSave(_ sender: Any) {
        var flag = false
        var str: String?
        for i in 0..<self.arrayModelSequenceVo.count {
            let value = self.arrayModelSequenceVo[i]
            for j in i+1..<self.arrayModelSequenceVo.count {
                let value1 = self.arrayModelSequenceVo[j]
                if value.sequenceNum == value1.sequenceNum {
                    flag = true
                    str = value.sequenceNum
                    break
                }
            }
        }
        if flag {
            MyAlertCenter.default()?.postAlert(withMessage: "\(str!)模具序号已经存在，不能保存，客户修改后再进行保存")
            return
        }
        self.callBack!(self.arrayModelSequenceVo)
        self.navigationController?.popViewController(animated: true)
       
    }
    
    @IBAction func buttonReset(_ sender: Any) {
        self.initRequest()
        self.tableView.reloadData()
    }
    
    func buttonSaveCallBack(completionHandler: @escaping (_ array: [ModelSequenceVo])->Void) {
        self.callBack = completionHandler
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
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
