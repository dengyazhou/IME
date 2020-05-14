//
//  ECSScreenView.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/7/2.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ECSScreenViewBGDelegate <NSObject>


@optional

- (void)eCSScreenViewBGDelegateIndex:(NSInteger)labelTag CompanyName:(NSString *)company Netherlands:(NSString *)district;//把ECSScreenViewBG 上的三个值 传给ViewController

@end

@interface ECSScreenViewBG : UIView

@property (nonatomic,weak) id<ECSScreenViewBGDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withArrayTGSupplierTag:(NSMutableArray *)arrayTGSupplierTag;

@end
