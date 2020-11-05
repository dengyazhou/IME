//
//  ECInquiryViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ECInquiryViewController.h"
#import "VoHeader.h"

#import "EChooseView.h"
#import "ECInquiryCell122.h"

#import "DingDanXiangQingCaiViewController.h"


#import "XunPanXiangQingViewController.h"
#import "TiWenViewController.h"
#import "HuiDaViewController.h"

#import "ChaKanShouPanViewController.h"
#import "ChaKanShouPanJiePanDingJiaViewController.h"
#import "ECChaKanShouPanYiJiaViewController.h"
#import "ChaKanDingJiaViewController.h"
#import "ECYiJiaViewController.h"
#import "ECChaKanBaoJiaYiJiaViewController.h"


#import "ShaiXuanBaoJiaViewController.h"

#import "AFNetworkReachabilityManager.h"



#import "ShouYeViewController.h"
#import "HuoDongViewController.h"

#import "ShenHeShouPanViewController.h"
#import "ShenHeShouPanYiJiaViewController.h"
#import "ShenHeShouPanDingJiaViewController.h"
#import "ShenHeShouPanHeJiaVC.h"
#import "ECChaKanShouPanHeJiaVC.h"
#import "ECChaKanBaoJiaHeJiaVC.h"

#import "ShouHuoSearchViewController09.h"
#import "ZhiJianSearchViewController09.h"
#import "SongDaSearchViewController09.h"

#import "ECOrderViewController.h"

#import "RefreshManager.h"
#import "GlobalSettingManager.h"

#import "EInspectionListVC.h"

@interface ECInquiryViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,EChooseViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate> {
    NSArray *_arrayButton;
    UITableView *_tableView0;
    
    NSArray *_arrayType0;
    NSMutableArray *_arrayTypeNoOrYes0;

    NSArray *_arrayState;
    NSMutableArray *_arrayStateNoOrYes0;
    NSMutableArray *_arrayTimeNoOrYes;
    
    EChooseView *_eChooseView0;
    
    NSMutableArray *_arrayInquiryOrderModel;
    NSInteger _aPage;

    NSString *_inquiryTypeSelect0;//询盘类型
    NSString *_inquiryOrderStatusSelect0;
    NSString *_timeSelect0;
    NSString *_timeSelect1;
    
    UIView *_viewNoContent0;
    UIView *_viewRequestTimeout;
    
    UIView *_viewNoNet;
    
    NSArray *_arrayCheXiaoXunPan;
    InquiryOrder *_inquiryOrderQuXiaoXunPan;
    
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

@property (weak, nonatomic) IBOutlet UIButton *buttonScreen;//筛选


@property (nonatomic,strong) NSIndexPath *indexPathIME;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (weak, nonatomic) IBOutlet UIView *viewZhiJianShouHuoBg;
@property (weak, nonatomic) IBOutlet UIView *viewZhiJIanShouHuo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewZhiJianShouHuoTop;


@end

@implementation ECInquiryViewController

- (int)getPlus:(int)num1 num2:(int)num2 {
    return num1 + num2;
}

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
        } else {

        }
        
        [self refresh];
        _firstRefresh = @"second";
    }
    
}

- (void)dealloc {
#pragma mark KVO 移除观察者
    RefreshManager *rManager = [RefreshManager shareRefreshManager];
    [rManager removeObserver:self forKeyPath:@"eCInquiryVC"];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notificationRefreshECInquiryFaPan" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.viewZhiJIanShouHuo.layer.cornerRadius = 4;
    self.viewZhiJIanShouHuo.layer.shadowColor = [UIColor blackColor].CGColor;
    self.viewZhiJIanShouHuo.layer.shadowOffset = CGSizeMake(0, 2);
    self.viewZhiJIanShouHuo.layer.shadowRadius = 4;
    self.viewZhiJIanShouHuo.layer.shadowOpacity = 0.1;
    
    self.viewZhiJianShouHuoBg.hidden = true;
    self.viewZhiJianShouHuoTop.constant = _height_NavBar;
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    singleFingerOne.delegate = self;
    [self.viewZhiJianShouHuoBg addGestureRecognizer:singleFingerOne];
    
    
    _firstRefresh = @"first";
    
#pragma mark KVO 添加观察者
    RefreshManager *rManager = [RefreshManager shareRefreshManager];
    [rManager addObserver:self forKeyPath:@"eCInquiryVC" options:NSKeyValueObservingOptionOld context:@"RefreshManager_eCInquiryVC"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRefreshFaPan:) name:@"notificationRefreshECInquiryFaPan" object:nil];
    
    [self initUI];
    

    [self initRequestWithTableView:_tableView0 WithInquiryType:nil WithInquiryOrderStatus:nil WithTime0:nil WithTime1:nil WithNoContentView:_viewNoContent0];
    
    
    self.viewPickView0 = [[UIView alloc] initWithFrame:self.view.frame];
    self.viewPickView0.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:self.viewPickView0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelectorQuXiao:)];
    [self.viewPickView0 addGestureRecognizer:tap];
    
    self.viewPickView1 = [[UIView alloc] initWithFrame:CGRectMake(0, kMainH-250, kMainW, 250)];
    self.viewPickView1.backgroundColor = colorBG;
    [self.view addSubview:self.viewPickView1];
    UIButton *buttonL = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonL.frame = CGRectMake(30, 0, (kMainW-60)/2, 45);
    [buttonL setTitle:@"取消" forState:UIControlStateNormal];
    buttonL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [buttonL addTarget:self action:@selector(buttonWanCheng:) forControlEvents:UIControlEventTouchUpInside];
    buttonL.titleLabel.font = [UIFont systemFontOfSize:15];
    buttonL.tag = 2;
    [self.viewPickView1 addSubview:buttonL];
    
    UIButton *buttonR = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonR.frame = CGRectMake(kMainW/2, 0, (kMainW-60)/2, 45);
    [buttonR setTitle:@"完成" forState:UIControlStateNormal];
    buttonR.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [buttonR addTarget:self action:@selector(buttonWanCheng:) forControlEvents:UIControlEventTouchUpInside];
    buttonR.titleLabel.font = [UIFont systemFontOfSize:15];
    buttonR.tag = 3;
    [self.viewPickView1 addSubview:buttonR];
    
    _arrayCheXiaoXunPan = @[@"不需要询盘了",@"零件描述有误",@"收获地址有误",@"询盘时间太短",@"线下已找到供应商",@"其他原因"];
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, kMainW, CGRectGetHeight(self.viewPickView1.frame)-45)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [self.viewPickView1 addSubview:self.pickerView];
    self.viewPickView0.hidden = YES;
    self.viewPickView1.hidden = YES;
}

#pragma mark KVO 观察者回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == @"RefreshManager_eCInquiryVC") {
        if ([keyPath isEqualToString:@"eCInquiryVC"]) {
            [self kVORefresh];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.viewZhiJIanShouHuo]) {
        return NO;
    }
    return YES;
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)tap{
    self.viewZhiJianShouHuoBg.hidden = true;
}
- (IBAction)buttonSelectZhiJianOrShouhuo:(id)sender {
    self.viewZhiJianShouHuoBg.hidden = false;
}

#pragma mark 质检、收货、送达、巡检
- (IBAction)buttonZhiJianOrShouHuoClick:(UIButton *)sender {
    self.viewZhiJianShouHuoBg.hidden = true;
    if (sender.tag == 0) {//质检
        ZhiJianSearchViewController09 *vc = [[ZhiJianSearchViewController09 alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    } else if (sender.tag == 1) {//收货
        ShouHuoSearchViewController09 *vc = [[ShouHuoSearchViewController09 alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    } else if (sender.tag == 2) {//送达
        SongDaSearchViewController09 *vc = [[SongDaSearchViewController09 alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    } else if (sender.tag == 3) {//巡检
        EInspectionListVC *vc = [[EInspectionListVC alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    }
}

- (void)kVORefresh {
    if (!_indexInquiryType) {
        _indexInquiryType = 0;
    }
    if (_indexInquiryType == 0) {
        [self upDateArrayInquiryOrderModel:_tableView0 WithindexPath:self.indexPathIME];
    }
}

- (void)notificationRefreshFaPan:(NSNotification *)info {
    [_tableView0.mj_header beginRefreshing];
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
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = colorBG;
    self.scrollView.scrollEnabled = NO;
    
    _tableView0 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH-_height_NavBar-42.5-_height_TabBar) style:UITableViewStyleGrouped];
    _tableView0.delegate = self;
    _tableView0.dataSource = self;
    _tableView0.tag = 200;
    _tableView0.backgroundColor = [UIColor clearColor];
    [_tableView0 registerNib:[UINib nibWithNibName:@"ECInquiryCell122" bundle:nil] forCellReuseIdentifier:@"eCInquiryCell122"];
    _tableView0.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView0.tableFooterView = [UIView new];
    _tableView0.estimatedRowHeight = 226.5;
    _tableView0.rowHeight = UITableViewAutomaticDimension;
    [self.scrollView addSubview:_tableView0];
    _viewNoContent0 = [UIView addViewNoNetWithScrollView:self.scrollView tableView:_tableView0 imageNamed:@"ime_picture_inquiry_empty" label0Text:@"无内容" label1Text:@"暂时没有全部询盘"];
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
    
    _arrayState = @[@"未报价",@"已报价",@"已授单",@"拒绝报价",@"询盘取消"];
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


    _eChooseView0 = [[EChooseView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH) withTitleState:@"询盘类型" withState:_arrayType0 withArrayTypeNoOrYes:_arrayTypeNoOrYes0 withTitleState:@"询盘状态" withState:_arrayState withArrayStateNoOrYes:_arrayStateNoOrYes0 withTitleTime:@"询盘截止日期" withTime0:nil withTime1:nil with:@[@"重置",@"确认"] withColor:colorCai];
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
            [but setTitleColor:colorCai forState:UIControlStateNormal];
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
        
        NSArray *arrayState = @[@"NEW",@"QUOTATION",@"SEND",@"REFUSE",@"CANCEL"];//DYZSHSP 审核授盘
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
        [self.buttonScreen setTitleColor:colorCai forState:UIControlStateNormal];
    }
/*－－－－改变筛选的颜色－－－－*/
    
    
    _arrayInquiryOrderModel = nil;
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
        
        NSArray *arrayState = @[@"NEW",@"QUOTATION",@"SEND",@"REFUSE",@"CANCEL"];
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
        [self.buttonScreen setTitleColor:colorCai forState:UIControlStateNormal];
    }
}

- (IBAction)buttonShaiXuan:(UIButton *)sender {
    if (_indexInquiryType == 0) {
        _eChooseView0.hidden = NO;
    }
    
    self.imageArrow.hidden = NO;
    [sender setImage:[UIImage imageNamed:@"icon_filter_2t"] forState:UIControlStateNormal];
    [sender setTitleColor:colorCai forState:UIControlStateNormal];
}

- (void)eChooseViewDelegate:(EChooseView *)view ButtonClick3:(UIButton *)sender withArrayTypeNoOrYes:(NSMutableArray *)arrayTypeNoOrYes withArrayStateNoOrYes:(NSMutableArray *)arrayStateNoOrYes withwithTime0:(NSString *)time0 withTime1:(NSString *)time1{
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
        NSArray *arrayState = @[@"NEW",@"QUOTATION",@"SEND",@"REFUSE",@"CANCEL"];
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
        
        if (_inquiryTypeSelect0 == nil && _inquiryOrderStatusSelect0 == nil && _timeSelect0 == nil && _timeSelect1 == nil) {
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
            
            NSArray *arrayState = @[@"NEW",@"QUOTATION",@"SEND",@"REFUSE",@"CANCEL"];
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
            [self.buttonScreen setTitleColor:colorCai forState:UIControlStateNormal];
        }
        /*－－－－改变筛选的颜色－－－－*/
        
        _arrayInquiryOrderModel = nil;
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
                [but setTitleColor:colorCai forState:UIControlStateNormal];
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
    
    ECInquiryCell122 *cell = [tableView dequeueReusableCellWithIdentifier:@"eCInquiryCell122" forIndexPath:indexPath];
    InquiryOrder *inquiryOrderModel = _arrayInquiryOrderModel[indexPath.section];
    
    [cell initDataWith:inquiryOrderModel andQuanXian:nil];

    [cell.buttonL addTarget:self action:@selector(buttonClickInquiryOrder:) forControlEvents:UIControlEventTouchUpInside];
    [cell.buttonR addTarget:self action:@selector(buttonClickInquiryOrder:) forControlEvents:UIControlEventTouchUpInside];
    cell.buttonL.tag = indexPath.section;
    cell.buttonR.tag = indexPath.section;

    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 148;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.indexPathIME = [NSIndexPath indexPathForRow:indexPath.section inSection:0];
    
    InquiryOrder *inquiryOrderModel =  _arrayInquiryOrderModel[indexPath.section];;
    XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
    xunPanXiangQingViewController.inquiryOrderId = inquiryOrderModel.inquiryOrderId;
    [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
}

- (void)tapSelectorQuXiao:(UITapGestureRecognizer *)tap {
    self.viewPickView0.hidden = YES;
    self.viewPickView1.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

//查看订单 到 采购商订单列表
- (void)goPurchaseTradeOrderList:(InquiryOrder *)inquiryOrder{
    ECOrderViewController *vc = [[ECOrderViewController alloc] init];
    vc.se_enterpriseOrderCode = inquiryOrder.enterpriseOrderCode;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)buttonClickInquiryOrder:(UIButton *)sender {
    self.indexPathIME = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    InquiryOrder *inquiryOrder = _arrayInquiryOrderModel[sender.tag];
    
    if ([inquiryOrder.inquiryType isEqualToString:@"COM"] || [inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
        //COM 寻源，ATG 标准
        if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"NEW"]) {
            //未报价
#pragma mark 查询询盘
            XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
            xunPanXiangQingViewController.inquiryOrderId = inquiryOrder.inquiryOrderId;
            xunPanXiangQingViewController.isDefaultPurchase = DefaultPurchase;
            [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
        } else if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"QUOTATION"]) {
            //已报价
#pragma mark 筛选报价
            ShaiXuanBaoJiaViewController *shaiXuanBaoJiaViewController = [[ShaiXuanBaoJiaViewController alloc] init];
            shaiXuanBaoJiaViewController.inquiryOrder = inquiryOrder;
            [self.navigationController pushViewController:shaiXuanBaoJiaViewController animated:YES];
        } else if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"SEND"]) {
            //已授单
#pragma mark 查看订单
            [self goPurchaseTradeOrderList:inquiryOrder];
        } else if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"REFUSE"]) {
            //拒绝报价
#pragma mark 查看原因
            XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
            xunPanXiangQingViewController.inquiryOrderId = inquiryOrder.inquiryOrderId;
            xunPanXiangQingViewController.isDefaultPurchase = DefaultPurchase;
            [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
            
        } else if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
            //询盘取消
#pragma mark 查询询盘
            XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
            xunPanXiangQingViewController.inquiryOrderId = inquiryOrder.inquiryOrderId;
            xunPanXiangQingViewController.isDefaultPurchase = DefaultPurchase;
            [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
        }
    } else if ([inquiryOrder.inquiryType isEqualToString:@"TTG"]) {
        //TTG 议价
        if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"SEND"]) {
            //已授单
            if (inquiryOrder.inquiryOrderEnterprises[0].canEditPrice.integerValue == 0) {
#pragma mark 查看订单
                [self goPurchaseTradeOrderList:inquiryOrder];
            } else {
                if (inquiryOrder.inquiryOrderEnterprises[0].purchaseHasQuoed.integerValue == 1) {
#pragma mark 修改报价
                    ECYiJiaViewController *vc = [[ECYiJiaViewController alloc] init];
                    vc.inquiryOrderId = inquiryOrder.inquiryOrderId;
                    vc.quotationOrderId = inquiryOrder.inquiryOrderEnterprises[0].quotationOrderId;
                    [self.navigationController pushViewController:vc animated:YES];
                } else {
#pragma mark 立即报价
                    ECYiJiaViewController *vc = [[ECYiJiaViewController alloc] init];
                    vc.inquiryOrderId = inquiryOrder.inquiryOrderId;
                    vc.quotationOrderId = inquiryOrder.inquiryOrderEnterprises[0].quotationOrderId;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        } else if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
#pragma mark 查看询盘
            XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
            xunPanXiangQingViewController.inquiryOrderId = inquiryOrder.inquiryOrderId;
            xunPanXiangQingViewController.isDefaultPurchase = DefaultPurchase;
            [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
        }
    } else if ([inquiryOrder.inquiryType isEqualToString:@"FTG"]) {
        //FTG 指定
        if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"SEND"]) {
            //已授单
#pragma mark 查看订单
            [self goPurchaseTradeOrderList:inquiryOrder];
        } else if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
            //询盘取消
#pragma mark 查看询盘
            XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
            xunPanXiangQingViewController.inquiryOrderId = inquiryOrder.inquiryOrderId;
            xunPanXiangQingViewController.isDefaultPurchase = DefaultPurchase;
            [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
        }
    }
    
}



#pragma mark 取消询盘
- (void)buttonWanCheng:(UIButton *)sender {
    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:21]]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
        return;
    }
    
    if (sender.tag == 2) {
        self.tabBarController.tabBar.hidden = NO;
        self.viewPickView0.hidden = YES;
        self.viewPickView1.hidden = YES;
    }
    if (sender.tag == 3) {
        NSInteger row = [self.pickerView selectedRowInComponent:0];
        
        InquiryOrder *inquiryOrderModel = _inquiryOrderQuXiaoXunPan;
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        inquiryOrder.inquiryOrderId = inquiryOrderModel.inquiryOrderId;
        inquiryOrder.manufacturerId = inquiryOrderModel.manufacturerId;
        //    inquiryOrder.cancelId = @"";
        inquiryOrder.cancelMsg = _arrayCheXiaoXunPan[row];
        //    inquiryOrder.cancelName = @"";
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        //    NSLog(@"%@",dic);
        [HttpMamager postRequestWithURLString:DYZ_inquiry_cancel parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [self kVORefresh];
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"取消成功"];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"取消失败"];
            }
            self.tabBarController.tabBar.hidden = NO;
            self.viewPickView0.hidden = YES;
            self.viewPickView1.hidden = YES;
        } fail:^(NSError *error) {
            self.tabBarController.tabBar.hidden = NO;
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    }
}

- (void)upDateArrayInquiryOrderModel:(UITableView *)tableView WithindexPath:(NSIndexPath *)indexPath {
    InquiryOrder *model = _arrayInquiryOrderModel[indexPath.row];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;

    InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
    inquiryOrder.se_enterpriseOrderCode = model.enterpriseOrderCode;
    
    postEntityBean.entity = inquiryOrder.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_inquiry_purchase_list parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            
            NSMutableArray *arrayInquiryOrder = model.list;
            for (NSDictionary *dic in arrayInquiryOrder) {
                InquiryOrder *obj = [InquiryOrder mj_objectWithKeyValues:dic];
                [_arrayInquiryOrderModel replaceObjectAtIndex:indexPath.row withObject:obj];
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
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_inquiry_purchase_list parameters:dic success:^(id responseObjectModel) {
        dataBlock(responseObjectModel);
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (void)initRequestWithTableView:(UITableView *)tableView WithInquiryType:(NSString *)inquiryType WithInquiryOrderStatus:(NSString *)inquiryOrderStatus WithTime0:(NSString *)time0 WithTime1:(NSString *)time1 WithNoContentView:(UIView *)viewNoContent{
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
        
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
      
        inquiryOrder.manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
        
        inquiryOrder.inquiryType = inquiryType;
        inquiryOrder.inquiryOrderStatus = inquiryOrderStatus;
        
        inquiryOrder.sec_hasSendQuo = [NSNumber numberWithBool:YES];
        
        inquiryOrder.seb_endTm = time0;
        inquiryOrder.see_endTm = time1;
        
        postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;;
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;

//        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_inquiry_purchase_list parameters:dic success:^(id responseObjectModel) {
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
//            ReturnEntityBean
//            ReturnListBean
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
        
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        inquiryOrder.manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
        inquiryOrder.inquiryType = inquiryType;
        inquiryOrder.inquiryOrderStatus = inquiryOrderStatus;
        
        inquiryOrder.sec_hasSendQuo = [NSNumber numberWithBool:YES];
        
        inquiryOrder.seb_endTm = time0;
        inquiryOrder.see_endTm = time1;
        
        postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;

        [HttpMamager postRequestWithURLString:DYZ_inquiry_purchase_list parameters:dic success:^(id responseObjectModel) {
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

#pragma mark UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arrayCheXiaoXunPan.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _arrayCheXiaoXunPan[row];
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
