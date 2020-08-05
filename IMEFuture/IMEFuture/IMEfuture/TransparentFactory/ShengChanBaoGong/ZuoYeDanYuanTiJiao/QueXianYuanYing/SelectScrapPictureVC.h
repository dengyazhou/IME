//
//  SelectScrapPictureVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/3/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UploadImageBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectScrapPictureVC : UIViewController

@property (nonatomic,copy) NSString *TypeUploadImageName;

@property (nonatomic,copy) NSString *productionControlNumAndprocessOperationId;

@property (nonatomic,copy) NSString *confirmUser;

@property (nonatomic,strong) NSMutableArray <UploadImageBean *> * arrayUploadImageBean;//传入

@property (nonatomic,copy) void(^blockArrayUploadImageBean)(NSMutableArray <UploadImageBean *>*arrayUploadImageBean);//传出

@end

NS_ASSUME_NONNULL_END
