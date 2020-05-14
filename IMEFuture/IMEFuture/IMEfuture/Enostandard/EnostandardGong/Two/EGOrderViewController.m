//
//  ECOrderViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "EGOrderViewController.h"
#import "VoHeader.h"

#import "EChooseView.h"
#import "EGOrderCell.h"

#import "EShengChangJingduXiangXiViewController.h"
#import "FaBaoPingLunGongViewController.h"
#import "XunPanCell.h"
#import "XunPanXiangQingViewController.h"
#import "TiWenViewController.h"
#import "HuiDaViewController.h"
#import "FenLeiSouSuoViewController.h"

#import "ShaiXuanBaoJiaViewController.h"
#import "DingDanXiangQingGongViewController.h"


#import "AFNetworkReachabilityManager.h"

#import "ShouYeViewController.h"

#import "LogisticsInformationVC.h"

#import "ECCheckTheLogisticsViewController.h"
#import "BuFaHuoLieBiaoVC.h"
#import "YiCiFaHuoVC.h"

#import "FaHuoLieBiaoViewController09.h"
#import "ChaKanShouPanJiePanYiJiaViewController.h"


@interface EGOrderViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,EChooseViewDelegate> {
    NSArray *_arrayButton;
    UITableView *_tableView0;

    
    NSArray *_arrayType0;

    NSMutableArray *_arrayTypeNoOrYes0;
  
    NSMutableArray *_arrayTypeNoOrYes2;
    
    NSArray *_arrayState;
    
    NSMutableArray *_arrayStateNoOrYes0;
    NSMutableArray *_arrayStateNoOrYes;
    NSMutableArray *_arrayTimeNoOrYes;
    
    EChooseView *_eChooseView0;
    
    NSMutableArray *_arrayTradeOrderModel;
    NSInteger _aPage;
    
    NSString *_inquiryTypeSelect0;//询盘类型
    NSString *_inquiryOrderStatusSelect0;
    NSString *_timeSelect0;
    NSString *_timeSelect1;
    
    
    NSInteger _indexInquiryType;
    
    
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

@implementation EGOrderViewController

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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notificationRefreshEGOrder" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    _firstRefresh = @"first";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRefresh:) name:@"notificationRefreshEGOrder" object:nil];
    
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
    [_tableView0 registerNib:[UINib nibWithNibName:@"EGOrderCell" bundle:nil] forCellReuseIdentifier:@"eGOrderCell"];
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
  
    _arrayTypeNoOrYes2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < _arrayType0.count; i++) {
        [_arrayTypeNoOrYes0 addObject:@"NO"];
    }


    
    _arrayState = @[@"等待采购商付款",@"付款超时",@"付款确认中",@"待发货",@"供应商已发货",@"等待采购商验货",@"采购商已验货",@"交易成功",@"交易关闭"];
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
    
    _eChooseView0 = [[EChooseView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH) withTitleState:@"询盘类型" withState:_arrayType0 withArrayTypeNoOrYes:_arrayTypeNoOrYes0 withTitleState:@"订单状态" withState:_arrayState withArrayStateNoOrYes:_arrayStateNoOrYes0 withTitleTime:@"询盘截止日期" withTime0:nil withTime1:nil with:@[@"重置",@"确认"] withColor:colorGong];
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
            [but setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
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
//        NSArray *arrayType = @[@"COM",@"DIR",@"ATG",@"FTG",@"TTG"];
        NSArray *arrayType = @[@"COM",@"ATG",@"FTG",@"TTG"];
        NSMutableArray *arrayTpyeTemp0 = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i = 0; i < arrayType.count; i++) {
            NSString *string = _arrayTypeNoOrYes0[i];
            if ([string isEqualToString:@"YES"]) {
                [arrayTpyeTemp0 addObject:arrayType[i]];
            }
        }
        arrayTpyeTemp = arrayTpyeTemp0;
        
        NSArray *arrayState = @[@"waitingPaymentForPurchase",@"paymentOvertime",@"paymentConfirm",@"purchasePaid",@"supplierDelivered",@"examineCargoForPurchase",@"alreadyExamineCargoForPurchase",@"success",@"close"];
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
        [self.buttonScreen setImage:[UIImage imageNamed:@"icon_filter_3t"] forState:UIControlStateNormal];
        [self.buttonScreen setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
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
//        NSArray *arrayType = @[@"COM",@"DIR",@"ATG",@"FTG",@"TTG"];
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
        
        NSArray *arrayState = @[@"waitingPaymentForPurchase",@"paymentOvertime",@"paymentConfirm",@"purchasePaid",@"supplierDelivered",@"examineCargoForPurchase",@"alreadyExamineCargoForPurchase",@"success",@"close"];
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
        [self.buttonScreen setImage:[UIImage imageNamed:@"icon_filter_3t"] forState:UIControlStateNormal];
        [self.buttonScreen setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
    }
}


- (IBAction)buttonShaiXuan:(UIButton *)sender {
    if (_indexInquiryType == 0) {
        _eChooseView0.hidden = NO;
    }

    
    self.imageArrow.hidden = NO;
    [sender setImage:[UIImage imageNamed:@"icon_filter_3t"] forState:UIControlStateNormal];
    [sender setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
}

- (void)eChooseViewDelegate:(EChooseView *)view ButtonClick3:(UIButton *)sender withArrayTypeNoOrYes:(NSMutableArray *)arrayTypeNoOrYes withArrayStateNoOrYes:(NSMutableArray *)arrayStateNoOrYes withwithTime0:(NSString *)time0 withTime1:(NSString *)time1{
    NSMutableArray *arrayTpyeTempCount = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arrayTradeOrderSupplierStatusTempCount = [NSMutableArray arrayWithCapacity:0];
    if (view.tag == 0) {
        _arrayTypeNoOrYes0 = arrayTypeNoOrYes;
        NSArray *arrayType = @[@"COM",@"ATG",@"FTG",@"TTG"];
        NSString *inquiryTypeTemp = nil;
        for (NSInteger i = 0; i < arrayType.count; i++) {
            NSString *string = _arrayTypeNoOrYes0[i];
            if ([string isEqualToString:@"YES"]) {
                inquiryTypeTemp = arrayType[i];
            }
        }
        _inquiryTypeSelect0 = inquiryTypeTemp;
        
        
        _arrayStateNoOrYes0 = arrayStateNoOrYes;
        NSArray *arrayState = @[@"waitingPaymentForPurchase",@"paymentOvertime",@"paymentConfirm",@"purchasePaid",@"supplierDelivered",@"examineCargoForPurchase",@"alreadyExamineCargoForPurchase",@"success",@"close"];
        NSString *stateTemp = nil;
        for (NSInteger i = 0; i < arrayState.count; i++) {
            NSString *string = _arrayStateNoOrYes0[i];
            if ([string isEqualToString:@"YES"]) {
                stateTemp = arrayState[i];
            }
        }
        _inquiryOrderStatusSelect0 = stateTemp;
    }
    
    _timeSelect0 = time0;
    _timeSelect1 = time1;
    
    if (sender.tag == 301) {
        view.hidden = YES;
        self.imageArrow.hidden = YES;
        
        if (arrayTradeOrderSupplierStatusTempCount.count == 0 && arrayTpyeTempCount.count == 0) {
            [self.buttonScreen setImage:[UIImage imageNamed:@"icon_filter"] forState:UIControlStateNormal];
            [self.buttonScreen setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
        }
        if (view.tag == 0) {
            [self initRequestWithTableView:_tableView0 WithInquiryType:_inquiryTypeSelect0 WithInquiryOrderStatus:_inquiryOrderStatusSelect0 WithTime0:_timeSelect0 WithTime1:_timeSelect1 WithNoContentView:_viewNoContent0];
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
            
            NSArray *arrayState = @[@"waitingPaymentForPurchase",@"paymentOvertime",@"paymentConfirm",@"purchasePaid",@"supplierDelivered",@"examineCargoForPurchase",@"alreadyExamineCargoForPurchase",@"success",@"close"];
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
            [self.buttonScreen setImage:[UIImage imageNamed:@"icon_filter_3t"] forState:UIControlStateNormal];
            [self.buttonScreen setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
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
    return _arrayTradeOrderModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EGOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eGOrderCell" forIndexPath:indexPath];
    
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
    
    [self upDateArrayInquiryOrderModel:tableView WithindexPath:indexPath];
    
    TradeOrder *tradeOrder = _arrayTradeOrderModel[indexPath.section];
    
    DingDanXiangQingGongViewController *dingDanXiangQingViewController = [[DingDanXiangQingGongViewController alloc] init];
    dingDanXiangQingViewController.orderId = tradeOrder.orderId;
    [self.navigationController pushViewController:dingDanXiangQingViewController animated:YES];
}

- (IBAction)buttonSouSuo:(UIButton *)sender {
    FenLeiSouSuoViewController *flssVC = [[FenLeiSouSuoViewController alloc] init];
    flssVC.textFieldPlaceholder = @"搜索订单号或工艺";
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:flssVC] animated:YES completion:nil];
}

//查看原因
- (void)checkReason:(NSString *)inquiryOrderId {
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"查看原因" message:msg preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alertController addAction:action];
//    [self presentViewController:alertController animated:true completion:nil];
    
    XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
    xunPanXiangQingViewController.inquiryOrderId = inquiryOrderId;
    xunPanXiangQingViewController.isDefaultPurchase = DefaultSupplier;
    [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
}

- (void)buttonClickTradeOrder:(UIButton *)sender {
    self.indexPathIME = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    TradeOrder *tradeOrder = _arrayTradeOrderModel[sender.tag];
    
    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"purchasePaid"]) {
#pragma mark 发货
        FaHuoLieBiaoViewController09 *vc = [[FaHuoLieBiaoViewController09 alloc] init];
        vc.insideOrderCode = tradeOrder.insideOrderCode;
        vc.isOpenErp = tradeOrder.isOpenErp;
        [self.navigationController pushViewController:vc animated:true];
    } else if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"WAITORDER"]) {
#pragma mark 立即接单
        if ([tradeOrder.inquiryType isEqualToString:@"COM"] || [tradeOrder.inquiryType isEqualToString:@"ATG"]) {
            //COM-寻源\ATG-标准
            //暂时都进议价
            ChaKanShouPanJiePanYiJiaViewController *vc = [[ChaKanShouPanJiePanYiJiaViewController alloc] init];
            vc.orderId = tradeOrder.orderId;
            vc.inquiryOrderId = tradeOrder.inquiryOrderId;
            [self.navigationController pushViewController:vc animated:YES];
        } else if ([tradeOrder.inquiryType isEqualToString:@"TTG"]) {
            //TTG-议价
            ChaKanShouPanJiePanYiJiaViewController *vc = [[ChaKanShouPanJiePanYiJiaViewController alloc] init];
            vc.orderId = tradeOrder.orderId;
            vc.inquiryOrderId = tradeOrder.inquiryOrderId;
            [self.navigationController pushViewController:vc animated:YES];
            return;
        } else if ([tradeOrder.inquiryType isEqualToString:@"FTG"]) {
            //FTG-指定
            //暂时都进议价
            ChaKanShouPanJiePanYiJiaViewController *vc = [[ChaKanShouPanJiePanYiJiaViewController alloc] init];
            vc.orderId = tradeOrder.orderId;
            vc.inquiryOrderId = tradeOrder.inquiryOrderId;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if ((![tradeOrder.partType isEqualToString:@"FWJ"]) && [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"REFUSEDORDER"]) {
#pragma mark 查看原因
        [self checkReason:tradeOrder.inquiryOrderId];
    } else if ([tradeOrder.partType isEqualToString:@"FWJ"] && [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"ACCEPTFAILED"]) {
#pragma mark 查看原因
        [self checkReason:tradeOrder.inquiryOrderId];
    } else {
#pragma mark 查看订单
        DingDanXiangQingGongViewController *vc = [[DingDanXiangQingGongViewController alloc] init];
        vc.orderId = tradeOrder.orderId;
        [self.navigationController pushViewController:vc animated:YES];
    }

}


//- (void)tapSelector:(UITapGestureRecognizer *)tap {
//    [self.tableView.mj_header beginRefreshing];
//}

- (void)upDateArrayInquiryOrderModel:(UITableView *)tableView WithindexPath:(NSIndexPath *)indexPath {
    
    TradeOrder *model = _arrayTradeOrderModel[indexPath.row];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    
    TradeOrder *tradeOrder = [[TradeOrder alloc] init];
    tradeOrder.se_insideOrderCode = model.insideOrderCode;
    
    postEntityBean.entity = tradeOrder.mj_keyValues;
    
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    
    [HttpMamager postRequestWithURLString:DYZ_tradeOrder_supplier_tradeOrderList parameters:dic success:^(id responseObjectModel) {
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

- (void)initRequestWithTableView:(UITableView *)tableView WithInquiryType:(NSString *)inquiryType WithInquiryOrderStatus:(NSString *)tradeOrderPurchaseStatus WithTime0:(NSString *)time0 WithTime1:(NSString *)time1 WithNoContentView:(UIView *)viewNoContent{
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
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
        
        TradeOrder *tradeOrder = [[TradeOrder alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        tradeOrder.supplierEnterpriseId = loginModel.enterpriseId;
        
        //非标管家 19.06.03版
        tradeOrder.inquiryType = inquiryType;
        tradeOrder.tradeOrderPurchaseStatus = tradeOrderPurchaseStatus;
        tradeOrder.se_enterpriseOrderCode = self.se_enterpriseOrderCode;
        
        
        
        
        postEntityBean.entity = tradeOrder.mj_keyValues;
        

        postEntityBean.memberId = loginModel.memberId;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
//        NSLog(@">>%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_tradeOrder_supplier_tradeOrderList parameters:dic success:^(id responseObjectModel) {
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
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
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
        
        TradeOrder *tradeOrder = [[TradeOrder alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        tradeOrder.supplierEnterpriseId = loginModel.enterpriseId;
        
        //非标管家 19.06.03版
        tradeOrder.inquiryType = inquiryType;
        tradeOrder.tradeOrderPurchaseStatus = tradeOrderPurchaseStatus;
        tradeOrder.se_enterpriseOrderCode = self.se_enterpriseOrderCode;
        
        postEntityBean.entity = tradeOrder.mj_keyValues;
        
        postEntityBean.memberId = loginModel.memberId;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
    
        
        [HttpMamager postRequestWithURLString:DYZ_tradeOrder_supplier_tradeOrderList parameters:dic success:^(id responseObjectModel) {
            
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
    if ([vc isMemberOfClass:[EGOrderViewController class]]) {
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

- (NSString *)quantityUnit:(NSString *)string {
    if ([string isEqualToString:@"A"]) {
        return @"件";
    }
    if ([string isEqualToString:@"B"]) {
        return @"英尺";
    }
    if ([string isEqualToString:@"C"]) {
        return @"磅";
    }
    if ([string isEqualToString:@"D"]) {
        return @"吨";
    }
    if ([string isEqualToString:@"E"]) {
        return @"加仑";
    }
    if ([string isEqualToString:@"F"]) {
        return @"米";
    }
    if ([string isEqualToString:@"G"]) {
        return @"千克";
    }
    if ([string isEqualToString:@"H"]) {
        return @"公吨";
    }
    if ([string isEqualToString:@"I"]) {
        return @"升";
    }
    if ([string isEqualToString:@"J"]) {
        return @"套";
    }
    if ([string isEqualToString:@"K"]) {
        return @"套（组装件）";
    }
    if ([string isEqualToString:@"L"]) {
        return @"打";
    }
    if ([string isEqualToString:@"M"]) {
        return @"码";
    }
    if ([string isEqualToString:@"N"]) {
        return @"每个";
    }
    return nil;
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
