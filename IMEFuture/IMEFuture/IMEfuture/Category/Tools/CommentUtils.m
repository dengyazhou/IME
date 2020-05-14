//
//  CommentUtils.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/12/2.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "CommentUtils.h"

#import "Header.h"

#import "EGInquiryViewController.h"
#import "EGOrderViewController.h"
#import "ECInquiryViewController.h"
#import "ECOrderViewController.h"
#import "ECSupplierViewController.h"
#import "ECProjectViewController.h"


#import "IMETabBarViewController.h"

@implementation CommentUtils

+ (void)goToPurchaseView:(NSUInteger)selectedIndex withInquiryOrder:(NSString *)inquiryType withViewConTroller:(UIViewController *)viewController {
    
    IMETabBarViewController *imeTabBar = [[IMETabBarViewController alloc] init];
    
    [viewController.navigationController pushViewController:imeTabBar animated:YES];
}

+ (void)goToSupplierView:(NSUInteger)selectedIndex withInquiryOrder:(NSString *)inquiryType withViewConTroller:(UIViewController *)viewController{
    EGInquiryViewController *eGInquiryViewController = [[EGInquiryViewController alloc] init];
    eGInquiryViewController.tabBarItem.title = @"询盘";
    eGInquiryViewController.tabBarItem.image = [UIImage imageNamed:@"ime_icon_purchaser"];
    eGInquiryViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"ime_icon_purchaser_3t"];
    
    EGOrderViewController *eGOrderViewController = [[EGOrderViewController alloc] init];
    eGOrderViewController.tabBarItem.title = @"订单";
    eGOrderViewController.tabBarItem.image = [UIImage imageNamed:@"ime_icon_order"];
    eGOrderViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"ime_icon_order_3t"];
    
    
    UITabBarController * tabBarC = [[UITabBarController alloc] init];
    tabBarC.viewControllers = @[eGInquiryViewController,eGOrderViewController];
    tabBarC.selectedIndex = selectedIndex;
    tabBarC.tabBar.tintColor = [UIColor colorWithRed:0/255.0 green:168/255.0 blue:255/255.0 alpha:1];
    [viewController.navigationController pushViewController:tabBarC animated:YES];
    
    if (selectedIndex == 1) {
        if ([inquiryType isEqualToString:@"COM"]||[inquiryType isEqualToString:@"DIR"]) {
            eGOrderViewController.indexInquiryType = 1;
        }
        if ([inquiryType isEqualToString:@"ATG"]||[inquiryType isEqualToString:@"FTG"]||[inquiryType isEqualToString:@"TTG"]) {
            eGOrderViewController.indexInquiryType = 2;
        }
    }
}

@end
