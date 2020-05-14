//
//  UIViewController_tool.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/3.
//  Copyright © 2018年 Netease. All rights reserved.
//

import Foundation

extension UIViewController {
    public func toolSwiftAttributedString(text: String) -> NSMutableAttributedString {
        let attributeStr: NSMutableAttributedString = NSMutableAttributedString.init(string: text)
        attributeStr.addAttribute(NSAttributedStringKey.foregroundColor, value: colorRGB(r: 0, g: 122, b: 254), range: NSMakeRange(5, text.count-9))
        return attributeStr
    }
}

extension String {
    static func toolSwiftGetJSONFromDictionary(dictionary: NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try! JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
}
