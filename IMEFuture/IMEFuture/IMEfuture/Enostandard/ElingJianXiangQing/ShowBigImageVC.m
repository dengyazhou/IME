//
//  LingJianXiangQingViewController2.m
//  IMEFuture
//
//  Created by 邓亚洲 on 19/6/12.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ShowBigImageVC.h"
#import "VoHeader.h"
#import <WebKit/WebKit.h>

@interface ShowBigImageVC () <WKNavigationDelegate>{
    UIActivityIndicatorView *_activityIndicatorView;
    
    

    CGFloat _height_TabBar;
}


@property (weak, nonatomic) IBOutlet UIView *webBG;//以后会去掉

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (nonatomic,strong) WKWebView *wkWebView;

@end

@implementation ShowBigImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = Height_NavBar;
    
    
    WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.webBG.frame configuration:webViewConfiguration];
    [self.webBG addSubview:self.wkWebView];
    self.wkWebView.navigationDelegate = self;

    
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.frame = CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar);
    _activityIndicatorView.backgroundColor = colorRGB(230, 230, 230);
    [self.view addSubview:_activityIndicatorView];
    _activityIndicatorView.hidden = YES;
    
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_activityIndicatorView stopAnimating];
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
