//
//  EInspectionDetailCell.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/27.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UploadImageBean.h"
#import "MaterialDYZ.h"

@interface EInspectionDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;


@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;


@property (nonatomic, copy) void(^blockDaTu)(NSInteger rowYZ);
- (void)buttonClickChaKanDaTuBlock:(void(^)(NSInteger rowYZ))block;
@property (nonatomic, copy) void(^blockAddImage)(void);
- (void)buttonAddImageBlock:(void(^)(void))block;

@property (nonatomic, copy) void(^blockTableSelect)(NSInteger rowYZ);
- (void)tableViewDidSelectBlock:(void(^)(NSInteger rowYZ))block;





@end
