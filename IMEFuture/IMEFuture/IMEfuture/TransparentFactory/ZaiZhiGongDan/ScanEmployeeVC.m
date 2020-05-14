//
//  ScanEmployeeVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ScanEmployeeVC.h"
#import "VoHeader.h"

#import "SaoYiSaoVC.h"


@interface ScanEmployeeVC () <UITextFieldDelegate> {
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *label;//摄像头对准图纸二维码，点击扫描


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;

@end

@implementation ScanEmployeeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserBean *userBean = [UserBean mj_objectWithKeyValues:loginModel.ucenterUser];
    NSString * siteCode = userBean.enterpriseInfo.serialNo;
    NSString *personnelCode = [DatabaseTool t_TpfPWTableGetPersonnelCodeWithSiteCode:siteCode];
    if (![personnelCode isEqualToString:@"(null)"]) {
        NSLog(@"(null):存在");
        [self request:personnelCode];
    } else {
        NSLog(@"(null):不存在");
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _height_NavBar = Height_NavBar;
    _height_BottomBar = Height_BottomBar;
    self.heightNavBar.constant = _height_NavBar;
    self.heightBottomBar.constant = _height_BottomBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    
    [self setAttributedString:@"摄像头对准员工二维码，\n点击扫描"];//设置中间字颜色
    
    
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
    saoYiSaoVC.scanTitle = @"扫描员工二维码";
    [saoYiSaoVC setResultBlock:^(NSString *result) {
        
        NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
         [self request:dic[@"personnelCode"]];
    }];
    [self presentViewController:saoYiSaoVC animated:YES completion:nil];
}

- (void)request:(NSString *)result {

    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo * userInfoVo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString * siteCode = userInfoVo.siteCode;
    
    MesPostEntityBean * mesPostEntityBean = [[MesPostEntityBean alloc] init];
    PersonnelVo * personnelVo = [[PersonnelVo alloc] init];
    personnelVo.siteCode = siteCode;
    personnelVo.personnelCode = result;
    mesPostEntityBean.entity = personnelVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_scanRest_personnelScanCheck parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            PersonnelVo *personnelVo = [PersonnelVo mj_objectWithKeyValues:returnEntityBean.entity];

            
            if (self.passwordAuthentificationBlockTemp) {
                [self.navigationController popViewControllerAnimated:YES];
                self.passwordAuthentificationBlockTemp(result, personnelVo.needPassword.integerValue);
            }
        } else if ([returnEntityBean.status isEqualToString:@"ERROR"]) {
            /**
             {"status":"ERROR","memberId":null,"jsonStr":null,"returnCode":-3,"returnMsg":"员工无权限审核！","entity":null}
             
             */
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];//员工无权限审核！
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
       
       
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];

}

- (void)passwordAuthentificationCallBack:(void(^)(NSString * str,NSInteger needPassword))passwordAuthentificationBlock {
    self.passwordAuthentificationBlockTemp = passwordAuthentificationBlock;
}

#pragma mark 回到首页
- (IBAction)buttonGoHome:(id)sender {

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
