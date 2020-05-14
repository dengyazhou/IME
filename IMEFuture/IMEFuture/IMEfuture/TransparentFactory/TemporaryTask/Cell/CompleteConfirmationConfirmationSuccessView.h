//
//  CompleteConfirmationConfirmationSuccessView.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/19.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompleteConfirmationConfirmationSuccessView : UIView

@property (nonatomic,copy) void(^affrimBlock)(void);

+ (instancetype)loadXibView;


@end

NS_ASSUME_NONNULL_END
