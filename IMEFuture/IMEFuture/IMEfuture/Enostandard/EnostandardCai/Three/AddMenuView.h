//
//  AddMenuView.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/6/28.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMenuView : UIView

@property (nonatomic,copy) void(^buttonBlock)(NSInteger tag);

- (instancetype)initWithFrame:(CGRect)frame buttonClick:(void(^)(NSInteger tag))block;

@end
