//
//  PadCheckBigImageViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/11.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "PadCheckBigImageViewController.h"
#import "VoHeader.h"

#import <ReactiveObjC.h>
#import <WebKit/WebKit.h>

@interface PadCheckBigImageViewController () <WKNavigationDelegate>{
    UIView *_viewLoading;
}


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBack;
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation PadCheckBigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    self.webView.navigationDelegate = self;
    
    @weakify(self)
    [[self.buttonLeftBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:true];
    }];
    
    [self requestCreatePreviewUrlNew];
}

//获取图片接口
- (void)requestCreatePreviewUrlNew {
    _viewLoading.hidden = NO;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
       
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
       
    ProductionControlVo *productionControlVo = [[ProductionControlVo alloc] init];
    productionControlVo.siteCode = siteCode;
    productionControlVo.productionControlNum = self.productionControlNum;
       
    mesPostEntityBean.entity = productionControlVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
       
    [HttpMamager postRequestWithURLString:DYZ_productionControl_createPreviewUrlNew parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:returnMsgBean.returnMsg]]];
        } else {
            _viewLoading.hidden = YES;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    _viewLoading.hidden = YES;
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
