//
//  EInspectionCreateCell.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/27.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OssUploadResBean.h"
#import "MaterialDYZ.h"

@interface EInspectionCreateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *textField0;//供应商

@property (weak, nonatomic) IBOutlet UITextField *textField1;//巡检日期
@property (weak, nonatomic) IBOutlet UIButton *button1;


@property (weak, nonatomic) IBOutlet UITextField *textField2;//质量
@property (weak, nonatomic) IBOutlet UITextField *textField3;//成本
@property (weak, nonatomic) IBOutlet UITextField *textField4;//支付
@property (weak, nonatomic) IBOutlet UITextField *textField5;//响应
@property (weak, nonatomic) IBOutlet UITextField *textField6;//其他


@property (weak, nonatomic) IBOutlet UIView *ViewBGTaBleView;//tableView的BG
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray <OssUploadResBean *>*arrayDateImage;


@property (nonatomic, strong) NSMutableArray *arrayTgSupplier;


@property (nonatomic, copy) void(^blockDaTu)(NSInteger rowYZ);
- (void)buttonClickChaKanDaTuBlock:(void(^)(NSInteger rowYZ))block;
@property (nonatomic, copy) void(^blockAddImage)(void);
- (void)buttonAddImageBlock:(void(^)(void))block;

@property (nonatomic, copy) void(^blockTableSelect)(NSInteger rowYZ);
- (void)tableViewDidSelectBlock:(void(^)(NSInteger rowYZ))block;





@end
