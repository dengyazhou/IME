//
//  ECaiAddSupplierViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ECAddProjectViewController.h"
#import "VoHeader.h"
#import "ECAddProjectCell.h"


static NSInteger pageSize = 14;

@interface ECAddProjectViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate> {
//    NSMutableArray * _arrayEnterpriseInfoModel;
    NSMutableArray *_arrayPurchaseProjectModel;
    NSInteger _aPage;
    
    NSIndexPath *_indexPath;
    
    UIView *_viewNoContent;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UIButton *buttonCommit;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation ECAddProjectViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ECAddProjectCell" bundle:nil] forCellReuseIdentifier:@"eCAddProjectCell"];
    self.tableView.tableFooterView = [UIView new];
    
    _viewNoContent = [self viewNoContentWithTableView:self.tableView];
    [self.view addSubview:_viewNoContent];
    _viewNoContent.hidden = YES;
    
    [self initRequest];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayPurchaseProjectModel.count;
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ECAddProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eCAddProjectCell" forIndexPath:indexPath];
    PurchaseProject * purchaseProject = _arrayPurchaseProjectModel[indexPath.row];
    cell.lable.text = purchaseProject.projectName;
    if (_indexPath == indexPath) {
        [cell.button setImage:[UIImage imageNamed:@"label_agree"] forState:UIControlStateNormal];
    } else {
        [cell.button setImage:nil forState:UIControlStateNormal];
    }
    [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    return cell;
}

- (void)buttonClick:(UIButton *)sender{
    _indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    _indexPath = indexPath;
    [tableView reloadData];
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 0;
    } else {
        self.tableViewBottom.constant = rect.size.height;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (IBAction)left:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)right:(id)sender {
    if (!_indexPath) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择项目"];
        return;
    }
    
    PurchaseProject *purchaseProjectModel = _arrayPurchaseProjectModel[_indexPath.row];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    PurchaseProjectInfo *purchaseProjectInfo = [[PurchaseProjectInfo alloc] init];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    purchaseProjectInfo.manufacturerId = loginModel.manufacturerId;
    
    purchaseProjectInfo.projectId = purchaseProjectModel.purchaseProjectId;
    purchaseProjectInfo.inquiryOrderId = self.inquiryOrderId;
    purchaseProjectInfo.tradeOrderId = self.tradeOrderId;

    
    postEntityBean.entity = purchaseProjectInfo.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
//    NSLog(@"%@",dic);

    [HttpMamager postRequestWithURLString:DYZ_purchaseProject_bindInquiryToProject parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;

        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"添加成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"添加失败"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    
}

- (void)initRequest{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.isPurchase = [NSNumber numberWithInteger:1];
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:pageSize];
        pagerBean.page = [NSNumber numberWithInteger:[@1 integerValue]];
        postEntityBean.pager = pagerBean;
        
        PurchaseProject *purchaseProject = [[PurchaseProject alloc] init];
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        purchaseProject.manufacturerId = loginModel.manufacturerId;
        purchaseProject.purchasePorjectStatus = @"ING";
        
        postEntityBean.entity = purchaseProject.mj_keyValues;
        
        postEntityBean.memberId = loginModel.memberId;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        //NSLog(@"%@",dic);
        
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
                    if (arrayPurchaseProject.count < pageSize) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [self.tableView.mj_footer endRefreshing];
                    }
                    _viewNoContent.hidden = YES;
                } else {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    _viewNoContent.hidden = NO;
                    self.buttonCommit.hidden = YES;
                }
                _aPage = 2;
//                _viewRequestTimeout.hidden = YES;
                
            } else {
                
//                _viewRequestTimeout.hidden = NO;
                [self.tableView.mj_header endRefreshing];
                
            }
            
        } fail:^(NSError *error) {
//            _viewRequestTimeout.hidden = NO;
            [self.tableView.mj_header endRefreshing];
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.isPurchase = [NSNumber numberWithInteger:1];
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:pageSize];
        pagerBean.page = [NSNumber numberWithInteger:_aPage];
        postEntityBean.pager = pagerBean;
        
        PurchaseProject *purchaseProject = [[PurchaseProject alloc] init];
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        purchaseProject.manufacturerId = loginModel.manufacturerId;
        
        postEntityBean.entity = purchaseProject.mj_keyValues;
        
        postEntityBean.memberId = loginModel.memberId;
        
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
    UIView *view = [[UIView alloc] initWithFrame:tableView.frame];
    view.backgroundColor = colorRGB(241, 241, 241);
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ime_picture_consultation_empty"]];
    imageView.center = CGPointMake(kMainW/2, (kMainH-_height_NavBar-49)/2-50);
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
