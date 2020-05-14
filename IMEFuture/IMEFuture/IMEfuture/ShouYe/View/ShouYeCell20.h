//
//  ShouYeCell20.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/4/18.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShouYeCell20 : UITableViewCell

/*-----------------------------View10 中间部分-----------------------------*/
@property (weak, nonatomic) IBOutlet UIView *view100;//非标管家大 没有选择过
@property (weak, nonatomic) IBOutlet UIView *view101;//非标管家大 选择过
@property (weak, nonatomic) IBOutlet UIView *view102;//非标管家 图纸云

@property (weak, nonatomic) IBOutlet UILabel *view101LabelShang;
@property (weak, nonatomic) IBOutlet UILabel *view101LabelXia;


@property (weak, nonatomic) IBOutlet UIView *viewNonstandardSteward;//非标管家小
@property (weak, nonatomic) IBOutlet UIView *viewDrawingCloud;//图纸云

@property (weak, nonatomic) IBOutlet UIView *viewTransparentFactory;//透明工厂
@property (weak, nonatomic) IBOutlet UIView *viewWodezhikeSteward;//智客管家

@property (weak, nonatomic) IBOutlet UIView *view101Line;
/*-----------------------------View10 中间部分-----------------------------*/



/*-----------------------------View20 下面部分-----------------------------*/
@property (weak, nonatomic) IBOutlet UIView *view20;//图纸云、行业资讯、技术问答、自动化部件
@property (weak, nonatomic) IBOutlet UIView *view21;//行业资讯、技术问答、自动化部件
/*-----------------------------View20 下面部分-----------------------------*/


@property (weak, nonatomic) IBOutlet UIButton *buttonFeiBiaoGuanJia0;//非标管家大 没有选择过
@property (weak, nonatomic) IBOutlet UIButton *buttonFeiBiaoGuanJia1Shang;//非标管家大 选择过 上部
@property (weak, nonatomic) IBOutlet UIButton *buttonFeiBiaoGuanJia1Xia;//非标管家大 选择过 下部
@property (weak, nonatomic) IBOutlet UIButton *buttonFeiBiaoGuanJia2;//非标管家 小

@property (weak, nonatomic) IBOutlet UIButton *buttonTouMingGongChang;//透明工厂
@property (weak, nonatomic) IBOutlet UIButton *buttonZhiKeGuanJia;//智客管家

@property (weak, nonatomic) IBOutlet UIButton *buttonTuZhiYun0;//图纸云
@property (weak, nonatomic) IBOutlet UIButton *buttonTuZhiYun1;

@property (weak, nonatomic) IBOutlet UIButton *buttonHangYeZiXun0;//行业资讯
@property (weak, nonatomic) IBOutlet UIButton *buttonHangYeZiXun1;

@property (weak, nonatomic) IBOutlet UIButton *buttonJiShuWenDa0;//技术问答
@property (weak, nonatomic) IBOutlet UIButton *buttonJiShuWenDa1;

@property (weak, nonatomic) IBOutlet UIButton *buttonZiDongHuaBuJian0;//自动化部件
@property (weak, nonatomic) IBOutlet UIButton *buttonZiDongHuaBuJian1;
@end
