//
//  EH5FuKuanViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/9/22.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "EH5FuKuanViewController.h"
#import "Header.h"
#import "UIView+AddViewNoNetAndNoContent.h"

#import <WebKit/WebKit.h>
#import "IMEProcessPool.h"

@interface EH5FuKuanViewController () <WKNavigationDelegate> {
    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;


@end

@implementation EH5FuKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    
    WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *contentController = [[WKUserContentController alloc] init];
    webViewConfiguration.userContentController = contentController;
    webViewConfiguration.processPool = [IMEProcessPool shareInstance];
    WKWebView *wkWebView =[[WKWebView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) configuration:webViewConfiguration];
    wkWebView.navigationDelegate = self;
    [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]]];
    [self.view addSubview:wkWebView];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@">>>>>%@<",[webView.URL absoluteString]);
    
    if ([[webView.URL absoluteString] containsString:@"trade/getPayStatus"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshECOrder" object:nil userInfo:nil];
    }
    
    if ([[webView.URL absoluteString] containsString:@"purchaseOrder/orderDetail"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    _viewLoading.hidden = YES;
}


- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
