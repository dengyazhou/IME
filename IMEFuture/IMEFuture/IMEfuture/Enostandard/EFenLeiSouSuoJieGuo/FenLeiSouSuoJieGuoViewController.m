//
//  FenLeiSouSuoJieGuoViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/6.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "FenLeiSouSuoJieGuoViewController.h"
#import "VoHeader.h"


#import "XunPanCell.h"
#import "XunPanXiangQingViewController.h"

#import "AFNetworkReachabilityManager.h"


#import "CompanyViewController.h"



@interface FenLeiSouSuoJieGuoViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayInquiryOrderModel;
    NSInteger _aPage;
    UIView *_viewNoNet;
    UIView *_viewNoContent;
}

@end

@implementation FenLeiSouSuoJieGuoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    
    [self initRequest];
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 0) {
        _viewNoNet.hidden = NO;
    }
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 1 || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==2) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)initRequest {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
        
        postEntityBean.isPurchase = [NSNumber numberWithInteger:0];
        
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        inquiryOrder.se_enterpriseOrderCode = self.stringSearchContent;


        postEntityBean.entity = inquiryOrder.mj_keyValues;
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:[@1 integerValue]];
        postEntityBean.pager = pagerBean;
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        postEntityBean.memberId = loginModel.memberId;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
         NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_inquiry_supplier_list parameters:dic success:^(id responseObjectModel) {
            
            ReturnListBean *model = responseObjectModel;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                _arrayInquiryOrderModel = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *arrayInquiryOrder = model.list;
                for (NSDictionary *dic in arrayInquiryOrder) {
                    InquiryOrder *obj = [InquiryOrder mj_objectWithKeyValues:dic];
                    [_arrayInquiryOrderModel addObject:obj];
                }
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                if (_arrayInquiryOrderModel.count != 0) {
                    [self.tableView.mj_footer endRefreshing];
                    _viewNoContent.hidden = YES;
                } else {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    _viewNoContent.hidden = NO;
                }
                _aPage = 2;
            } else {
                
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
        
        postEntityBean.isPurchase = [NSNumber numberWithInteger:0];
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        inquiryOrder.se_enterpriseOrderCode = self.stringSearchContent;

        
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:_aPage];
        postEntityBean.pager = pagerBean;
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        postEntityBean.memberId = loginModel.memberId;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_inquiry_supplier_list parameters:dic success:^(id responseObjectModel) {
            
            ReturnListBean *model = responseObjectModel;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                NSMutableArray *arrayInquiryOrder = model.list;
                for (NSDictionary *dic in arrayInquiryOrder) {
                    InquiryOrder *obj = [InquiryOrder mj_objectWithKeyValues:dic];
                    [_arrayInquiryOrderModel addObject:obj];
                }
                NSLog(@"%ld",_arrayInquiryOrderModel.count);
                [self.tableView reloadData];
                if (arrayInquiryOrder.count != 0) {
                    [self.tableView.mj_footer endRefreshing];
                } else {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                _aPage++;
            } else {
                
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
        
    }];
}

- (void)initUI {
    [self line];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 22, 22)];
    imageView.image = [UIImage imageNamed:@"ime_icon_search_2t"];
    [self.buttonSearch addSubview:imageView];
    
    UILabel *labelSearch = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, 7, 150, 14)];
    labelSearch.text = self.stringSearchContent;
    labelSearch.font = [UIFont systemFontOfSize:14];
    labelSearch.textColor = colorRGB(117, 117, 117);
    [self.buttonSearch addSubview:labelSearch];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"XunPanCell" bundle:nil] forCellReuseIdentifier:@"xpCell"];
    self.tableView.tableFooterView = [UIView new];
    
    _viewNoNet = [UIView addNoNetWith:CGRectMake(0, 64, kMainW, kMainH-64)];
    [self.view addSubview:_viewNoNet];
    _viewNoNet.hidden = YES;
    
    _viewNoContent = [UIView addNoContent:CGRectMake(0, 64, kMainW, kMainH-64)];
    [self.view addSubview:_viewNoContent];
    _viewNoContent.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayInquiryOrderModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XunPanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xpCell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        if (view.tag == 456) {
            [view removeFromSuperview];
        }
    }
    
    InquiryOrder *model = _arrayInquiryOrderModel[indexPath.row];
    cell.inquiryOrder = model;
    
    InquiryOrderItem *modelInquiryOrderItem = model.inquiryOrderItems[0];
    
    if ([modelInquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
        [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:modelInquiryOrderItem.sec_thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
    } else {
        
        NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,model.member.enterpriseInfo.enterpriseId,modelInquiryOrderItem.partNumber,modelInquiryOrderItem.picVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
    }

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
    if (!stringPsw) {//没取到密码 请先登录登录
        CompanyViewController *companyVC = [[CompanyViewController alloc] init];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:companyVC] animated:YES completion:nil];
    } else {
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        if ([loginModel.userType isEqualToString:@"NORMAL"]) {
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"个人用户无法使用该功能，\r\n请注册企业用户！" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [ac addAction:action];
            [self presentViewController:ac animated:YES completion:nil];
        }
        if ([loginModel.userType isEqualToString:@"ENTERPRISE"]) {
            InquiryOrder *inquiryOrderModel = _arrayInquiryOrderModel[indexPath.row];
            if ([loginModel.manufacturerId isEqualToString:inquiryOrderModel.manufacturerId]) {//采购商看询盘单
                XunPanXiangQingViewController *vc = [[XunPanXiangQingViewController alloc] init];
                vc.inquiryOrderId = inquiryOrderModel.inquiryOrderId;
                vc.isDefaultPurchase = DefaultSupplier;
                [self.navigationController pushViewController:vc animated:YES];
            } else {//供应商看询盘单
                XunPanXiangQingViewController *vc = [[XunPanXiangQingViewController alloc] init];
                vc.inquiryOrderId = inquiryOrderModel.inquiryOrderId;
                vc.isDefaultPurchase = DefaultSupplier;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)line {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, kMainW, 0.5)];
    label.backgroundColor = colorLine;
    [self.view addSubview:label];
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
