//
//  LianXiRenViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/7/24.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LianXiRenViewController1Delegate <NSObject>

- (void)selectLianXiRenWhithStrPhoneNumber:(NSString *)strPhoneNumber whithStrName:(NSString *)strName;

@end

@interface LianXiRenViewController1 : UIViewController

@property (nonatomic,weak) id <LianXiRenViewController1Delegate> delegate;

@end
