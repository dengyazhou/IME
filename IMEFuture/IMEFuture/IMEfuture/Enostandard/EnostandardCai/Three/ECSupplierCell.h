//
//  QiYeCell.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/19.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECSupplierCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseName;
@property (weak, nonatomic) IBOutlet UILabel *provinceCity;

//46 8
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label_factoryImgConstraint;
//68 30 和 8
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *enterpriseNameConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *isTemporaryImg;


@property (weak, nonatomic) IBOutlet UIImageView *label_factoryImg;

@end
