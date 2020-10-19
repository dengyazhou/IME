//
//  PadSelectPersonnelListByOperationViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PadSelectPersonnelListByOperationViewController : UIViewController

@property (nonatomic, copy) NSString *productionControlNum;
@property (nonatomic, copy) NSString *processOperationId;
@property (nonatomic, copy) NSString *operationCode;
@property (nonatomic, copy) NSString *workUnitCode;
@property (nonatomic, strong) NSNumber *workRecordType;

@end

NS_ASSUME_NONNULL_END
