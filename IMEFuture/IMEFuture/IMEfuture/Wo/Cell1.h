//
//  Cell1.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/6/25.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell1 : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UIButton *headImgButton;//盖在headImg上


@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end
