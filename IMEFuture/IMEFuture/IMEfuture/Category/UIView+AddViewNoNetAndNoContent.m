//
//  UIView+AddViewNoNetAndNoContent.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/10.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "UIView+AddViewNoNetAndNoContent.h"

#import "Header.h"


@implementation UIView (AddViewNoNetAndNoContent)

+ (UIView *)addNoNetWith:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = colorRGB(241, 241, 241);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ime_picture_network"]];
    imageView.center = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame)-100);
    [view addSubview:imageView];
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, kMainW, 21);
    label.center = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMaxY(imageView.frame)+CGRectGetHeight(label.frame)/2.0);
    label.text = @"网络不可用，请检查网络！";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = colorRGB(117, 117, 117);
    [view addSubview:label];
    return view;
}

+ (UIView *)addNoContent:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = colorRGB(241, 241, 241);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ime_picture_inquiry_empty"]];
    imageView.center = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame)-100);
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, kMainW, 21);
    label.center = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMaxY(imageView.frame)+CGRectGetHeight(label.frame)/2.0);
    label.text = @"无内容";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = colorRGB(32, 32, 32);
    [view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.bounds = CGRectMake(0, 0, kMainW, 21);
    label1.center = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMaxY(label.frame)+CGRectGetHeight(label1.frame)/2.0);
    label1.text = @"暂时没有询盘单";
    label1.font = [UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = colorRGB(117, 117, 117);
    [view addSubview:label1];
    
    return view;
}

+ (UIView *)addView:(CGRect)frame withTitle:(NSString *)title {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = colorRGB(241, 241, 241);
    UILabel *labelText1 = [[UILabel alloc] init];
    labelText1.frame = CGRectMake(0, CGRectGetHeight(view.frame)/2.0 - 42, kMainW, 42);
    labelText1.text = title;
    labelText1.textAlignment = NSTextAlignmentCenter;
    labelText1.numberOfLines = 0;
    labelText1.textColor = colorRGB(117, 117, 117);
    [view addSubview:labelText1];
    return view;
}

#pragma mark 一个UIImageView 一个UILabel
+ (UIView *)addView:(CGRect)frame imageNamed:(NSString *)imageNamed title:(NSString *)title {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = colorRGB(241, 241, 241);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    imageView.center = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame)-100);
    [view addSubview:imageView];
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, kMainW, 21);
    label.center = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMaxY(imageView.frame)+CGRectGetHeight(label.frame)/2.0+14);
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = colorRGB(153, 153, 153);
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    return view;
}


+ (UIView *)loadingWithFrame:(CGRect)frame {
    UIView *_loading = [[UIView alloc]initWithFrame:frame];
    _loading.backgroundColor = colorRGB(241, 241, 241);
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 34)/2, (frame.size.height - 34)/2, 34, 34)];
    image.image = [UIImage imageNamed:@"加载3"];
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicAnimation.duration = 4;
    basicAnimation.removedOnCompletion = NO;
    [basicAnimation setRepeatCount:NSIntegerMax];
    basicAnimation.fromValue = [NSNumber numberWithInt:0];
    basicAnimation.toValue = [NSNumber numberWithInt:M_PI*8];
    [image.layer addAnimation:basicAnimation forKey:@"rotation"];
    [_loading addSubview:image];
    return _loading;
}

+ (UIView *)loadingWithFrame:(CGRect)frame color:(UIColor *)color imageView:(CGRect)frame1{
    UIView *_loading = [[UIView alloc]initWithFrame:frame];
    _loading.backgroundColor = color;
    UIImageView *image = [[UIImageView alloc]initWithFrame:frame1];
    image.image = [UIImage imageNamed:@"加载3"];
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicAnimation.duration = 4;
    basicAnimation.removedOnCompletion = NO;
    [basicAnimation setRepeatCount:NSIntegerMax];
    basicAnimation.fromValue = [NSNumber numberWithInt:0];
    basicAnimation.toValue = [NSNumber numberWithInt:M_PI*8];
    [image.layer addAnimation:basicAnimation forKey:@"rotation"];
    [_loading addSubview:image];
    return _loading;
}

+ (UIView *)networkAnomalyWithFrame:(CGRect)frame withTitle:(NSString *)title{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = colorRGB(241, 241, 241);
    UILabel *label = [[UILabel alloc] init];
    label.center = CGPointMake(view.center.x, view.center.y-100);
    label.bounds = CGRectMake(0, 0, CGRectGetWidth(frame), 30);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = colorRGB(117, 117, 117);
    label.text = title;
    [view addSubview:label];
    return view;
}

+ (UIView *)addViewNoNetWithScrollView:(UIScrollView *)scrollView tableView:(UITableView *)tableView imageNamed:(NSString *)imageNamed label0Text:(NSString *)text0 label1Text:(NSString *)text1{
    UIView *view = [[UIView alloc] initWithFrame:tableView.frame];
    view.backgroundColor = colorRGB(241, 241, 241);
    [scrollView addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    imageView.center = CGPointMake(CGRectGetWidth(tableView.frame)/2, CGRectGetHeight(tableView.frame)/2-50);
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, kMainW, 21);
    label.center = CGPointMake(CGRectGetWidth(tableView.frame)/2,  CGRectGetMaxY(imageView.frame)+CGRectGetHeight(label.frame)/2.0);
    label.text = text0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = colorRGB(32, 32, 32);
    [view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.bounds = CGRectMake(0, 0, kMainW, 21);
    label1.center = CGPointMake(CGRectGetWidth(tableView.frame)/2, CGRectGetMaxY(label.frame)+CGRectGetHeight(label1.frame)/2.0);
    label1.text = text1;
    label1.font = [UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = colorRGB(117, 117, 117);
    [view addSubview:label1];
    return view;
}

+ (UIView *)addViewNoNetWithScrollView:(UIScrollView *)scrollView collectionView:(UICollectionView *)collectionView imageNamed:(NSString *)imageNamed label0Text:(NSString *)text0 label1Text:(NSString *)text1{
    UIView *view = [[UIView alloc] initWithFrame:collectionView.frame];
    view.backgroundColor = colorRGB(241, 241, 241);
    [scrollView addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    imageView.center = CGPointMake(CGRectGetWidth(collectionView.frame)/2, CGRectGetHeight(collectionView.frame)/2-50);
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, kMainW, 21);
    label.center = CGPointMake(CGRectGetWidth(collectionView.frame)/2,  CGRectGetMaxY(imageView.frame)+CGRectGetHeight(label.frame)/2.0);
    label.text = text0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = colorRGB(32, 32, 32);
    [view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.bounds = CGRectMake(0, 0, kMainW, 21);
    label1.center = CGPointMake(CGRectGetWidth(collectionView.frame)/2, CGRectGetMaxY(label.frame)+CGRectGetHeight(label1.frame)/2.0);
    label1.text = text1;
    label1.font = [UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = colorRGB(117, 117, 117);
    [view addSubview:label1];
    return view;
}


+ (UIView *)addViewNoNetWithScrollView:(UIScrollView *)scrollView tableView:(UITableView *)tableView imageNamed:(NSString *)imageNamed labelText:(NSString *)text {
    
    UIView *view = [[UIView alloc] initWithFrame:tableView.frame];
    view.backgroundColor = colorRGB(241, 241, 241);
    [scrollView addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    imageView.center = CGPointMake(CGRectGetWidth(tableView.frame)/2, CGRectGetHeight(tableView.frame)/2-50);
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, kMainW, 21);
    label.center = CGPointMake(CGRectGetWidth(tableView.frame)/2,  CGRectGetMaxY(imageView.frame)+CGRectGetHeight(label.frame)/2.0+7);
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = colorRGB(153, 153, 153);
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    

    return view;
}

+ (UIView *)addViewNoContentToSuperView:(UIView *)superView tableView:(UITableView *)tableView imageNamed:(NSString *)imageNamed label0Text:(NSString *)text0 label1Text:(NSString *)text1 buttonTitle:(NSString *)buttonTitle {
    UIView *view = [[UIView alloc] initWithFrame:tableView.frame];
    view.backgroundColor = colorRGB(241, 241, 241);
    [superView addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    imageView.center = CGPointMake(CGRectGetWidth(tableView.frame)/2, CGRectGetHeight(tableView.frame)/2-50);
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, kMainW, 21);
    label.center = CGPointMake(CGRectGetWidth(tableView.frame)/2,  CGRectGetMaxY(imageView.frame)+CGRectGetHeight(label.frame)/2.0);
    label.text = text0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = colorRGB(32, 32, 32);
    [view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.bounds = CGRectMake(0, 0, kMainW, 21);
    label1.center = CGPointMake(CGRectGetWidth(tableView.frame)/2, CGRectGetMaxY(label.frame)+CGRectGetHeight(label1.frame)/2.0);
    label1.text = text1;
    label1.font = [UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = colorRGB(117, 117, 117);
    [view addSubview:label1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 150, 35);
    button.center = CGPointMake(CGRectGetWidth(tableView.frame)/2, CGRectGetMaxY(label1.frame)+CGRectGetHeight(button.frame)/2.0+10);
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    button.tag = 10;
    [view addSubview:button];
    
    return view;
}
@end
