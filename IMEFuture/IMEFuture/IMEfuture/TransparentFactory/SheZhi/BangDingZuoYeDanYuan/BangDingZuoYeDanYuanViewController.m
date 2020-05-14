//
//  ScanZuoYeDanYuanViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BangDingZuoYeDanYuanViewController.h"
#import "VoHeader.h"

#import "SaoYiSaoVC.h"
#import "ScanYuanGongMaViewController.h"
#import "TpfMaiViewController.h"
#import "ZuoYeDanYuanLieBiaoViewController.h"

@interface BangDingZuoYeDanYuanViewController () <UITextFieldDelegate> {
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;


@property (weak, nonatomic) IBOutlet UIView *view00;
@property (weak, nonatomic) IBOutlet UIView *view01;
@property (weak, nonatomic) IBOutlet UIView *view02;

@property (weak, nonatomic) IBOutlet UIView *view10;
@property (weak, nonatomic) IBOutlet UILabel *view10LabelName;
@property (weak, nonatomic) IBOutlet UIView *view11;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;

@end

@implementation BangDingZuoYeDanYuanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.view00.hidden = YES;
    self.view01.hidden = YES;
    self.view02.hidden = YES;
    
    self.view10.hidden = YES;
    self.view11.hidden = YES;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserBean *userBean = [UserBean mj_objectWithKeyValues:loginModel.ucenterUser];
    NSString * siteCode = userBean.enterpriseInfo.serialNo;
    NSString *workUnitCode = [DatabaseTool t_TpfPWTableGetWorkUnitCodeWithSiteCode:siteCode];

    if (![workUnitCode isEqualToString:@"(null)"]) {
        NSLog(@"(null):存在");
        self.view10.hidden = NO;
        self.view11.hidden = NO;
    } else {
        NSLog(@"(null):不存在");
        self.view00.hidden = NO;
        self.view01.hidden = NO;
        self.view02.hidden = NO;
    }
    
    self.view10LabelName.text = [DatabaseTool t_TpfPWTableGetWorkUnitTextWithSiteCode:siteCode];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view00.hidden = YES;
    self.view01.hidden = YES;
    self.view02.hidden = YES;
    
//    self.view10.hidden = YES;
//    self.view11.hidden = YES;
    
    _height_NavBar = Height_NavBar;
    _height_BottomBar = Height_BottomBar;
    self.heightNavBar.constant = _height_NavBar;
    self.heightBottomBar.constant = _height_BottomBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self setAttributedString:@"摄像头对准作业单元二维码，\n点击扫描"];//设置中间字颜色
    
    
    self.textField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self request:textField.text];
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}


#pragma mark 扫描
- (IBAction)buttonScan:(id)sender {
    NSLog(@"%s",__FUNCTION__);
    
    SaoYiSaoVC *saoYiSaoVC = [[SaoYiSaoVC alloc] init];
    saoYiSaoVC.scanTitle = @"扫描作业单元二维码";
    [saoYiSaoVC setResultBlock:^(NSString *result) {
        NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        [self request:dic[@"workUnitCode"]];
    }];
    [self presentViewController:saoYiSaoVC animated:YES completion:nil];
}
- (void)request:(NSString *)result {
    
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserBean *userBean = [UserBean mj_objectWithKeyValues:loginModel.ucenterUser];
    NSString * siteCode = userBean.enterpriseInfo.serialNo;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    ReportWorkWorkUnitScanVo *workUnitScanVo = [[ReportWorkWorkUnitScanVo alloc] init];
    workUnitScanVo.siteCode = siteCode;
    workUnitScanVo.workUnitCode = result;
    mesPostEntityBean.entity = workUnitScanVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_scan_workUnitBindingScan parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        _viewLoading.hidden = YES;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            ReportWorkWorkUnitScanVo *workUnitScanVo = [ReportWorkWorkUnitScanVo mj_objectWithKeyValues:returnEntityBean.entity];
            [DatabaseTool t_TpfPWTableUpdateWithSiteCode:siteCode andWorkUnitCode:workUnitScanVo.workUnitCode andWorkUnitText:workUnitScanVo.workUnitText];
            [self viewWillAppear:YES];
        } else {
            _viewLoading.hidden = YES;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

#pragma mark 重新绑定
- (IBAction)buttonChongXinBangDing:(id)sender {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserBean *userBean = [UserBean mj_objectWithKeyValues:loginModel.ucenterUser];
    NSString * siteCode = userBean.enterpriseInfo.serialNo;
    [DatabaseTool t_TpfPWTableUpdateWithSiteCode:siteCode andWorkUnitCode:nil andWorkUnitText:nil];
    [self viewWillAppear:YES];
}

- (void)setAttributedString:(NSString *)text {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:colorRGB(0, 122, 254) range:NSMakeRange(5, text.length - 9)];
    self.label.attributedText = attributeStr;
}

- (IBAction)back:(id)sender {
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
