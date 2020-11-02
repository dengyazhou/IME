//
//  ZhangHuGuanLiViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/6/26.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ZhangHuGuanLiViewController.h"
#import "VoHeader.h"

#import "ZhuangHuGuanLiCell.h"


#import "JPUSHService.h"

#import "UIView+Toast.h"

#import "NSArray+Transition.h"

#import <WebKit/WebKit.h>
#import "IMEProcessPool.h"

#import "GlobalSettingManager.h"

@interface ZhangHuGuanLiViewController ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate> {
    UIView *_viewLoading1;//透明
   
    NSString *_first;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *arrayDataList;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation ZhangHuGuanLiViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];

    NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
    
    self.arrayDataList = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in array) {
        IdentityBean *obj = [IdentityBean mj_objectWithKeyValues:dic];
        [self.arrayDataList addObject:obj];
    }
    

    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZhuangHuGuanLiCell" bundle:nil] forCellReuseIdentifier:@"zhuangHuGuanLiCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _viewLoading1 = [UIView loadingWithFrame:CGRectMake(0, 0, kMainW, kMainH)];
    _viewLoading1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewLoading1];
    _viewLoading1.hidden = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayDataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZhuangHuGuanLiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zhuangHuGuanLiCell" forIndexPath:indexPath];
    
    cell.viewLineTop.hidden = YES;
    cell.viewLineBottomDuan.hidden = YES;
    cell.viewLineBottom.hidden = YES;
    cell.imageAgree.hidden = YES;
    cell.labelNameTrailingMargin.constant = 0;
    
    if (indexPath.row == 0) {
        cell.viewLineTop.hidden = NO;
    }
    
    if (indexPath.row == self.arrayDataList.count-1) {
        cell.viewLineBottom.hidden = NO;
    } else {
        cell.viewLineBottomDuan.hidden = NO;
    }
    
    IdentityBean *identityBean = self.arrayDataList[indexPath.row];
    
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    if ([loginModel.ucenterId isEqualToString:identityBean.ucenterId]) {
        cell.imageAgree.hidden = NO;
        cell.labelNameTrailingMargin.constant = 18;
    }
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"hhmmss";
    NSString *stringDate = [formatter stringFromDate:date];
    stringDate = [stringDate substringToIndex:5];//取时间的前五个字符，防止刷新两次
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@&t=%@",PostURLSheZhi(@"/interface/getUserHeadImg.html?uid="),identityBean.ucenterId,stringDate];
    
    if ([identityBean.userType isEqualToString:@"ENTERPRISE"]) {
        [cell.imageHeader sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"ime_icon_head-portrait01"]];
    } else {
        [cell.imageHeader sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"ime_icon_head-portrait00"]];
    }
    
    cell.labelName.text = identityBean.showName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    IdentityBean *identityBean = self.arrayDataList[indexPath.row];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    if ([loginModel.ucenterId isEqualToString:identityBean.ucenterId]) {
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否切换身份到:" message:identityBean.showName preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionleft = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *actionRight = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _viewLoading1.hidden = NO;
        _first = @"first";
   
        NSString *string = [NSString stringWithFormat:@"%@?ucenterId=%@",DYZ_user_changeIdentity,identityBean.ucenterId];
        
        WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *contentController = [[WKUserContentController alloc] init];
        webViewConfiguration.userContentController = contentController;
        webViewConfiguration.processPool = [IMEProcessPool shareInstance];
        WKWebView *wkWebView =[[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:webViewConfiguration];
        wkWebView.navigationDelegate = self;
        [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
        [self.view addSubview:wkWebView];
        
    }];
    [alertController addAction:actionleft];
    [alertController addAction:actionRight];
    [self presentViewController:alertController animated:YES completion:nil];
    
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"是否切换身份到:" attributes:@{NSForegroundColorAttributeName:colorRGB(102, 102, 102),NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    [alertController setValue:alertControllerStr forKey:@"attributedTitle"];
    
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:identityBean.showName attributes:@{NSForegroundColorAttributeName:colorRGB(33, 33, 33),NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%@",webView.URL.absoluteString);
    
    if (![webView.URL.absoluteString containsString:@"goMain"]) {
        if ([_first isEqualToString:@"first"]) {
            _first = @"first1";
            NSString *string1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
            NSString *string2 = [[NSUserDefaults standardUserDefaults]objectForKey:@"epname"];
            NSString *string3 = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
            NSString *string4 = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginType"];
            NSDictionary *dicParameters = @{@"username":string1,
                                            @"epname":string2,
                                            @"password":string3,
                                            @"loginType":string4,
                                            @"isRefreshToken":@"false"};

            [HttpMamager postRequestLoginWithURLString:DYZ_user_login parameters:dicParameters success:^(id responseObjectModel) {
//                _viewLoading1.hidden = YES;
                [self httpRequestCallback:(id)responseObjectModel url:DYZ_user_login];
            } fail:^(NSError *error) {
                _viewLoading1.hidden = YES;
            }];
        }
    }
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
        

        [[NSUserDefaults standardUserDefaults] synchronize];
        if ([dic[@"userType"] isEqualToString:@"ENTERPRISE"]) {
            @try {
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic[@"member"] options:NSJSONWritingPrettyPrinted error:nil];
                obj.member = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            } @catch (NSException *exception) {
                obj.member = nil;
            }
        }
        
        @try {
            NSData *jsonDataIdentityBeans = [NSJSONSerialization dataWithJSONObject:dic[@"identityBeans"] options:NSJSONWritingPrettyPrinted error:nil];
            obj.identityBeans = [[NSString alloc] initWithData:jsonDataIdentityBeans encoding:NSUTF8StringEncoding];
        } @catch (NSException *exception) {
            obj.identityBeans = nil;
        }
        
        @try {
            NSData *jsonDataucenterUser = [NSJSONSerialization dataWithJSONObject:dic[@"ucenterUser"] options:NSJSONWritingPrettyPrinted error:nil];
            obj.ucenterUser = [[NSString alloc] initWithData:jsonDataucenterUser encoding:NSUTF8StringEncoding];
        } @catch (NSException *exception) {
            obj.ucenterUser = nil;
        }
        
        if (dic[@"tpfUser"] != [NSNull null] && dic[@"tpfUser"] != nil) {
            NSData *jsonTpfUser = [NSJSONSerialization dataWithJSONObject:dic[@"tpfUser"] options:NSJSONWritingPrettyPrinted error:nil];
            obj.tpfUser = [[NSString alloc] initWithData:jsonTpfUser encoding:NSUTF8StringEncoding];
            
        } else {
            obj.tpfUser = nil;
        }
        
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
            
                [DatabaseTool updateLoginReturnWithLogin:obj];
                
                NSArray *array = [NSArray stringToJSON:obj.identityBeans];
                for (NSDictionary *dic in array) {
                    IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
                    if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                        [JPUSHService setAlias:identityBean.userId callbackSelector:nil object:self];
                        break;
                    }
                }
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                _viewLoading1.hidden = YES;
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"切换成功"];
        
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
                    
                } else {
                   
                }
                
                [self.tableView reloadData];
            }
        } else if ([dic[@"resultCode"] integerValue] == -2) {
            _viewLoading1.hidden = YES;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"密码错误"];
        } else if ([dic[@"resultCode"] integerValue] == -1) {
            _viewLoading1.hidden = YES;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"系统异常"];
        } else {
            _viewLoading1.hidden = YES;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"登录失败"];
        }
    }
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
