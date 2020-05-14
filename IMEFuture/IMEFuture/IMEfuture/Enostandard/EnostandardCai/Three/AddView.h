//
//  AddView.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/6/28.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddView : UIView

- (instancetype)initWithFrame:(CGRect)frame buttonClick:(void(^)(NSInteger tag))block;

@end
