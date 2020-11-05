//
//  EInspectionCell.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/11/3.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EInspectionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewBg;

@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@end

NS_ASSUME_NONNULL_END
