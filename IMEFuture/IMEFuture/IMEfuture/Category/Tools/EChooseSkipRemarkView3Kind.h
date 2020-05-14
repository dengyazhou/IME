//
//  EChooseTaxRateView5Kind.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/7/20.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

//税率选择17% 和 6% 3% 0% 自定义
@interface EChooseSkipRemarkView3Kind : UIView

@property (nonatomic,copy) void(^buttonBlock)(NSString *confirmTax);

- (instancetype)initWithFrame:(CGRect)frame defaultSkipRemark:(NSString *)skipRemark buttonConfirmClick:(void(^)(NSString *confirmTax))block;

@end
