//
//  PadSingleUserWorkCompleteCell2.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/27.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UploadImageBean.h"
#import "MaterialDYZ.h"

@interface PadSingleUserWorkCompleteCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *textField0;

@property (weak, nonatomic) IBOutlet UITextField *textField1;//不良
@property (weak, nonatomic) IBOutlet UITextField *textField2;//报废


@property (weak, nonatomic) IBOutlet UIView *view21;//不良
@property (weak, nonatomic) IBOutlet UIButton *buttonQueXianYuanYing21;//不良原因
@property (weak, nonatomic) IBOutlet UIButton *buttonQueXianYuanYingQingXuanZe21;

@property (weak, nonatomic) IBOutlet UIView *view22;//报废
@property (weak, nonatomic) IBOutlet UIButton *buttonQueXianYuanYing22;//报废原因
@property (weak, nonatomic) IBOutlet UIButton *buttonQueXianYuanYingQingXuanZe22;

@property (weak, nonatomic) IBOutlet UITextField *textFieldMaoZhong;//毛重
@property (weak, nonatomic) IBOutlet UITextField *textFieldJingZhong;//净重
@property (weak, nonatomic) IBOutlet UIButton *buttonDianJiSaoMa;//点击扫码


@property (weak, nonatomic) IBOutlet UILabel *labelMoJu;//模具
@property (weak, nonatomic) IBOutlet UIButton *buttonDianJiXuanZeMoJu;//点击选择模具

@property (weak, nonatomic) IBOutlet UIView *ViewBGTaBleViewMuJu;//tableView的BG
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray <UploadImageBean * >*arrayDateImage;


@property (nonatomic, strong) NSMutableArray <MaterialDYZ *> *materialArray;


@property (nonatomic, copy) void(^blockDaTu)(NSInteger rowYZ);
- (void)buttonClickChaKanDaTuBlock:(void(^)(NSInteger rowYZ))block;
@property (nonatomic, copy) void(^blockAddImage)(void);
- (void)buttonAddImageBlock:(void(^)(void))block;

@property (nonatomic, copy) void(^blockTableSelect)(NSInteger rowYZ);
- (void)tableViewDidSelectBlock:(void(^)(NSInteger rowYZ))block;





@end
