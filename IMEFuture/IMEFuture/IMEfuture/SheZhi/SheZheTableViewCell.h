//
//  SheZheTableViewCell.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/10/24.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheZheTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;

@property (weak, nonatomic) IBOutlet UIImageView *imageNext;




@property (weak, nonatomic) IBOutlet UIView *viewLineTop;
@property (weak, nonatomic) IBOutlet UIView *viewLineBottomDuan;
@property (weak, nonatomic) IBOutlet UIView *viewLineBottom;


@end
