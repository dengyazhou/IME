//
//  YanHuoCell0900.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YanHuoCell0900 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelInspectTiem;

@property (nonatomic,copy) void(^buttonInspectTime)(void);

@end

NS_ASSUME_NONNULL_END
