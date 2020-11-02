//
//  LingliaochukuVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/1.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class LingliaochukuVC: UIViewController, UITextFieldDelegate{
    var arrayWorkingOrderVO: [WorkingOrderVO]! = []
    
    private let _height_NavBar = Height_NavBar!
    private let _height_BottomBar = Height_BottomBar!
    
    private var _selectType = 0;
    
    private var _viewLoading: UIView!
    
    @IBOutlet weak var buttonLeftBottomLine: UIView!
    @IBOutlet weak var buttonRightBottomLine: UIView!
    
    
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

        self.setAttributedString(text: "摄像头对准领料单二维码，\n点击扫描")
        
        self.textField.delegate = self
    }
    
    //MARK 扫描领料单
    @IBAction func buttonScanlingliaodan(_ sender: Any) {
        _selectType = 0
        self.buttonLeftBottomLine.backgroundColor = colorRGB(r: 72, g: 184, b: 252)
        self.buttonRightBottomLine.backgroundColor = colorRGB(r: 255, g: 255, b: 255)
    }
    
    //MARK 创建领料单
    @IBAction func ButtonCreatelingliaodan(_ sender: Any) {
        _selectType = 1
        self.buttonLeftBottomLine.backgroundColor = colorRGB(r: 255, g: 255, b: 255)
        self.buttonRightBottomLine.backgroundColor = colorRGB(r: 72, g: 184, b: 252)
    }
    
    func setAttributedString(text: String) {
        let attributeStr: NSMutableAttributedString = NSMutableAttributedString.init(string: text)
        attributeStr.addAttribute(NSAttributedStringKey.foregroundColor, value: colorRGB(r: 0, g: 122, b: 254), range: NSMakeRange(5, text.count - 9))
        self.label.attributedText = attributeStr
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count == 0 {
            MyAlertCenter.default()?.postAlert(withMessage: "请输入领料单号")
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
        saoYiSao.scanTitle = "扫描领料单二维码"
        saoYiSao.resultBlock = {(result: String!) -> () in
            self.request(result: result)
        }
        self.present(saoYiSao, animated: true, completion: nil)
    }
    
    func request(result: String?) {
        self.textField.text = nil
        if _selectType == 0 {//扫描领料单
            let vc = YingLiaoRuKuViewController.init()
            vc.requisitionCode = result
            self.navigationController?.pushViewController(vc, animated: true)
        } else if _selectType == 1 {//创建领料单
            let vc = LingliaoCreateVC()
            vc.requisitionCode = result
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            //不存在此情况
        }
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
