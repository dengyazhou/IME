//
//  MXBaoJiaCell01.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/10/17.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXBaoJiaCell01 : UITableViewCell

/**
 * 零件名称
 */
@property (weak, nonatomic) IBOutlet UILabel *dyzPartNumber;

//零件名
@property (weak, nonatomic) IBOutlet UILabel *dyzPartName;

/**
 * 一级材质名称、二级材质名称
 */
@property (weak, nonatomic) IBOutlet UILabel *materialName;

/**
 * 尺寸 长 宽 高 单位
 */
@property (weak, nonatomic) IBOutlet UILabel *sizeLWHUnit;

/**
 * 第一报价数量 第二报价数量 第三报价数量
 */
@property (weak, nonatomic) IBOutlet UILabel *num123;

/**
 * 缩略图临时存储字段
 */
@property (weak, nonatomic) IBOutlet UIImageView *sec_thumbnailUrl;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage;

@property (weak, nonatomic) IBOutlet UIButton *buttonDetail;

@property (weak, nonatomic) IBOutlet UIButton *buttonClose;
@property (weak, nonatomic) IBOutlet UIButton *buttonClose1;



@property (weak, nonatomic) IBOutlet UIView *viewDaoHuoTime;//要求到货时间
@property (weak, nonatomic) IBOutlet UILabel *labelDaoHuoTime;


@property (weak, nonatomic) IBOutlet UIView *viewZanBuBaoJia;//暂不报价
@property (weak, nonatomic) IBOutlet UILabel *labelZanBuBaoJia;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;
@property (weak, nonatomic) IBOutlet UIButton *buttonZanBuBaoJia;

@property (weak, nonatomic) IBOutlet UIView *viewZongjia;
@property (weak, nonatomic) IBOutlet UITextField *textFieldZongJia;


@property (weak, nonatomic) IBOutlet UIView *viewZongChaKan;
@property (weak, nonatomic) IBOutlet UILabel *zongChaKanlabel0;
@property (weak, nonatomic) IBOutlet UILabel *zongChaKanlabel1;
@property (weak, nonatomic) IBOutlet UILabel *zongChaKanlabel2;

@property (weak, nonatomic) IBOutlet UIView *viewZongYiJiaChaKan;
@property (weak, nonatomic) IBOutlet UILabel *zongYiJiaChaKanlabel1;
@property (weak, nonatomic) IBOutlet UILabel *zongYiJiaChaKanlabel2;
@property (weak, nonatomic) IBOutlet UILabel *zongYiJiaChaKanlabel11;
@property (weak, nonatomic) IBOutlet UILabel *zongYiJiaChaKanlabel12;

@property (weak, nonatomic) IBOutlet UILabel *labelTargetPrice;


@property (weak, nonatomic) IBOutlet UIView *viewZongYiJia;
@property (weak, nonatomic) IBOutlet UILabel *zongYiJialabel1;
@property (weak, nonatomic) IBOutlet UILabel *zongYiJialabel2;
@property (weak, nonatomic) IBOutlet UITextField *zongYiJiaTextField;











@end
