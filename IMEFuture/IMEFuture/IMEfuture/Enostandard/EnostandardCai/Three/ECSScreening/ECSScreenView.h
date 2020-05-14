//
//  ECSScreenView.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/7/2.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ECSScreenViewDelegate <NSObject>



@optional
- (void)eCSScreenViewDelegateShowPickerBG;//点击ECSScreenView 上的选择地区 使ECSScreenViewBG上的PickerViewBG显示出来

- (void)eCSScreenViewDelegateIndex:(NSInteger)labelTag CompanyName:(NSString *)company Netherlands:(NSString *)district;//把ECSScreenView 上的三个值 传给它的的上一级 ECSScreenViewBG

@end

@interface ECSScreenView : UIView

@property (nonatomic,weak) id<ECSScreenViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withArrayTGSupplierTag:(NSMutableArray *)arrayTGSupplierTag;

@end
