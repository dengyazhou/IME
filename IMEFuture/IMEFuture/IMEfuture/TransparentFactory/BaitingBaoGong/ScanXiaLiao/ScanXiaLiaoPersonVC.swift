//
//  ScanXiaLiaoPersonVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/24.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class ScanXiaLiaoPersonVC: UIViewController,UITextFieldDelegate {
    
    var _viewLoading: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelblankingCode: UILabel!
    @IBOutlet weak var labelworkUnitCode: UILabel!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    
    var blankingWorkTimeLogVo: BlankingWorkTimeLogVo!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.heightNavBar.constant = Height_NavBar
        self.heightBottomBar.constant = Height_BottomBar
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: Height_NavBar, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW-34)/2, y: 180, width: 34, height: 34));
        self.view.addSubview(_viewLoading);
        _viewLoading.isHidden = true
        
        self.label.attributedText = toolSwiftAttributedString(text: "摄像头对准员工二维码，\n点击扫描")
        
        self.textField.delegate = self
        
        self.labelblankingCode.text = "下料单号："+self.blankingWorkTimeLogVo.blankingCode
        self.labelworkUnitCode.text = "作业单元："+self.blankingWorkTimeLogVo.workUnitCode
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count == 0 {
            MyAlertCenter.default().postAlert(withMessage: "请输入员工码")
            return true
        }
        self.goNextStep(result: textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }

    @IBAction func buttonScan(_ sender: Any) {
        let saoYiSao = SaoYiSaoVC.init()
        saoYiSao.scanTitle = "请扫描员工码"
        saoYiSao.resultBlock = {(result: String?) -> Void in
            print(result)
            let jsonData = result?.data(using: String.Encoding.utf8)
            let dic = try? JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyHashable : Any]
            if let a = dic {
                if let personnelCode  = a["personnelCode"] as? String {
                    self.goNextStep(result: personnelCode)
                } else {
                    MyAlertCenter.default().postAlert(withMessage: "请扫描员工码")
                }
            } else {
                MyAlertCenter.default().postAlert(withMessage: "请扫描员工码")
            }
        }
        self.present(saoYiSao, animated: true, completion: nil)
    }
    
    func goNextStep(result: String!) {
        self.blankingWorkTimeLogVo.confirmUser = result
        let vc = XiaLiaoBaoGongViewController.init()
        vc.blankingWorkTimeLogVo = self.blankingWorkTimeLogVo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func buttonGoHome(_ sender: Any) {
        for vc in (self.navigationController?.viewControllers)! {
            if vc is TpfMaiViewController {
                self.navigationController?.popToViewController(vc, animated: true)
                return
            }
        }
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
