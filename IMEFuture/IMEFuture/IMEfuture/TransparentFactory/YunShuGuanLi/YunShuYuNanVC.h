//
//  YunShuYuNanVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/8.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadImageBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface YunShuYuNanVC : UIViewController

@property (nonatomic,strong) UploadImageBean *uploadImageBean;

@property (nonatomic,copy) void(^callBack)(void);



@end

NS_ASSUME_NONNULL_END
