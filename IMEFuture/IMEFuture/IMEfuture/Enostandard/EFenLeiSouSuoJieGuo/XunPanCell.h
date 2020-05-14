//
//  XunPanCell.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoHeader.h"


@interface XunPanCell : UITableViewCell

@property (nonatomic,strong) InquiryOrder *inquiryOrder;

/**
 * 缩略图临时存储字段
 */
@property (weak, nonatomic) IBOutlet UIImageView *sec_thumbnailUrl;



@end
