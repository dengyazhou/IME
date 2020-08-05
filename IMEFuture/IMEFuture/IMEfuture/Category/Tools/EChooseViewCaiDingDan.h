//
//  EChooseViewCaiDingDan.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2016/11/1.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EChooseViewCaiDingDan;

@protocol EChooseViewCaiDingDanDelegate <NSObject>

@optional

- (void)eChooseViewDelegate:(EChooseViewCaiDingDan *)view ButtonClick0:(UIButton *)sender withArrayTypeNoOrYes:(NSMutableArray *)arrayTypeNoOrYes;
- (void)eChooseViewDelegateButtonClick1:(UIButton *)sender withArrayStateNoOrYes:(NSMutableArray *)arrayStateNoOrYes;
- (void)eChooseViewDelegateButtonClick2:(UIButton *)sender;
- (void)eChooseViewDelegate:(EChooseViewCaiDingDan *)view ButtonClick3:(UIButton *)sender withArrayTypeNoOrYes:(NSMutableArray *)arrayTypeNoOrYes withArrayStateNoOrYes:(NSMutableArray *)arrayStateNoOrYes withwithTime0:(NSString *)time0 withTime1:(NSString *)time1 wihtstrSuoShuXiangMu:(NSString *)strSuoShuXiangMu withstrGongYingShang:(NSString *)strGongYingShang;
- (void)eChooseViewDelegateTapSelector;
- (void)eChooseViewDelegateTapSelectorWithArrayStateNoOrYes:(NSMutableArray *)arrayStateNoOrYes;//如果没用就删掉

- (void)eChooseViewDelegateTapRemove:(EChooseViewCaiDingDan *)view;

@end

@interface EChooseViewCaiDingDan : UIView

@property (nonatomic,assign) id <EChooseViewCaiDingDanDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withTitleState:(NSString *)labelType withState:(NSArray *)arrayType withArrayTypeNoOrYes:(NSMutableArray *)arrayTypeNoOrYes withTitleState:(NSString *)labelState withState:(NSArray *)arrayState withArrayStateNoOrYes:(NSMutableArray *)arrayStateNoOrYes withTitleTime:(NSString *)labelTime withTime0:(NSString *)time0 withTime1:(NSString *)time1 with:(NSArray *)array3 withColor:(UIColor *)color;

@end
