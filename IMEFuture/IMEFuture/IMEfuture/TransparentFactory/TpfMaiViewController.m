//
//  TpfMaiViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "TpfMaiViewController.h"
#import "VoHeader.h"
#import "NSArray+Transition.h"

#import "ScanTuZhiViewController.h"
#import "TpfSZViewController.h"
#import "WebDatailURLTouMingGongChang.h"

#import <WebKit/WebKit.h>
#import "IMEProcessPool.h"


#import "IMEFuture-swift.h"
#import "YunShuVC.h"
#import "TemporaryTaskDetailedListVC.h"
#import "TemporaryTaskVC.h"
#import "YunShuGuanLi/YunShuDetailVC.h"
#import "ScanGongXuViewController.h"
#import "SweepTheCodeReturnsVC.h"
#import "GlobalSettingManager.h"



@interface TpfMaiViewController () <WKNavigationDelegate> {
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    NSMutableArray *_arrayUserRoleAuthorities;
    
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (weak, nonatomic) IBOutlet UIButton *button00;
@property (weak, nonatomic) IBOutlet UILabel *label00;
@property (weak, nonatomic) IBOutlet UIImageView *image00;

@property (weak, nonatomic) IBOutlet UIButton *button01;
@property (weak, nonatomic) IBOutlet UILabel *label01;
@property (weak, nonatomic) IBOutlet UIImageView *image01;

@property (weak, nonatomic) IBOutlet UIButton *button02;
@property (weak, nonatomic) IBOutlet UILabel *label02;
@property (weak, nonatomic) IBOutlet UIImageView *image02;

@property (weak, nonatomic) IBOutlet UIButton *button03;
@property (weak, nonatomic) IBOutlet UILabel *label03;
@property (weak, nonatomic) IBOutlet UIImageView *image03;

@property (weak, nonatomic) IBOutlet UIButton *button04;
@property (weak, nonatomic) IBOutlet UILabel *label04;
@property (weak, nonatomic) IBOutlet UIImageView *image04;

@property (weak, nonatomic) IBOutlet UIButton *button05;
@property (weak, nonatomic) IBOutlet UILabel *label05;
@property (weak, nonatomic) IBOutlet UIImageView *image05;

@property (weak, nonatomic) IBOutlet UIButton *button06;
@property (weak, nonatomic) IBOutlet UILabel *label06;
@property (weak, nonatomic) IBOutlet UIImageView *image06;

@property (weak, nonatomic) IBOutlet UIButton *button07;
@property (weak, nonatomic) IBOutlet UILabel *label07;
@property (weak, nonatomic) IBOutlet UIImageView *image07;

@property (weak, nonatomic) IBOutlet UIButton *button08;
@property (weak, nonatomic) IBOutlet UILabel *label08;
@property (weak, nonatomic) IBOutlet UIImageView *image08;

@property (weak, nonatomic) IBOutlet UIButton *button09;
@property (weak, nonatomic) IBOutlet UILabel *label09;
@property (weak, nonatomic) IBOutlet UIImageView *image09;

@property (weak, nonatomic) IBOutlet UIButton *button10;
@property (weak, nonatomic) IBOutlet UILabel *label10;
@property (weak, nonatomic) IBOutlet UIImageView *image10;

@property (weak, nonatomic) IBOutlet UIButton *button11;
@property (weak, nonatomic) IBOutlet UILabel *label11;
@property (weak, nonatomic) IBOutlet UIImageView *image11;

@property (weak, nonatomic) IBOutlet UIButton *button12;
@property (weak, nonatomic) IBOutlet UILabel *label12;
@property (weak, nonatomic) IBOutlet UIImageView *image12;

@property (weak, nonatomic) IBOutlet UIButton *button13;
@property (weak, nonatomic) IBOutlet UILabel *label13;
@property (weak, nonatomic) IBOutlet UIImageView *image13;





@property (weak, nonatomic) IBOutlet UIButton *button100;
@property (weak, nonatomic) IBOutlet UILabel *label100;
@property (weak, nonatomic) IBOutlet UIImageView *image100;

@property (weak, nonatomic) IBOutlet UIButton *button101;
@property (weak, nonatomic) IBOutlet UILabel *label101;
@property (weak, nonatomic) IBOutlet UIImageView *image101;

@property (weak, nonatomic) IBOutlet UIButton *button102;
@property (weak, nonatomic) IBOutlet UILabel *label102;
@property (weak, nonatomic) IBOutlet UIImageView *image102;

@property (weak, nonatomic) IBOutlet UIButton *button103;
@property (weak, nonatomic) IBOutlet UILabel *label103;
@property (weak, nonatomic) IBOutlet UIImageView *image103;


@property (weak, nonatomic) IBOutlet UIButton *buttonSetUp;


@end

@implementation TpfMaiViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    self.heightNavBar.constant = _height_NavBar;
    
    WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
    webViewConfiguration.processPool = [IMEProcessPool shareInstance];
    
    WKWebView * wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:webViewConfiguration];
    wkWebView.navigationDelegate = self;
    [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:IME_TouMingGongChangDengLu]]];
    [self.view addSubview:wkWebView];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    
    NSLog(@"是否显示计划工时:%ld 多工单入库是否显示:%ld IQC模式:%ld",[GlobalSettingManager shareGlobalSettingManager].showPlanHour,[GlobalSettingManager shareGlobalSettingManager].showMultiltask,[GlobalSettingManager shareGlobalSettingManager].iQCPattern);
    
    
    [self initRequest];
//    [self initRequestDispatch_barrier_async];
//    [self initRequestDispatch_group];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

#pragma mark 栅栏函数 测试，检测不到回调
//- (void)initRequestDispatch_barrier_async {
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("dyz", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(concurrentQueue, ^{
//        NSLog(@"LLLLLLLL");
//        LoginModel *loginModel = [DatabaseTool getLoginModel];
//
//        MesPostEntityBean * mesPostEntityBean = [[MesPostEntityBean alloc] init];
//        UserInfoVo * userInfoVo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
//        mesPostEntityBean.entity = userInfoVo.mj_keyValues;
//        NSDictionary *dic = mesPostEntityBean.mj_keyValues;
//
//        [HttpMamager postRequestWithURLString:DYZ_userRoleAuthorities_getUserRoleAuthorities parameters:dic success:^(id responseObjectModel) {
//            NSLog(@"1111");
//        } fail:^(NSError *error) {
//            NSLog(@"2222");
//        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
//    });
//    dispatch_barrier_async(concurrentQueue, ^{
//        NSLog(@"LLLLLLLM");
//    });
//    dispatch_async(concurrentQueue, ^{
//        NSLog(@"LLLLLLLJ");
//    });
//}

#pragma mark 调度组 测试
- (void)initRequestDispatch_group {
    //方法一 在回调里面leave，可以检测到回调
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_group_t group = dispatch_group_create();
//
//    dispatch_group_enter(group);
//    dispatch_async(queue, ^{
//        LoginModel *loginModel = [DatabaseTool getLoginModel];
//
//        MesPostEntityBean * mesPostEntityBean = [[MesPostEntityBean alloc] init];
//        UserInfoVo * userInfoVo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
//        mesPostEntityBean.entity = userInfoVo.mj_keyValues;
//        NSDictionary *dic = mesPostEntityBean.mj_keyValues;
//
//        [HttpMamager postRequestWithURLString:DYZ_userRoleAuthorities_getUserRoleAuthorities parameters:dic success:^(id responseObjectModel) {
//            NSLog(@"1111");
//             dispatch_group_leave(group);
//        } fail:^(NSError *error) {
//            NSLog(@"2222");
//             dispatch_group_leave(group);
//        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
//    });
//
//    dispatch_group_enter(group);
//    dispatch_async(queue, ^{
//        NSLog(@"任务二");
//        dispatch_group_leave(group);
//    });
//
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"主线程刷新UI");
//    });
    
    
    //方法二 无法检测到回调
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_notify(group, queue, ^{
//        LoginModel *loginModel = [DatabaseTool getLoginModel];
//
//        MesPostEntityBean * mesPostEntityBean = [[MesPostEntityBean alloc] init];
//        UserInfoVo * userInfoVo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
//        mesPostEntityBean.entity = userInfoVo.mj_keyValues;
//        NSDictionary *dic = mesPostEntityBean.mj_keyValues;
//
//        [HttpMamager postRequestWithURLString:DYZ_userRoleAuthorities_getUserRoleAuthorities parameters:dic success:^(id responseObjectModel) {
//            NSLog(@"1111");
//        } fail:^(NSError *error) {
//            NSLog(@"2222");
//        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
//    });
//    dispatch_group_notify(group, queue, ^{
//        NSLog(@"任务二");
//    });
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"主线程刷新UI");
//    });
    
}

- (void)initRequest {
    _viewLoading.hidden = NO;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    MesPostEntityBean * mesPostEntityBean = [[MesPostEntityBean alloc] init];
    UserInfoVo * userInfoVo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    mesPostEntityBean.entity = userInfoVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_userRoleAuthorities_getUserRoleAuthorities parameters:dic success:^(id responseObjectModel) {
        
        ReturnListBean *returnListBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            
            self->_arrayUserRoleAuthorities = returnListBean.list;
            [GlobalSettingManager shareGlobalSettingManager].userRoleAuthorities = self->_arrayUserRoleAuthorities;
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"PRODUCTIONRECORD"]) {//生产报工
                self.image00.alpha = 1;
                self.label00.alpha = 1;
                self.button00.enabled = YES;
            } else {
                self.image00.alpha = 0.4;
                self.label00.alpha = 0.4;
                self.button00.enabled = NO;
            }
            
            if ([GlobalSettingManager shareGlobalSettingManager].showMultiltask == 1) {
                if ([self->_arrayUserRoleAuthorities containsObject:@"BATCHWORKORDER"]) {//多工单报工
                    self.image01.alpha = 1;
                    self.label01.alpha = 1;
                    self.button01.enabled = YES;
                } else {
                    self.image01.alpha = 0.4;
                    self.label01.alpha = 0.4;
                    self.button01.enabled = NO;
                }
            } else {
                self.image01.alpha = 0.4;
                self.label01.alpha = 0.4;
                self.button01.enabled = NO;
            }
            
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"BLANKINGWORK"]) {//下料报工
                self.image02.alpha = 1;
                self.label02.alpha = 1;
                self.button02.enabled = YES;
            } else {
                self.image02.alpha = 0.4;
                self.label02.alpha = 0.4;
                self.button02.enabled = NO;
            }
            
            // IQC入库
            // IQCRECEIVING:IQC收货
            // IQCQC       :IQC质检
            // IQCINSTOCK  :IQC入库
            if ([GlobalSettingManager shareGlobalSettingManager].iQCPattern == 1 && ([[GlobalSettingManager shareGlobalSettingManager].userRoleAuthorities containsObject:@"IQCRECEIVING"] && [[GlobalSettingManager shareGlobalSettingManager].userRoleAuthorities containsObject:@"IQCQC"] && [[GlobalSettingManager shareGlobalSettingManager].userRoleAuthorities containsObject:@"IQCINSTOCK"])) {
                // 一步入库，所有权限都有
                self.image03.alpha = 1;
                self.label03.alpha = 1;
                self.button03.enabled = YES;
            } else if ([GlobalSettingManager shareGlobalSettingManager].iQCPattern == 2 && (([[GlobalSettingManager shareGlobalSettingManager].userRoleAuthorities containsObject:@"IQCRECEIVING"]&&[[GlobalSettingManager shareGlobalSettingManager].userRoleAuthorities containsObject:@"IQCQC"])||[[GlobalSettingManager shareGlobalSettingManager].userRoleAuthorities containsObject:@"IQCINSTOCK"])) {
                // 二步入库，有收货权限且有质检权限才可以质检，有入库权限可以入库
                self.image03.alpha = 1;
                self.label03.alpha = 1;
                self.button03.enabled = YES;
            } else if ([GlobalSettingManager shareGlobalSettingManager].iQCPattern == 3 && ([[GlobalSettingManager shareGlobalSettingManager].userRoleAuthorities containsObject:@"IQCRECEIVING"] || [[GlobalSettingManager shareGlobalSettingManager].userRoleAuthorities containsObject:@"IQCQC"] || [[GlobalSettingManager shareGlobalSettingManager].userRoleAuthorities containsObject:@"IQCINSTOCK"])) {
                // 三步入库，有一种权限就可以
                self.image03.alpha = 1;
                self.label03.alpha = 1;
                self.button03.enabled = YES;
            } else {
                self.image03.alpha = 0.4;
                self.label03.alpha = 0.4;
                self.button03.enabled = NO;
            }
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"MATERIELOUTSTOCK"]) {//领料出库
                self.image04.alpha = 1;
                self.label04.alpha = 1;
                self.button04.enabled = YES;
            } else {
                self.image04.alpha = 0.4;
                self.label04.alpha = 0.4;
                self.button04.enabled = NO;
            }
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"OQCINVOICE"]) {//OQC发货单
                self.image05.alpha = 1;
                self.label05.alpha = 1;
                self.button05.enabled = YES;
            } else {
                self.image05.alpha = 0.4;
                self.label05.alpha = 0.4;
                self.button05.enabled = NO;
            }
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"EQUIPMENTCHECK"]) {//设备点检
                self.image06.alpha = 1;
                self.label06.alpha = 1;
                self.button06.enabled = YES;
            } else {
                self.image06.alpha = 0.4;
                self.label06.alpha = 0.4;
                self.button06.enabled = NO;
            }
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"WORKINGORDER"]) {//在制工单
                self.image07.alpha = 1;
                self.label07.alpha = 1;
                self.button07.enabled = YES;
            } else {
                self.image07.alpha = 0.4;
                self.label07.alpha = 0.4;
                self.button07.enabled = NO;
            }

            if ([self->_arrayUserRoleAuthorities containsObject:@"ROUTINGINSPECTION"]) {//PDA巡检
                self.image08.alpha = 1;
                self.label08.alpha = 1;
                self.button08.enabled = YES;
            } else {
                self.image08.alpha = 0.4;
                self.label08.alpha = 0.4;
                self.button08.enabled = NO;
            }
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"OUTSOURCINGSCAN"]) {//委外单
                self.image09.alpha = 1;
                self.label09.alpha = 1;
                self.button09.enabled = YES;
            } else {
                self.image09.alpha = 0.4;
                self.label09.alpha = 0.4;
                self.button09.enabled = NO;
            }
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"TRANSPORTORDERPDA"]) {//运输
                self.image10.alpha = 1;
                self.label10.alpha = 1;
                self.button10.enabled = YES;
            } else {
                self.image10.alpha = 0.4;
                self.label10.alpha = 0.4;
                self.button10.enabled = NO;
            }
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"TEMPORARYTASKLEADER"] || [self->_arrayUserRoleAuthorities containsObject:@"TEMPORARYTASKEMPLOYEE"]) {
                self.image11.alpha = 1;
                self.label11.alpha = 1;
                self.button11.enabled = YES;
            } else {
                self.image11.alpha = 0.4;
                self.label11.alpha = 0.4;
                self.button11.enabled = NO;
            }
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"PROCEDUREPROGRESS"]) {//工序进度统计
                self.image12.alpha = 1;
                self.label12.alpha = 1;
                self.button12.enabled = YES;
            } else {
                self.image12.alpha = 0.4;
                self.label12.alpha = 0.4;
                self.button12.enabled = NO;
            }
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"SCANRETURNS"]) {//扫码退货
                self.image13.alpha = 1;
                self.label13.alpha = 1;
                self.button13.enabled = YES;
            } else {
                self.image13.alpha = 0.4;
                self.label13.alpha = 0.4;
                self.button13.enabled = NO;
            }
            
            
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"EMPLOYEESTATISTIC"]) {//人员统计
                self.image100.alpha = 1;
                self.label100.alpha = 1;
                self.button100.enabled = YES;
            } else {
                self.image100.alpha = 0.4;
                self.label100.alpha = 0.4;
                self.button100.enabled = NO;
            }
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"EQUIPMENTSTATISTICS"]) {//设备统计
                self.image101.alpha = 1;
                self.label101.alpha = 1;
                self.button101.enabled = YES;
            } else {
                self.image101.alpha = 0.4;
                self.label101.alpha = 0.4;
                self.button101.enabled = NO;
            }
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"PROJECTSTATISTICS"]) {//项目统计
                self.image102.alpha = 1;
                self.label102.alpha = 1;
                self.button102.enabled = YES;
            } else {
                self.image102.alpha = 0.4;
                self.label102.alpha = 0.4;
                self.button102.enabled = NO;
            }
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"SELFPROCESSINGSTATISTICS"]) {//我的加工
                self.image103.alpha = 1;
                self.label103.alpha = 1;
                self.button103.enabled = YES;
            } else {
                self.image103.alpha = 0.4;
                self.label103.alpha = 0.4;
                self.button103.enabled = NO;
            }
            
            
            
            if ([self->_arrayUserRoleAuthorities containsObject:@"SYSTEMSETTINGS"]) {//系统设置
                self.buttonSetUp.alpha = 1;
                self.buttonSetUp.enabled = YES;
            } else {
                self.buttonSetUp.alpha = 0.4;
                self.buttonSetUp.enabled = NO;
            }
        } else {
            self.image00.alpha = 0.4;
            self.label00.alpha = 0.4;
            self.button00.enabled = NO;
            self.image01.alpha = 0.4;
            self.label01.alpha = 0.4;
            self.button01.enabled = NO;
            self.image02.alpha = 0.4;
            self.label02.alpha = 0.4;
            self.button02.enabled = NO;
            self.image03.alpha = 0.4;
            self.label03.alpha = 0.4;
            self.button03.enabled = NO;
            self.image04.alpha = 0.4;
            self.label04.alpha = 0.4;
            self.button04.enabled = NO;
            self.image05.alpha = 0.4;
            self.label05.alpha = 0.4;
            self.button05.enabled = NO;
            self.image06.alpha = 0.4;
            self.label06.alpha = 0.4;
            self.button06.enabled = NO;
            self.image07.alpha = 0.4;
            self.label07.alpha = 0.4;
            self.button07.enabled = NO;
            self.image08.alpha = 0.4;
            self.label08.alpha = 0.4;
            self.button08.enabled = NO;
            self.image09.alpha = 0.4;
            self.label09.alpha = 0.4;
            self.button09.enabled = NO;
            self.image10.alpha = 0.4;
            self.label10.alpha = 0.4;
            self.button10.enabled = NO;
            self.image11.alpha = 0.4;
            self.label11.alpha = 0.4;
            self.button11.enabled = NO;
            self.image12.alpha = 0.4;
            self.label12.alpha = 0.4;
            self.button12.enabled = NO;
            self.image13.alpha = 0.4;
            self.label13.alpha = 0.4;
            self.button13.enabled = NO;
            
            self.image100.alpha = 0.4;
            self.label100.alpha = 0.4;
            self.button100.enabled = NO;
            self.image101.alpha = 0.4;
            self.label101.alpha = 0.4;
            self.button101.enabled = NO;
            self.image102.alpha = 0.4;
            self.label102.alpha = 0.4;
            self.button102.enabled = NO;
            self.image103.alpha = 0.4;
            self.label103.alpha = 0.4;
            self.button103.enabled = NO;
            
            
            
            
            
            self.buttonSetUp.alpha = 0.4;
            self.buttonSetUp.enabled = NO;
        }
    } fail:^(NSError *error) {
        self->_viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

#pragma mark 操作
- (IBAction)buttonOperation:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
#pragma mark 生产报工
        case 0:{
            ScanTuZhiViewController * scanTuZhiViewController = [[ScanTuZhiViewController alloc] init];
            [self.navigationController pushViewController:scanTuZhiViewController animated:YES];
            break;
        }
#pragma mark 多工单报工
        case 1:{
            ScanMYuanGongVC *scanMYuanGongVC = [[ScanMYuanGongVC alloc] init];
            [self.navigationController pushViewController:scanMYuanGongVC animated:true];
            break;
        }
#pragma mark 下料报工
        case 2:{
            ScanXiaLiaoViewController *scanXiaLiaoViewController = [[ScanXiaLiaoViewController alloc] init];
            [self.navigationController pushViewController:scanXiaLiaoViewController animated:true];
            break;
        }
#pragma mark IQC入库
        case 3:{
            IQCRuKuViewController * iQCRuKuViewController = [[IQCRuKuViewController alloc] init];
            [self.navigationController pushViewController:iQCRuKuViewController animated:YES];
            break;
        }
#pragma mark 领料出库
        case 4:{
            IQCChuKuYuanGongMaVC *iQCChuKuYuanGongMaVC = [[IQCChuKuYuanGongMaVC alloc] init];
            [self.navigationController pushViewController:iQCChuKuYuanGongMaVC animated:YES];
            break;
        }
#pragma mark OQC发货单
        case 5:{
            OQCViewController * oQCViewController = [[OQCViewController alloc] init];
            [self.navigationController pushViewController:oQCViewController animated:YES];
            break;
        }
#pragma mark 设备点检
        case 6:{
            SheBeiDianJianVC * sheBeiDianJianVC = [[SheBeiDianJianVC alloc] init];
            [self.navigationController pushViewController:sheBeiDianJianVC animated:YES];
            break;
        }
#pragma mark 在制工单
        case 7:{
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            UserBean *userBean = [UserBean mj_objectWithKeyValues:loginModel.ucenterUser];
            NSString *siteCode = userBean.enterpriseInfo.serialNo;
            NSString *personnerlCode = [DatabaseTool t_TpfPWTableGetPersonnelCodeWithSiteCode:siteCode];
            if (![personnerlCode isEqualToString:@"(null)"]) {
                ZaiZhiGongDanVC *vc = [[ZaiZhiGongDanVC alloc] init];
                vc.confirmUser = personnerlCode;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                ScanYuanGongMaVC *scanYuanGongMaVC = [[ScanYuanGongMaVC alloc] init];
                [self.navigationController pushViewController:scanYuanGongMaVC animated:YES];
            }
            break;
        }
#pragma mark 巡检
        case 8:{
            ScanXunJianRenYuanVC *scanXunJianRenYuanVC = [[ScanXunJianRenYuanVC alloc] init];            
            [self.navigationController pushViewController:scanXunJianRenYuanVC animated:YES];
            break;
        }
#pragma mark 委外单
        case 9:{
            WeiWaiDanViewController *weiWaiDanViewController = [[WeiWaiDanViewController alloc] init];
            [self.navigationController pushViewController:weiWaiDanViewController animated:YES];
            break;
        }
#pragma mark 运输管理
        case 10:{
            YunShuDetailVC *vc = [[YunShuDetailVC alloc] init];
            [self.navigationController pushViewController:vc animated:true];
            break;
        }
#pragma mark 临时任务
        case 11:{
            TemporaryTaskDetailedListVC *vc = [[TemporaryTaskDetailedListVC alloc] init];
            if ([_arrayUserRoleAuthorities containsObject:@"TEMPORARYTASKLEADER"]) {//班长
                vc.leaderFlag = 1;
            } else if ([_arrayUserRoleAuthorities containsObject:@"TEMPORARYTASKEMPLOYEE"]) {
                vc.leaderFlag = 0;
            }
            [self.navigationController pushViewController:vc animated:true];
            break;
        }
            
#pragma mark 工序加工进度
        case 12: {
            ScanGongXuViewController *vc =[[ScanGongXuViewController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
            break;
        }
            
#pragma mark 扫码退货
        case 13: {
            SweepTheCodeReturnsVC *vc = [[SweepTheCodeReturnsVC alloc] init];
            [self.navigationController pushViewController:vc animated:true];
            break;
        }
            
            
#pragma mark 系统设置
        case 20:{
            TpfSZViewController * tpfSZViewController = [[TpfSZViewController alloc] init];
            [self.navigationController pushViewController:tpfSZViewController animated:YES];
            break;
        }
        default:
            break;
    }
}



#pragma mark 报表
- (IBAction)buttonStatement:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
#pragma mark 人员统计
        case 0:{
            [self webViewWithTouMingGongChangTitle:@"透明工厂" withURL:DYZ_html_employee];
            break;
        }
#pragma mark 设备统计
        case 1:{
            [self webViewWithTouMingGongChangTitle:@"透明工厂" withURL:DYZ_html_chooseDeviceType];

            break;
        }
#pragma mark 项目统计
        case 2:{
            [self webViewWithTouMingGongChangTitle:@"透明工厂" withURL:DYZ_html_projectStatistics];
            break;
        }
#pragma mark 我的加工
        case 3:{
            [self webViewWithTouMingGongChangTitle:@"透明工厂" withURL:DYZ_html_myProcessingInfo];
            break;
        }
        default:
            break;
    }
}



- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewWithTouMingGongChangTitle:(NSString *)title withURL:(NSString *)url{
    WebDatailURLTouMingGongChang *webDatailURL = [[WebDatailURLTouMingGongChang alloc] init];
    webDatailURL.detailUrl = url;
    [self.navigationController pushViewController:webDatailURL animated:YES];
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
