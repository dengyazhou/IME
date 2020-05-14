//
//  ECProjectViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/1/3.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ECProjectViewController.h"
#import "VoHeader.h"

#import "ShouYeViewController.h"
#import "ProjectCell.h"

#import "AFNetworkReachabilityManager.h"

#import "ECProjectDetailViewController.h"



@interface ECProjectViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayPurchaseProjectModel;
    NSInteger _aPage;
    
    
    UIView *_viewNoContent;
    UIView *_viewRequestTimeout;
    UIView *_viewNoNet;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;



@end

@implementation ECProjectViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.estimatedRowHeight = 115;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectCell" bundle:nil] forCellReuseIdentifier:@"projectCell"];
    
    _viewNoContent = [self viewNoContentWithTableView:self.tableView];
    [self.view addSubview:_viewNoContent];
    _viewNoContent.hidden = YES;
    
    _viewRequestTimeout = [UIView addView:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar-Height_TabBar) withTitle:@"请求超时"];
    [self.view addSubview:_viewRequestTimeout];
    _viewRequestTimeout.hidden = YES;
    
    _viewNoNet = [UIView addView:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-_height_TabBar) imageNamed:@"ime_picture_network" title:@"网络不可用，请检查网络！"];
    [self.view addSubview:_viewNoNet];
    
    [self initRequest];
    
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 0) {
        _viewNoNet.hidden = NO;
    }
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 1 || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==2) {
        _viewNoNet.hidden = YES;
        [self.tableView.mj_header beginRefreshing];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrayPurchaseProjectModel.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"projectCell" forIndexPath:indexPath];
    PurchaseProject *purchaseProject = _arrayPurchaseProjectModel[indexPath.section];
    cell.purchaseProject = purchaseProject;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PurchaseProject *purchaseProject = _arrayPurchaseProjectModel[indexPath.section];
    ECProjectDetailViewController *vc = [[ECProjectDetailViewController alloc] init];
    vc.purchaseProject = purchaseProject;
    [self.navigationController pushViewController:vc animated:true];
    
    
}


- (IBAction)back:(id)sender {
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


- (void)requestData:(void (^)(id))dataBlock {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    PurchaseProject *purchaseProject = [[PurchaseProject alloc] init];
    postEntityBean.entity = purchaseProject.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_purchaseProject_getPurchaseProjectList parameters:dic success:^(id responseObjectModel) {
        dataBlock(responseObjectModel);
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}


- (void)initRequest{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:[@1 integerValue]];
        postEntityBean.pager = pagerBean;
        
        PurchaseProject *purchaseProject = [[PurchaseProject alloc] init];

        postEntityBean.entity = purchaseProject.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
 
        
        [HttpMamager postRequestWithURLString:DYZ_purchaseProject_getPurchaseProjectList parameters:dic success:^(id responseObjectModel) {
            
            ReturnListBean *model = responseObjectModel;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                _arrayPurchaseProjectModel = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *arrayPurchaseProject = model.list;
                for (NSDictionary *dic in arrayPurchaseProject) {
                    PurchaseProject *obj = [PurchaseProject mj_objectWithKeyValues:dic];
                    [_arrayPurchaseProjectModel addObject:obj];
                }
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                if (arrayPurchaseProject.count != 0) {
                    if (arrayPurchaseProject.count < [pageSizeDYZ integerValue]) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [self.tableView.mj_footer endRefreshing];
                    }
                    _viewNoContent.hidden = YES;
                } else {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    _viewNoContent.hidden = NO;
                }
                _aPage = 2;
                _viewRequestTimeout.hidden = YES;
             
            } else {
             
                _viewRequestTimeout.hidden = NO;
                [self.tableView.mj_header endRefreshing];
             
            }
          
        } fail:^(NSError *error) {
            _viewRequestTimeout.hidden = NO;
            [self.tableView.mj_header endRefreshing];
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:_aPage];
        postEntityBean.pager = pagerBean;
        
        PurchaseProject *purchaseProject = [[PurchaseProject alloc] init];
        
        postEntityBean.entity = purchaseProject.mj_keyValues;

        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        //NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_purchaseProject_getPurchaseProjectList parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *model = responseObjectModel;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                NSMutableArray *arrayPurchaseProject = model.list;
                for (NSDictionary *dic in arrayPurchaseProject) {
                    PurchaseProject *obj = [PurchaseProject mj_objectWithKeyValues:dic];
                    [_arrayPurchaseProjectModel addObject:obj];
                }
                [self.tableView reloadData];
                if (arrayPurchaseProject.count != 0) {
                    [self.tableView.mj_footer endRefreshing];
                } else {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                _aPage++;
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];

}

- (UIView *)viewNoContentWithTableView:(UITableView *)tableView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar-Height_TabBar)];
    view.backgroundColor = colorRGB(241, 241, 241);
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ime_picture_consultation_empty"]];
    imageView.center = CGPointMake(kMainW/2, (kMainH-_height_NavBar-_height_TabBar)/2-50);
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, kMainW, 21);
    label.center = CGPointMake(kMainW/2,  CGRectGetMaxY(imageView.frame)+CGRectGetHeight(label.frame)/2.0);
    label.text = @"无内容";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = colorRGB(32, 32, 32);
    [view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.bounds = CGRectMake(0, 0, kMainW, 21);
    label1.center = CGPointMake(kMainW/2, CGRectGetMaxY(label.frame)+CGRectGetHeight(label1.frame)/2.0);
    label1.text = @"您需要去电脑端添加项目";
    label1.font = [UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = colorRGB(117, 117, 117);
    [view addSubview:label1];
    
    return view;
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
