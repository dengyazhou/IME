//
//  ShouYeViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/6/25.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ShouYeViewController.h"

//#import <dlfcn.h>
//#import <libkern/OSAtomic.h>



#import "VoHeader.h"


#import "InformationShowViewController.h"

//非标采购
#import "ECInquiryViewController.h"
#import "ECOrderViewController.h"
#import "ECSupplierViewController.h"
#import "ECProjectViewController.h"

//非标供应
#import "EGInquiryViewController.h"
#import "EGOrderViewController.h"
#import "YanHuoLieBiaoVC.h"
#import "YanHuoXiangQingVC.h"
#import "BuFaHuoLieBiaoVC.h"

//透明工厂
#import "TpfMaiViewController.h"

#import "CompanyViewController.h"
#import "WebDatailURL.h"
#import "WebDatailURLTouMingGongChang.h"

#import "WoViewController.h"

#import "HJCycleScrollView.h"
#import "BaiduMobStat.h"

#import "ZhangHuGuanLiViewController.h"


#import "NSArray+Transition.h"

#import "XiTongTZSelectedResultsViewController.h"


#import "JPUSHService.h"
#import "UIView+Toast.h"


#import "XunPanXiangQingViewController.h"
#import "DingDanXiangQingGongViewController.h"
#import "DingDanXiangQingCaiViewController.h"
#import "BaoJiaZiXunViewController.h"
#import "ECYiJiaViewController.h"
#import "ECChaKanBaoJiaYiJiaViewController.h"
#import "EGChaKanBaoJiaYiJiaViewController.h"
#import "EGYiJiaViewController.h"

#import "CaiGouShangFaPanVC.h"
#import "XuanZeYaoQiuDaoHuoRiQiVC.h"

#import "IMETabBarViewController.h"

#import "ShouYeCell10.h"
#import "ShouYeCell20.h"
#import "ShouYeCell30.h"
#import "ShouYeCell40.h"
#import "CCPScrollView.h"
#import "ViewSelectIdentity.h"

#import <WebKit/WebKit.h>

#import "ModelGetInformationList.h"

#import "WoDeTongZhiViewController.h"
#import "IMEProcessPool.h"
#import "GlobalSettingManager.h"


@interface ShouYeViewController () <UITabBarControllerDelegate,HJCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate> {
    NSInteger _index;
    NSMutableArray *_arrayRecommend;
    NSMutableArray *_arrayImages;
    
    NSInteger _jPushCount;
    
    UIView *_viewLoading1;//透明
    
    NSMutableDictionary *_mutableDic;//存放通知过来的extra
    
    NSString *_first;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_dataArrayNotification;
    ViewSelectIdentity *_viewSelectIdentity;
    
    NSInteger _aPage;
    
    NSString *_firstStringPsw;
    
}

@property (nonatomic,strong) NSArray *paramsBeanArrayCopy;//self.paramsBeanArray因为会被置为nil，而后面又要用到self.paramsBeanArray，所以引进self.paramsBeanArrayCopy

/*----------头部--------------*/

@property (weak, nonatomic) IBOutlet UIView *viewVisitor;
@property (weak, nonatomic) IBOutlet UIView *viewNormal;
@property (weak, nonatomic) IBOutlet UIView *viewEnterprise;

@property (weak, nonatomic) IBOutlet UILabel *viewNormalLabel;
@property (weak, nonatomic) IBOutlet UIImageView *viewNormalImage;
@property (weak, nonatomic) IBOutlet UIButton *viewNormalButtonLeft;
@property (weak, nonatomic) IBOutlet UIButton *viewNormalRight;

@property (weak, nonatomic) IBOutlet UILabel *viewEnterpriseLabel;
@property (weak, nonatomic) IBOutlet UIImageView *viewEnterpriseImage;
@property (weak, nonatomic) IBOutlet UIButton *viewEnterpriseButton;
/*----------头部--------------*/

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ShouYeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"global_tab_bg"]];
    
    _first = @"first";
    

    self.viewVisitor.hidden = YES;
    self.viewNormal.hidden = YES;
    self.viewEnterprise.hidden = YES;
    NSInteger userTpye = [self getUserType];
    if (userTpye == 0) {//游客
        self.viewVisitor.hidden = NO;
    } else if (userTpye == 1) {//个人
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        
        NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
        if (array.count == 1) {
            self.viewNormal.hidden = NO;
        } else {
            self.viewEnterprise.hidden = NO;
        }
    } else if (userTpye == 2 || userTpye == 3) {//企业员工 || 企业管理员
        self.viewEnterprise.hidden = NO;
    }
    
    //开启定时器 DDCycleScrollView自动滚动
    [[NSNotificationCenter  defaultCenter]  postNotificationName:HJCycleScrollViewOpenTimerNotiName object:nil userInfo:nil];
    
    NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
    if (stringPsw) {//取到密码
        UIView *viewBage = [self.tabBarController.tabBar viewWithTag:1992];
        viewBage.hidden = YES;
        
        EfeibiaoPostEntityBean *efeibiaoPostEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        PageQueryBean *pageQueryBean = [[PageQueryBean alloc] init];
        
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
        pageQueryBean.requestUserId = userId;
        efeibiaoPostEntityBean.entity = pageQueryBean.mj_keyValues;
        NSDictionary *dic = efeibiaoPostEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_notify_getUserPmCount parameters:dic success:^(id responseObjectModel) {
            ReturnEntityBean *returnEntityBean = responseObjectModel;
            PageQueryBean *pageQueryBean = [PageQueryBean mj_objectWithKeyValues:returnEntityBean.entity];
            if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
                
                _jPushCount = [pageQueryBean.unreadNum integerValue];
                if ([pageQueryBean.unreadNum integerValue] == 0) {
                    UIView *viewBage = [self.tabBarController.tabBar viewWithTag:1992];
                    viewBage.hidden = YES;
                } else {
                    UIView *viewBage = [self.tabBarController.tabBar viewWithTag:1992];
                    viewBage.hidden = NO;
                }
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
        
        NSInteger userTpye = [self getUserType];
        if (userTpye == 1) {//个人
            if (array.count == 1) {
                if (array.count == 1) {
                    self.viewNormalImage.hidden = YES;
                } else {
                    self.viewNormalImage.hidden = NO;
                }
            } else {
                if (array.count == 1) {
                    self.viewEnterpriseImage.hidden = YES;
                } else {
                    self.viewEnterpriseImage.hidden = NO;
                }
            }
        } else if (userTpye == 2 || userTpye == 3) {//企业员工 || 企业管理员
            if (array.count == 1) {
                self.viewEnterpriseImage.hidden = YES;
            } else {
                self.viewEnterpriseImage.hidden = NO;
            }
        }
        
        for (NSDictionary *dic in array) {
            IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
            if ([loginModel.ucenterId isEqualToString:identityBean.ucenterId]) {
                NSString *showName;
                NSInteger num = (kMainW-30-15)/17;
                if (identityBean.showName.length > num) {
                    showName = identityBean.showName;
                    showName = [NSString stringWithFormat:@"%@...",[showName substringWithRange:NSMakeRange(0, num-1)]];
                } else {
                    showName = identityBean.showName;
                }
                
                if (userTpye == 1) {//个人
                    if (array.count == 1) {
                        self.viewNormalLabel.text = showName;
                    } else {
                        self.viewEnterpriseLabel.text = showName;
                    }
                } else if (userTpye == 2 || userTpye == 3) {//企业员工 || 企业管理员
                    self.viewEnterpriseLabel.text = showName;
                }
                break;
            }
        }
        
        [self getUserPm];
//        //解决老用户数据库中没有identityBeans 问题
//        if (!array) {
//            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"psw"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            [DatabaseTool dropLoginModel];
//        }
    } else {
        UIView *viewBage = [self.tabBarController.tabBar viewWithTag:1992];
        viewBage.hidden = YES;
        _dataArrayNotification = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    [self.tableView reloadData];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    
    self.navigationController.navigationBar.hidden = YES;
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"tabBarControllerSelectedIndex"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //关闭定时器  DDCycleScrollView停止自动滚动
    [[NSNotificationCenter  defaultCenter]  postNotificationName:HJCycleScrollViewOpenTimerNotiName object:nil userInfo:nil];
    
}
#pragma ---- banna滚动图片------

-(void)HJCycleScrollView:(HJCycleScrollView *)cycleScrollView didSelectIndex:(NSInteger)index {
    if (_arrayImages.count ==  1 && _arrayRecommend.count == 0) {
        return;
    }
    Recommend *recommend = _arrayRecommend[index];
    WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
    webDatailURL.titleTitle = recommend.title;
    webDatailURL.detailUrl = recommend.infoLink;
    [self.navigationController pushViewController:webDatailURL animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([_firstStringPsw isEqualToString:@"first"]) {
        _firstStringPsw = @"second";
        NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
        if (!stringPsw) {//没取到密码            
            CompanyViewController *companyVC = [[CompanyViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:companyVC];
            nav.modalPresentationStyle = 0;
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
    
    
    if (self.paramsBeanArray) {
        //程序当前正处于前台 收到通知 跳到首页 切换身份
        _mutableDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        for (ParamsBean *paramsBean in self.paramsBeanArray) {
            [_mutableDic setObject:paramsBean.value forKey:paramsBean.name];
        }
        NSLog(@">>%@",_mutableDic);
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        if ([_mutableDic[@"needAppDisplay"] integerValue] == 1) {
            //需要App原生展示
            if ([_mutableDic[@"readUserId"] isEqualToString:loginModel.userId]) {
                //当前身份是可以展示
                NSLog(@"需要App原生展示 --- 当前身份是可以展示");
                for (ParamsBean *paramsBean in self.paramsBeanArray) {
                    if ([paramsBean.name isEqualToString:@"type"]) {
                        [self initRunParamsBean:paramsBean withArray:self.paramsBeanArray];
                        break;
                    }
                }
            } else {
                //当前身份不能展示，需要切换身份
                NSLog(@"需要App原生展示 --- 当前身份不能展示，需要切换身份");
                [self changeIdentity:_mutableDic[@"readUserId"]];
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
                [self changeIdentity:_mutableDic[@"readUserId"]];
            }
        } else {
            //不需要展示
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"该通知无详情页面"];
        }
        
    }
    self.paramsBeanArrayCopy = self.paramsBeanArray;
    self.paramsBeanArray = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its
    
    self.tabBarController.tabBar.translucent = NO;
    
    _firstStringPsw = @"first";
    

    
    
    _arrayImages = [[NSMutableArray alloc] initWithCapacity:0];
    [_arrayImages addObject:@"back-ground-banner"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"shouYeCell00"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouYeCell10" bundle:nil] forCellReuseIdentifier:@"shouYeCell10"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouYeCell20" bundle:nil] forCellReuseIdentifier:@"shouYeCell20"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouYeCell30" bundle:nil] forCellReuseIdentifier:@"shouYeCell30"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouYeCell40" bundle:nil] forCellReuseIdentifier:@"shouYeCell40"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [HttpMamager postRequestWithURLString:DYZ_information_getInformationList parameters:@{@"searchInfo":@"",@"page":@1,@"infoType":@"N",@"pageSize":@3} success:^(id responseObjectModel) {
            _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
            ModelGetInformationList *model = responseObjectModel;
            for (ModelGetInformationList *modelGetInformationList in model.newsList) {
                [_dataArray addObject:modelGetInformationList];
                
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        } fail:^(NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
        } isKindOfModel:NSClassFromString(@"ModelGetInformationList")];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    EfeibiaoPostEntityBean *efeibiaoPostEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    Recommend *recommend = [[Recommend alloc] init];
    recommend.sei_p__recommendPage = [[NSMutableArray alloc] initWithObjects:@"APP_A", nil];
    efeibiaoPostEntityBean.entity = recommend.mj_keyValues;
    NSDictionary *dic = efeibiaoPostEntityBean.mj_keyValues;

    [HttpMamager postRequestWithURLString:DYZ_cmsRecommend_getAPPRecommendList parameters:dic success:^(id responseObjectModel) {
        
        ReturnListBean *model = responseObjectModel;
        
        _arrayRecommend = [[NSMutableArray alloc] initWithCapacity:0];
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _arrayImages = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in model.list) {
                Recommend *recommend = [Recommend mj_objectWithKeyValues:dic];
                [_arrayRecommend addObject:recommend];
                [_arrayImages addObject:recommend.picUrl];
            }
            if (_arrayImages.count == 0) {
                [_arrayImages addObject:@"back-ground-banner"];
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
    } fail:^(NSError *error) {

    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    
    
    _viewLoading1 = [UIView loadingWithFrame:CGRectMake(0, 0, kMainW, kMainH)];
    _viewLoading1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewLoading1];
    _viewLoading1.hidden = YES;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 1;
    } else if (section == 4) {
        return _dataArray.count;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//        return 210;
        return kMainW/375.0*173;
    } else if (indexPath.section == 1) {
        if (_dataArrayNotification.count == 0) {
            return 0;
        }
        return 48;
    } else if (indexPath.section == 2) {
        return 317;
    } else if (indexPath.section == 3) {
        if (_dataArray.count == 0) {
            return 0;
        }
        return 30;
    } else if (indexPath.section == 4) {
        return 93;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shouYeCell00" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == 21) {
                
                [view removeFromSuperview];
            }
        }
        
        HJCycleScrollView *scrollView =[[HJCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainW,  kMainW/375.0*173) Duration:9 pageControlHeight:5];
        scrollView.tag = 21;
        scrollView.delegate=self;
        scrollView.imageArray = _arrayImages;
        [cell.contentView addSubview:scrollView];
        
        return cell;
    } else if (indexPath.section == 1) {
        ShouYeCell10 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouYeCell10" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == 23) {
                
                [view removeFromSuperview];
            }
        }
        
        if (_dataArrayNotification.count == 0) {
            cell.hidden = YES;
        }
        
        CCPScrollView *ccpView = [[CCPScrollView alloc] initWithFrame:CGRectMake(0, 10, kMainW, 38)];
        ccpView.tag = 23;
        
        ccpView.dataArray = _dataArrayNotification;
        
        [ccpView clickTitleLabel:^(NSInteger index,NSString *titleString) {
            
            NSLog(@"%ld-----%@",index,titleString);
            
            WoDeTongZhiViewController *wdtzVC = [[WoDeTongZhiViewController alloc] init];
            [self.navigationController pushViewController:wdtzVC animated:YES];
            
        }];

        [cell.contentView addSubview:ccpView];
        return cell;
    } else if (indexPath.section == 2) {
        ShouYeCell20 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouYeCell20" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.view100.hidden = YES;//非标管家大 没有选择过
        cell.view101.hidden = YES;//非标管家大 选择过
        cell.view102.hidden = YES;//非标管家 图纸云
        
        
        cell.view20.hidden = YES;//图纸云、行业资讯、技术问答、自动化部件
        cell.view21.hidden = YES;//行业资讯、技术问答、自动化部件
        
        
        NSInteger userTpye = [self getUserType];
        if (userTpye == 0) {//游客
            cell.view102.hidden = NO;
            cell.view21.hidden = NO;
        } else if (userTpye == 1) {//个人
            cell.view102.hidden = NO;
            cell.view21.hidden = NO;
        } else if (userTpye == 2 || userTpye == 3) {//企业员工 || 企业管理员
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            NSInteger type = [DatabaseTool t_IdentityBeanGettypeWithUserId:loginModel.userId];
            
            if (type == 0) {//没选择过
                
                cell.view100.hidden = NO;
            } else {//选择过
                cell.view101.hidden = NO;
                if (type == 1) {//采购商
                    cell.view101LabelShang.text = @"非标管家-采购商";
                    cell.view101LabelXia.text = @"切换到供应商 >";
                }
                if (type == 2) {//供应商
                    cell.view101LabelShang.text = @"非标管家-供应商";
                    cell.view101LabelXia.text = @"切换到采购商 >";
                }
                
            }
            cell.view20.hidden = NO;
        }
        
        [cell.buttonFeiBiaoGuanJia0 addTarget:self action:@selector(buttonFeiBiaoGuanJia0:) forControlEvents:UIControlEventTouchUpInside];//非标管家大 没有选择过
        [cell.buttonFeiBiaoGuanJia1Shang addTarget:self action:@selector(buttonFeiBiaoGuanJia1Shang:) forControlEvents:UIControlEventTouchUpInside];//非标管家大 选择过 上部
        [cell.buttonFeiBiaoGuanJia1Xia addTarget:self action:@selector(buttonFeiBiaoGuanJia1Xia:) forControlEvents:UIControlEventTouchUpInside];//非标管家大 选择过 下部
        [cell.buttonFeiBiaoGuanJia2 addTarget:self action:@selector(buttonFeiBiaoGuanJia2:) forControlEvents:UIControlEventTouchUpInside];//非标管家 小
        
        
        [cell.buttonTouMingGongChang addTarget:self action:@selector(buttonTouMingGongChang:) forControlEvents:UIControlEventTouchUpInside];//透明工厂
        [cell.buttonZhiKeGuanJia addTarget:self action:@selector(buttonZhiKeGuanJia:) forControlEvents:UIControlEventTouchUpInside];//智客管家
        [cell.buttonTuZhiYun0 addTarget:self action:@selector(buttonTuZhiYun0:) forControlEvents:UIControlEventTouchUpInside];//图纸云
        [cell.buttonTuZhiYun1 addTarget:self action:@selector(buttonTuZhiYun0:) forControlEvents:UIControlEventTouchUpInside];//图纸云
        [cell.buttonHangYeZiXun0 addTarget:self action:@selector(buttonHangYeZiXun0:) forControlEvents:UIControlEventTouchUpInside];//行业资讯
        [cell.buttonHangYeZiXun1 addTarget:self action:@selector(buttonHangYeZiXun0:) forControlEvents:UIControlEventTouchUpInside];//行业资讯
        [cell.buttonJiShuWenDa0 addTarget:self action:@selector(buttonJiShuWenDa0:) forControlEvents:UIControlEventTouchUpInside];//技术问答
        [cell.buttonJiShuWenDa1 addTarget:self action:@selector(buttonJiShuWenDa0:) forControlEvents:UIControlEventTouchUpInside];//技术问答
        [cell.buttonZiDongHuaBuJian0 addTarget:self action:@selector(buttonZiDongHuaBuJian0:) forControlEvents:UIControlEventTouchUpInside];//自动化部件
        [cell.buttonZiDongHuaBuJian1 addTarget:self action:@selector(buttonZiDongHuaBuJian0:) forControlEvents:UIControlEventTouchUpInside];//自动化部件
        
        return cell;
    } else if (indexPath.section == 3) {
        ShouYeCell30 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouYeCell30" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_dataArray.count == 0) {
            cell.hidden = YES;
        }
        
        return cell;
    } else if (indexPath.section == 4) {
        ShouYeCell40 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouYeCell40" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewLineTop.hidden = YES;
        cell.viewLineBottom.hidden = YES;
        cell.viewLineBottom15.hidden = YES;
        if (indexPath.row == 0) {
            cell.viewLineTop.hidden = NO;
        }
        if (indexPath.row == _dataArray.count-1) {
            cell.viewLineBottom.hidden = NO;
        } else {
            cell.viewLineBottom15.hidden = NO;
        }
        
        ModelGetInformationListList *model = _dataArray[indexPath.row];
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:model.urlPath]];
        cell.labelContent.text = model.title;
        cell.labelDate.text = [[model.pubTm componentsSeparatedByString:@" "] firstObject];
        return cell;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4) {
        WebDatailURL *webVC = [[WebDatailURL alloc] init];
        ModelGetInformationListList *model = _dataArray[indexPath.row];

        webVC.detailUrl = model.detailUrl;
        webVC.titleTitle = model.title;
        webVC.content = model.info;
        webVC.imagePath = model.urlPath;
        webVC.isShare = true;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

#pragma mark 点击登录
- (IBAction)viewVistorButtonLogin:(id)sender {
    [self goLogin];
}

- (void)goLogin {
    CompanyViewController *companyVC = [[CompanyViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:companyVC];
    nav.modalPresentationStyle = 0;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark 账户管理
- (IBAction)buttonZhangHuGuanLi:(id)sender {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
    if (array.count > 1) {
        ZhangHuGuanLiViewController *zhangHuGuanLiViewController = [[ZhangHuGuanLiViewController alloc] init];
        [self.navigationController pushViewController:zhangHuGuanLiViewController animated:YES];
    }
}
#pragma mark 创建企业
- (IBAction)viewChuangJianQiYe:(id)sender {
    [self webViewWithTitle:@"创建企业" withURL:IME_CreatEnterprise];
}

#pragma mark 获取非标token
- (void)getUserEFEIBIAOToken:(NSString *)ucenterId callBack:(void(^)(void))block{
    __block BOOL isSuccess = true;
    _viewLoading1.hidden = false;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        EfeibiaoPostEntityBean *efeibiaoPostEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        MemberReqBean *memberReqBean = [[MemberReqBean alloc] init];
        memberReqBean.ucId = ucenterId;
        efeibiaoPostEntityBean.entity = memberReqBean.mj_keyValues;
        NSDictionary *dic = efeibiaoPostEntityBean.mj_keyValues;
        [HttpMamager postRequestWithURLString:DYZ_ucenter_user_getUserEFEIBIAOToken parameters:dic success:^(id responseObjectModel) {
            
            NSLog(@"-responseObjectModel-%@",[responseObjectModel mj_JSONString]);
            EfeibiaoReturnEntityBean * efeibiaoReturnEntityBean = responseObjectModel;
            if ([efeibiaoReturnEntityBean.status isEqualToString:@"SUCCESS"]) {
                [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken = efeibiaoReturnEntityBean.returnToken;
                MemberResBean *member = [MemberResBean mj_objectWithKeyValues:efeibiaoReturnEntityBean.entity];
                [GlobalSettingManager shareGlobalSettingManager].member = member;
                [GlobalSettingManager shareGlobalSettingManager].memberId = member.idd;
                [GlobalSettingManager shareGlobalSettingManager].manufacturerId = member.enterpriseInfoId;
                

                
                NSLog(@"-----%@",[GlobalSettingManager shareGlobalSettingManager].memberId);
                NSLog(@"----%@", [GlobalSettingManager shareGlobalSettingManager].manufacturerId);
                
                // 获取非标 权限数组
                [[GlobalSettingManager shareGlobalSettingManager] requestfbCompetenceAllWithfbToken:[GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken];
                isSuccess = true;
                dispatch_group_leave(group);
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:efeibiaoReturnEntityBean.returnMsg];
                isSuccess = false;
                dispatch_group_leave(group);
            }
            
        } fail:^(NSError *error) {
            isSuccess = false;
            dispatch_group_leave(group);
            
            
        } isKindOfModel:NSClassFromString(@"EfeibiaoReturnEntityBean")];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self->_viewLoading1.hidden = true;
        if (isSuccess) {
            block();
        }
    });
}

#pragma mark 非标管家大 没有选择过
- (void)buttonFeiBiaoGuanJia0:(UIButton *)sender {
    _viewSelectIdentity = [ViewSelectIdentity selectIdentity];
    [_viewSelectIdentity.buttonSelectProcurer addTarget:self action:@selector(buttonSelectProcurer:) forControlEvents:UIControlEventTouchUpInside];
    [_viewSelectIdentity.buttonSelectSupplier addTarget:self action:@selector(buttonSelectSupplier:) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:_viewSelectIdentity];
}
#pragma mark 非标管家大 选择过 上部
- (void)buttonFeiBiaoGuanJia1Shang:(UIButton *)sender {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    [self getUserEFEIBIAOToken:loginModel.ucenterId callBack:^{
//        NSLog(@"%@",[GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken);
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        NSInteger type = [DatabaseTool t_IdentityBeanGettypeWithUserId:loginModel.userId];

        if (type == 1) {//采购商
            [self goPurchaser];
        } else if (type == 2) {//供应商
            [self goSupplier];
        }
    }];
}
#pragma mark 非标管家大 选择过 下部
- (void)buttonFeiBiaoGuanJia1Xia:(UIButton *)sender {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    [self getUserEFEIBIAOToken:loginModel.ucenterId callBack:^{
        NSInteger type = [DatabaseTool t_IdentityBeanGettypeWithUserId:loginModel.userId];
        if (type == 1) {//采购商
            [DatabaseTool t_IdentityBeanUpdateWithUserId:loginModel.userId andType:2];
            //进供应商
            [self goSupplier];
        } else if (type == 2) {//供应商
            [DatabaseTool t_IdentityBeanUpdateWithUserId:loginModel.userId andType:1];
            //进采购商
            [self goPurchaser];
        }
    }];
}
#pragma mark 非标管家 小
- (void)buttonFeiBiaoGuanJia2:(UIButton *)sender {
    [self goPurchaser];
}
#pragma mark 选择采购商
- (void)buttonSelectProcurer:(UIButton *)sender {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    [self getUserEFEIBIAOToken:loginModel.ucenterId callBack:^{
        [DatabaseTool t_IdentityBeanUpdateWithUserId:loginModel.userId andType:1];
        [self goPurchaser];
        [self->_viewSelectIdentity removeFromSuperview];
    }];
}
#pragma mark 选择供应商
- (void)buttonSelectSupplier:(UIButton *)sender {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    [self getUserEFEIBIAOToken:loginModel.ucenterId callBack:^{
        [DatabaseTool t_IdentityBeanUpdateWithUserId:loginModel.userId andType:2];
        [self goSupplier];
        [self->_viewSelectIdentity removeFromSuperview];
    }];
}

#pragma mark 透明工厂
- (void)buttonTouMingGongChang:(UIButton *)sender {
    [self goTouMingGongChang];
}
#pragma mark 智客管家
- (void)buttonZhiKeGuanJia:(UIButton *)sender {
    [self webViewWithTitle:@"智客管家" withURL:IME_ThiKeGuanJia];
}
#pragma mark 图纸云
- (void)buttonTuZhiYun0:(UIButton *)sender {
    NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
    if (!stringPsw) {//没取到密码 请先登录登录
        [self goLogin];
    } else {
        [self webViewWithTitle:@"图纸云" withURL:IME_TuZhiYun];
    }
}
#pragma mark 行业资讯
- (void)buttonHangYeZiXun0:(UIButton *)sender {
    InformationShowViewController *informationShowViewController = [[InformationShowViewController alloc] init];
    [self.navigationController pushViewController:informationShowViewController animated:YES];
}
#pragma mark 技术问答
- (void)buttonJiShuWenDa0:(UIButton *)sender {
    [self webViewWithTitle:@"技术问答" withURL:@"https://bbs.imefuture.com/question/"];
}
#pragma mark 自动化部件
- (void)buttonZiDongHuaBuJian0:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://electric.imefuture.com/electric/index.jsp"]];
}

- (void)goPurchaser {
    NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
    if (!stringPsw) {//没取到密码 请先登录登录 -> //进宣传页
//        [self webViewWithTitle:@"非标采购商" withURL:IME_beta];
        [self goLogin];
    } else {
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        
        NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
        for (NSDictionary *dic in array) {
            IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
            if ([loginModel.ucenterId isEqualToString:identityBean.ucenterId]) {
                if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                    //个人账号
                    [self webViewWithTitle:@"非标采购商" withURL:IME_beta];
                    break;
                }
                if ([identityBean.userType isEqualToString:@"ENTERPRISE"] && [identityBean.epAccLevel isEqualToString:@"F"]) {
                    //企业管理员
                    NSString *userBean = loginModel.ucenterUser;
                    UserBean *userBeanModel = [UserBean mj_objectWithKeyValues:userBean];
                    BOOL isTrue = false;
                    for (EnterpriseSpecialAppInfoBean *enterpriseSpecialAppInfoBean in userBeanModel.enterpriseInfo.enterpriseSpecialAppInfo) {
                        if (([enterpriseSpecialAppInfoBean.appId integerValue] == 2 || [enterpriseSpecialAppInfoBean.appId integerValue] == 4)&&([enterpriseSpecialAppInfoBean.isAvailable integerValue]==1)) {
                            isTrue = true;
                        }
                    }
                    if (isTrue) {
                        [self goToPurchaseTabBarController];
                        break;
                    } else {
                        [self webViewWithTitle:@"非标采购商" withURL:IME_beta];
                        break;
                    }
                }
                if ([identityBean.userType isEqualToString:@"ENTERPRISE"] && [identityBean.epAccLevel isEqualToString:@"C"]) {
                    //企业员工
                    NSString *userBean = loginModel.ucenterUser;
                    UserBean *userBeanModel = [UserBean mj_objectWithKeyValues:userBean];
                    
                    BOOL isTrue = false;
                    for (EnterpriseSpecialAppInfoBean *enterpriseSpecialAppInfoBean in userBeanModel.enterpriseInfo.enterpriseSpecialAppInfo) {
                        if (([enterpriseSpecialAppInfoBean.appId integerValue] == 2 || [enterpriseSpecialAppInfoBean.appId integerValue] == 4)&&([enterpriseSpecialAppInfoBean.isAvailable integerValue]==1)) {
                            isTrue = true;
                        }
                    }
                    if (isTrue) {
                        if ([userBeanModel.hasEfeibiao integerValue] == 1) {
                            [self goToPurchaseTabBarController];
                            break;
                        } else {
                            [self webViewWithTitle:@"非标采购商" withURL:IME_beta];
                            break;
                        }
                    } else {
                        [self webViewWithTitle:@"非标采购商" withURL:IME_beta];
                        break;
                    }
                }
            }
        }
    }
}

- (void)goSupplier {
    NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
    if (!stringPsw) {//没取到密码 请先登录登录
//        [self webViewWithTitle:@"非标供应商" withURL:IME_beta];
        [self goLogin];
    } else {
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
        for (NSDictionary *dic in array) {
            IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
            if ([loginModel.ucenterId isEqualToString:identityBean.ucenterId]) {
                if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                    //个人账号
                    [self webViewWithTitle:@"非标供应商" withURL:IME_betand];
                    break;
                }
                if ([identityBean.userType isEqualToString:@"ENTERPRISE"] && [identityBean.epAccLevel isEqualToString:@"F"]) {
                    //企业管理员
                    NSString *userBean = loginModel.ucenterUser;
                    UserBean *userBeanModel = [UserBean mj_objectWithKeyValues:userBean];
                    
                    BOOL isTrue = false;
                    for (EnterpriseSpecialAppInfoBean *enterpriseSpecialAppInfoBean in userBeanModel.enterpriseInfo.enterpriseSpecialAppInfo) {
                        if (([enterpriseSpecialAppInfoBean.appId integerValue] == 3)&&([enterpriseSpecialAppInfoBean.isAvailable integerValue]==1)) {
                            isTrue = true;
                        }
                    }
                    
                    if (isTrue) {
                        [self goToSupplierTabBarController];
                        break;
                    } else {
                        [self webViewWithTitle:@"非标供应商" withURL:IME_betand];
                        break;
                    }
                }
                if ([identityBean.userType isEqualToString:@"ENTERPRISE"] && [identityBean.epAccLevel isEqualToString:@"C"]) {
                    //企业员工
                    NSString *userBean = loginModel.ucenterUser;
                    UserBean *userBeanModel = [UserBean mj_objectWithKeyValues:userBean];
                    
                    BOOL isTrue = false;
                    for (EnterpriseSpecialAppInfoBean *enterpriseSpecialAppInfoBean in userBeanModel.enterpriseInfo.enterpriseSpecialAppInfo) {
                        if (([enterpriseSpecialAppInfoBean.appId integerValue] == 3)&&([enterpriseSpecialAppInfoBean.isAvailable integerValue]==1)) {
                            isTrue = true;
                        }
                    }
                    if (isTrue) {
                        if ([userBeanModel.hasEfeibiao integerValue] == 1) {
                            [self goToSupplierTabBarController];
                            break;
                        } else {
                            [self webViewWithTitle:@"非标供应商" withURL:IME_betand];
                            break;
                        }
                    } else {
                        [self webViewWithTitle:@"非标供应商" withURL:IME_betand];
                        break;
                    }
                }
            }
        }
    }
}

- (void)goTouMingGongChang {
    NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
    if (!stringPsw) {//没取到密码 请先登录登录
//        [self webViewWithTitle:@"透明工厂" withURL:IME_TouMingGongChangXuanChuanYe];
        [self goLogin];
    } else {
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        
        NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
        for (NSDictionary *dic in array) {
            IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
            if ([loginModel.ucenterId isEqualToString:identityBean.ucenterId]) {
                if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                    //个人账号
                    [self webViewWithTitle:@"透明工厂" withURL:IME_TouMingGongChangXuanChuanYe];
                    break;
                }
                if ([identityBean.userType isEqualToString:@"ENTERPRISE"] && [identityBean.epAccLevel isEqualToString:@"F"]) {
                    //企业管理员
                    NSString *userBean = loginModel.ucenterUser;
                    UserBean *userBeanModel = [UserBean mj_objectWithKeyValues:userBean];
                    BOOL isTrue = false;
                    for (EnterpriseSpecialAppInfoBean *enterpriseSpecialAppInfoBean in userBeanModel.enterpriseInfo.enterpriseSpecialAppInfo) {
                        if (([enterpriseSpecialAppInfoBean.appId integerValue] == 1)&&([enterpriseSpecialAppInfoBean.isAvailable integerValue]==1)) {
                            isTrue = true;
                        }
                    }
                    if (isTrue) {
                        NSDate *date = [NSDate date];
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @"hhmmss";
                        NSString *stringDate = [formatter stringFromDate:date];
                        stringDate = [stringDate substringToIndex:5];
                        [self webViewWithTouMingGongChangTitle:@"透明工厂" withURL:[NSString stringWithFormat:@"%@?t=%@",IME_TouMingGongChang,stringDate]];
                        break;
                    } else {
                        [self webViewWithTitle:@"透明工厂" withURL:IME_TouMingGongChangXuanChuanYe];
                        break;
                    }
                }
                if ([identityBean.userType isEqualToString:@"ENTERPRISE"] && [identityBean.epAccLevel isEqualToString:@"C"]) {
                    //企业员工
                    NSString *userBean = loginModel.ucenterUser;
                    UserBean *userBeanModel = [UserBean mj_objectWithKeyValues:userBean];
                    
                    BOOL isTrue = false;
                    for (EnterpriseSpecialAppInfoBean *enterpriseSpecialAppInfoBean in userBeanModel.enterpriseInfo.enterpriseSpecialAppInfo) {
                        if (([enterpriseSpecialAppInfoBean.appId integerValue] == 1)&&([enterpriseSpecialAppInfoBean.isAvailable integerValue]==1)) {
                            isTrue = true;
                        }
                    }
                    if (isTrue) {
                        if ([userBeanModel.hasTmgc integerValue] == 1) {
                            NSDate *date = [NSDate date];
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            formatter.dateFormat = @"hhmmss";
                            NSString *stringDate = [formatter stringFromDate:date];
                            stringDate = [stringDate substringToIndex:5];
                            [self webViewWithTouMingGongChangTitle:@"透明工厂" withURL:[NSString stringWithFormat:@"%@?t=%@",IME_TouMingGongChang,stringDate]];
                            break;
                        } else {
                            [self webViewWithTitle:@"透明工厂" withURL:IME_TouMingGongChangXuanChuanYe];
                            break;
                        }
                    } else {
                        [self webViewWithTitle:@"透明工厂" withURL:IME_TouMingGongChangXuanChuanYe];
                        break;
                    }
                }
            }
        }
    }
}

- (void)webViewWithTitle:(NSString *)title withURL:(NSString *)url{
    WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
    webDatailURL.titleTitle = title;
    webDatailURL.detailUrl = url;
    [self.navigationController pushViewController:webDatailURL animated:YES];
}

- (void)webViewWithTouMingGongChangTitle:(NSString *)title withURL:(NSString *)url{
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    if (loginModel.tpfUser != [NSNull null] && loginModel.tpfUser != nil) {
        UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        [self requesttpfGetparameterlistWithSiteCode:tpfUser.siteCode callBack:^{
            TpfMaiViewController *tpfMaiViewController = [[TpfMaiViewController alloc] init];
            [self.navigationController pushViewController:tpfMaiViewController animated:YES];
        }];
    } else {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"tpfUser 不存在"];
    }
}

#pragma mark 获取透明工厂配置参数
- (void)requesttpfGetparameterlistWithSiteCode:(NSString *)siteCode callBack:(void(^)(void))block{
    __block BOOL isSuccess = true;
    _viewLoading1.hidden = false;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
        ParameterEntityVo *vo = [[ParameterEntityVo alloc] init];
        vo.siteCode = siteCode;
        postEntityBean.entity = vo.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        [HttpMamager postRequestWithURLString:DYZ_mes_parameter_getparameterlist parameters:dic success:^(id responseObjectModel) {
            
            ReturnListBean *returnListBean = responseObjectModel;
            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                NSMutableArray <ParameterEntityVo *> *array =  [ParameterEntityVo mj_objectArrayWithKeyValuesArray:returnListBean.list];
                for (ParameterEntityVo *vo in array) {
                    if ([vo.parameterCode isEqualToString:@"MATERIALARRIVEDORDEROPERATINGMODE"]) {// IQC入库 模式
                        for (ParameterValueVo *valueVo in vo.parameterValue) {
                            if (valueVo.defaultFlag.integerValue == 1) {
                                [GlobalSettingManager shareGlobalSettingManager].iQCPattern = valueVo.value.integerValue;
                            }
                        }
                    }
                    if ([vo.parameterCode isEqualToString:@"PLANWORKTIMEDISPLAY"]) {// 计划工时 是否显示
                        [GlobalSettingManager shareGlobalSettingManager].showPlanHour = vo.defaultValue.integerValue;
                    }
                    if ([vo.parameterCode isEqualToString:@"ALLOWSINGLEPERSONMULTITASK"]) {// 多工单报工入口 是否显示
                        [GlobalSettingManager shareGlobalSettingManager].showMultiltask = vo.defaultValue.integerValue;
                    }
                }
                isSuccess = true;
                dispatch_group_leave(group);
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
                isSuccess = false;
                dispatch_group_leave(group);
            }
            
        } fail:^(NSError *error) {
            isSuccess = false;
            dispatch_group_leave(group);
            
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self->_viewLoading1.hidden = true;
        if (isSuccess) {
            block();
        }
    });
}



- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    _index = tabBarController.selectedIndex;
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex != 0) {
        NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
        if (!stringPsw) {//没取到密码 请先登录登录
            CompanyViewController *companyVC = [[CompanyViewController alloc] init];
            companyVC.delegate = tabBarController.viewControllers[tabBarController.selectedIndex];
            companyVC.sourceVC = @"E";
            companyVC.viewController = tabBarController.viewControllers[tabBarController.selectedIndex];
            tabBarController.selectedIndex = _index;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:companyVC];
            nav.modalPresentationStyle = 0;
            [self presentViewController:nav animated:YES completion:nil];
        } else {
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            if ([loginModel.userType isEqualToString:@"NORMAL"]) {
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"个人用户无法使用该功能，\r\n请注册企业用户！" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                }];
                [ac addAction:action];
                [self presentViewController:ac animated:YES completion:nil];
                tabBarController.selectedIndex = 0;
            }
        }
    }
}

- (void)goToPurchaseTabBarController{
    IMETabBarViewController *imeTabBar = [[IMETabBarViewController alloc] init];
    
    [self.navigationController pushViewController:imeTabBar animated:YES];
}

- (void)goToSupplierTabBarController{
    EGInquiryViewController *eGInquiryViewController = [[EGInquiryViewController alloc] init];
    eGInquiryViewController.tabBarItem.title = @"询盘";
    eGInquiryViewController.tabBarItem.image = [UIImage imageNamed:@"ime_icon_purchaser"];
    eGInquiryViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"ime_icon_purchaser_3t"];
        
    EGOrderViewController *eGOrderViewController = [[EGOrderViewController alloc] init];
    eGOrderViewController.tabBarItem.title = @"订单";
    eGOrderViewController.tabBarItem.image = [UIImage imageNamed:@"ime_icon_order"];
    eGOrderViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"ime_icon_order_3t"];
    
    
    UITabBarController * tabBarG = [[UITabBarController alloc] init];
    tabBarG.viewControllers = @[eGInquiryViewController,eGOrderViewController];
    tabBarG.tabBar.tintColor = [UIColor colorWithRed:0/255.0 green:168/255.0 blue:255/255.0 alpha:1];
    [self.navigationController pushViewController:tabBarG animated:YES];
}

- (void)showAlertControllerWithTitle:(NSString *)title {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}

#pragma mark App用网页展示通知

#pragma mark 切换身份
- (void)changeIdentity:(NSString *)receiveUserId {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
    for (NSDictionary *dic in array) {
        IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
        if ([identityBean.userId isEqualToString:receiveUserId]) {
            [self changeWithIdentityBean:identityBean];
            break;
        }
    }
}

- (void)changeWithIdentityBean:(IdentityBean *)identityBean {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否切换身份到:" message:identityBean.showName preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionleft = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *actionRight = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _viewLoading1.hidden = NO;
        
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
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
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
                                            @"isRefreshToken":@"false"
                                            };
            [HttpMamager postRequestLoginWithURLString:DYZ_user_login parameters:dicParameters success:^(id responseObjectModel) {
                _viewLoading1.hidden = YES;
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
            if ([obj.regStatus isEqualToString:@"CONFIRM"]) {
                //已审核
                
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
                if ([_mutableDic[@"needAppDisplay"] integerValue] == 1) {
                    //需要App原生展示
                    for (ParamsBean *paramsBean in self.paramsBeanArrayCopy) {
                        if ([paramsBean.name isEqualToString:@"type"]) {
                            [self initRunParamsBean:paramsBean withArray:self.paramsBeanArrayCopy];
                            break;
                        }
                    }
                    
                } else if (((NSString *)_mutableDic[@"detailUrl"]).length>0) {
                    //需要App用网页展示通知URL之向的网页
                    [self webViewWithTitle:@"通知详情" withURL:_mutableDic[@"detailUrl"]];
                    return;
                }
                
            }
        } else if ([dic[@"resultCode"] integerValue] == -2) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"密码错误"];
        } else if ([dic[@"resultCode"] integerValue] == -1) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"系统异常"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"登录失败"];
        }
    }
}

#pragma mark 通知处理
- (void)initRunParamsBean:(ParamsBean *)paramsBean withArray:(NSArray *)paramsBeanArray{
    
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
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
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

#pragma mark 获取用户类型 0:游客；1：个人；2：企业员工；3:企业管理员
- (NSInteger)getUserType {
    NSInteger type = 0;
    NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
    if (!stringPsw) {
        //游客
        type = 0;
    } else {
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
        for (NSDictionary *dic in array) {
            IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
            if ([loginModel.ucenterId isEqualToString:identityBean.ucenterId]) {
                if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                    //个人账号
                    type = 1;
                }
                if ([identityBean.userType isEqualToString:@"ENTERPRISE"] && [identityBean.epAccLevel isEqualToString:@"C"]) {
                    //企业员工
                    type = 2;
                }
                if ([identityBean.userType isEqualToString:@"ENTERPRISE"] && [identityBean.epAccLevel isEqualToString:@"F"]) {
                    //企业管理员
                    type = 3;
                }
                break;
            }
        }
    }
    return type;
}

- (void)getUserPm {
    EfeibiaoPostEntityBean *efeibiaoPostEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    PagerBean *pagerBean = [[PagerBean alloc] init];
    pagerBean.pageSize = [NSNumber numberWithInteger:5];
    pagerBean.page = [NSNumber numberWithInteger:[@1 integerValue]];
    efeibiaoPostEntityBean.pager = pagerBean;
    
    OrderByBean *orderByBean = [[OrderByBean alloc] init];
    orderByBean.orderName = @"c.createTime";
    orderByBean.orderSort = @"desc";
    
    NSMutableArray <OrderByBean *> *arrayOrderByBean = [[NSMutableArray alloc] initWithCapacity:0];
    [arrayOrderByBean addObject:orderByBean];
    efeibiaoPostEntityBean.order = arrayOrderByBean;
    
    PageQueryBean *pageQueryBean = [[PageQueryBean alloc] init];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
    for (NSDictionary *dic in array) {
        IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
        if ([identityBean.userType isEqualToString:@"NORMAL"]) {
            pageQueryBean.requestUserId = identityBean.userId;
            break;
        }
    }
    
    pageQueryBean.requestStatus = [NSNumber numberWithInteger:3];
    
    efeibiaoPostEntityBean.entity = pageQueryBean.mj_keyValues;
    
    NSDictionary *dic = efeibiaoPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_notify_getUserPm parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            NSLog(@"%@",returnListBean.mj_JSONString);
            _dataArrayNotification = [[NSMutableArray alloc] initWithCapacity:1];
            _dataArrayNotification = [PmPageBean mj_objectArrayWithKeyValuesArray:returnListBean.list];
            [self.tableView reloadData];
        } else {
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 二进制重排
- (IBAction)ButtonClickBinaryRearrangement:(id)sender {
//    NSMutableArray <NSString *> * symbolNames = [NSMutableArray array];
//
//    while (YES) {
//        SYNode * node = OSAtomicDequeue(&symbolList, offsetof(SYNode, next));
//        if (node == NULL) {
//            break;
//        }
//        Dl_info info;
//        dladdr(node->pc, &info);
//        NSString * name = @(info.dli_sname);
//        BOOL  isObjc = [name hasPrefix:@"+["] || [name hasPrefix:@"-["];
//        NSString * symbolName = isObjc ? name: [@"_" stringByAppendingString:name];
//        [symbolNames addObject:symbolName];
//    }
//    //取反
//    NSEnumerator * emt = [symbolNames reverseObjectEnumerator];
//    //去重
//    NSMutableArray<NSString *> *funcs = [NSMutableArray arrayWithCapacity:symbolNames.count];
//    NSString * name;
//    while (name = [emt nextObject]) {
//        if (![funcs containsObject:name]) {
//            [funcs addObject:name];
//        }
//    }
//    //干掉自己!
//    [funcs removeObject:[NSString stringWithFormat:@"%s",__FUNCTION__]];
//    //将数组变成字符串
//    NSString * funcStr = [funcs  componentsJoinedByString:@"\n"];
//
//    NSString * filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"dyz.order"];
//    NSData * fileContents = [funcStr dataUsingEncoding:NSUTF8StringEncoding];
//    [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileContents attributes:nil];
//    NSLog(@"%@",filePath);
}

//void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
//                                                    uint32_t *stop) {
//  static uint64_t N;  // Counter for the guards.
//  if (start == stop || *start) return;  // Initialize only once.
//  printf("INIT: %p %p\n", start, stop);
//  for (uint32_t *x = start; x < stop; x++)
//    *x = ++N;  // Guards should start from 1.
//}
//
////原子队列
//static  OSQueueHead symbolList = OS_ATOMIC_QUEUE_INIT;
////定义符号结构体
//typedef struct {
//    void *pc;
//    void *next;
//}SYNode;
//
//void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
//    if (!*guard) return;  // Duplicate the guard check.
//    void *PC = __builtin_return_address(0);
//    SYNode *node = malloc(sizeof(SYNode));
//    *node = (SYNode){PC,NULL};
//    //进入
//    OSAtomicEnqueue(&symbolList, node, offsetof(SYNode, next));
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
