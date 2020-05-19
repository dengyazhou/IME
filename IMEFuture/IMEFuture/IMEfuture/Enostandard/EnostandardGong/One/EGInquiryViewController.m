//
//  EGInquiryViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "EGInquiryViewController.h"
#import "VoHeader.h"

#import "XunPanXiangQingViewController.h"
#import "FenLeiSouSuoViewController.h"
#import "ShaiXuanBaoJiaViewController.h"
#import "AFNetworkReachabilityManager.h"

#import "ShouYeViewController.h"

#import "EGInquiryCell.h"
#import "BaoJiaViewController.h"
#import "ChaKanZiJiDeBaoJiaViewController.h"
#import "EGYiJiaViewController.h"
#import "EGOrderViewController.h"

#import "RefreshManager.h"
#import "GlobalSettingManager.h"



@interface EGInquiryViewController () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    NSArray *_arrayButton;
    
    UITableView *_tableView0;
    UITableView *_tableView1;
    UITableView *_tableView2;
    
    NSMutableArray *_arrayInquiryOrderModel;
    
    NSInteger _aPage;
    
    NSInteger _indexInquiryType;
    
    UIView *_viewNoContent0;
    UIView *_viewNoContent1;
    UIView *_viewNoContent2;

    UIView *_viewRequestTimeout;
    
    
    UIView *_viewNoNet;
    
    NSMutableArray *_arrayButtonUp;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;

}

@property (weak, nonatomic) IBOutlet UILabel *labelLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLineCenterX;
@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) NSIndexPath *indexPathIME;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;



@end

@implementation EGInquiryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    
    RefreshManager *fManager = [RefreshManager shareRefreshManager];
    [fManager addObserver:self forKeyPath:@"eGInquiryVC" options:NSKeyValueObservingOptionOld context:@"RefreshManager_eGInquiryVC"];
    
    [self initUI];

    [self initRequestWithTableView:_tableView0 WithRecommendTypeArray:@[@0,@2,@4,@5,@6,@8] WithNoContentView:_viewNoContent0];
    [self initRequestWithTableView:_tableView1 WithRecommendTypeArray:@[@8] WithNoContentView:_viewNoContent1];
    [self initRequestWithTableView:_tableView2 WithNoContentView:_viewNoContent2];
    
    _indexInquiryType = 0;
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 0) {
        _viewNoNet.hidden = NO;
    }
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 1 || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==2) {
        _viewNoNet.hidden = YES;
        
        if (_indexInquiryType == 0) {
            [_tableView0.mj_header beginRefreshing];
        }
        if (_indexInquiryType == 1) {
            [_tableView1.mj_header beginRefreshing];
        }
        if (_indexInquiryType == 2) {
            [_tableView2.mj_header beginRefreshing];
        }
    }

}

- (void)dealloc {
    [[RefreshManager shareRefreshManager] removeObserver:self forKeyPath:@"eGInquiryVC"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == @"RefreshManager_eGInquiryVC") {
        if ([keyPath isEqualToString:@"eGInquiryVC"]) {
            [self kVORefresh];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)kVORefresh {
    if (!_indexInquiryType) {
        _indexInquiryType = 0;
    }
    UITableView *tableView;
    if (_indexInquiryType == 0) {
        tableView = _tableView0;
    } else if (_indexInquiryType == 1) {
        tableView = _tableView1;
    } else if (_indexInquiryType == 2) {
        tableView = _tableView2;
    }
    [self upDateArrayInquiryOrderModel:tableView withIndexPath:self.indexPathIME];
}

- (void)initUI {
    _arrayButton = @[_button0,_button1,_button2];
    for (int i = 0; i < _arrayButton.count; i++) {
        UIButton *button = _arrayButton[i];
        button.tag = 100+i;
    }
    
    self.scrollView.delegate = self;
    self.scrollView.tag = 500;
    self.scrollView.contentSize = CGSizeMake(kMainW*_arrayButton.count, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.backgroundColor = colorBG;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    
    _tableView0 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH-_height_NavBar-42.5-_height_TabBar) style:UITableViewStyleGrouped];
    _tableView0.delegate = self;
    _tableView0.dataSource = self;
    _tableView0.tag = 200;
    _tableView0.backgroundColor = [UIColor clearColor];
    [_tableView0 registerNib:[UINib nibWithNibName:@"EGInquiryCell" bundle:nil] forCellReuseIdentifier:@"eGInquiryCell"];
    _tableView0.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView0.tableFooterView = [UIView new];
    _tableView0.estimatedRowHeight = 226.5;
    _tableView0.rowHeight = UITableViewAutomaticDimension;
    [self.scrollView addSubview:_tableView0];
    _viewNoContent0 = [UIView addViewNoNetWithScrollView:self.scrollView tableView:_tableView0 imageNamed:@"ime_picture_inquiry_empty" label0Text:@"无内容" label1Text:@"暂时没有全部询盘"];
    _viewNoContent0.hidden = YES;
    
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(kMainW, 0, kMainW, kMainH-_height_NavBar-42.5-_height_TabBar) style:UITableViewStyleGrouped];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.tag = 201;
    _tableView1.backgroundColor = [UIColor clearColor];
    [_tableView1 registerNib:[UINib nibWithNibName:@"EGInquiryCell" bundle:nil] forCellReuseIdentifier:@"eGInquiryCell"];
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView1.tableFooterView = [UIView new];
    _tableView1.estimatedRowHeight = 226.5;
    _tableView1.rowHeight = UITableViewAutomaticDimension;
    [self.scrollView addSubview:_tableView1];
    _viewNoContent1 = [UIView addViewNoNetWithScrollView:self.scrollView tableView:_tableView1 imageNamed:@"ime_picture_inquiry_empty" label0Text:@"无内容" label1Text:@"暂时没有全部询盘"];
    _viewNoContent1.hidden = YES;
    
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(kMainW*2, 0, kMainW, kMainH-_height_NavBar-42.5-_height_TabBar) style:UITableViewStyleGrouped];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.tag = 202;
    _tableView2.backgroundColor = [UIColor clearColor];
    [_tableView2 registerNib:[UINib nibWithNibName:@"EGInquiryCell" bundle:nil] forCellReuseIdentifier:@"eGInquiryCell"];
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.tableFooterView = [UIView new];
    _tableView2.estimatedRowHeight = 226.5;
    _tableView2.rowHeight = UITableViewAutomaticDimension;
    [self.scrollView addSubview:_tableView2];
    _viewNoContent2 = [UIView addViewNoNetWithScrollView:self.scrollView tableView:_tableView2 imageNamed:@"ime_picture_inquiry_empty" label0Text:@"无内容" label1Text:@"暂时没有全部询盘"];
    _viewNoContent2.hidden = YES;
    
    _arrayButtonUp = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.frame = CGRectMake(kMainW - 60+kMainW*i, kMainH-_height_NavBar-42.5-_height_TabBar-60, 0, 0);
        [button setImage:[UIImage imageNamed:@"icon_top"] forState:UIControlStateNormal];
        [button sizeToFit];
        [button addTarget:self action:@selector(buttonClickStick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        button.hidden = YES;
        [_arrayButtonUp addObject:button];
    }
    
    _viewRequestTimeout = [UIView addView:CGRectMake(0, _height_NavBar + 42.5, kMainW, kMainH-_height_NavBar-42.5-_height_TabBar) withTitle:@"请求超时"];
    [self.view addSubview:_viewRequestTimeout];
    _viewRequestTimeout.hidden = YES;
    
    _viewNoNet = [UIView addView:CGRectMake(0, _height_NavBar + 42.5, kMainW, kMainH-_height_NavBar-42.5-_height_TabBar) imageNamed:@"ime_picture_network" title:@"网络不可用，请检查网络！"];
    [self.view addSubview:_viewNoNet];
    
}

- (void)buttonClickStick:(UIButton *)sender {
    if (sender.tag == 0) {
        [_tableView0 setContentOffset:CGPointZero animated:YES];
    }
    if (sender.tag == 1) {
        [_tableView1 setContentOffset:CGPointZero animated:YES];
    }
    if (sender.tag == 2) {
        [_tableView2 setContentOffset:CGPointZero animated:YES];
    }
}


- (IBAction)buttonClick:(UIButton *)sender {
    [self.scrollView setContentOffset:CGPointMake((sender.tag-100)*kMainW, 0)];
    
    _indexInquiryType = sender.tag - 100;
    
    _arrayInquiryOrderModel = nil;
    if (sender.tag == 100) {
        [_tableView0 reloadData];
        [_tableView0.mj_header beginRefreshing];
    }
    if (sender.tag == 101) {
        [_tableView1 reloadData];
        [_tableView1.mj_header beginRefreshing];
    }
    if (sender.tag == 102) {
        [_tableView2 reloadData];
        [_tableView2.mj_header beginRefreshing];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 500) {
        int x = scrollView.contentOffset.x;
        NSInteger index;
        if (x < kMainW/2) {
            index = 100;
        } else if (x < kMainW/2*3) {
            index = 101;
        } else if (x < kMainW/2*5) {
            index = 102;
        } else if (x < kMainW/2*7) {
            index = 103;
        } else {
            index = 104;
        }
        
        _indexInquiryType = index - 100;
        
        if (index == 100) {
            [_tableView0.mj_header beginRefreshing];
        }
        if (index == 101) {
            [_tableView1.mj_header beginRefreshing];
        }
        if (index == 102) {
            [_tableView2.mj_header beginRefreshing];
        }
    } else {
        UIButton *button = _arrayButtonUp[scrollView.tag-200];
        if (scrollView.contentOffset.y > scrollView.bounds.size.height*2) {
            button.hidden = NO;
        } else {
            button.hidden = YES;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 500) {
        int x = scrollView.contentOffset.x;
        NSInteger index;
        if (x < kMainW/2) {
            index = 0;
        } else if (x < kMainW/2*3) {
            index = 1;
        } else if (x < kMainW/2*5) {
            index = 2;
        } else if (x < kMainW/2*7) {
            index = 3;
        } else {
            index = 4;
        }

        UIButton *but0 = [_arrayButton firstObject];
        UIButton *but = _arrayButton[index];
        self.labelLineCenterX.constant = 0;
        if (index==2) {
            self.labelLineCenterX.constant = (CGRectGetWidth(but.frame)-CGRectGetWidth(but0.frame))/2+CGRectGetWidth(but0.frame)*4;
        } else {
            self.labelLineCenterX.constant = CGRectGetWidth(but.frame)*index;
        }
        for (int i = 0; i < _arrayButton.count; i++) {
            UIButton *but = _arrayButton[i];
            if (index == i) {
                [but setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
            } else {
                [but setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
            }
        }
    } else {
        UIButton *button = _arrayButtonUp[scrollView.tag-200];
        button.hidden = YES;
    }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrayInquiryOrderModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EGInquiryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eGInquiryCell" forIndexPath:indexPath];
    InquiryOrder *inquiryOrderModel = _arrayInquiryOrderModel[indexPath.section];
    
    [cell initDataWith:inquiryOrderModel andQuanXian:nil];
    
    [cell.buttonL addTarget:self action:@selector(buttonClickInquiryOrder:) forControlEvents:UIControlEventTouchUpInside];
    [cell.buttonR addTarget:self action:@selector(buttonClickInquiryOrder:) forControlEvents:UIControlEventTouchUpInside];
    cell.buttonL.tag = indexPath.section;
    cell.buttonR.tag = indexPath.section;
    
    return cell;
}

- (void)buttonClickInquiryOrder:(UIButton *)sender {
    self.indexPathIME = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    InquiryOrder *inquiryOrderModel = _arrayInquiryOrderModel[sender.tag];
#pragma mark ----------供应商----------
    NSInteger shoupan = 0;
    if ([inquiryOrderModel.inquiryType isEqualToString:@"COM"] || [inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
        for (InquiryOrderItem *item in inquiryOrderModel.inquiryOrderItems) {
            if ([item.inquiryOrderItemStatus isEqualToString:@"SEND"]) {
                if (![item.sendManufacturerId isEqualToString:loginModel.enterpriseId]) {
                    item.inquiryOrderItemStatusDesc = @"授单他人";
                } else {
                    shoupan++;
                }
            }
        }
    }
    
    if ([inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
        //ATG 标准
        if ([inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"NEW"]) {
            //未报价
#pragma mark 立即报价
            BaoJiaViewController *bjVC = [[BaoJiaViewController alloc] init];
            bjVC.inquiryOrderId = inquiryOrderModel.inquiryOrderId;
            [self.navigationController pushViewController:bjVC animated:YES];
        } else if ([inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"QUOTATION"]) {
            //已报价
            if (shoupan>0) {
#pragma mark 查看报价
                if ([sender.currentTitle isEqualToString:@"查看报价"]) {
                    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:82]]) {
                        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
                        return;
                    }
                    ChaKanZiJiDeBaoJiaViewController *vc = [[ChaKanZiJiDeBaoJiaViewController alloc] init];
                    vc.inquiryOrder = inquiryOrderModel;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
#pragma mark 查看订单
                if ([sender.currentTitle isEqualToString:@"查看订单"]) {
                    [self goSupplierTradeOrderListWithEnterpriseOrderCode:inquiryOrderModel.enterpriseOrderCode];
                }
            } else {
#pragma mark 查看报价
                if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:82]]) {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
                    return;
                }
                ChaKanZiJiDeBaoJiaViewController *vc = [[ChaKanZiJiDeBaoJiaViewController alloc] init];
                vc.inquiryOrder = inquiryOrderModel;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        } else if ([inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SEND"]) {
            //已授单
#pragma mark 查看订单
            [self goSupplierTradeOrderListWithEnterpriseOrderCode:inquiryOrderModel.enterpriseOrderCode];
            
        } else if ([inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"REFUSE"]) {
            //已拒绝
            
        } else if ([inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SENDOTHER"]) {
            //授单他人
            
        } else if ([inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"CANCEL"]) {
            //询盘取消
            
        }
        
    } else if ([inquiryOrderModel.inquiryType isEqualToString:@"COM"]) {
        //COM 寻源
        if ([inquiryOrderModel.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
            //询盘取消
            
        } else if ([inquiryOrderModel.inquiryOrderStatus isEqualToString:@"REFUSE"]) {
            //拒绝报价
            
        } else if ([inquiryOrderModel.inquiryOrderStatus isEqualToString:@"SEND"]) {
            if (shoupan>0) {
                
            } else {
                
            }
        } else {
            if (inquiryOrderModel.inquiryOrderEnterprises == nil || inquiryOrderModel.inquiryOrderEnterprises.count == 0) {
#pragma mark 立即报价
                BaoJiaViewController *bjVC = [[BaoJiaViewController alloc] init];
                bjVC.inquiryOrderId = inquiryOrderModel.inquiryOrderId;
                [self.navigationController pushViewController:bjVC animated:YES];
            } else if ([inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"QUOTATION"]) {
                if (shoupan>0) {
#pragma mark 查看报价
                    if ([sender.currentTitle isEqualToString:@"查看报价"]) {
                        if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:82]]) {
                            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
                            return;
                        }
                        ChaKanZiJiDeBaoJiaViewController *vc = [[ChaKanZiJiDeBaoJiaViewController alloc] init];
                        vc.inquiryOrder = inquiryOrderModel;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
#pragma mark 查看订单
                    if ([sender.currentTitle isEqualToString:@"查看订单"]) {
                        [self goSupplierTradeOrderListWithEnterpriseOrderCode:inquiryOrderModel.enterpriseOrderCode];
                    }
                } else {
#pragma mark 查看报价
                    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:82]]) {
                        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
                        return;
                    }
                    ChaKanZiJiDeBaoJiaViewController *vc = [[ChaKanZiJiDeBaoJiaViewController alloc] init];
                    vc.inquiryOrder = inquiryOrderModel;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            } else if ([inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SEND"]) {
                if (shoupan>0) {
#pragma mark 查看订单
                    [self goSupplierTradeOrderListWithEnterpriseOrderCode:inquiryOrderModel.enterpriseOrderCode];
                }
            }
        }
        
    } else if ([inquiryOrderModel.inquiryType isEqualToString:@"TTG"]) {
        //TTG 议价
        if ([inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SEND"]) {
            if (inquiryOrderModel.inquiryOrderEnterprises[0].canEditPrice.integerValue == 0) {
#pragma mark 查看订单
                [self goSupplierTradeOrderListWithEnterpriseOrderCode:inquiryOrderModel.enterpriseOrderCode];
            } else {
                if (inquiryOrderModel.inquiryOrderEnterprises[0].supplierHasQuoed.integerValue == 1) {
#pragma mark 查看订单
                    if ([sender.currentTitle isEqualToString:@"查看订单"]) {
                        [self goSupplierTradeOrderListWithEnterpriseOrderCode:inquiryOrderModel.enterpriseOrderCode];
                    }
#pragma mark 修改报价
                    if ([sender.currentTitle isEqualToString:@"修改报价"]) {
                        EGYiJiaViewController *vc = [[EGYiJiaViewController alloc] init];
                        vc.inquiryOrderId = inquiryOrderModel.inquiryOrderId;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                } else {
#pragma mark 查看订单
                    if ([sender.currentTitle isEqualToString:@"查看订单"]) {
                        [self goSupplierTradeOrderListWithEnterpriseOrderCode:inquiryOrderModel.enterpriseOrderCode];
                    }
#pragma mark 立即报价
                    if ([sender.currentTitle isEqualToString:@"立即报价"]) {
                        EGYiJiaViewController *vc = [[EGYiJiaViewController alloc] init];
                        vc.inquiryOrderId = inquiryOrderModel.inquiryOrderId;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }
            }
        } else if ([inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"CANCEL"]) {
            
        }
    } else if ([inquiryOrderModel.inquiryType isEqualToString:@"FTG"]) {
        //FTG 指定
        if ([inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SEND"]) {
#pragma mark 查看订单
            [self goSupplierTradeOrderListWithEnterpriseOrderCode:inquiryOrderModel.enterpriseOrderCode];
        } else if ([inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"CANCEL"]) {
            
        }
    }
}

- (void)goSupplierTradeOrderListWithEnterpriseOrderCode:(NSString *)enterpriseOrderCode {
    EGOrderViewController *vc = [[EGOrderViewController alloc] init];
    vc.se_enterpriseOrderCode = enterpriseOrderCode;
    [self.navigationController pushViewController:vc animated:true];
}


//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    EGInquiryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"eGInquiryCollectionViewCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
//
//    for (UIView *view in cell.contentView.subviews) {
//        if (view.tag == 456) {
//            [view removeFromSuperview];
//        }
//    }
//
//    InquiryOrder *inquiryOrderModel = _arrayInquiryOrderModel[indexPath.row];
//
//    cell.inquiryOrderCodeAndTitle.text = [NSString stringWithFormat:@"询盘号：%@",inquiryOrderModel.enterpriseOrderCode?inquiryOrderModel.enterpriseOrderCode:@"--"];
//
//    cell.imageWidth.constant = 32.5;
//    if ([inquiryOrderModel.inquiryType isEqualToString:@"COM"]) {
//        cell.imageViewType.hidden = YES;
//        cell.distanceTitle.constant = 10;
//    }
//    if ([inquiryOrderModel.inquiryType isEqualToString:@"DIR"]) {
//        cell.imageViewType.hidden = NO;
//        cell.distanceTitle.constant = 50;
//        cell.imageViewType.image = [UIImage imageNamed:@"label_directional"];
//    }
//    if ([inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
//        cell.imageViewType.hidden = NO;
//        cell.distanceTitle.constant = 50;
//        cell.imageViewType.image = [UIImage imageNamed:@"label_housekeeper"];
//    }
//    if ([inquiryOrderModel.inquiryType isEqualToString:@"FTG"]) {
//        cell.imageViewType.hidden = NO;
//        cell.distanceTitle.constant = 50;
//        cell.imageViewType.image = [UIImage imageNamed:@"label_price"];
//        cell.imageWidth.constant = 44.5;
//    }
//    if ([inquiryOrderModel.inquiryType isEqualToString:@"TTG"]) {
//        cell.imageViewType.hidden = NO;
//        cell.distanceTitle.constant = 50;
//        cell.imageViewType.image = [UIImage imageNamed:@"label_bargaining"];
//        cell.imageWidth.constant = 44.5;
//    }
//
//    InquiryOrderItem *modelInquiryOrderItem = inquiryOrderModel.inquiryOrderItems[0];
////    NSArray *arrayTags = [modelInquiryOrderItem.tags componentsSeparatedByString:@"."];
//
//    NSArray *arrayTags = [inquiryOrderModel.tags componentsSeparatedByString:@"."];
//    NSMutableArray *arrayTags1 = [[NSMutableArray alloc] initWithCapacity:0];
//    for (NSString *string in arrayTags) {
//        if (![string isEqualToString:@""]) {
//            [arrayTags1 addObject:string];
//        }
//    }
//    NSString *stringTag;
//    for (int i = 0; i < arrayTags1.count; i++) {
//        if (i == 0) {
//            stringTag = arrayTags1[i];
//        } else {
//            stringTag = [NSString stringWithFormat:@"%@、%@",stringTag,arrayTags1[i]];
//        }
//    }
//    cell.tags.text = [NSString stringWithFormat:@"工艺：%@",stringTag?stringTag:@"--"];
//
//    double num = 0;
//    for (InquiryOrderItem *item in inquiryOrderModel.inquiryOrderItems) {
//        num += item.num1.doubleValue;
//    }
//    cell.num123.text = [NSString stringWithFormat:@"数量：%@",[NSString removeSuffixIsZone:num]];
//
//
//    NSArray *arrayEndTm = [[[inquiryOrderModel.endTm componentsSeparatedByString:@" "] firstObject] componentsSeparatedByString:@"-"];
//    cell.endTm.text = [NSString stringWithFormat:@"%@年%@月%@日",arrayEndTm[0],arrayEndTm[1],arrayEndTm[2]];

//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.indexPathIME = [NSIndexPath indexPathForRow:indexPath.section inSection:0];
    
    InquiryOrder *inquiryOrderModel = _arrayInquiryOrderModel[indexPath.row];
    XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
    xunPanXiangQingViewController.inquiryOrderId = inquiryOrderModel.inquiryOrderId;
    
    if (tableView == _tableView0 || tableView == _tableView1) {
        xunPanXiangQingViewController.isDefaultPurchase = DefaultSupplier;
    } else if (tableView == _tableView2) {
        xunPanXiangQingViewController.isDefaultPurchase = DefaultCenter;
    }
    
    [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
}



- (IBAction)buttonSouSuo:(UIButton *)sender {
    FenLeiSouSuoViewController *flssVC = [[FenLeiSouSuoViewController alloc] init];
    flssVC.textFieldPlaceholder = @"搜索询盘号或工艺";
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:flssVC] animated:YES completion:nil];
}

- (void)upDateArrayInquiryOrderModel:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath {
    InquiryOrder *model = _arrayInquiryOrderModel[indexPath.row];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    
    InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
    inquiryOrder.se_enterpriseOrderCode = model.enterpriseOrderCode;
    
    postEntityBean.entity = inquiryOrder.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    NSString *urlString;
    if (tableView == _tableView0 || tableView == _tableView1) {
        urlString = DYZ_inquiry_supplier_list;
    } else if (tableView == _tableView2) {
        urlString = DYZ_inquiry_center_list;
    }
    [HttpMamager postRequestWithURLString:urlString parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            NSMutableArray *arrayInquiryOrder = model.list;
            for (NSDictionary *dic in arrayInquiryOrder) {
                InquiryOrder *obj = [InquiryOrder mj_objectWithKeyValues:dic];
                [_arrayInquiryOrderModel replaceObjectAtIndex:indexPath.row withObject:obj];
            }
            [tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}



#pragma mark initRequest
- (void)initRequestWithTableView:(UITableView *)tableView WithRecommendTypeArray:(NSArray *)seiIoeRecommendTypeArray WithNoContentView:(UIView *)viewNoContent{
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
        OrderByBean *orderByBean = [[OrderByBean alloc] init];
        orderByBean.orderName = @"c.createTime";
        orderByBean.orderSort = @"desc";
        
        NSMutableArray <OrderByBean *> *arrayOrderByBean = [[NSMutableArray alloc] initWithCapacity:0];
        [arrayOrderByBean addObject:orderByBean];
        postEntityBean.order = arrayOrderByBean;
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:[@1 integerValue]];
        postEntityBean.pager = pagerBean;
        
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        inquiryOrder.ioe__manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
        inquiryOrder.sei_ioe__recommendType = [NSMutableArray arrayWithArray:seiIoeRecommendTypeArray];
        inquiryOrder.confirmStatus = [NSNumber numberWithInteger:0];
        
        
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        NSString *urlString;
        if (tableView == _tableView0 || tableView == _tableView1) {
            urlString = DYZ_inquiry_supplier_list;
        } else if (tableView == _tableView2) {
            urlString = DYZ_inquiry_center_list;
        }
        [HttpMamager postRequestWithURLString:urlString parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *model = responseObjectModel;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                _arrayInquiryOrderModel = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *arrayInquiryOrder = model.list;
                for (NSDictionary *dic in arrayInquiryOrder) {
                    InquiryOrder *obj = [InquiryOrder mj_objectWithKeyValues:dic];
                    [_arrayInquiryOrderModel addObject:obj];
                }
                [tableView reloadData];
                [tableView.mj_header endRefreshing];
                if (arrayInquiryOrder.count != 0) {
                    if (arrayInquiryOrder.count < [pageSizeDYZ integerValue]) {
                        [tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [tableView.mj_footer endRefreshing];
                    }
                    viewNoContent.hidden = YES;
                } else {
                    [tableView.mj_footer endRefreshingWithNoMoreData];
                    viewNoContent.hidden = NO;
                }
                _aPage = 2;
                _viewRequestTimeout.hidden = YES;
                
            } else {
                _viewRequestTimeout.hidden = NO;
                [tableView.mj_header endRefreshing];
            }
        } fail:^(NSError *error) {
            _viewRequestTimeout.hidden = NO;
            [tableView.mj_header endRefreshing];
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
    
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
        OrderByBean *orderByBean = [[OrderByBean alloc] init];
        orderByBean.orderName = @"c.createTime";
        orderByBean.orderSort = @"desc";
        
        NSMutableArray <OrderByBean *> *arrayOrderByBean = [[NSMutableArray alloc] initWithCapacity:0];
        [arrayOrderByBean addObject:orderByBean];
        postEntityBean.order = arrayOrderByBean;
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:_aPage];
        postEntityBean.pager = pagerBean;
        
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        inquiryOrder.ioe__manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
        inquiryOrder.sei_ioe__recommendType = [NSMutableArray arrayWithArray:seiIoeRecommendTypeArray];
        inquiryOrder.confirmStatus = [NSNumber numberWithInteger:0];
        
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        NSString *urlString;
        if (tableView == _tableView0 || tableView == _tableView1) {
            urlString = DYZ_inquiry_supplier_list;
        } else if (tableView == _tableView2) {
            urlString = DYZ_inquiry_center_list;
        }
        [HttpMamager postRequestWithURLString:urlString parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *model = responseObjectModel;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                NSMutableArray *arrayInquiryOrder = model.list;
                for (NSDictionary *dic in arrayInquiryOrder) {
                    InquiryOrder *obj = [InquiryOrder mj_objectWithKeyValues:dic];
                    [_arrayInquiryOrderModel addObject:obj];
                }
                [tableView reloadData];
                if (arrayInquiryOrder.count != 0) {
                    if (arrayInquiryOrder.count < [pageSizeDYZ integerValue]) {
                        [tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [tableView.mj_footer endRefreshing];
                    }
                } else {
                    [tableView.mj_footer endRefreshingWithNoMoreData];
                }
                _aPage++;
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
}

- (void)initRequestWithTableView:(UITableView *)tableView WithNoContentView:(UIView *)viewNoContent{
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
        postEntityBean.isPurchase = [NSNumber numberWithInteger:0];
        OrderByBean *orderByBean = [[OrderByBean alloc] init];
        orderByBean.orderName = @"c.createTime";
        orderByBean.orderSort = @"desc";
        
        NSMutableArray <OrderByBean *> *arrayOrderByBean = [[NSMutableArray alloc] initWithCapacity:0];
        [arrayOrderByBean addObject:orderByBean];
        postEntityBean.order = arrayOrderByBean;
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:[@1 integerValue]];
        postEntityBean.pager = pagerBean;
        
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        
        inquiryOrder.sei_inquiryType = [NSMutableArray arrayWithArray:@[@"COM"]];
        inquiryOrder.sei_status = [NSMutableArray arrayWithArray:@[@"IING",@"SQ"]];
        inquiryOrder.confirmStatus = [NSNumber numberWithInteger:0];
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        NSString *urlString;
        if (tableView == _tableView0 || tableView == _tableView1) {
            urlString = DYZ_inquiry_supplier_list;
        } else if (tableView == _tableView2) {
            urlString = DYZ_inquiry_center_list;
        }
        
        [HttpMamager postRequestWithURLString:urlString parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *model = responseObjectModel;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                _arrayInquiryOrderModel = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *arrayInquiryOrder = model.list;
                for (NSDictionary *dic in arrayInquiryOrder) {
                    InquiryOrder *obj = [InquiryOrder mj_objectWithKeyValues:dic];
                    [_arrayInquiryOrderModel addObject:obj];
                }
                [tableView reloadData];
                [tableView.mj_header endRefreshing];
                if (arrayInquiryOrder.count != 0) {
                    if (arrayInquiryOrder.count < [pageSizeDYZ integerValue]) {
                        [tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [tableView.mj_footer endRefreshing];
                    }
                    viewNoContent.hidden = YES;
                } else {
                    [tableView.mj_footer endRefreshingWithNoMoreData];
                    viewNoContent.hidden = NO;
                }
                _aPage = 2;
                _viewRequestTimeout.hidden = YES;
            } else {
                _viewRequestTimeout.hidden = NO;
                [tableView.mj_header endRefreshing];
            }
        } fail:^(NSError *error) {
            _viewRequestTimeout.hidden = NO;
            [tableView.mj_header endRefreshing];
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
    
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
        postEntityBean.isPurchase = [NSNumber numberWithInteger:0];
        OrderByBean *orderByBean = [[OrderByBean alloc] init];
        orderByBean.orderName = @"c.createTime";
        orderByBean.orderSort = @"desc";
        
        NSMutableArray <OrderByBean *> *arrayOrderByBean = [[NSMutableArray alloc] initWithCapacity:0];
        [arrayOrderByBean addObject:orderByBean];
        postEntityBean.order = arrayOrderByBean;
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:_aPage];
        postEntityBean.pager = pagerBean;
        
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        inquiryOrder.sei_inquiryType = [NSMutableArray arrayWithArray:@[@"COM"]];
        inquiryOrder.sei_status = [NSMutableArray arrayWithArray:@[@"IING",@"SQ"]];
        inquiryOrder.confirmStatus = [NSNumber numberWithInteger:0];
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        NSString *urlString;
        if (tableView == _tableView0 || tableView == _tableView1) {
            urlString = DYZ_inquiry_supplier_list;
        } else if (tableView == _tableView2) {
            urlString = DYZ_inquiry_center_list;
        }
        [HttpMamager postRequestWithURLString:urlString parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *model = responseObjectModel;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                NSMutableArray *arrayInquiryOrder = model.list;
                for (NSDictionary *dic in arrayInquiryOrder) {
                    InquiryOrder *obj = [InquiryOrder mj_objectWithKeyValues:dic];
                    [_arrayInquiryOrderModel addObject:obj];
                }
                [tableView reloadData];
                if (arrayInquiryOrder.count != 0) {
                    [tableView.mj_footer endRefreshing];
                } else {
                    [tableView.mj_footer endRefreshingWithNoMoreData];
                }
                _aPage++;
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
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


- (void)line:(CGFloat)y{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, kMainW, 0.5)];
    label.backgroundColor = colorLine;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)lastDay:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateTime = [formatter dateFromString:time];
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:dateTime];
    NSString *lastDayTime = [formatter stringFromDate:lastDay];
    return lastDayTime;
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
