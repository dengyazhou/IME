//
//  PadSelectPersonnelCheckListViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PadSelectPersonnelCheckListViewController : UIViewController

@property (nonatomic,copy) void(^passwordAuthentificationBlockTemp)(NSString *,NSInteger);

- (void)passwordAuthentificationCallBack:(void(^)(NSString * str,NSInteger needPassword))passwordAuthentificationBlock;

@end

NS_ASSUME_NONNULL_END
