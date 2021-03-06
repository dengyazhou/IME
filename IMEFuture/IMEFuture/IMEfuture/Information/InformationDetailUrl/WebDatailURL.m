//
//  WebDatailURL.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "WebDatailURL.h"

#import "Header.h"
#import "UrlContant.h"
#import "UIView+AddViewNoNetAndNoContent.h"

#import <JavaScriptCore/JavaScriptCore.h>


#import <ShareSDK/ShareSDK.h>
// 弹出分享菜单需要导入的头文件
#import <ShareSDKUI/ShareSDK+SSUI.h>
// 自定义分享菜单栏需要导入的头文件
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//自定义分享编辑界面所需要导入的头文件
#import <ShareSDKUI/SSUIEditorViewStyle.h>

#import "CompanyViewController.h"


#import <WebKit/WebKit.h>
#import "IMEProcessPool.h"

@interface WebDatailURL () <WKNavigationDelegate,WKScriptMessageHandler> {

    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    
    WKWebView *_wkWebView;
}

@property (strong, nonatomic) JSContext *jsContext;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation WebDatailURL

- (void)viewWillAppear:(BOOL)animated {
    _viewLoading.hidden = NO;
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.labelHeaderTitle.text = self.titleTitle;

    
    WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *contentController = [[WKUserContentController alloc] init];
    [contentController addScriptMessageHandler:self name:@"webLaunchNativeAppLogin"];
    webViewConfiguration.userContentController = contentController;
    webViewConfiguration.processPool = [IMEProcessPool shareInstance];
    
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) configuration:webViewConfiguration];
    _wkWebView.navigationDelegate = self;
    [self.view addSubview:_wkWebView];
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    if (self.isShare) {
        self.shareButton.hidden = NO;
    } else {
        self.shareButton.hidden = YES;
    }
}



#pragma mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    _viewLoading.hidden = YES;
}
#pragma mark WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"webLaunchNativeAppLogin"]) {
//        NSLog(@"body:%@",message.body);
        CompanyViewController *companyVC = [[CompanyViewController alloc] init];
        companyVC.isH5 = @"YES";
        companyVC.backBlock = ^ (NSString *string) {
            [self.navigationController popViewControllerAnimated:YES];
        };
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:companyVC] animated:YES completion:nil];
    }
}


- (IBAction)share:(UIButton *)sender {
    //1、创建分享参数
//    NSArray* imageArray = @[[UIImage imageNamed:@"icon_act_2t"]];
    NSArray* imageArray = @[self.imagePath];
    
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKEnableUseClientShare];
        [shareParams SSDKSetupShareParamsByText:self.content
                                         images:imageArray
                                            url:[NSURL URLWithString:self.detailUrl]
                                          title:self.titleTitle
                                           type:SSDKContentTypeAuto];
        
        [SSUIShareActionSheetStyle setItemNameFont:[UIFont systemFontOfSize:11.75]];
        [SSUIEditorViewStyle setiPhoneNavigationBarBackgroundColor:[UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1]];
        
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:@[@(SSDKPlatformSubTypeWechatSession),
                                         @(SSDKPlatformSubTypeWechatTimeline),
                                         @(SSDKPlatformTypeSinaWeibo)]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }];
    }
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    WKWebView *wkWeb = [[UIApplication sharedApplication].keyWindow viewWithTag:9875];
    wkWeb.frame = CGRectMake(0, 0, 0, 0);
}


- (NSMutableString *)getbodyHead {
    NSArray *cookieArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"cookieArr"];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:cookieArr];
    
    NSMutableString * _badyhead =[NSMutableString string];
    
    if (!cookieArr) {
        return _badyhead;
    }
    
    for (int i = 0; i<mutableArray.count; i++) {
        
        NSString *bady = [NSString stringWithFormat:@"%@=%@;",mutableArray[i][0],mutableArray[i][1]];
        
        [_badyhead appendFormat:@"%@",bady];
    }
    
    [_badyhead deleteCharactersInRange:NSMakeRange(_badyhead.length - 1, 1)];
    
    return _badyhead;
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
