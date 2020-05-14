//
//  IQCChuKuYuanGongMaVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/1.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class IQCChuKuYuanGongMaVC: UIViewController, UITextFieldDelegate{
    var arrayWorkingOrderVO: [WorkingOrderVO]! = []
    
    private let _height_NavBar = Height_NavBar!
    private let _height_BottomBar = Height_BottomBar!
    
    
    private var _viewLoading: UIView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar
        self.heightBottomBar.constant = _height_BottomBar
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true

        self.setAttributedString(text: "摄像头对准员工二维码，\n点击扫描")
        
        self.textField.delegate = self
    }
    
    func setAttributedString(text: String) {
        let attributeStr: NSMutableAttributedString = NSMutableAttributedString.init(string: text)
        attributeStr.addAttribute(NSAttributedStringKey.foregroundColor, value: colorRGB(r: 0, g: 122, b: 254), range: NSMakeRange(5, text.count - 9))
        self.label.attributedText = attributeStr
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count == 0 {
            MyAlertCenter.default()?.postAlert(withMessage: "请输入员工码")
            textField.resignFirstResponder()
            return false
        }
        self.request(result: textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
//    MARK: 扫描
    @IBAction func scan(_ sender: Any) {
        let saoYiSao = SaoYiSaoVC()
        saoYiSao.scanTitle = "扫描员工二维码"
        saoYiSao.resultBlock = {(result: String!) -> () in

            let jsonData = result.data(using: String.Encoding.utf8)! as Data
            let dic = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyHashable : Any]
            if let a = dic {
                self.request(result: a["personnelCode"] as? String)
            } else {
                self.request(result: nil)
            }
        }
        self.present(saoYiSao, animated: true, completion: nil)
    }
    
    func request(result: String?) {        
        let vc = YingLiaoRuKuViewController.init()
        vc.warehouseInOperator = result
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    MARK: back
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
