//
//  WebDatailURL.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "WebDatailURLTouMingGongChang.h"

#import "Header.h"
#import "UrlContant.h"
#import "UIView+AddViewNoNetAndNoContent.h"

#import <JavaScriptCore/JavaScriptCore.h>


#import <WebKit/WebKit.h>
#import "IMEProcessPool.h"

@protocol JSObjcDelegate <JSExport>

- (void)jsCallOCBack;

@end

@interface WebDatailURLTouMingGongChang () <JSObjcDelegate,WKNavigationDelegate,WKScriptMessageHandler> {
    UIView *_viewLoading;

    CGFloat _height_NavBar;
    
    WKWebView *_wkWebView;
    WKWebView *_wkWebView1;
    
    NSInteger _howManyTimes;
}

@property (strong, nonatomic) JSContext *jsContext;

@end

@implementation WebDatailURLTouMingGongChang

- (void)viewWillAppear:(BOOL)animated {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _howManyTimes = 0;
    _height_NavBar = Height_NavBar;
    

    WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *contentController = [[WKUserContentController alloc] init];
    [contentController addScriptMessageHandler:self name:@"finishWebView"];
    webViewConfiguration.userContentController = contentController;
    webViewConfiguration.processPool = [IMEProcessPool shareInstance];


    _wkWebView1 = [[WKWebView alloc] initWithFrame:CGRectMake(0, Height_StatusBar, kMainW, kMainH) configuration:webViewConfiguration];
    _wkWebView1.navigationDelegate = self;
//    _wkWebView1.tag = 101;
    [_wkWebView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]]];
    _wkWebView1.scrollView.bounces = NO;
    [self.view addSubview:_wkWebView1];
    
    
    WKWebView *wkWeb = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:webViewConfiguration];
//    wkWeb.tag = 100;
    wkWeb.navigationDelegate = self;
    [wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:IME_TouMingGongChangDengLu]]];
//    [wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self.view addSubview:wkWeb];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    //假使改变状态栏显色
    UIView *view20 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, Height_StatusBar)];
    view20.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view20];
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //JS调用OC方法
    //message.boby就是JS里传过来的参数
//    NSLog(@"body:%@",message.body);
    if ([message.name isEqualToString:@"finishWebView"]) {
//        NSLog(@"%@",[NSThread currentThread]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s",__FUNCTION__);
    
    if (webView.tag == 100) {
        [_wkWebView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]]];
    }
    if (webView.tag == 101) {
        _viewLoading.hidden = YES;
    }
    
    _viewLoading.hidden = YES;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
    
}



- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s",__FUNCTION__);
    
    if (webView.tag == 100) {
        [_wkWebView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]]];
    }

}



- (void)dealloc {
//    _web.delegate = nil;
//    self.webView.delegate = nil;
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
