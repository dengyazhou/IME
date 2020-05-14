//
//  TemporaryTaskVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface TemporaryTaskVC : UIViewController

/**
 临时任务ID
 1、如果idDYZ没有赋值，说明是点击“+”进来，创建临时任务
 */
@property (nonatomic,strong) NSNumber * idDYZ;//Long

/**
 是否是班长 1 是 0 否。
 如果是班长，但是不是自己的任务时，完成按钮是直接完成，不需要确认密码；
 如果是自己的临时任务，那么完成按钮就是找组长输入密码
 */
@property (nonatomic, assign) NSInteger leaderFlag;


@end

NS_ASSUME_NONNULL_END
