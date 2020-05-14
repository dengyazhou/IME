//
//  HYJXuanZeGYSVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/2/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "HYJXuanZeGYSVC.h"
#import "VoHeader.h"

#import "XZGongYingShangCell.h"

#import "Masonry.h"
#import "ECAddSupplierVC.h"

@interface HYJXuanZeGYSVC () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView0;
    
    NSMutableArray *_arrayEnterpriseRelation0;
    
    NSMutableArray *_arrayEnterpriseInfo012;//总数组
    
    UIView *_viewNoContent0;
    UIView *_viewLoading;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTabBar;

@property (nonatomic, assign) NSInteger page;

@end

@implementation HYJXuanZeGYSVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView0.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    self.heightTabBar.constant = _height_TabBar;
    
    if (self.arrayTempEnterpriseRelation.count > 0) {
        
    } else {
        self.arrayTempEnterpriseRelation = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    _arrayEnterpriseInfo012 = [NSMutableArray arrayWithCapacity:0];
    
    self.scrollView.contentSize = CGSizeMake(kMainW, kMainH-_height_NavBar-_height_TabBar-10);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = NO;
    
    _tableView0 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH-_height_NavBar-_height_TabBar-10) style:UITableViewStylePlain];
    _tableView0.delegate = self;
    _tableView0.dataSource = self;
    _tableView0.tag = 200;
    _tableView0.backgroundColor = [UIColor clearColor];
    [_tableView0 registerNib:[UINib nibWithNibName:@"XZGongYingShangCell" bundle:nil] forCellReuseIdentifier:@"xZGongYingShangCell"];
    _tableView0.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView0.tableFooterView = [UIView new];
    _tableView0.tableHeaderView = [self tableViewHeaderView];
    [self.scrollView addSubview:_tableView0];
    
    _viewNoContent0 = [UIView addViewNoNetWithScrollView:self.scrollView tableView:_tableView0 imageNamed:@"null" labelText:@"暂无数据"];
    _viewNoContent0.hidden = YES;
    [_viewNoContent0 addSubview:[self tableViewHeaderView]];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    [self initRequest0];
}

- (UIView *)tableViewHeaderView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 44)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_supplier"]];
    [view addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.left.mas_equalTo(15);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"新增管家供应商";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = colorRGB(32, 32, 32);
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.left.mas_equalTo(42);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kMainW, 44);
    [button addTarget:self action:@selector(buttonClickXinZengTuoGuanGongYingShang:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIView *viewLineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 0.5)];
    viewLineTop.backgroundColor = colorRGB(221, 221, 221);
    [view addSubview:viewLineTop];
    
    return view;;
}

#pragma mark 新增管家供应商
- (void)buttonClickXinZengTuoGuanGongYingShang:(UIButton *)sender {
    ECAddSupplierVC *eCAddSupplierVC = [[ECAddSupplierVC alloc] init];
    [self.navigationController pushViewController:eCAddSupplierVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayEnterpriseRelation0.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EnterpriseRelation *enterpriseRelation = _arrayEnterpriseRelation0[indexPath.row];
    
    XZGongYingShangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xZGongYingShangCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.viewLineTop.hidden = YES;
    cell.viewLineBottomLeading.constant = 15;
    cell.imageView2.hidden = YES;
    if (indexPath.row == 0) {
        cell.viewLineTop.hidden = NO;
    }
    if (indexPath.row == _arrayEnterpriseRelation0.count-1) {
        cell.viewLineBottomLeading.constant = 0;
    }
    
    if ([enterpriseRelation.passiveEnterprise.isTemporary integerValue] == 1) {//临时用户
        cell.imageView2.hidden = NO;
    } else {
        cell.imageView2.hidden = YES;
    }
    
    cell.label0.text = enterpriseRelation.passiveEnterpriseName;
    NSString *stringProvinceCity = [NSString stringWithFormat:@"%@ %@",enterpriseRelation.passiveEnterprise.province?enterpriseRelation.passiveEnterprise.province:@"",enterpriseRelation.passiveEnterprise.city?enterpriseRelation.passiveEnterprise.city:@""];
    cell.label1.text = ![stringProvinceCity isEqualToString:@" "]?stringProvinceCity:@"--";
    [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:enterpriseRelation.passiveEnterprise.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
    
    BOOL isNoSelect = NO;
    for (EnterpriseRelation *enterprise in self.arrayTempEnterpriseRelation) {
        if ([enterpriseRelation.passiveId isEqualToString:enterprise.passiveId]) {
            isNoSelect = YES;
        }
    }
    
    if (isNoSelect == NO) {
        cell.imageView0.image = [UIImage imageNamed:@"multiselect_unchecked"];
    } else {
        cell.imageView0.image = [UIImage imageNamed:@"multiselect_selected"];
    }
    return cell;
}

#pragma mark 确定
- (IBAction)buttonQueRen:(id)sender {
    self.buttonBackBlock(self.arrayTempEnterpriseRelation);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isNoSelect = NO;
    NSInteger index = 999;//随便取的默认值
    
    EnterpriseRelation *enterpriseRelation = _arrayEnterpriseRelation0[indexPath.row];

    for (NSInteger i = 0; i < self.arrayTempEnterpriseRelation.count; i++) {
        EnterpriseRelation *enterprise = self.arrayTempEnterpriseRelation[i];
        if ([enterpriseRelation.passiveId isEqualToString:enterprise.passiveId]) {
            isNoSelect = YES;
            index = i;
        }
    }
    
    if (isNoSelect == NO) {
        if (self.arrayTempEnterpriseRelation.count >= 1) {
            [self.arrayTempEnterpriseRelation replaceObjectAtIndex:0 withObject:enterpriseRelation];
        } else {
            [self.arrayTempEnterpriseRelation addObject:enterpriseRelation];
        }
    } else {
        [self.arrayTempEnterpriseRelation removeObjectAtIndex:index];
    }
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [tableView reloadData];
}


#pragma mark 获取管家列表接口
- (void)initRequest0 {
    _tableView0.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:EFeiBiaoToken];
        
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
            self->_viewLoading.hidden = YES;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                self->_arrayEnterpriseRelation0 = [[NSMutableArray alloc] init];
                NSMutableArray *enterpriseRelations = entity[@"list"];
                for (NSDictionary *dic in enterpriseRelations) {
                    EnterpriseRelation *enterpriseRelation = [EnterpriseRelation mj_objectWithKeyValues:dic];
                    [self->_arrayEnterpriseRelation0 addObject:enterpriseRelation];
                    
                    BOOL isNo = NO;//_arrayEnterpriseInfo012中没有
                    for (EnterpriseRelation *enterpriseRelation0123 in self->_arrayEnterpriseInfo012) {
                        if ([enterpriseRelation.passiveId isEqualToString:enterpriseRelation0123.passiveId]) {
                            isNo = YES;
                            break;
                        }
                    }
                    if (isNo == NO) {
                        [self->_arrayEnterpriseInfo012 addObject:enterpriseRelation];
                    }
                }
                
                [self->_tableView0 reloadData];
                [self->_tableView0.mj_header endRefreshing];
                if (enterpriseRelations.count != 0) {
                    if (enterpriseRelations.count < [pageSizeDYZ integerValue]) {
                        [self->_tableView0.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [self->_tableView0.mj_footer endRefreshing];
                    }
                    self->_viewNoContent0.hidden = YES;
                } else {
                    [self->_tableView0.mj_footer endRefreshingWithNoMoreData];
                    self->_viewNoContent0.hidden = NO;
                }
                self.page = 2;
                
            }
        } fail:^(NSError *error) {
            [self->_tableView0.mj_header endRefreshing];
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    }];
    
    _tableView0.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:EFeiBiaoToken];
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:self.page];
        postEntityBean.pager = pagerBean;
        
        EnterpriseRelation *enterpriseRelation = [[EnterpriseRelation alloc] init];
        
        
        
        postEntityBean.entity = enterpriseRelation.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_epRelation_trustRelationList parameters:dic success:^(id responseObjectModel) {
            ReturnEntityBean *model = responseObjectModel;
            NSDictionary *entity = model.entity;
            self->_viewLoading.hidden = YES;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                NSMutableArray *enterpriseRelations = entity[@"list"];
                for (NSDictionary *dic in enterpriseRelations) {
                    EnterpriseRelation *enterpriseRelation = [EnterpriseRelation mj_objectWithKeyValues:dic];
                    [self->_arrayEnterpriseRelation0 addObject:enterpriseRelation];
                    
                    BOOL isNo = NO;//_arrayEnterpriseInfo012中没有
                    for (EnterpriseRelation *enterpriseRelation0123 in self->_arrayEnterpriseInfo012) {
                        if ([enterpriseRelation.passiveId isEqualToString:enterpriseRelation0123.passiveId]) {
                            isNo = YES;
                            break;
                        }
                    }
                    if (isNo == NO) {
                        [self->_arrayEnterpriseInfo012 addObject:enterpriseRelation];
                    }
                }
                
                [self->_tableView0 reloadData];
    
                if (enterpriseRelations.count != 0) {
                    [self->_tableView0.mj_footer endRefreshing];
                } else {
                    [self->_tableView0.mj_footer endRefreshingWithNoMoreData];
                
                }
                self.page++;
            }
        } fail:^(NSError *error) {
            [self->_tableView0.mj_footer endRefreshing];
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    }];
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
