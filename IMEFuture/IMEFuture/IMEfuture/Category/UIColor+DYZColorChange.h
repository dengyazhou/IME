//
//  UIColor+DYZColorChange.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/25.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DYZColorChange)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *)colorWithHexString: (NSString *)color;

@end
