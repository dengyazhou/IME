//
//  EChooseTaxRateView.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EChooseTaxRateViewDeegate <NSObject>

- (void)eChooseTaxRateViewButton:(UIButton *)sender;
- (void)eChooseTaxRateViewTapSelector;

@end

//税率选择17% 和 3%
@interface EChooseTaxRateView : UIView

@property (nonatomic,assign) id <EChooseTaxRateViewDeegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withImageName0:(NSString *)name0 withImageName1:(NSString *)name1;

@end
