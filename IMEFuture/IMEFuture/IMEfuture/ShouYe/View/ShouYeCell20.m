//
//  ShouYeCell20.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/4/18.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ShouYeCell20.h"

#import "Header.h"

@interface ShouYeCell20 (){
    
}
@end;

@implementation ShouYeCell20

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CGFloat width = (kMainW-45)/2.0;
    CGFloat height2 = 159;
    CGFloat height1 = 72;
    
#pragma mark 非标管家 大 没有选择过
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)colorRGB(255, 200, 68).CGColor,  (__bridge id)colorRGB(255, 147, 68).CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, width, height2);//获取的self.view100.frame不准
    gradientLayer.cornerRadius = 4;
    gradientLayer.shadowColor = colorRGB(255, 148, 68).CGColor;//shadowColor阴影颜色
    gradientLayer.shadowOffset = CGSizeMake(0,4);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
    gradientLayer.shadowRadius = 8;
    gradientLayer.shadowOpacity = 0.4;//阴影透明度，默认0
    [self.view100.layer insertSublayer:gradientLayer atIndex:0];
    self.view100.layer.cornerRadius = 4;
    
#pragma mark 非标管家大 选择过
    CAGradientLayer *gradientLayer5 = [CAGradientLayer layer];
    gradientLayer5.colors = @[(__bridge id)colorRGB(255, 200, 68).CGColor,  (__bridge id)colorRGB(255, 147, 68).CGColor];
    gradientLayer5.locations = @[@0.0, @1.0];
    gradientLayer5.startPoint = CGPointMake(0, 0);
    gradientLayer5.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer5.frame = CGRectMake(0, 0, width, height2);//获取的self.view100.frame不准
    gradientLayer5.cornerRadius = 4;
    gradientLayer5.shadowColor = colorRGB(255, 148, 68).CGColor;//shadowColor阴影颜色
    gradientLayer5.shadowOffset = CGSizeMake(0,4);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
    gradientLayer5.shadowRadius = 8;
    gradientLayer5.shadowOpacity = 0.4;//阴影透明度，默认0
    [self.view101.layer insertSublayer:gradientLayer5 atIndex:0];
    self.view101.layer.cornerRadius = 4;
    
#pragma mark 透明工厂
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.colors = @[(__bridge id)colorRGB(117,175,253).CGColor,  (__bridge id)colorRGB(54,135,254).CGColor];
    gradientLayer1.locations = @[@0.0, @1.0];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer1.frame = CGRectMake(0, 0, width, height1);
    gradientLayer1.cornerRadius = 4;
    gradientLayer1.shadowColor = colorRGB(46,159,255).CGColor;
    gradientLayer1.shadowOffset = CGSizeMake(0,4);
    gradientLayer1.shadowRadius = 8;
    gradientLayer1.shadowOpacity = 0.4;
    [self.viewTransparentFactory.layer insertSublayer:gradientLayer1 atIndex:0];
    self.viewTransparentFactory.layer.cornerRadius = 4;

#pragma mark 智客管家
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.colors = @[(__bridge id)colorRGB(135,224,76).CGColor,  (__bridge id)colorRGB(76,193,120).CGColor];
    gradientLayer2.locations = @[@0.0, @1.0];
    gradientLayer2.startPoint = CGPointMake(0, 0);
    gradientLayer2.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer2.frame = CGRectMake(0, 0, width, height1);
    gradientLayer2.cornerRadius = 4;
    gradientLayer2.shadowColor = colorRGB(76,193,120).CGColor;
    gradientLayer2.shadowOffset = CGSizeMake(0,4);
    gradientLayer2.shadowRadius = 8;
    gradientLayer2.shadowOpacity = 0.4;
    [self.viewWodezhikeSteward.layer insertSublayer:gradientLayer2 atIndex:0];
    self.viewWodezhikeSteward.layer.cornerRadius = 4;
    
#pragma mark 非标管家 小
    CAGradientLayer *gradientLayer3 = [CAGradientLayer layer];
    gradientLayer3.colors = @[(__bridge id)colorRGB(255, 200, 68).CGColor,  (__bridge id)colorRGB(255, 147, 68).CGColor];
    gradientLayer3.locations = @[@0.0, @1.0];
    gradientLayer3.startPoint = CGPointMake(0, 0);
    gradientLayer3.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer3.frame = CGRectMake(0, 0, width, height1);//获取的self.view100.frame不准
    gradientLayer3.cornerRadius = 4;
    gradientLayer3.shadowColor = colorRGB(255, 148, 68).CGColor;//shadowColor阴影颜色
    gradientLayer3.shadowOffset = CGSizeMake(0,4);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
    gradientLayer3.shadowRadius = 8;
    gradientLayer3.shadowOpacity = 0.4;//阴影透明度，默认0
    [self.viewNonstandardSteward.layer insertSublayer:gradientLayer3 atIndex:0];
    self.viewNonstandardSteward.layer.cornerRadius = 4;
    
#pragma mark 图纸云
    CAGradientLayer *gradientLayer4 = [CAGradientLayer layer];
    gradientLayer4.colors = @[(__bridge id)colorRGB(117,175,253).CGColor,  (__bridge id)colorRGB(54,135,254).CGColor];
    gradientLayer4.locations = @[@0.0, @1.0];
    gradientLayer4.startPoint = CGPointMake(0, 0);
    gradientLayer4.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer4.frame = CGRectMake(0, 0, width, height1);
    gradientLayer4.cornerRadius = 4;
    gradientLayer4.shadowColor = colorRGB(46,159,255).CGColor;
    gradientLayer4.shadowOffset = CGSizeMake(0,4);
    gradientLayer4.shadowRadius = 8;
    gradientLayer4.shadowOpacity = 0.4;
    [self.viewDrawingCloud.layer insertSublayer:gradientLayer4 atIndex:0];
    self.viewDrawingCloud.layer.cornerRadius = 4;
    
    
//    self.view101Line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
