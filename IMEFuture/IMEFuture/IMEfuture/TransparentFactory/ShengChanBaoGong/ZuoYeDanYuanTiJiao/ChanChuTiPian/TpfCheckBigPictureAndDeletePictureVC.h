//
//  TpfShanChuTuPianVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/3/8.
//  Copyright © 2018年 Netease. All rights reserved.
//

//用TpfCheckBigPictureAndDeletePictureVC取代TpfShanChuTuPianVC，后面会逐一全部取代

#import <UIKit/UIKit.h>

#import "InquiryOrderItem.h"

#import "UploadImageBean.h"

@interface TpfCheckBigPictureAndDeletePictureVC : UIViewController

@property (nonatomic,copy) void(^buttonBackBlock)(void);//保存
@property (nonatomic,strong) NSMutableArray <UploadImageBean *>* arrayUploadImageBean;
@property (nonatomic,assign) NSInteger index;

@end
