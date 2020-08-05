//
//  AppDelegate.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/5/28.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "AppDelegate.h"
#import "VoHeader.h"

#import "UIView+Toast.h"

#import <UserNotifications/UserNotifications.h>

#import <AFNetworking.h>

#import <JPUSHService.h>

#import "Masonry.h"
#import "ShouYeViewController.h"
#import "HuoDongViewController.h"
#import "WoViewController.h"
#import "CompanyViewController.h"
#import "AFNetworkReachabilityManager.h"


#import "XunPanXiangQingViewController.h"
#import "YinDaoYeViewController.h"
#import "BaoJiaZiXunViewController.h"
#import "WoDeTongZhiViewController.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"

#import "BaiduMobStat.h"
#import <Bugly/Bugly.h>


#import "EGOrderViewController.h"
#import "YanHuoLieBiaoVC.h"
#import "YanHuoXiangQingVC.h"
#import "BuFaHuoLieBiaoVC.h"

#import "DingDanXiangQingCaiViewController.h"
#import "DingDanXiangQingGongViewController.h"


#import "EGYiJiaViewController.h"
#import "ECYiJiaViewController.h"
#import "EGChaKanBaoJiaYiJiaViewController.h"
#import "ECChaKanBaoJiaYiJiaViewController.h"

#import "NSArray+Transition.h"
#import "WebDatailURL.h"

#import <WebKit/WebKit.h>
#import "IMEProcessPool.h"

#import "GlobalSettingManager.h"
#import "ProfileUpdatesObject.h"



NSString *NTESNotificationLogout = @"NTESNotificationLogout";
@interface AppDelegate ()<UITabBarControllerDelegate> {
    NSInteger _index;
    NSDictionary * _userInfo;
    UITabBarController *_tabBarC;
    BOOL _isAppStoreBack;//判断是否是从AppStore返回
}


//@property (nonatomic, assign) BOOL stateChanged;

@end

@implementation AppDelegate

- (void)delayMethod:(NSDictionary *)userInfo{

    //Jpush推送
    if ((userInfo[@"UIApplicationLaunchOptionsRemoteNotificationKey"][@"extra"])&&(!userInfo[@"UIApplicationLaunchOptionsRemoteNotificationKey"][@"nim"])) {
        NSArray *arrayExtra = [NSArray stringToJSON:userInfo[@"UIApplicationLaunchOptionsRemoteNotificationKey"][@"extra"]];
        NSArray *paramsBeanArray = [ParamsBean mj_objectArrayWithKeyValuesArray:arrayExtra];
        for (ParamsBean *paramsBean in paramsBeanArray) {
            if ([paramsBean.name isEqualToString:@"pushId"]) {
                EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
                postEntityBean.entity = @{@"pushIds":paramsBean.value};
                NSDictionary *dic = postEntityBean.mj_keyValues;
                
                [HttpMamager postRequestWithURLString:DYZ_notify_pushCallback parameters:dic success:^(id responseObjectModel) {
                    ReturnMsgBean *returnMsgBean = responseObjectModel;
                    if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                        
                    }
                } fail:^(NSError *error) {
                    
                } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
                break;
            }
        }
        
        for (ParamsBean *paramsBean in paramsBeanArray) {
            if ([paramsBean.name isEqualToString:@"type"]) {
                for (ParamsBean *paramsBean1 in paramsBeanArray) {
                    if ([paramsBean1.name isEqualToString:@"pmId"]) {
                        [self jPushIsReadNotificationItemIdWith:paramsBean1.value];
                        break;
                    }
                }
                break;
            }
        }
        [self createTabBarControllerWithNotificationParamsBeanArray:paramsBeanArray];
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    if (launchOptions) { //App关掉的收到通知
        
        [self performSelector:@selector(delayMethod:) withObject:launchOptions afterDelay:1];
    }
    [DatabaseTool createDatabase];
    
#pragma mark 帮助页 存储帮助页字典 dicHelp
    //    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"hangZhuYeDic"]) {
    //        NSMutableDictionary *dicHelp = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"no",@"help0",@"no",@"help1",@"no",@"help2",@"no",@"help3",@"no",@"help4",@"no",@"help5",@"no",@"help6",nil];
    //        [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:dicHelp] forKey:@"hangZhuYeDic"];
    //        [[NSUserDefaults standardUserDefaults] synchronize];
    //    }
    
#pragma mark Jpush 注册
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:isProduction];
    
    
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
#pragma mark ShareSDK 注册
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformSubTypeWechatSession),
                                        @(SSDKPlatformSubTypeWechatTimeline),
                                        @(SSDKPlatformTypeQQ)]
                             onImport:^(SSDKPlatformType platformType) {
                                 switch (platformType)
                                 {
                                     case SSDKPlatformTypeSinaWeibo:
                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                         break;
                                     case SSDKPlatformTypeWechat:
                                         [ShareSDKConnector connectWeChat:[WXApi class]];
                                         break;
                                         
                                     case SSDKPlatformTypeQQ:
                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                         break;
                                     default:
                                         break;
                                 }
                             } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                 switch (platformType)
                                 {
                                     case SSDKPlatformTypeSinaWeibo:
                                         //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                         [appInfo SSDKSetupSinaWeiboByAppKey:@"1755952260"
                                                                   appSecret:@"e90bf521e695a0f14250a90f5ac0707e"
                                                                 redirectUri:@"https://www.imefuture.com"
                                                                    authType:SSDKAuthTypeSSO];
                                         break;
                                     case SSDKPlatformTypeWechat:
                                         [appInfo SSDKSetupWeChatByAppId:@"wx15b1f6d5de838a9b"
                                                               appSecret:@"411a7a41d3a70c437f582824b3320a41"];
                                         break;
                                     case SSDKPlatformTypeQQ:
                                         [appInfo SSDKSetupQQByAppId:@"1105642395"
                                                              appKey:@"zIOvsMtV0uIAetdr"
                                                            authType:SSDKAuthTypeBoth];
                                         break;
                                     default:
                                         
                                         break;
                                 }
                             }];
   
    
#pragma mark 百度移动统计 注册
    //测试
//    NSString *baiduModAppId = @"e66578d263";
    //正式
    NSString *baiduModAppId = @"2240ffd30c";
    [[BaiduMobStat defaultStat] startWithAppId:baiduModAppId];
    [[BaiduMobStat defaultStat] logEvent:@"open" eventLabel:@"打开APP"];
    
    
#pragma mark 腾讯Bugly
    [Bugly startWithAppId:@"cb8c4e3ace"];
    
#pragma mark 后台自动登录
    NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
    if (stringPsw) {
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
            [self httpRequestCallback:(id)responseObjectModel url:DYZ_user_login];
        } fail:^(NSError *error) {
            
        }];
    }
    
    
#pragma mark 自升级
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    AppVersion *appVersion = [[AppVersion alloc] init];
    appVersion.appType = @"IMEFUTURE";
    appVersion.appCategory = @"IOS";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    appVersion.version = version;
    postEntityBean.entity = appVersion.mj_keyValues;
    NSDictionary *dicParameters = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_appversion_getLatestVersion parameters:dicParameters success:^(id responseObjectModel) {
        
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            AppVersion *appVersion = [AppVersion mj_objectWithKeyValues:returnEntityBean.entity];
            if ([appVersion.mustUpgrade integerValue] == 2) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"当前版本过低,请升级！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alerAction0 = [UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/zhi-zao-jiaimefuture/id1157968569?mt=8"]];
                    _isAppStoreBack = YES;
                }];
                UIAlertAction *alerAction1 = [UIAlertAction actionWithTitle:@"退出App" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    abort();
                }];
                [alertController addAction:alerAction1];
                [alertController addAction:alerAction0];
                
                [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
            }
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    
#pragma mark 存储地区数据
    //    [self getZoneData];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if (![[[NSUserDefaults standardUserDefaults] stringForKey:@"version"] isEqualToString:version]) {
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"version"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"profileUpdatesObject.data"];
        ProfileUpdatesObject *profileUpdatesObject = [[ProfileUpdatesObject alloc] init]; //每次版本升级都需要，初始化。
        [NSKeyedArchiver archiveRootObject:profileUpdatesObject toFile:path];
        
        
        NSMutableDictionary *dicHelp = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"no",@"help0",@"no",@"help1",@"no",@"help2",@"no",@"help3",@"no",@"help4",@"no",@"help5",@"no",@"help6",nil];
        [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:dicHelp] forKey:@"hangZhuYeDic"];
        [[NSUserDefaults standardUserDefaults] synchronize]; // dicHelp，会被profileUpdatesObject 替换，后面再改吧。
        
        YinDaoYeViewController *yinDaoYeViewController = [[YinDaoYeViewController alloc] init];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:yinDaoYeViewController];
    } else {
        [self createTabBarControllerWithNotificationParamsBeanArray:nil];
//        [NSThread sleepForTimeInterval:1.5];//延长开机时间 让开机动画变长
    }
    
    [self.window makeKeyAndVisible];
    
    //调用网络状态
    [self netWorkStatus];
    return YES;
}

- (void)createTabBarControllerWithNotificationParamsBeanArray:(NSArray *)paramsBeanArray {
    ShouYeViewController *shouyeVC = [[ShouYeViewController alloc] init];
    shouyeVC.tabBarItem.title = @"首页";
    shouyeVC.tabBarItem.image = [UIImage imageNamed:@"icon_home"];
    shouyeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_home_2t"];
    if (paramsBeanArray) {
        shouyeVC.paramsBeanArray = paramsBeanArray;
    }
    
    HuoDongViewController *huodongVC = [[HuoDongViewController alloc] init];
    huodongVC.tabBarItem.title = @"活动";
    huodongVC.tabBarItem.image = [UIImage imageNamed:@"icon_act"];
    huodongVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_act_2t"];
    
    WoViewController *woVC = [[WoViewController alloc] init];
    woVC.tabBarItem.title = @"我";
    woVC.tabBarItem.image = [UIImage imageNamed:@"icon_me"];
    woVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_me_2t"];
    
    _tabBarC = [[UITabBarController alloc] init];
    _tabBarC.delegate = self;
    _tabBarC.viewControllers = @[shouyeVC,huodongVC,woVC];
    _tabBarC.tabBar.tintColor = [UIColor colorWithRed:89/255.0 green:179/255.0 blue:50/255.0 alpha:1];
    //    _tabBarC.tabBar.translucent = NO;
    
    CGFloat widthM = [UIScreen mainScreen].bounds.size.width;
    CGFloat widthAA = [UIScreen mainScreen].bounds.size.width/_tabBarC.viewControllers.count;
    UIView *viewBadge = [[UIView alloc] initWithFrame:CGRectMake(widthM-(widthAA/2-15), 8, 10, 10)];
    viewBadge.backgroundColor = [UIColor redColor];
    viewBadge.layer.cornerRadius = 5;
    viewBadge.layer.masksToBounds = YES;
    viewBadge.tag = 1992;
    viewBadge.hidden = YES;
    [_tabBarC.tabBar addSubview:viewBadge];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:_tabBarC];
}


- (void)networkDidReceiveMessage:(NSNotification *)notification {
    //    NSDictionary * userInfo = [notification userInfo];
    //    NSString *content = [userInfo valueForKey:@"content"];
    //    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    //    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    NSLog(@"%@",notification);
}


- (void)netWorkStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                [self showNetWorkMessage:@"未知网络,请检查互联网"];
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:{
                [self showNetWorkMessage:@"无网络,请检查互联网"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
//                [self showNetWorkMessage:@"蜂窝网络"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
//                [self showNetWorkMessage:@"WiFi网络"];
                break;
            }
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

- (void)showNetWorkMessage:(NSString *)msg {
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    [aler addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
    [self.window.rootViewController presentViewController:aler animated:YES completion:nil];
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    _index = tabBarController.selectedIndex;
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 2) {
        NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
        if (!stringPsw) {//没取到密码 请先登录登录
            tabBarController.selectedIndex = _index;
            CompanyViewController *companyVC = [[CompanyViewController alloc] init];
            companyVC.delegate = tabBarController.viewControllers[2];
            companyVC.woVC = tabBarController.viewControllers[2];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:companyVC];
            nav.modalPresentationStyle = 0;
            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - ApplicationDelegate


- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [JPUSHService setBadge:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%d",_isAppStoreBack);
    
    if (_isAppStoreBack) {
        NSLog(@"AppStore");
        abort();
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    // Required jPushDYZ
    [JPUSHService registerDeviceToken:deviceToken];
    //    //jPushDYZ 别名推送
    
    
    //    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    //    [JPUSHService setAlias:loginModel.ucenterId callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
}

//是否支持屏幕旋转，iphone其实不需要这个设置，主要是为了ipad
//- (BOOL)shouldAutorotate{
//    return NO;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)nowWindow {
//    return UIInterfaceOrientationMaskPortrait;
//}


#pragma mark 通知处理
- (void)initRunParamsBean:(ParamsBean *)paramsBean withArray:(NSArray *)paramsBeanArray{
    
    NSMutableDictionary *_mutableDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (ParamsBean *paramsBean in paramsBeanArray) {
        [_mutableDic setObject:paramsBean.value forKey:paramsBean.name];
    }
    
    if ([paramsBean.value isEqualToString:@"ND1"]||[paramsBean.value isEqualToString:@"ND2"]||[paramsBean.value isEqualToString:@"ND3"]||[paramsBean.value isEqualToString:@"ND5"]||[paramsBean.value isEqualToString:@"ND7"]||[paramsBean.value isEqualToString:@"ND8"]||[paramsBean.value isEqualToString:@"ND10"]||[paramsBean.value isEqualToString:@"ND25"]||[paramsBean.value isEqualToString:@"ND26"]||[paramsBean.value isEqualToString:@"ND27"]) {
        //询盘详情
        if ([paramsBean.value isEqualToString:@"ND3"]||[paramsBean.value isEqualToString:@"ND5"]||[paramsBean.value isEqualToString:@"ND7"]) {
            //非标采购商 询盘详情
            UIViewController *currentVC = [self getCurrentVC];
            XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
            xunPanXiangQingViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
            if ([currentVC isMemberOfClass:[UINavigationController class]]) {
                [(UINavigationController *)currentVC pushViewController:xunPanXiangQingViewController animated:YES];
            } else {
                [currentVC.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
            }
        } else {
            //非标供应商 询盘详情
            UIViewController *currentVC = [self getCurrentVC];
            XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
            xunPanXiangQingViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
            if ([currentVC isMemberOfClass:[UINavigationController class]]) {
                [(UINavigationController *)currentVC pushViewController:xunPanXiangQingViewController animated:YES];
            } else {
                [currentVC.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
            }
        }
    }
    if ([paramsBean.value isEqualToString:@"ND6"]||[paramsBean.value isEqualToString:@"ND9"]||[paramsBean.value isEqualToString:@"ND11"]||[paramsBean.value isEqualToString:@"ND12"]||[paramsBean.value isEqualToString:@"ND13"]||[paramsBean.value isEqualToString:@"ND16"]||[paramsBean.value isEqualToString:@"ND17"]||[paramsBean.value isEqualToString:@"ND21"]||[paramsBean.value isEqualToString:@"ND28"]) {
        // 订单详情
        if ([paramsBean.value isEqualToString:@"ND6"]||[paramsBean.value isEqualToString:@"ND16"]||[paramsBean.value isEqualToString:@"ND17"]) {
            //非标采购商 订单详情
            UIViewController *currentVC = [self getCurrentVC];
            DingDanXiangQingCaiViewController *dingDanXiangQingCaiViewController = [[DingDanXiangQingCaiViewController alloc] init];
            dingDanXiangQingCaiViewController.orderId = _mutableDic[@"tradeId"];
            dingDanXiangQingCaiViewController.stringResource = @"ECaiGouShangViewControllerL";
            if ([currentVC isMemberOfClass:[UINavigationController class]]) {
                [(UINavigationController *)currentVC pushViewController:dingDanXiangQingCaiViewController animated:YES];
            } else {
                [currentVC.navigationController pushViewController:dingDanXiangQingCaiViewController animated:YES];
            }
        } else {
            //非标供应商 订单详情
            UIViewController *currentVC = [self getCurrentVC];
            DingDanXiangQingGongViewController *dingDanXiangQingGongViewController = [[DingDanXiangQingGongViewController alloc] init];
            dingDanXiangQingGongViewController.orderId = _mutableDic[@"tradeId"];
            if ([currentVC isMemberOfClass:[UINavigationController class]]) {
                [(UINavigationController *)currentVC pushViewController:dingDanXiangQingGongViewController animated:YES];
            } else {
                [currentVC.navigationController pushViewController:dingDanXiangQingGongViewController animated:YES];
            }
        }
    }
    if ([paramsBean.value isEqualToString:@"ND23"]||[paramsBean.value isEqualToString:@"ND24"]){
        //报价咨询
        UIViewController *currentVC = [self getCurrentVC];
        BaoJiaZiXunViewController *baoJiaZiXunViewController = [[BaoJiaZiXunViewController alloc] init];
        baoJiaZiXunViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
        if ([currentVC isMemberOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVC pushViewController:baoJiaZiXunViewController animated:YES];
        } else {
            [currentVC.navigationController pushViewController:baoJiaZiXunViewController animated:YES];
        }
    }
    if ([paramsBean.value isEqualToString:@"ND30"]){
        UIViewController *currentVC = [self getCurrentVC];
        ECYiJiaViewController *eCYiJiaViewController = [[ECYiJiaViewController alloc] init];
        eCYiJiaViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
        if ([currentVC isMemberOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVC pushViewController:eCYiJiaViewController animated:YES];
        } else {
            [currentVC.navigationController pushViewController:eCYiJiaViewController animated:YES];
        }
    }
    if ([paramsBean.value isEqualToString:@"ND31"]){
        UIViewController *currentVC = [self getCurrentVC];
        ECChaKanBaoJiaYiJiaViewController *eCChaKanBaoJiaYiJiaViewController = [[ECChaKanBaoJiaYiJiaViewController alloc] init];
        eCChaKanBaoJiaYiJiaViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
        if ([currentVC isMemberOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVC pushViewController:eCChaKanBaoJiaYiJiaViewController animated:YES];
        } else {
            [currentVC.navigationController pushViewController:eCChaKanBaoJiaYiJiaViewController animated:YES];
        }
        
    }
    if ([paramsBean.value isEqualToString:@"ND32"]){
        UIViewController *currentVC = [self getCurrentVC];
        EGYiJiaViewController *eGYiJiaViewController = [[EGYiJiaViewController alloc] init];
        eGYiJiaViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
        if ([currentVC isMemberOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVC pushViewController:eGYiJiaViewController animated:YES];
        } else {
            [currentVC.navigationController pushViewController:eGYiJiaViewController animated:YES];
        }
    }
    if ([paramsBean.value isEqualToString:@"ND33"]){
        UIViewController *currentVC = [self getCurrentVC];
        EGChaKanBaoJiaYiJiaViewController *eGChaKanBaoJiaYiJiaViewController = [[EGChaKanBaoJiaYiJiaViewController alloc] init];
        eGChaKanBaoJiaYiJiaViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
        if ([currentVC isMemberOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVC pushViewController:eGChaKanBaoJiaYiJiaViewController animated:YES];
        } else {
            [currentVC.navigationController pushViewController:eGChaKanBaoJiaYiJiaViewController animated:YES];
        }
    }
    
    if ([paramsBean.value isEqualToString:@"ND101"]){//验货列表
        UIViewController *currentVC = [self getCurrentVC];
        YanHuoLieBiaoVC *yanHuoLieBiaoVC = [[YanHuoLieBiaoVC alloc] init];
        yanHuoLieBiaoVC.tradeOrderId = _mutableDic[@"tradeId"];
        if ([currentVC isMemberOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVC pushViewController:yanHuoLieBiaoVC animated:YES];
        } else {
            [currentVC.navigationController pushViewController:yanHuoLieBiaoVC animated:YES];
        }
    }
    if ([paramsBean.value isEqualToString:@"ND102"]){//验货详情
        UIViewController *currentVC = [self getCurrentVC];
        YanHuoXiangQingVC *yanHuoXiangQingVC = [[YanHuoXiangQingVC alloc] init];
        yanHuoXiangQingVC.orderOperateId = _mutableDic[@"operateId"];
        if ([currentVC isMemberOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVC pushViewController:yanHuoXiangQingVC animated:YES];
        } else {
            [currentVC.navigationController pushViewController:yanHuoXiangQingVC animated:YES];
        }
    }
    if ([paramsBean.value isEqualToString:@"ND103"]){//验货详情
        UIViewController *currentVC = [self getCurrentVC];
        YanHuoXiangQingVC *yanHuoXiangQingVC = [[YanHuoXiangQingVC alloc] init];
        yanHuoXiangQingVC.orderOperateId = _mutableDic[@"operateId"];
        if ([currentVC isMemberOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVC pushViewController:yanHuoXiangQingVC animated:YES];
        } else {
            [currentVC.navigationController pushViewController:yanHuoXiangQingVC animated:YES];
        }
    }
    if ([paramsBean.value isEqualToString:@"ND104"]){//验货详情
        UIViewController *currentVC = [self getCurrentVC];
        YanHuoXiangQingVC *yanHuoXiangQingVC = [[YanHuoXiangQingVC alloc] init];
        yanHuoXiangQingVC.orderOperateId = _mutableDic[@"operateId"];
        if ([currentVC isMemberOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVC pushViewController:yanHuoXiangQingVC animated:YES];
        } else {
            [currentVC.navigationController pushViewController:yanHuoXiangQingVC animated:YES];
        }
    }
    if ([paramsBean.value isEqualToString:@"ND105"]){//补发货列表
        UIViewController *currentVC = [self getCurrentVC];
        BuFaHuoLieBiaoVC *buFaHuoLieBiaoVC = [[BuFaHuoLieBiaoVC alloc] init];
        buFaHuoLieBiaoVC.tradeOrderId = _mutableDic[@"tradeId"];
        if ([currentVC isMemberOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVC pushViewController:buFaHuoLieBiaoVC animated:YES];
        } else {
            [currentVC.navigationController pushViewController:buFaHuoLieBiaoVC animated:YES];
        }
    }
    if ([paramsBean.value isEqualToString:@"ND121"]){//授盘审核失败
        UIViewController *currentVC = [self getCurrentVC];
        XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
        xunPanXiangQingViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
        if ([currentVC isMemberOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVC pushViewController:xunPanXiangQingViewController animated:YES];
        } else {
            [currentVC.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
        }
    }
    if ([paramsBean.value isEqualToString:@"ND122"]){//被预授盘的供应商修改报价
        UIViewController *currentVC = [self getCurrentVC];
        XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
        xunPanXiangQingViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
        if ([currentVC isMemberOfClass:[UINavigationController class]]) {
            [(UINavigationController *)currentVC pushViewController:xunPanXiangQingViewController animated:YES];
        } else {
            [currentVC.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
        }
    }
}

- (void)webViewWithTitle:(NSString *)title withURL:(NSString *)url{
    WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
    webDatailURL.titleTitle = title;
    webDatailURL.detailUrl = url;
    
    UIViewController *currentVC = [self getCurrentVC];
    [currentVC.navigationController pushViewController:webDatailURL animated:YES];
}

#pragma mark 在前台和在后台收到通知时，看是否需要切换身份，需要则跳到首页，不需要则当前页处理
- (void)paramsBeanArray:(NSArray *)paramsBeanArray {
    
    NSMutableDictionary *_mutableDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (ParamsBean *paramsBean in paramsBeanArray) {
        [_mutableDic setObject:paramsBean.value forKey:paramsBean.name];
    }
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    if ([_mutableDic[@"needAppDisplay"] integerValue] == 1) {
        //需要App原生展示
        if ([_mutableDic[@"readUserId"] isEqualToString:loginModel.userId]) {
            //当前身份是可以展示
            NSLog(@"需要App原生展示 --- 当前身份是可以展示");
            for (ParamsBean *paramsBean in paramsBeanArray) {
                if ([paramsBean.name isEqualToString:@"type"]) {
                    [self initRunParamsBean:paramsBean withArray:paramsBeanArray];
                    break;
                }
            }
        } else {
            //当前身份不能展示，需要切换身份
            NSLog(@"需要App原生展示 --- 当前身份不能展示，需要切换身份");
            [self createTabBarControllerWithNotificationParamsBeanArray:paramsBeanArray];
        }
    } else if (((NSString *)_mutableDic[@"detailUrl"]).length>0) {
        //需要App用网页展示通知URL之向的网页
        if ([_mutableDic[@"readUserId"] isEqualToString:loginModel.userId]) {
            //当前身份是可以展示
            NSLog(@"需要App用网页展示通知URL之向的网页 --- 当前身份是可以展示");
            [self webViewWithTitle:@"通知详情" withURL:_mutableDic[@"detailUrl"]];
        } else {
            //当前身份不能展示，需要切换身份
            NSLog(@"需要App用网页展示通知URL之向的网页 --- 当前身份不能展示，需要切换身份");
            [self createTabBarControllerWithNotificationParamsBeanArray:paramsBeanArray];
        }
    } else {
        //不需要展示
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"该通知无详情页面"];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{

    NSLog(@"%@",userInfo);
    
    _userInfo = userInfo;
    
    NSArray *arrayExtra = [NSArray stringToJSON:userInfo[@"extra"]];
    
    NSArray *paramsBeanArray = [ParamsBean mj_objectArrayWithKeyValuesArray:arrayExtra];
    
    for (ParamsBean *paramsBean in paramsBeanArray) {
        
        if ([paramsBean.name isEqualToString:@"pushId"]) {
            EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
            postEntityBean.entity = @{@"pushIds":paramsBean.value};
            NSDictionary *dic = postEntityBean.mj_keyValues;
            
            [HttpMamager postRequestWithURLString:DYZ_notify_pushCallback parameters:dic success:^(id responseObjectModel) {
                ReturnMsgBean *returnMsgBean = responseObjectModel;
                if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                    
                }
            } fail:^(NSError *error) {
                
            } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
            break;
        }
        
    }
    
    if (application.applicationState == UIApplicationStateActive) {
        
        //程序当前正处于前台
        //        [application setApplicationIconBadgeNumber:0];
        
        if (userInfo[@"extra"]&&(!userInfo[@"nim"])) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:userInfo[@"aps"][@"alert"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"查看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                for (ParamsBean *paramsBean in paramsBeanArray) {
                    if ([paramsBean.name isEqualToString:@"type"]) {
                        for (ParamsBean *paramsBean1 in paramsBeanArray) {
                            if ([paramsBean1.name isEqualToString:@"pmId"]) {
                                [self jPushIsReadNotificationItemIdWith:paramsBean1.value];
                                break;
                            }
                        }
                        break;
                    }
                }
                
                [self paramsBeanArray:paramsBeanArray];
                
            }];
            [alertC addAction:action];
            [alertC addAction:action1];
            UIViewController *VC = [self getCurrentVC];
            
            [VC presentViewController:alertC animated:YES completion:nil];
        }
        if (!userInfo[@"extra"]&&([userInfo[@"nim"] integerValue] == 1)) {
            
        }
        
    } else if(application.applicationState == UIApplicationStateInactive) {
        //程序处于后台
        if (userInfo[@"extra"]&&(!userInfo[@"nim"])) {
            
            for (ParamsBean *paramsBean in paramsBeanArray) {
                if ([paramsBean.name isEqualToString:@"type"]) {
                    
                    for (ParamsBean *paramsBean1 in paramsBeanArray) {
                        if ([paramsBean1.name isEqualToString:@"pmId"]) {
                            [self jPushIsReadNotificationItemIdWith:paramsBean1.value];
                            break;
                        }
                    }
                    break;
                }
            }
            
            [self paramsBeanArray:paramsBeanArray];
        }
    }
    // Required
    [JPUSHService handleRemoteNotification:userInfo];
    
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}


- (void)tagsAliasCallback:(int)iResCode tags:(NSSet *)tags alias:(NSString *)alias {
    NSLog(@"iResCode -->> %d",iResCode);
    NSLog(@"alias -->> %@",alias);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:@"identifierKey"];
}



#pragma mark JPush来的通知 已读调这个接口
- (void)jPushIsReadNotificationItemIdWith:(NSString *)pmId{
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    NSString *userId = nil;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
    for (NSDictionary *dic in array) {
        IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
        if ([identityBean.userType isEqualToString:@"NORMAL"]) {
            userId = identityBean.userId;
            break;
        }
    }
    postEntityBean.entity = @{@"pmIds":pmId,@"userId":userId};
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_notify_readUserPm parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            NSLog(@"SUCCESS");
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)getZoneData {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    Zone *zone = [[Zone alloc] init];
    if (![DatabaseTool t_ZoneIsOrHave]) {
        zone.level = @"0";
    } else {
        zone.level = [[NSUserDefaults standardUserDefaults] objectForKey:@"ZoneVersion"];
    }
    postEntityBean.entity = zone.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_zone_getAllZoneInfo parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            if (model.list.count>0) {
                [[NSUserDefaults standardUserDefaults] setObject:model.returnMsg forKey:@"ZoneVersion"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                dispatch_queue_t queue = dispatch_queue_create("com.tencent", DISPATCH_QUEUE_CONCURRENT);
                dispatch_async(queue, ^{
                    [DatabaseTool t_Zonedrop];
                    [DatabaseTool t_ZoneCreate];
                    for (NSDictionary *dic in model.list) {
                        Zone *zone = [Zone mj_objectWithKeyValues:dic];
                        [DatabaseTool t_ZoneInsertInto:zone];
                        NSLog(@">%@>>%@",zone.Myid,zone.name);
                    }
                });
            }
        } else {
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        
        result = nextResponder;
    else
        
        result = window.rootViewController;
    
    return result;
}

//获取当前屏幕中present出来的viewcontroller
- (UIViewController *)getPresentedViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
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
        

        
        if ([dic[@"userType"] isEqualToString:@"ENTERPRISE"]) {
//            @try
//            {
//                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic[@"member"] options:NSJSONWritingPrettyPrinted error:nil];
//                obj.member = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            } @catch (NSException * e) {
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
     
        if (dic[@"ucenterUser"] != [NSNull null] && dic[@"ucenterUser"] != nil) {
            NSData *jsonDataucenterUser = [NSJSONSerialization dataWithJSONObject:dic[@"ucenterUser"] options:NSJSONWritingPrettyPrinted error:nil];
            obj.ucenterUser = [[NSString alloc] initWithData:jsonDataucenterUser encoding:NSUTF8StringEncoding];
        } else {
            obj.ucenterUser = nil;
        }
        
        if (dic[@"tpfUser"] != [NSNull null] && dic[@"tpfUser"] != nil) {
            NSData *jsonTpfUser = [NSJSONSerialization dataWithJSONObject:dic[@"tpfUser"] options:NSJSONWritingPrettyPrinted error:nil];
            obj.tpfUser = [[NSString alloc] initWithData:jsonTpfUser encoding:NSUTF8StringEncoding];
            
//            UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:obj.tpfUser];
//            [[GlobalSettingManager shareGlobalSettingManager] requesttpfGetparameterlistWithSiteCode:userInfo.siteCode];
        } else {
            obj.tpfUser = nil;
        }
        
        if (obj.resultCode == 0) {
            
            if ([obj.regStatus isEqualToString:@"CONFIRM"]) {//已审核
                
                NSString *string1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
                NSString *string2 = [[NSUserDefaults standardUserDefaults]objectForKey:@"epname"];
                NSString *string3 = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
                NSString *string4 = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginType"];
                
                NSString *string = [NSString stringWithFormat:@"%@?userName=%@&password=%@&isChild=%@&epName=%@",DYZ_user_ssoLogin,string1,string3,[NSString stringWithFormat:@"%ld",[string4 integerValue]],string2];
                
                WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
                WKUserContentController *contentController = [[WKUserContentController alloc] init];
                webViewConfiguration.userContentController = contentController;
                webViewConfiguration.processPool = [IMEProcessPool shareInstance];
                WKWebView *wkWebView =[[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:webViewConfiguration];
                [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                [[UIApplication sharedApplication].keyWindow addSubview:wkWebView];
                
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
                
#pragma mark 存储地区数据
                [self getZoneData];
                
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
                    
                } else {
                    
                }
            }
        } else if ([dic[@"resultCode"] integerValue] == -2) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"密码错误"];
            //密码错误
            //密码错误退出登录
            [HttpMamager postRequestWithURLString:DYZ_user_synlogout parameters:nil success:^(id responseObjectModel) {
                LoginModel *obj = responseObjectModel;
                if (obj.resultCode == 0) {
                    UIViewController *VC = [self getCurrentVC];
                    
                    WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
                    WKUserContentController *contentController = [[WKUserContentController alloc] init];
                    webViewConfiguration.userContentController = contentController;
                    webViewConfiguration.processPool = [IMEProcessPool shareInstance];
                    WKWebView *wkWebView =[[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:webViewConfiguration];
                    [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[DYZ_user_ssoLogout stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                    [VC.view addSubview:wkWebView];
                    
                    
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"psw"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [JPUSHService setAlias:@"" callbackSelector:nil object:self];
                    _tabBarC.viewControllers[2].tabBarItem.badgeValue = nil;
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"退出成功"];
                    [DatabaseTool dropLoginModel];
                }
            } fail:^(NSError *error) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"退出失败"];
            } isKindOfModel:NSClassFromString(@"LoginModel")];
        } else if ([dic[@"resultCode"] integerValue] == -1) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"系统异常"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"登录失败"];
        }
    }
}

@end

