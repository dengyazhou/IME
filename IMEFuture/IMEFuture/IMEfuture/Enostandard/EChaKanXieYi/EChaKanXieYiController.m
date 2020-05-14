//
//  EChaKanXieYi.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/9/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "EChaKanXieYiController.h"
#import "Header.h"
#import "UIView+AddViewNoNetAndNoContent.h"
#import "VoHeader.h"
#import <WebKit/WebKit.h>

@interface EChaKanXieYiController () <WKNavigationDelegate> {
    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (nonatomic,strong) WKWebView *wkWebView;

@end

@implementation EChaKanXieYiController

- (void)viewWillAppear:(BOOL)animated {
    _viewLoading.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.webBG.frame configuration:webViewConfiguration];
    [self.webBG addSubview:self.wkWebView];
    self.wkWebView.navigationDelegate = self;
    
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]]];

    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    _viewLoading.hidden = YES;
}

#pragma mark 不同意
- (IBAction)buttonBuTongYi:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(buTongYiXieYiEChaKanXieYiControllerDelegate)]) {
        [self.delegate buTongYiXieYiEChaKanXieYiControllerDelegate];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 同意
- (IBAction)buttonTongYi:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tongYiXieYiEChaKanXieYiControllerDelegate)]) {
        [self.delegate tongYiXieYiEChaKanXieYiControllerDelegate];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
