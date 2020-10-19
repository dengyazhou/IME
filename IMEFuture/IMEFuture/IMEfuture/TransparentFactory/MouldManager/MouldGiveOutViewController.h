//
//  MouldGiveOutViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MouldGiveOutViewController : UIViewController


@property (nonatomic, copy) NSString *materialCode;
@property (nonatomic, copy) NSString *materialText;
@property (nonatomic, strong) NSNumber *plannedQuantity;
@property (nonatomic, copy) NSString *requirementDate;
@property (nonatomic, copy) NSString *mouldCode;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy) NSString *plannedstartDateTime;

@property (nonatomic, copy) NSString *productionControlNum;

@end

NS_ASSUME_NONNULL_END
