//
//  CompleteConfirmationVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoHeader.h"


NS_ASSUME_NONNULL_BEGIN

@interface CompleteConfirmationVC : UIViewController

@property (nonatomic,strong) TemporaryTaskVo *temporaryTaskVo;

// 任务名
@property (nonatomic,copy) NSString * name;
// 存储实际工时
@property (nonatomic,strong) NSNumber * workTime;//Long
// 存储计划工时
@property (nonatomic,strong) NSNumber * planWorkTime;//Integer

@end

NS_ASSUME_NONNULL_END
