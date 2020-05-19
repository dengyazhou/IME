//
//  ECSupplierViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ECSupplierViewController.h"
#import "VoHeader.h"


#import "QiYeXinXiXiangQingViewController.h"

#import "ECSupplierCell.h"

#import "ECAddSupplierVC.h"

#import "ECTuoGuanSupplierViewController.h"
#import "AFNetworkReachabilityManager.h"
#import "ShouYeViewController.h"

#import "ECSLabelManagementVC.h"

#import "AddView.h"

#import "ECSScreenViewBG.h"


@interface ECSupplierViewController () <UITableViewDelegate,UITableViewDataSource,ECSScreenViewBGDelegate> {
    UITableView *_tableView;

    NSMutableArray *_arrayEnterpriseRelationModel;
    
    
    NSInteger _aPage;
    
    UIView *_viewNoContent0;
    UIView *_viewRequestTimeout;
    
    UIView *_viewNoNet;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    
}



@property (weak, nonatomic) IBOutlet UIButton *addButton;


@property (strong,nonatomic) ECSScreenViewBG *eCSScreenViewBG;

@property (nonatomic,strong) NSMutableArray *arrayTGSupplierTag;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation ECSupplierViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 0) {
        _viewNoNet.hidden = NO;
    }
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 1 || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==2) {
        _viewNoNet.hidden = YES;
        
        [_tableView.mj_header beginRefreshing];
    }
    
    [self initRequestTgSupplierTagQuerytg];//获取所有标签
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-_height_NavBar-_height_TabBar) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 200;
    _tableView.backgroundColor = colorRGB(241, 241, 241);
    [_tableView registerNib:[UINib nibWithNibName:@"ECSupplierCell" bundle:nil] forCellReuseIdentifier:@"eCSupplierCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    
    _viewNoContent0 = [UIView addViewNoContentToSuperView:self.view tableView:_tableView imageNamed:@"ime_picture_supplier" label0Text:@"无内容" label1Text:@"您可以点击按钮，或右上角“＋”添加" buttonTitle:@"添加管家供应商"];
    
    for (UIView *view in _viewNoContent0.subviews) {
        if (view.tag == 10) {
            UIButton *button = (UIButton *)view;
            [button addTarget:self action:@selector(buttonAddSupplier) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    _viewNoContent0.hidden = YES;
    
    _viewRequestTimeout = [UIView addView:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-_height_TabBar) withTitle:@"请求超时"];
    [self.view addSubview:_viewRequestTimeout];
    _viewRequestTimeout.hidden = YES;
    
    _viewNoNet = [UIView addView:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-_height_TabBar) imageNamed:@"ime_picture_network" title:@"网络不可用，请检查网络！"];
    [self.view addSubview:_viewNoNet];

    
    [self initRequest0WithTGSupplierTag:nil se_temporaryEnterpriseName:nil se_temporaryZoneStr:nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrayEnterpriseRelationModel.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 70;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01f;
    }
    return 10.f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ECSupplierCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eCSupplierCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.isTemporaryImg.hidden = YES;
    cell.label_factoryImg.hidden = YES;
    
    EnterpriseRelation *enterpriseRelation = _arrayEnterpriseRelationModel[indexPath.section];
    
    if ([enterpriseRelation.passiveEnterprise.isTemporary integerValue] == 1) {//临时用户
        cell.isTemporaryImg.hidden = NO;
        if ([enterpriseRelation.passiveEnterprise.hasTrFactory integerValue] == 0) {
            cell.label_factoryImg.hidden = YES;
            cell.enterpriseNameConstraint.constant = 46;
        }
        if ([enterpriseRelation.passiveEnterprise.hasTrFactory integerValue] == 1) {
            cell.label_factoryImg.hidden = NO;
            cell.enterpriseNameConstraint.constant = 68;
            cell.label_factoryImgConstraint.constant = 46;
        }
    } else {
        cell.isTemporaryImg.hidden = YES;
        if ([enterpriseRelation.passiveEnterprise.hasTrFactory integerValue] == 0) {
            cell.label_factoryImg.hidden = YES;
            cell.enterpriseNameConstraint.constant = 8;
        }
        if ([enterpriseRelation.passiveEnterprise.hasTrFactory integerValue] == 1) {
            cell.label_factoryImg.hidden = NO;
            cell.enterpriseNameConstraint.constant = 30;
            cell.label_factoryImgConstraint.constant = 8;
        }
    }
    
    cell.enterpriseName.text = enterpriseRelation.passiveEnterpriseName;
    if ([enterpriseRelation.passiveEnterprise.isTemporary integerValue] == 1) {//临时用户
        cell.provinceCity.text = enterpriseRelation.temporaryZoneStr.length>0?enterpriseRelation.temporaryZoneStr:@"--";
    } else {
        NSString *stringProvinceCity = [NSString stringWithFormat:@"%@ %@",enterpriseRelation.passiveEnterprise.province?enterpriseRelation.passiveEnterprise.province:@"",enterpriseRelation.passiveEnterprise.city?enterpriseRelation.passiveEnterprise.city:@""];
        cell.provinceCity.text = ![stringProvinceCity isEqualToString:@" "]?stringProvinceCity:@"--";
    }
    [cell.logoImg sd_setImageWithURL:[NSURL URLWithString:enterpriseRelation.passiveEnterprise.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EnterpriseRelation *enterpriseRelationModel = _arrayEnterpriseRelationModel[indexPath.section];
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
        EnterpriseRelation *enterpriseRelation = [[EnterpriseRelation alloc] init];
        enterpriseRelation.initiatorId = enterpriseRelationModel.initiatorId;
        enterpriseRelation.passiveId = enterpriseRelationModel.passiveId;
        postEntityBean.entity = enterpriseRelation.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_epRelation_cancelTrustRelation parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"取消成功"];
                [self->_arrayEnterpriseRelationModel removeObjectAtIndex:indexPath.section];
                [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"取消失败"];
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    EnterpriseRelation *enterpriseRelation = _arrayEnterpriseRelationModel[indexPath.section];
//    ECTuoGuanSupplierViewController * eCTuoGuanSupplierViewController = [[ECTuoGuanSupplierViewController alloc] init];
//    eCTuoGuanSupplierViewController.enterpriseRelationSuper = enterpriseRelation;
//    [self.navigationController pushViewController:eCTuoGuanSupplierViewController animated:YES];
}

- (IBAction)back:(UIButton *)sender {
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isMemberOfClass:[UITabBarController  class]]) {
            UITabBarController *tab = (UITabBarController *)vc;
            if ([tab.viewControllers[0] isMemberOfClass:[ShouYeViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                tab.selectedIndex = 0;
                break;
            }
        }
    }
}

- (ECSScreenViewBG *)eCSScreenViewBG {
    if (!_eCSScreenViewBG) {
        _eCSScreenViewBG = [[ECSScreenViewBG alloc] initWithFrame:self.view.frame withArrayTGSupplierTag:self.arrayTGSupplierTag];
        _eCSScreenViewBG.delegate = self;
    } else {
        [_eCSScreenViewBG removeFromSuperview];
        _eCSScreenViewBG = [[ECSScreenViewBG alloc] initWithFrame:self.view.frame withArrayTGSupplierTag:self.arrayTGSupplierTag];
        _eCSScreenViewBG.delegate = self;
    }
    return _eCSScreenViewBG;
}

//点击ECSScreenView上的完成 执行
- (void)eCSScreenViewBGDelegateIndex:(NSInteger)labelTag CompanyName:(NSString *)company Netherlands:(NSString *)district {
//    NSLog(@"labelTag:%ld company:%@ district:%@",labelTag,company,district);
    TGSupplierTag *tGSupplierTag;
    if (labelTag == 20) {
        tGSupplierTag = nil;
    } else {
        tGSupplierTag = self.arrayTGSupplierTag[labelTag];
    }
    if (!(company.length > 0)) {
        company = nil;
    }
    if (!(district.length > 0)) {
        district = nil;
    }
    [self initRequest0WithTGSupplierTag:tGSupplierTag se_temporaryEnterpriseName:company se_temporaryZoneStr:district];
    [_tableView.mj_header beginRefreshing];
    
}
- (IBAction)add:(UIButton *)sender {
    __block AddView *addView = [[AddView alloc] initWithFrame:self.view.frame buttonClick:^(NSInteger tag) {
        [addView removeFromSuperview];
        if (tag == 0) {
            [self.view.window addSubview:self.eCSScreenViewBG];
        }
        if (tag == 1) {
            ECSLabelManagementVC *eCSLabelManagementVC = [[ECSLabelManagementVC alloc] init];
            [self.navigationController pushViewController:eCSLabelManagementVC animated:YES];
        }
        if (tag == 2) {
            ECAddSupplierVC *eCAddSupplierVC = [[ECAddSupplierVC alloc] init];
            [self.navigationController pushViewController:eCAddSupplierVC animated:YES];
        }
    }];
    [self.view.window addSubview:addView];
}

- (void)buttonAddSupplier {
    ECAddSupplierVC *eCAddSupplierVC = [[ECAddSupplierVC alloc] init];
    [self.navigationController pushViewController:eCAddSupplierVC animated:YES];
}

#pragma mark 获取管家列表接口
- (void)initRequest0WithTGSupplierTag:(TGSupplierTag *)tGSupplierTag se_temporaryEnterpriseName:(NSString *)se_temporaryEnterpriseName se_temporaryZoneStr:(NSString *)se_temporaryZoneStr{
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:[@1 integerValue]];
        postEntityBean.pager = pagerBean;
        
        EnterpriseRelation *enterpriseRelation = [[EnterpriseRelation alloc] init];
        
        postEntityBean.entity = enterpriseRelation.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_epRelation_trustRelationList parameters:dic success:^(id responseObjectModel) {
            ReturnEntityBean *model = responseObjectModel;
            NSDictionary *entity = model.entity;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                self->_arrayEnterpriseRelationModel = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *enterpriseRelations = entity[@"list"];
                for (NSDictionary *dic in enterpriseRelations) {
                    EnterpriseRelation *obj = [EnterpriseRelation mj_objectWithKeyValues:dic];
                    [self->_arrayEnterpriseRelationModel addObject:obj];
                }
                [self->_tableView reloadData];
                [self->_tableView.mj_header endRefreshing];
                if (enterpriseRelations.count != 0) {
                    if (enterpriseRelations.count < [pageSizeDYZ integerValue]) {
                        [self->_tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [self->_tableView.mj_footer endRefreshing];
                    }
                    self->_viewNoContent0.hidden = YES;
                } else {
                    [self->_tableView.mj_footer endRefreshingWithNoMoreData];
                    self->_viewNoContent0.hidden = NO;
                }
                self->_aPage = 2;
                self->_viewRequestTimeout.hidden = YES;
            }
        } fail:^(NSError *error) {
            self->_viewRequestTimeout.hidden = NO;
            [self->_tableView.mj_header endRefreshing];
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    }];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:self->_aPage];
        postEntityBean.pager = pagerBean;
        
        EnterpriseRelation *enterpriseRelation = [[EnterpriseRelation alloc] init];
        
        postEntityBean.entity = enterpriseRelation.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_epRelation_trustRelationList parameters:dic success:^(id responseObjectModel) {
            ReturnEntityBean *model = responseObjectModel;
            NSDictionary *entity = model.entity;
            
            if ([model.status isEqualToString:@"SUCCESS"]) {
                NSMutableArray *enterpriseRelations = entity[@"list"];
                for (NSDictionary *dic in enterpriseRelations) {
                    EnterpriseRelation *obj = [EnterpriseRelation mj_objectWithKeyValues:dic];
                    [self->_arrayEnterpriseRelationModel addObject:obj];
                }
                [self->_tableView reloadData];
                if (enterpriseRelations.count != 0) {
                    [self->_tableView.mj_footer endRefreshing];
                } else {
                    [self->_tableView.mj_footer endRefreshingWithNoMoreData];
                }
                self->_aPage++;
            }
            
        } fail:^(NSError *error) {
            [self->_tableView.mj_footer endRefreshing];
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    }];
    
}

#pragma mark 查询托管供应商标签
- (void)initRequestTgSupplierTagQuerytg {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    TGSupplierTag *tGSupplierTag = [[TGSupplierTag alloc] init];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    tGSupplierTag.manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    
    postEntityBean.entity = tGSupplierTag.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    
    [HttpMamager postRequestWithURLString:DYZ_tgSupplierTag_querytg parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            self.arrayTGSupplierTag = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *arrayTGSupplierTag = model.list;
            for (NSDictionary *dic in arrayTGSupplierTag) {
                TGSupplierTag *obj = [TGSupplierTag mj_objectWithKeyValues:dic];
                [self.arrayTGSupplierTag addObject:obj];
            }
        } else {
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}


#pragma mark CompanyViewControllerDelegate
- (void)notLoginExchangeViewController {
}
- (void)loginSuccess {
    self.tabBarController.selectedIndex = 2;
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
