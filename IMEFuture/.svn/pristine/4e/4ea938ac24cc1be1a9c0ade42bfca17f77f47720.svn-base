//
//  MyAlertCenter.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/8/26.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface MyAlert : UIView

-(id)init;
- (void) setMessageText:(NSString *)message;
@end

@interface MyAlertCenter : NSObject {
    MyAlert *myAlertView;//alertView
    BOOL active;//当前是否在用
}

+ (MyAlertCenter *) defaultCenter;//单例 生成alert控制器
- (void) postAlertWithMessage:(NSString*)message;//弹出文字
@end

