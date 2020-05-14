//
//  YZSwitch.h
//  UISwitch文字
//
//  Created by 邓亚洲 on 2018/8/6.
//  Copyright © 2018年 邓亚洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZSwitch : UIView

- (instancetype)initWithFrame:(CGRect)frame withInt:(int)type returnInt:(void(^)(int type1))callBack;

@end
