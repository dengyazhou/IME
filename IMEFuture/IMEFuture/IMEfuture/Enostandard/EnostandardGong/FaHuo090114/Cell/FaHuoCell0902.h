//
//  FaHuoCell0902.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PurchaseOrderResBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaHuoCell0902 : UITableViewCell

@property (nonatomic,strong) PurchaseOrderResBean *model;

@property (weak, nonatomic) IBOutlet UILabel *labelPartNumber;

@property (weak, nonatomic) IBOutlet UILabel *labelNum;

@property (weak, nonatomic) IBOutlet UITextField *textField;


@property (copy, nonatomic) void(^buttonClickCallBack)(void);
@property (copy, nonatomic) void(^textFieldCallBack)(void);

@end

NS_ASSUME_NONNULL_END
