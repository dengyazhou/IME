//
//  BaoJiaHeaderView01.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/10/21.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaoJiaHeaderView01 : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *labelName;

@property (weak, nonatomic) IBOutlet UIButton *buttonOpen;
@property (weak, nonatomic) IBOutlet UIButton *buttonOpen1;

@property (weak, nonatomic) IBOutlet UIView *viewYiBaoJia;//已报价

@property (weak, nonatomic) IBOutlet UILabel *label00;//¥
@property (weak, nonatomic) IBOutlet UILabel *label0;

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label2DanWei;

@property (weak, nonatomic) IBOutlet UIView *viewWeiBaoJia;//未报价
@property (weak, nonatomic) IBOutlet UILabel *label0Wei;

@property (weak, nonatomic) IBOutlet UILabel *label1Wei;
@property (weak, nonatomic) IBOutlet UILabel *label1WeiDanWei;

@property (weak, nonatomic) IBOutlet UIView *viewZanBuBaoJia;
@property (weak, nonatomic) IBOutlet UILabel *labelZanBuBaoJia;
@property (weak, nonatomic) IBOutlet UILabel *labelZanBuYuanYin;

@property (weak, nonatomic) IBOutlet UIView *viewZongJia;
@property (weak, nonatomic) IBOutlet UILabel *labelZongjia;
@property (weak, nonatomic) IBOutlet UILabel *labelZongjiaDanWei;
@property (weak, nonatomic) IBOutlet UIView *viewZongJiaRight;
@property (weak, nonatomic) IBOutlet UITextField *textFieldZongjia;

@property (weak, nonatomic) IBOutlet UIView *viewYiJia;
@property (weak, nonatomic) IBOutlet UILabel *labelYiJia1;
@property (weak, nonatomic) IBOutlet UILabel *labelYiJia2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldYiJia;

@property (weak, nonatomic) IBOutlet UIView *viewHeJia;
@property (weak, nonatomic) IBOutlet UILabel *labelHeJia00;//¥ (255,151,0) ()
@property (weak, nonatomic) IBOutlet UILabel *labelHeJia1;//颜色 (255,151,0) ()
@property (weak, nonatomic) IBOutlet UILabel *labelHeJia10;//我的比价
@property (weak, nonatomic) IBOutlet UILabel *labelHeJia2;
@property (weak, nonatomic) IBOutlet UILabel *labelHeJia20;//供应商报价

@property (weak, nonatomic) IBOutlet UIView *viewHeJia1;
@property (weak, nonatomic) IBOutlet UILabel *labelHeJia11;//未核价
@property (weak, nonatomic) IBOutlet UILabel *labelHeJia21;
@property (weak, nonatomic) IBOutlet UILabel *labelHeJia210;//供应商报价




@end
