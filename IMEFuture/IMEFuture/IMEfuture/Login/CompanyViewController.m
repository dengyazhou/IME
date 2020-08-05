///
//  CompanyViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/6/28.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "CompanyViewController.h"
#import "VoHeader.h"

#import "WoViewController.h"


#import "UIView+Toast.h"


#import "WebDatailURL.h"
#import "JPUSHService.h"
#import "BaiduMobStat.h"

#import "NSArray+Transition.h"

#import <WebKit/WebKit.h>

#import "IMEProcessPool.h"

#import "GlobalSettingManager.h"
#import "ProfileUpdatesObject.h"

@interface CompanyViewController () <WKNavigationDelegate>{
    UIView *_viewLoading;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    
    NSMutableArray *cookieMutaArr;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation CompanyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"profileUpdatesObject.data"];
    ProfileUpdatesObject *profileUpdatesObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    

    if (!profileUpdatesObject.personalPrivacyGuidelines) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"个人隐私保护指引" message:@"欢迎您使用智造家APP！我们将通过《隐私协议》帮助你了解我们收集、使用、存储和共享个人信息的情况，特别是我们所采集的个人信息类" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            profileUpdatesObject.personalPrivacyGuidelines = YES;
            [NSKeyedArchiver archiveRootObject:profileUpdatesObject toFile:path];
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:true completion:nil];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    cookieMutaArr = [[NSMutableArray alloc] initWithCapacity:0];
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.textFieldUser.borderStyle = UITextBorderStyleNone;
    self.textFieldPsw.borderStyle = UITextBorderStyleNone;
    
    self.buttonLogin.enabled = NO;
    self.textFieldPsw.secureTextEntry = YES;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)login:(UIButton *)sender {
    
    NSDictionary *dic = @{@"username":self.textFieldUser.text,
                            @"epname":@"",
                          @"password":self.textFieldPsw.text,
                         @"loginType":@"1",
                    @"isRefreshToken":@"true"};
    _viewLoading.hidden = NO;

    [HttpMamager postRequestLoginWithURLString:DYZ_user_login parameters:dic success:^(id responseObjectModel) {

        [self httpRequestCallback:(id)responseObjectModel url:DYZ_user_login];
    } fail:^(NSError *error) {

        _viewLoading.hidden = YES;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请连接网络"];
    }];
}
- (void)httpRequestCallback:(id)responseObjectModel url:(NSString *)url {
    if ([url isEqualToString:DYZ_user_login]) {
        NSDictionary *dic = responseObjectModel;
        
        LoginModel *obj = [[LoginModel alloc] init];
        obj.enterpriseName = dic[@"enterpriseName"];
        obj.errorMes = dic[@"errorMes"];
        obj.headImg = [NSString stringWithFormat:@"%@",dic[@"headImg"]];
        obj.manufacturerId = dic[@"manufacturerId"];
        obj.memberId = dic[@"memberId"];
        obj.neteaseToken = dic[@"neteaseToken"];
        obj.notifyUrls = dic[@"notifyUrls"];
        obj.resultCode = [dic[@"resultCode"] integerValue];
        obj.ucenterId = dic[@"ucenterId"];
        obj.userType = dic[@"userType"];
        obj.accountName = dic[@"accountName"];
        obj.enterpriseId = dic[@"enterpriseId"];
        obj.regStatus = dic[@"regStatus"];
        obj.userId = dic[@"userId"];
        

        @try {
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"apiTokenId"] forKey:@"tokenId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } @catch (NSException * e) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"tokenId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        if ([dic[@"userType"] isEqualToString:@"ENTERPRISE"]) {
//            @try
//            {
//                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic[@"member"] options:NSJSONWritingPrettyPrinted error:nil];
//                obj.member = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            }@catch (NSException * e) {
//                obj.member = nil;
//            }
        }
        
        @try
        {
            NSData *jsonDataIdentityBeans = [NSJSONSerialization dataWithJSONObject:dic[@"identityBeans"] options:NSJSONWritingPrettyPrinted error:nil];
            obj.identityBeans = [[NSString alloc] initWithData:jsonDataIdentityBeans encoding:NSUTF8StringEncoding];
        }@catch (NSException * e) {
            obj.identityBeans = nil;
        }
        
        if ([dic[@"userType"] isEqualToString:@"ENTERPRISE"]||[dic[@"userType"] isEqualToString:@"NORMAL"]) {
            @try
            {
                NSData *jsonDataucenterUser = [NSJSONSerialization dataWithJSONObject:dic[@"ucenterUser"] options:NSJSONWritingPrettyPrinted error:nil];
                obj.ucenterUser = [[NSString alloc] initWithData:jsonDataucenterUser encoding:NSUTF8StringEncoding];
            }@catch (NSException * e) {
                obj.ucenterUser = nil;
            }
        }

        if (dic[@"tpfUser"] != [NSNull null] && dic[@"tpfUser"] != nil) {//必须用[NSNull null] 因为是一个空对象，用nil判断不出来
            NSData *jsonTpfUser = [NSJSONSerialization dataWithJSONObject:dic[@"tpfUser"] options:NSJSONWritingPrettyPrinted error:nil];
            obj.tpfUser = [[NSString alloc] initWithData:jsonTpfUser encoding:NSUTF8StringEncoding];
            
            UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:obj.tpfUser];
            [[GlobalSettingManager shareGlobalSettingManager] requesttpfGetparameterlistWithSiteCode:userInfo.siteCode];
        } else {
            obj.tpfUser = nil;
        }
        
       
        _viewLoading.hidden = YES;
        if (obj.resultCode == 0) {
            
            if ([obj.regStatus isEqualToString:@"REGISTER"]) {//已注册帐号
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"注册信息不完善，请到官网登录完善信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [ac addAction:action];
                [self presentViewController:ac animated:YES completion:nil];
            }
            if ([obj.regStatus isEqualToString:@"COMPLETEDATA"]) {//已提交资料,待审核
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"账户审核中，请等待" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [ac addAction:action];
                [self presentViewController:ac animated:YES completion:nil];
            }
            if ([obj.regStatus isEqualToString:@"REFUSE"]) {//已拒绝
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"账户审核失败，请到官网查看失败原因" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [ac addAction:action];
                [self presentViewController:ac animated:YES completion:nil];
            }
            if ([obj.regStatus isEqualToString:@"CONFIRM"]) {//已审核
                [[NSUserDefaults standardUserDefaults] setObject:@"mima" forKey:@"psw"];
                [[NSUserDefaults standardUserDefaults] setObject:self.textFieldUser.text forKey:@"username"];
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"epname"];
                [[NSUserDefaults standardUserDefaults] setObject:self.textFieldPsw.text forKey:@"password"];

                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"loginType"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                if ([self.delegate respondsToSelector:@selector(getLoginModel:)]) {
                    [self.delegate getLoginModel:obj];
                }
                if ([self.delegate respondsToSelector:@selector(loginSuccess)]) {
                    [self.delegate loginSuccess];
                }
                if ([obj.userType isEqualToString:@"ENTERPRISE"]) {
                    if ([self.delegate respondsToSelector:@selector(hiddenWoQiYe:hiddenWoGeRen:)]) {
                        [self.delegate hiddenWoQiYe:NO hiddenWoGeRen:YES];
                    }
                }
                if ([obj.userType isEqualToString:@"NORMAL"]) {
                    if ([self.delegate respondsToSelector:@selector(hiddenWoQiYe:hiddenWoGeRen:)]) {
                        [self.delegate hiddenWoQiYe:YES hiddenWoGeRen:NO];
                    }
                }
                [DatabaseTool createLoginReturn];
                
                [DatabaseTool updateLoginReturnWithLogin:obj];
 
                
                
                NSArray *array = [NSArray stringToJSON:obj.identityBeans];
                
                for (NSDictionary *dic in array) {
                    IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
                    if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                        [JPUSHService setAlias:identityBean.userId callbackSelector:nil object:self];
                        break;
                    }
                }
                
                [DatabaseTool t_IdentityBeanCreate];
                for (NSDictionary *dic in array) {
                    
                    IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
                    if (![DatabaseTool t_IdentityBeanOrHaveWithUserId:identityBean.userId]) {
                        [DatabaseTool t_IdentityBeanInsertIntoWithUserId:identityBean.userId andType:0];
                    }
                    NSLog(@"---%@---",identityBean.userId);
                    
                }
                
                [DatabaseTool t_TpfPWTableCreate];
                UserBean *userBean = [UserBean mj_objectWithKeyValues:obj.ucenterUser];
                NSString * siteCode = userBean.enterpriseInfo.serialNo;
                if (![DatabaseTool t_TpfPWTableOrHaveWithSiteCode:siteCode]) {
                    [DatabaseTool t_TpfPWTableInsertIntoWithSiteCode:siteCode andPersonnelCode:nil andPersonnelName:nil andWorkUnitCode:nil andWorkUnitText:nil];
                }
                
                if ([self.isH5 isEqualToString:@"YES"]) {
                    self.backBlock(@"YES");
                }
                
                [self dismissViewControllerAnimated:YES completion:nil];
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"登录成功"];
                [[BaiduMobStat defaultStat] logEvent:@"login" eventLabel:@"登录次数"];
                
                /*  enterpriseNameDic  为税率17% 3%  */
                NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"enterpriseNameDic"];//用来存储登录过的用户 公司名 为税率17% 3%
                NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithDictionary:dic];
                BOOL haveEnterpriseName = NO;
                for (NSString *str in dicM.allKeys) {
                    if ([obj.enterpriseName isEqualToString:str]) {
                        haveEnterpriseName = YES;
                        break;
                    }
                }
                if (!haveEnterpriseName) {
                    [dicM setObject:@"" forKey:obj.enterpriseName];
                    [[NSUserDefaults standardUserDefaults] setObject:dicM forKey:@"enterpriseNameDic"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                /*  enterpriseNameDic  为税率17% 3%  */
                
                if ([obj.userType isEqualToString:@"ENTERPRISE"]) {
            
                }
                
            
                NSString *isChild = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginType"];
                
                NSString *string = [NSString stringWithFormat:@"%@?userName=%@&password=%@&isChild=%@&epName=%@",DYZ_user_ssoLogin,self.textFieldUser.text,self.textFieldPsw.text,isChild,@""];
                
                WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
                WKUserContentController *contentController = [[WKUserContentController alloc] init];
                webViewConfiguration.userContentController = contentController;
                webViewConfiguration.processPool = [IMEProcessPool shareInstance];
                WKWebView *wkWeb = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:webViewConfiguration];
                wkWeb.navigationDelegate = self;
                [wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                [[UIApplication sharedApplication].keyWindow addSubview:wkWeb];
                
//                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } else if ([dic[@"resultCode"] integerValue] == -2) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"账号或密码错误"];
        } else if ([dic[@"resultCode"] integerValue] == -1) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"系统异常"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"登录失败"];
        }
        
    }
}


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)editingDidBegin:(UITextField *)sender {
    switch (sender.tag) {
            case 10:
//                self.imageViewUser.highlighted = YES;
            break;
            case 11:
//                self.imageViewPassword.highlighted = YES;
            break;
        default:
            break;
    }
}

- (IBAction)editingChanged:(UITextField *)sender {
    if (self.textFieldUser.text.length != 0 && self.textFieldPsw.text.length != 0) {
        self.buttonLogin.backgroundColor = [UIColor colorWithRed:89/255.0 green:179/255.0 blue:50/255.0 alpha:1];
        self.buttonLogin.enabled = YES;
    } else {
        self.buttonLogin.backgroundColor = [UIColor colorWithRed:167/255.0 green:213/255.0 blue:150/255.0 alpha:1];
        self.buttonLogin.enabled = NO;
    }
}

- (IBAction)buttonClickPsw:(UIButton *)sender {
    if (self.textFieldPsw.secureTextEntry == YES) {
        self.textFieldPsw.secureTextEntry = NO;
//        [sender setBackgroundImage:[UIImage imageNamed:@"pss_so"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"pss_so"] forState:UIControlStateNormal];
    }else {
        self.textFieldPsw.secureTextEntry = YES;
//        [sender setBackgroundImage:[UIImage imageNamed:@"pss_invisible"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"pss_invisible"] forState:UIControlStateNormal];
    }
}

#pragma mark 忘记密码
- (IBAction)wangJiMiMa:(UIButton *)sender {
    WebDatailURL * webDatailURL = [[WebDatailURL alloc] init];
    webDatailURL.titleTitle = @"忘记密码";
    webDatailURL.detailUrl = PostForgetPassword;
    [self.navigationController pushViewController:webDatailURL animated:YES];
}

#pragma mark 没有帐号，快速注册
- (IBAction)buttonClickZhuCe:(UIButton *)sender {
    WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
    webDatailURL.titleTitle = @"帐号注册";
    webDatailURL.detailUrl = PostAccount;
    [self.navigationController pushViewController:webDatailURL animated:YES];
}


- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([self.delegate respondsToSelector:@selector(notLoginExchangeViewController)]) {
        [self.delegate notLoginExchangeViewController];
    }
}
- (IBAction)buttonZanBuDengLu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
