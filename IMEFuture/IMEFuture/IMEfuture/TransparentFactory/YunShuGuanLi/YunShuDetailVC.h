//
//  YunShuDetailVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/8.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YunShuDetailVC : UIViewController

@property (nonatomic,copy) NSString *transportOrderNum;

//预提交后 返回到YunShuDetailVC调用
- (void)initRequest;


@end

NS_ASSUME_NONNULL_END
