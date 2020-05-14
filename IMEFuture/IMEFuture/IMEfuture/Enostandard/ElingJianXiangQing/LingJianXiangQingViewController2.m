//
//  LingJianXiangQingViewController2.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/9/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "LingJianXiangQingViewController2.h"
#import "VoHeader.h"
#import <WebKit/WebKit.h>

@interface LingJianXiangQingViewController2 () <WKNavigationDelegate> {
    UIActivityIndicatorView *_activityIndicatorView;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (nonatomic,strong) WKWebView *wkWebView;

@end

@implementation LingJianXiangQingViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.imageViewBG.hidden = YES;
    WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.webBG.frame configuration:webViewConfiguration];
    [self.webBG addSubview:self.wkWebView];
    self.wkWebView.navigationDelegate = self;
    
    self.wkWebView.hidden = YES;
    
    
    
    self.imageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panSelector:)];
    [self.imageView addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchSelector:)];
    [self.imageView addGestureRecognizer:pinch];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.frame = CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar);
    _activityIndicatorView.backgroundColor = colorRGB(230, 230, 230);
    [self.view addSubview:_activityIndicatorView];
    _activityIndicatorView.hidden = YES;
    
    
    
    
    if ([self.isMatchDrawingCloud integerValue] == 0) {
        self.imageViewBG.hidden = NO;
        
        if ([self.inquiryOrderItemFile.sec_thumbnailUrl containsString:@".dwg"] ) {
            self.imageView.image = [UIImage imageNamed:@"picture_dwg"];
        } else if ([self.inquiryOrderItemFile.sec_thumbnailUrl containsString:@".png"] || [self.inquiryOrderItemFile.sec_thumbnailUrl containsString:@".gif"] || [self.inquiryOrderItemFile.sec_thumbnailUrl containsString:@".jpeg"]) {
            _activityIndicatorView.hidden = NO;
            [_activityIndicatorView startAnimating];
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.inquiryOrderItemFile.sec_realUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [_activityIndicatorView stopAnimating];
            }];
        } else if ([self.inquiryOrderItemFile.sec_thumbnailUrl containsString:@".jpg"]) {
            if ([self.inquiryOrderItemFile.sec_thumbnailUrl containsString:@"pdf.jpg"]) {
                self.wkWebView.hidden = NO;
                _activityIndicatorView.hidden = NO;
                [_activityIndicatorView startAnimating];
                [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.inquiryOrderItemFile.sec_realUrl]]];
            } else {
                _activityIndicatorView.hidden = NO;
                [_activityIndicatorView startAnimating];
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.inquiryOrderItemFile.sec_realUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [_activityIndicatorView stopAnimating];
                }];
            }
        } else {
            self.imageView.image = [UIImage imageNamed:@"img_picture_conversion"];
        }
    }
    
    if ([self.isMatchDrawingCloud integerValue] == 1) {
        self.wkWebView.hidden = NO;
        _activityIndicatorView.hidden = NO;
        [_activityIndicatorView startAnimating];
        
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        
        postEntityBean.entity = @{@"adId":self.accDrawingInter.adId,@"enterpriseId":loginModel.enterpriseId};
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_drawingCloud_createPreviewUrl parameters:dic success:^(id responseObjectModel) {
            
            ReturnMsgBean *model = responseObjectModel;
            
            if ([model.status isEqualToString:@"SUCCESS"]) {
//                NSLog(@"%@",model.returnMsg);
                
                [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.returnMsg]]];
                
            } else {
                self.imageViewBG.hidden = NO;
                self.imageView.image = [UIImage imageNamed:@"img_picture_conversion"];
            }
            
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    }
    
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_activityIndicatorView stopAnimating];
}


- (void)panSelector:(UIPanGestureRecognizer*)pan{
    //获取手势的坐标
    CGPoint point = [pan translationInView:self.view];
    //设置手势所在View的坐标
    pan.view.center = CGPointMake(pan.view.center.x+point.x, pan.view.center.y+point.y);
    
    //解决坐标叠加的问题加了以下代码就是每一次把坐标设置成初始的样子
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)pinchSelector:(UIPinchGestureRecognizer*)pinch{
    //scale扩大或者缩小的倍数
    CGFloat scale = pinch.scale;
    //CGAffineTransformScale是设置View的扩大或缩小的值，第一个参数是原来的样子，第二和第三个参数分别是从X和Y的方向上扩大或缩小的尺度值
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, scale, scale);
    //解决放大或缩小叠加的问题将这个放大或缩小的倍数变成原来的值就可以了
    pinch.scale = 1;
}

- (IBAction)back:(UIButton *)sender {
    self.imageViewBG.hidden = YES;
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
