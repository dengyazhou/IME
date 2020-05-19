//
//  ECOrderViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ECOrderViewController.h"
#import "VoHeader.h"

#import "EChooseView.h"
#import "ECOrderCell.h"

#import "EH5FuKuanViewController.h"
#import "EShengChangJingduXiangXiViewController.h"
#import "FaBaoPingLunCaiViewController.h"


#import "XunPanCell.h"
#import "XunPanXiangQingViewController.h"
#import "TiWenViewController.h"
#import "HuiDaViewController.h"

#import "ShaiXuanBaoJiaViewController.h"

#import "AFNetworkReachabilityManager.h"



#import "DingDanXiangQingCaiViewController.h"
#import "FaBaoPingLunTuoGuanViewController.h"
#import "FaBaoPingLunTuoGuanChaKanViewController.h"
#import "ShouYeViewController.h"

#import "ECCheckTheLogisticsViewController.h"
#import "ShouHuoLieBiaoVC.h"
#import "YanHuoLieBiaoVC.h"
#import "ShenHeShouPanViewController.h"

#import "ShenQingYSHView.h"
#import "ShQYSHCHKRView.h"
#import "ChaKanYuanYinViewController.h"
#import "ShenHeShouPanHeJiaVC.h"


@interface ECOrderViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,EChooseViewDelegate> {
    NSArray *_arrayButton;
    UITableView *_tableView0;
    
    NSArray *_arrayType0;
    NSMutableArray *_arrayTypeNoOrYes0;

    NSArray *_arrayState;
    NSMutableArray *_arrayStateNoOrYes0;
    NSMutableArray *_arrayTimeNoOrYes;
    
    EChooseView *_eChooseView0;
    ShenQingYSHView *_shenQingYSHView;
    
    NSMutableArray *_arrayTradeOrderModel;
    NSInteger _aPage;
    
    NSString *_inquiryTypeSelect0;//询盘类型
    NSString *_tradeOrderPurchaseStatusSelect0;
    NSString *_timeSelect0;
    NSString *_timeSelect1;
    
    
    
    UIView *_viewNoContent0;
    UIView *_viewRequestTimeout;
    
    
    UIView *_viewNoNet;
    UIView *_viewLoading;
    
    NSMutableArray *_arrayButtonUp;
    
    NSString *_firstRefresh;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    
}

@property (weak, nonatomic) IBOutlet UILabel *labelLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLineCenterX;
@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIImageView *imageArrow;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *buttonScreen;


@property (nonatomic,strong) NSIndexPath *indexPathIME;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;


@end

@implementation ECOrderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.imageArrow.hidden = YES;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([_firstRefresh isEqualToString:@"first"]) {
        if (!_indexInquiryType) {
            _indexInquiryType = 0;
        }
        [self refresh];
        _firstRefresh = @"second";
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notificationRefreshECOrder" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    _firstRefresh = @"first";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRefresh:) name:@"notificationRefreshECOrder" object:nil];
    
    [self initUI];
    
    [self initRequestWithTableView:_tableView0 WithInquiryType:nil WithInquiryOrderStatus:nil WithTime0:nil WithTime1:nil WithNoContentView:_viewNoContent0];
    
    
}

- (void)notificationRefresh:(NSNotification *)info {
    if (!_indexInquiryType) {
        _indexInquiryType = 0;
    }
    
    if (_indexInquiryType == 0) {
        [self upDateArrayInquiryOrderModel:_tableView0 WithindexPath:self.indexPathIME];
    }
    
}
#pragma mark 刷新
- (void)refresh {
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 0) {
        _viewNoNet.hidden = NO;
    }
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 1 || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==2) {
        _viewNoNet.hidden = YES;
        
        if (_indexInquiryType == 0) {
            [_tableView0.mj_header beginRefreshing];
        }
    }
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
    self.scrollView.scrollEnabled = NO;
    
    _tableView0 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH-_height_NavBar-42.5-_height_TabBar) style:UITableViewStyleGrouped];
    _tableView0.delegate = self;
    _tableView0.dataSource = self;
    _tableView0.tag = 200;
    _tableView0.backgroundColor = [UIColor clearColor];
    [_tableView0 registerNib:[UINib nibWithNibName:@"ECOrderCell" bundle:nil] forCellReuseIdentifier:@"eCOrderCell"];
    _tableView0.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView0.tableFooterView = [UIView new];
    _tableView0.estimatedRowHeight = 226.5;
    _tableView0.rowHeight = UITableViewAutomaticDimension;
    [self.scrollView addSubview:_tableView0];
    _viewNoContent0 = [UIView addViewNoNetWithScrollView:self.scrollView tableView:_tableView0 imageNamed:@"ime_picture_empty" label0Text:@"无内容" label1Text:@"暂时没有全部订单"];
    _viewNoContent0.hidden = YES;
    
    _arrayButtonUp = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
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

    _arrayType0 = @[@"e非标",@"标准",@"指定价",@"后议价"];
    _arrayTypeNoOrYes0 = [[NSMutableArray alloc] init];
    for (int i = 0; i < _arrayType0.count; i++) {
        [_arrayTypeNoOrYes0 addObject:@"NO"];
    }
    
    _arrayState = @[@"等待采购商付款",@"付款超时",@"付款确认中",@"待发货",@"供应商已发货",@"等待采购商验货",@"采购商已验货",@"交易成功",@"交易关闭",@"等待退款",@"已退款"];
    _arrayStateNoOrYes0 = [[NSMutableArray alloc] init];
  

    for (int i = 0; i < _arrayState.count; i++) {
        [_arrayStateNoOrYes0 addObject:@"NO"];
    }
    _arrayTimeNoOrYes = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++) {
        [_arrayTimeNoOrYes addObject:@"NO"];
    }
    
    _viewRequestTimeout = [UIView addView:CGRectMake(0, _height_NavBar + 42.5, kMainW, kMainH-_height_NavBar-42.5-_height_TabBar) withTitle:@"请求超时"];
    [self.view addSubview:_viewRequestTimeout];
    _viewRequestTimeout.hidden = YES;
    
    _viewNoNet = [UIView addView:CGRectMake(0, _height_NavBar + 42.5, kMainW, kMainH-_height_NavBar-42.5-_height_TabBar) imageNamed:@"ime_picture_network" title:@"网络不可用，请检查网络！"];
    [self.view addSubview:_viewNoNet];
    _viewNoNet.hidden = YES;
    

    _eChooseView0 = [[EChooseView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH) withTitleState:@"询盘类型" withState:_arrayType0 withArrayTypeNoOrYes:_arrayTypeNoOrYes0 withTitleState:@"订单状态" withState:_arrayState withArrayStateNoOrYes:_arrayStateNoOrYes0 withTitleTime:@"询盘截止日期" withTime0:nil withTime1:nil with:@[@"重置",@"确认"] withColor:colorCai];
    _eChooseView0.delegate = self;
    _eChooseView0.tag = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:_eChooseView0];
    _eChooseView0.hidden = YES;

}

- (void)buttonClickStick:(UIButton *)sender {
    if (sender.tag == 0) {
        [_tableView0 setContentOffset:CGPointZero animated:YES];
    }
}

- (IBAction)buttonClick:(UIButton *)sender {
    self.labelLineCenterX.constant = 0;
    self.labelLineCenterX.constant = CGRectGetWidth(sender.frame) * (sender.tag-100);
    for (int i = 0; i < _arrayButton.count; i++) {
        UIButton *but = _arrayButton[i];
        if ((sender.tag-100) == i) {
            [but setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
        } else {
            [but setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
        }
    }
    [self.scrollView setContentOffset:CGPointMake((sender.tag-100)*kMainW, 0)];
    
    _indexInquiryType = sender.tag - 100;
    
    /*－－－－改变筛选的颜色－－－－*/
    
    
    NSMutableArray *arrayTpyeTemp = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *arrayStateTemp = [[NSMutableArray alloc] initWithCapacity:0];
    if (_indexInquiryType == 0) {
        NSArray *arrayType = @[@"COM",@"ATG",@"FTG",@"TTG"];
        NSMutableArray *arrayTpyeTemp0 = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i = 0; i < arrayType.count; i++) {
            NSString *string = _arrayTypeNoOrYes0[i];
            if ([string isEqualToString:@"YES"]) {
                if (i==0) {
                    [arrayTpyeTemp0 addObject:@"COM"];
                    [arrayTpyeTemp0 addObject:@"DIR"];
                } else {
                    [arrayTpyeTemp0 addObject:arrayType[i]];
                }
            }
        }
        arrayTpyeTemp = arrayTpyeTemp0;
        
        NSArray *arrayState = @[@"waitingPaymentForPurchase",@"paymentOvertime",@"paymentConfirm",@"purchasePaid",@"supplierDelivered",@"examineCargoForPurchase",@"alreadyExamineCargoForPurchase",@"success",@"close",@"waitingRefund",@"refunded"];
        NSMutableArray *arrayStateTemp0 = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i = 0; i < arrayState.count; i++) {
            NSString *string = _arrayStateNoOrYes0[i];
            if ([string isEqualToString:@"YES"]) {
                [arrayStateTemp0 addObject:arrayState[i]];
            }
        }
        arrayStateTemp = arrayStateTemp0;
    }
    
    if (arrayStateTemp.count == 0 && arrayTpyeTemp.count == 0) {
        [self.buttonScreen setImage:[UIImage imageNamed:@"icon_filter"] forState:UIControlStateNormal];
        [self.buttonScreen setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
    } else {
        [self.buttonScreen setImage:[UIImage imageNamed:@"icon_filter_2t"] forState:UIControlStateNormal];
        [self.buttonScreen setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
    }
    /*－－－－改变筛选的颜色－－－－*/
    
    _arrayTradeOrderModel = nil;
    if (sender.tag == 100) {
        [_tableView0 reloadData];
        [_tableView0.mj_header beginRefreshing];
    }
}

- (void)eChooseViewDelegateTapRemove:(EChooseView *)view{
    view.hidden = YES;
    self.imageArrow.hidden = YES;
    
    
    NSMutableArray *arrayTpyeTemp = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *arrayStateTemp = [[NSMutableArray alloc] initWithCapacity:0];
    if (view.tag == 0) {
        NSArray *arrayType = @[@"COM",@"ATG",@"FTG",@"TTG"];
        NSMutableArray *arrayTpyeTemp0 = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i = 0; i < arrayType.count; i++) {
            NSString *string = _arrayTypeNoOrYes0[i];
            if ([string isEqualToString:@"YES"]) {
                if (i==0) {
                    [arrayTpyeTemp0 addObject:@"COM"];
                    [arrayTpyeTemp0 addObject:@"DIR"];
                } else {
                    [arrayTpyeTemp0 addObject:arrayType[i]];
                }
            }
        }
        arrayTpyeTemp = arrayTpyeTemp0;
        
        NSArray *arrayState = @[@"waitingPaymentForPurchase",@"paymentOvertime",@"paymentConfirm",@"purchasePaid",@"supplierDelivered",@"examineCargoForPurchase",@"alreadyExamineCargoForPurchase",@"success",@"close",@"waitingRefund",@"refunded"];
        NSMutableArray *arrayStateTemp0 = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i = 0; i < arrayState.count; i++) {
            NSString *string = _arrayStateNoOrYes0[i];
            if ([string isEqualToString:@"YES"]) {
                [arrayStateTemp0 addObject:arrayState[i]];
            }
        }
        arrayStateTemp = arrayStateTemp0;
    }
    
    if (arrayStateTemp.count == 0 && arrayTpyeTemp.count == 0) {
        [self.buttonScreen setImage:[UIImage imageNamed:@"icon_filter"] forState:UIControlStateNormal];
        [self.buttonScreen setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
    } else {
        [self.buttonScreen setImage:[UIImage imageNamed:@"icon_filter_2t"] forState:UIControlStateNormal];
        [self.buttonScreen setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
    }
}

- (IBAction)buttonShaiXuan:(UIButton *)sender {
    if (_indexInquiryType == 0) {
        _eChooseView0.hidden = NO;
    }
    
    self.imageArrow.hidden = NO;
    [sender setImage:[UIImage imageNamed:@"icon_filter_2t"] forState:UIControlStateNormal];
    [sender setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
}


- (void)eChooseViewDelegate:(EChooseView *)view ButtonClick3:(UIButton *)sender withArrayTypeNoOrYes:(NSMutableArray *)arrayTypeNoOrYes withArrayStateNoOrYes:(NSMutableArray *)arrayStateNoOrYes withwithTime0:(NSString *)time0 withTime1:(NSString *)time1{
    NSMutableArray *arrayTpyeTempCount = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arrayTradeOrderPurchaseStatusTempCount = [NSMutableArray arrayWithCapacity:0];
    if (view.tag == 0) {
        _arrayTypeNoOrYes0 = arrayTypeNoOrYes;
        NSArray *arrayType = @[@"COM",@"ATG",@"FTG",@"TTG"];
        NSString *inquiryTypeTemp = nil;
        NSMutableArray *arrayTpyeTemp = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i = 0; i < arrayType.count; i++) {
            NSString *string = _arrayTypeNoOrYes0[i];
            if ([string isEqualToString:@"YES"]) {
                inquiryTypeTemp = arrayType[i];
            }
        }
        _inquiryTypeSelect0 = inquiryTypeTemp;
        
        
        _arrayStateNoOrYes0 = arrayStateNoOrYes;
        NSArray *arrayState = @[@"waitingPaymentForPurchase",@"paymentOvertime",@"paymentConfirm",@"purchasePaid",@"supplierDelivered",@"examineCargoForPurchase",@"alreadyExamineCargoForPurchase",@"success",@"close",@"waitingRefund",@"refunded"];
        NSString *stateTemp = nil;
        for (NSInteger i = 0; i < arrayState.count; i++) {
            NSString *string = _arrayStateNoOrYes0[i];
            if ([string isEqualToString:@"YES"]) {
                stateTemp = arrayState[i];
            }
        }
        _tradeOrderPurchaseStatusSelect0 = stateTemp;
    }
    
    _timeSelect0 = time0;
    _timeSelect1 = time1;
    
    if (sender.tag == 301) {
        view.hidden = YES;
        self.imageArrow.hidden = YES;
        
        if (_inquiryTypeSelect0 == nil && _tradeOrderPurchaseStatusSelect0 == nil && _timeSelect0 == nil && _timeSelect1 == nil) {
            [self.buttonScreen setImage:[UIImage imageNamed:@"icon_filter"] forState:UIControlStateNormal];
            [self.buttonScreen setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
        }
        
        if (view.tag == 0) {
            
            [self initRequestWithTableView:_tableView0 WithInquiryType:_inquiryTypeSelect0 WithInquiryOrderStatus:_tradeOrderPurchaseStatusSelect0 WithTime0:_timeSelect0 WithTime1:_timeSelect1 WithNoContentView:_viewNoContent0];
            [_tableView0.mj_header beginRefreshing];
        }
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
        } else {
            index = 103;
        }
        _indexInquiryType = index - 100;
        
        /*－－－－改变筛选的颜色－－－－*/
        NSMutableArray *arrayTpyeTemp = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *arrayStateTemp = [[NSMutableArray alloc] initWithCapacity:0];
        if (_indexInquiryType == 0) {
//            NSArray *arrayType = @[@"COM",@"DIR",@"ATG",@"FTG",@"TTG"];
            NSArray *arrayType = @[@"COM",@"ATG",@"FTG",@"TTG"];
            NSMutableArray *arrayTpyeTemp0 = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSInteger i = 0; i < arrayType.count; i++) {
                NSString *string = _arrayTypeNoOrYes0[i];
                if ([string isEqualToString:@"YES"]) {
                    if (i==0) {
                        [arrayTpyeTemp0 addObject:@"COM"];
                        [arrayTpyeTemp0 addObject:@"DIR"];
                    } else {
                        [arrayTpyeTemp0 addObject:arrayType[i]];
                    }
                }
            }
            arrayTpyeTemp = arrayTpyeTemp0;
            
            NSArray *arrayState = @[@"waitingPaymentForPurchase",@"paymentOvertime",@"paymentConfirm",@"purchasePaid",@"supplierDelivered",@"examineCargoForPurchase",@"alreadyExamineCargoForPurchase",@"success",@"close",@"waitingRefund",@"refunded"];
            NSMutableArray *arrayStateTemp0 = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSInteger i = 0; i < arrayState.count; i++) {
                NSString *string = _arrayStateNoOrYes0[i];
                if ([string isEqualToString:@"YES"]) {
                    [arrayStateTemp0 addObject:arrayState[i]];
                }
            }
            arrayStateTemp = arrayStateTemp0;
        }
        if (arrayStateTemp.count == 0 && arrayTpyeTemp.count == 0) {
            [self.buttonScreen setImage:[UIImage imageNamed:@"icon_filter"] forState:UIControlStateNormal];
            [self.buttonScreen setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
        } else {
            [self.buttonScreen setImage:[UIImage imageNamed:@"icon_filter_2t"] forState:UIControlStateNormal];
            [self.buttonScreen setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
        }
        /*－－－－改变筛选的颜色－－－－*/
        
        if (_indexInquiryType == 0) {
            [_tableView0 reloadData];
            [_tableView0.mj_header beginRefreshing];
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
            index = 100;
        } else if (x < kMainW/2*3) {
            index = 101;
        } else if (x < kMainW/2*5) {
            index = 102;
        } else {
            index = 103;
        }
        UIButton *but = [_arrayButton firstObject];
        self.labelLineCenterX.constant = 0;
        self.labelLineCenterX.constant = CGRectGetWidth(but.frame) * (index-100);
        for (int i = 0; i < _arrayButton.count; i++) {
            UIButton *but = _arrayButton[i];
            if ((index-100) == i) {
                [but setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
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
    return _arrayTradeOrderModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ECOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eCOrderCell" forIndexPath:indexPath];
    
    TradeOrder *tradeOrder = _arrayTradeOrderModel[indexPath.section];
    
    [cell initDataWith:tradeOrder andQuanXian:nil];
    
    [cell.button1 addTarget:self action:@selector(buttonClickTradeOrder:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button2 addTarget:self action:@selector(buttonClickTradeOrder:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button3 addTarget:self action:@selector(buttonClickTradeOrder:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button4 addTarget:self action:@selector(buttonClickTradeOrder:) forControlEvents:UIControlEventTouchUpInside];
    cell.button1.tag = indexPath.section;
    cell.button2.tag = indexPath.section;
    cell.button3.tag = indexPath.section;
    cell.button4.tag = indexPath.section;
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 189;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.indexPathIME = [NSIndexPath indexPathForRow:indexPath.section inSection:0];
    
    TradeOrder *tradeOrder = _arrayTradeOrderModel[indexPath.section];
    
    DingDanXiangQingCaiViewController *dingDanXiangQingCaiViewController = [[DingDanXiangQingCaiViewController alloc] init];
    dingDanXiangQingCaiViewController.orderId = tradeOrder.orderId;
    [self.navigationController pushViewController:dingDanXiangQingCaiViewController animated:YES];
}

//立即审批
- (void)approvalImmediately:(TradeOrder *)tradeOrder {
    if ([tradeOrder.inquiryType isEqualToString:@"COM"] || [tradeOrder.inquiryType isEqualToString:@"ATG"]) {//寻源-标准
        if (tradeOrder.isDesignated.integerValue == 1) {//比价收盘
            ShenHeShouPanHeJiaVC *vc = [[ShenHeShouPanHeJiaVC alloc] init];
            vc.orderId = tradeOrder.orderId;
            vc.inquiryOrderId = tradeOrder.inquiryOrderId;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            ShenHeShouPanViewController *vc = [[ShenHeShouPanViewController alloc] init];
            vc.orderId = tradeOrder.orderId;
            vc.inquiryOrderId = tradeOrder.inquiryOrderId;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if ([tradeOrder.inquiryType isEqualToString:@"TTG"]) {//议价   //议价 审批先用 寻源-标准
        ShenHeShouPanViewController *vc = [[ShenHeShouPanViewController alloc] init];
        vc.orderId = tradeOrder.orderId;
        vc.inquiryOrderId = tradeOrder.inquiryOrderId;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([tradeOrder.inquiryType isEqualToString:@"FTG"]) {//指定   //指定 审批先用 寻源-标准
        ShenHeShouPanViewController *vc = [[ShenHeShouPanViewController alloc] init];
        vc.orderId = tradeOrder.orderId;
        vc.inquiryOrderId = tradeOrder.inquiryOrderId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)buttonClickTradeOrder:(UIButton *)sender {
    self.indexPathIME = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    TradeOrder *tradeOrder = _arrayTradeOrderModel[sender.tag];
    if (([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"WAITAPPROVAL"] || ([tradeOrder.inquiryType isEqualToString:@"TTG"] && tradeOrder.bargainStatus.integerValue == 2)) && tradeOrder.isOpenErp.integerValue == 0 && tradeOrder.isNeedReNotify.integerValue == 0) {
#pragma mark 立即审批
        [self approvalImmediately:tradeOrder];
    } else if (tradeOrder.isOpenErp.integerValue == 1 && tradeOrder.isNeedReNotify.integerValue == 1 && [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"WAITAPPROVAL"]) {
#pragma mark 重新对接
        
    } else if ([tradeOrder.partType isEqualToString:@"FWJ"] && [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"examineCargoForPurchase"]) {
#pragma mark 申请验收
        if (_shenQingYSHView == nil) {
            _shenQingYSHView = [ShenQingYSHView loadView];
        } else {
            _shenQingYSHView.hidden = false;
        }
        _shenQingYSHView.frame = self.view.frame;
        [[UIApplication sharedApplication].keyWindow addSubview:_shenQingYSHView];
        [_shenQingYSHView initData:tradeOrder];
        __weak typeof(self) weakSelf = self;
        [_shenQingYSHView setButtonBlockYanShou:^(NSInteger index, NSString * _Nonnull str) {
            __strong typeof(self) strongSelf = weakSelf;
            //index == 1 通过; index == 0 不通过
            [strongSelf initRequestYanShou:tradeOrder index:index str:str];
        }];
        

    } else if ([tradeOrder.partType isEqualToString:@"FWJ"] && [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"ACCEPTFAILED"]) {
#pragma mark 查看原因 申请验收
        ShQYSHCHKRView *view = [ShQYSHCHKRView loadView];
        view.frame = self.view.frame;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        [view initData:tradeOrder];
        [view setButtonBlockRevise:^{
            ShenQingYSHView *shenQingYSHView = [ShenQingYSHView loadView];
            shenQingYSHView.frame = self.view.frame;
            [[UIApplication sharedApplication].keyWindow addSubview:shenQingYSHView];
            [shenQingYSHView initData:tradeOrder];
            __weak typeof(self) weakSelf = self;
            [shenQingYSHView setButtonBlockYanShou:^(NSInteger index, NSString * _Nonnull str) {
                __strong typeof(self) strongSelf = weakSelf;
                //index == 1 通过; index == 0 不通过
                [strongSelf initRequestYanShou:tradeOrder index:index str:str];
            }];
        }];
    } else if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"REFUSEDAPPROVAL"] || [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"REFUSEDORDER"] || ([tradeOrder.inquiryType isEqualToString:@"TTG"] && tradeOrder.bargainStatus.integerValue == 3)) {
#pragma mark 查看原因
        ChaKanYuanYinViewController *vc = [[ChaKanYuanYinViewController alloc] init];
        vc.orderId = tradeOrder.orderId;
        [self.navigationController pushViewController:vc animated:true];
    } else {
#pragma mark 查看订单
        DingDanXiangQingCaiViewController *vc = [[DingDanXiangQingCaiViewController alloc] init];
        vc.orderId = tradeOrder.orderId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (tradeOrder.isTemporary.integerValue == 0 && [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"purchasePaid"]) {
#pragma mark 催发货
        [self initRequesrCuiFaHuo:tradeOrder];
    }
    if (tradeOrder.isTemporary.integerValue == 1 && ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"WAITORDER"] || [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"purchasePaid"])) {
#pragma mark 邀请操作
       
    }
}


#pragma mark 催发货接口
- (void)initRequesrCuiFaHuo:(TradeOrder *)tradeOrder {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    PurchaseProjectInfo *purchasePI = [[PurchaseProjectInfo alloc] init];
    purchasePI.DYZid = tradeOrder.orderId;
    postEntityBean.entity = purchasePI.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_purchaseProject_notifySend parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
//            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"催发货成功"];
            [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
        } else {
            if (model.returnCode.integerValue == -6) {
//                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您已发过催发货提醒，请稍后再试"];
                [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
            }
        }
       
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

#pragma mark 验收接口
- (void)initRequestYanShou:(TradeOrder *)tradeOrder index:(NSInteger)index str:(NSString *)str {
    
    
    if (index == 0 && str.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请填写不通过原因"];
        return;
    }
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    
    TradeOrder *trader = [[TradeOrder alloc] init];
    trader.orderId = tradeOrder.orderId;
    trader.purchaseAcceptStatus = [NSNumber numberWithInteger:index];
    trader.purchaseAccpetMsg = str;
    
    postEntityBean.entity = trader.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_api_tradeOrder_purchase_purchaseAccpetOrder parameters:dic success:^(id responseObjectModel) {
        
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            if (index == 0) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"验收不通过"];
            }
            if (index == 1) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"验收通过"];
            }
            
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"验证失败"];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)upDateArrayInquiryOrderModel:(UITableView *)tableView WithindexPath:(NSIndexPath *)indexPath{
    TradeOrder *model = _arrayTradeOrderModel[indexPath.row];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;

    TradeOrder *tradeOrder = [[TradeOrder alloc] init];
    tradeOrder.se_insideOrderCode = model.insideOrderCode;
    
    postEntityBean.entity = tradeOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
  
    
    [HttpMamager postRequestWithURLString:DYZ_tradeOrder_purchase_tradeOrderList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            for (NSDictionary *dic in returnListBean.list) {
                TradeOrder *tradeOrder = [TradeOrder mj_objectWithKeyValues:dic];
                [_arrayTradeOrderModel replaceObjectAtIndex:indexPath.row withObject:tradeOrder];
            }
            [tableView reloadData];
        } else {
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (void)requestData:(void (^)(id))dataBlock {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    TradeOrder *tradeOrder = [[TradeOrder alloc] init];
    postEntityBean.entity = tradeOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_tradeOrder_purchase_tradeOrderList parameters:dic success:^(id responseObjectModel) {
        dataBlock(responseObjectModel);
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    
}

#pragma mark initRequest
- (void)initRequestWithTableView:(UITableView *)tableView WithInquiryType:(NSString *)inquiryType WithInquiryOrderStatus:(NSString *)tradeOrderPurchaseStatus WithTime0:(NSString *)time0 WithTime1:(NSString *)time1 WithNoContentView:(UIView *)viewNoContent{
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
        postEntityBean.isPurchase = [NSNumber numberWithInteger:1];
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
        
        TradeOrder *tradeOrder = [[TradeOrder alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        tradeOrder.purchaseEnterpriseId = loginModel.enterpriseId;
        
        

    
        //非标管家 19.06.03版
        tradeOrder.inquiryType = inquiryType;
        tradeOrder.tradeOrderPurchaseStatus = tradeOrderPurchaseStatus;
        tradeOrder.se_enterpriseOrderCode = self.se_enterpriseOrderCode;
        
        
        
        
        postEntityBean.entity = tradeOrder.mj_keyValues;
        
        postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
//        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_tradeOrder_purchase_tradeOrderList parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *returnListBean = responseObjectModel;
            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                _arrayTradeOrderModel = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *dic in returnListBean.list) {
                    TradeOrder *tradeOrder = [TradeOrder mj_objectWithKeyValues:dic];
                    [_arrayTradeOrderModel addObject:tradeOrder];
                }
                [tableView reloadData];
                [tableView.mj_header endRefreshing];
                if (returnListBean.list.count != 0) {
                    if (returnListBean.list.count < [pageSizeDYZ integerValue]) {
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
        postEntityBean.isPurchase = [NSNumber numberWithInteger:1];
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
        
        TradeOrder *tradeOrder = [[TradeOrder alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        tradeOrder.purchaseEnterpriseId = loginModel.enterpriseId;
 
        tradeOrder.inquiryType = inquiryType;
        tradeOrder.tradeOrderPurchaseStatus = tradeOrderPurchaseStatus;
        tradeOrder.se_enterpriseOrderCode = self.se_enterpriseOrderCode;
 
        
        postEntityBean.entity = tradeOrder.mj_keyValues;
        
        postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
//        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_tradeOrder_purchase_tradeOrderList parameters:dic success:^(id responseObjectModel) {
            
            ReturnListBean *returnListBean = responseObjectModel;
            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                for (NSDictionary *dic in returnListBean.list) {
                    TradeOrder *tradeOrder = [TradeOrder mj_objectWithKeyValues:dic];
                    [_arrayTradeOrderModel addObject:tradeOrder];
                }
                [tableView reloadData];
                if (returnListBean.list.count != 0) {
                    [tableView.mj_footer endRefreshing];
                } else {
                    [tableView.mj_footer endRefreshingWithNoMoreData];
                }
                _aPage ++;
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
}

- (IBAction)back:(UIButton *)sender {
    UIViewController *vc = [self.navigationController.viewControllers lastObject];
    if ([vc isMemberOfClass:[ECOrderViewController class]]) {
        [self.navigationController popViewControllerAnimated:true];
        return;
    }
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
