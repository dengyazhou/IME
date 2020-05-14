//
//  ChaKanYuanYinCell2.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/5.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "TradeOrderItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChaKanYuanYinCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon;
@property (weak, nonatomic) IBOutlet UIButton *buttonImage;
@property (weak, nonatomic) IBOutlet UIButton *buttonDetail;


- (void)initDataTradeOrderItem:(TradeOrderItem *)tradeOrderItem withNSIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
