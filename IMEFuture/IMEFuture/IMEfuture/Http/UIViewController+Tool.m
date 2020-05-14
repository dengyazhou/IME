//
//  UIViewController+Tool.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/11.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "UIViewController+Tool.h"
#import "DatabaseTool.h"
#import "UrlContant.h"

#import <WebKit/WebKit.h>
#import "IMEProcessPool.h"

#import "JPUSHService.h"

#import "Header.h"

@implementation UIViewController (Tool)

- (void)goHomepage {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"用户登录信息失效，请重新登录!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self loginOut];
        
        if ([self isMemberOfClass:[UINavigationController class]]) {
            NSLog(@"%@",((UINavigationController *)self).viewControllers);
            [(UINavigationController *)self popToRootViewControllerAnimated:YES];
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
//    NSLog(@"%s",__FUNCTION__);
    
}

- (void)loginOut {
    WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *contentController = [[WKUserContentController alloc] init];
    webViewConfiguration.userContentController = contentController;
    webViewConfiguration.processPool = [IMEProcessPool shareInstance];
    WKWebView *wkWebView =[[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:webViewConfiguration];
    [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[DYZ_user_ssoLogout stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    [self.view addSubview:wkWebView];
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"psw"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [JPUSHService setAlias:@"" callbackSelector:nil object:self];
    UITabBarController *tabBar;
    if ([self isMemberOfClass:[UINavigationController class]]) {
        tabBar = ((UINavigationController *)self).viewControllers[0];
    } else {
        tabBar = self.navigationController.viewControllers[0];
    }
//    tabBar.viewControllers[2].tabBarItem.badgeValue = nil;//不要这句话好像也可以
    [DatabaseTool dropLoginModel];
}


- (NSAttributedString *)toolAttributedString:(NSString *)text {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:colorRGB(0, 122, 254) range:NSMakeRange(5, text.length - 9)];
    return attributeStr;
}

@end
