//
//  ECaiTuoGuanSupplierViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ECTuoGuanSupplierViewController.h"
#import "VoHeader.h"

#import "ECPingJiaCell.h"
#import "ECPingJiaCell1.h"
#import "ECOrderCell.h"
#import "Masonry.h"
#import "ECTGSPingJiaViewController.h"
#import "ECTGSPingJiaViewController1.h"
#import "ECTGSPingJiaViewController2.h"

#import "EH5FuKuanViewController.h"
#import "EShengChangJingduXiangXiViewController.h"
#import "FaBaoPingLunCaiViewController.h"
#import "LineView.h"
#import "DingDanXiangQingCaiViewController.h"

#import "FaBaoPingLunTuoGuanViewController.h"

#import "FaBaoPingLunTuoGuanChaKanViewController.h"
#import "ECInquiryCell122.h"
#import "ShaiXuanBaoJiaViewController.h"
#import "ChaKanShouPanJiePanDingJiaViewController.h"
#import "ECChaKanShouPanYiJiaViewController.h"
#import "ChaKanShouPanViewController.h"
#import "ECYiJiaViewController.h"
#import "ChaKanDingJiaViewController.h"
#import "ECChaKanBaoJiaYiJiaViewController.h"
#import "ChaKanZiJiDeBaoJiaViewController.h"
#import "XunPanXiangQingViewController.h"
#import "ECCheckTheLogisticsViewController.h"
#import "ShouHuoLieBiaoVC.h"
#import "YanHuoLieBiaoVC.h"


@interface ECTuoGuanSupplierViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray *_arrayButton;
    UITableView *_tableView0;//供应商评价
    UITableView *_tableViewECOrder;//全部订单
    UITableView *_tableView2;//供应商资料
//    UITableView *_tableView3;//全部询盘单 @property (nonatomic,strong) UITableView *tableView3;
//    UITableView *_tableView4;//供应商信息
    
    NSArray *_arrayPurchase;//采购类
    NSArray *_arrayPurchaseComWeight;//采购类 权重
    NSArray *_arrayQuality;//质量类
    NSArray *_arrayQualityComWeight;//质量类 权重
    
    NSArray *_arrayComment;//评论
    
    UIButton *_tableHeaderButton;
    UILabel *_tableHeaderLabel;
    
    NSArray *_arrayYears;
    NSArray *_arrayMonth;
    NSString *_stringYearTemp;
    NSString *_stringMonthTemp;
    NSString *_stringYear;
    NSString *_stringMonth;
    
    BOOL _recentEpComment;//获取企业最近评价
    
    NSMutableArray *_arrayEnterpriseCommentModel;
    
    EnterpriseComment *_enterpriseCommentModel;
    
    NSString * _returnCode;
    
    NSMutableArray *_arrayTradeOrderModel;
    NSInteger _aPage;
    
    UIView *_viewRequestTimeout;
    UIView *_viewNoContent;
    
    NSMutableArray *_arrayInquiryOrderModel;
    NSInteger _aPageECInquiry;
    
    UIView *_viewRequestTimeoutECInquiry;
    UIView *_viewNoContentECInquiry;

    
}


@property (weak, nonatomic) IBOutlet UIView *buttonViewBG5;
@property (weak, nonatomic) IBOutlet UILabel *labelLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLineCenterX;
@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;

@property (weak, nonatomic) IBOutlet UIView *buttonViewBG4;
@property (weak, nonatomic) IBOutlet UILabel *labelLine4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLineCenterX4;
@property (weak, nonatomic) IBOutlet UIButton *button00;
@property (weak, nonatomic) IBOutlet UIButton *button01;
@property (weak, nonatomic) IBOutlet UIButton *button02;
@property (weak, nonatomic) IBOutlet UIButton *button03;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *viewPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic,strong) UITableView *tableView3;//全部询盘单
@property (nonatomic,strong) UITableView *tableView4;//供应商信息

@property (nonatomic,strong) EnterpriseRelation *enterpriseRelation;//供应商信息

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightView;


@end

@implementation ECTuoGuanSupplierViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    
    if (_recentEpComment == YES) {
        _recentEpComment = NO;
    } else {
        [self initRequestEnterpriseCommentEpCommentList];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE_X) {
        self.heightView.constant = 170+24;
    } else {
        self.heightView.constant = 170;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    
    
    _stringYear = [[strDate componentsSeparatedByString:@"-"] firstObject];
    _stringMonth = [[strDate componentsSeparatedByString:@"-"] lastObject];
    
    _returnCode = @"0";
    
    _recentEpComment = YES;
    
    self.buttonViewBG4.hidden = YES;
    self.buttonViewBG5.hidden = YES;
    NSInteger isTemporary = [self.enterpriseRelationSuper.passiveEnterprise.isTemporary integerValue];//1临时用户 0线上用户
    if (isTemporary == 1) {
        self.buttonViewBG4.hidden = NO;
        _arrayButton = @[_button00,_button01,_button02,_button03];
        for (int i = 0; i < _arrayButton.count; i++) {
            UIButton *button = _arrayButton[i];
            button.tag = 100+i;
            [button addTarget:self action:@selector(buttonClick4:) forControlEvents:UIControlEventTouchUpInside];
        }
    } else {
        self.buttonViewBG5.hidden = NO;
        _arrayButton = @[_button0,_button1,_button2,_button3,_button4];
        for (int i = 0; i < _arrayButton.count; i++) {
            UIButton *button = _arrayButton[i];
            button.tag = 100+i;
            [button addTarget:self action:@selector(buttonClick5:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    
    _viewPicker.hidden = YES;
    _viewPicker.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelectorQuXiao:)];
    [_viewPicker addGestureRecognizer:tapGesture];
    
    
    self.scrollView.tag = 500;
    self.scrollView.contentSize = CGSizeMake(kMainW*_arrayButton.count, 0);
    self.scrollView.pagingEnabled = YES;
    
    [self.logoImg sd_setImageWithURL:[NSURL URLWithString:self.enterpriseRelationSuper.passiveEnterprise.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
    self.enterpriseName.text = self.enterpriseRelationSuper.passiveEnterprise.enterpriseName;
    self.zoneStr.text = self.enterpriseRelationSuper.passiveEnterprise.zoneStr;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    Member *memberModel = [Member mj_objectWithKeyValues:loginModel.member];
    _arrayPurchaseComWeight = @[memberModel.enterpriseInfo.comWeight1?memberModel.enterpriseInfo.comWeight1:@"--",memberModel.enterpriseInfo.comWeight2?memberModel.enterpriseInfo.comWeight2:@"--",memberModel.enterpriseInfo.comWeight3?memberModel.enterpriseInfo.comWeight3:@"--",memberModel.enterpriseInfo.comWeight4?memberModel.enterpriseInfo.comWeight4:@"--"];
    _arrayQualityComWeight = @[memberModel.enterpriseInfo.comWeight5?memberModel.enterpriseInfo.comWeight5:@"--"];
    
    _arrayPurchase = @[@"报价及时性及配合",@"报价专业性",@"加急事项的处理能力",@"交货及时率"];
    
    _arrayQuality = @[@"产品质量"];
//    _arrayComment = @[@"X规划指南、启动了一批重大工程和项目、创建了一批试点示范城市、制定了分省市建设指南。体系既已搭建，剩下的就只有往里“输血”之后期待顺利激活了",@"华为成功中标烟台市高速公路智能交通安全系统采购项目，考虑高速交警“双网双平台”建设模式和建设需求，创新性地采用其全球领先的双平面传输架构，成功在一套传输系统中兼容了两种需求迥异的业务模型"];
    
    _tableView0 = [[UITableView alloc] initWithFrame:CGRectMake(kMainW*3, 0, kMainW, kMainH-170-55-10) style:UITableViewStylePlain];
    _tableView0.delegate = self;
    _tableView0.dataSource = self;
    _tableView0.tag = 200;
    _tableView0.backgroundColor = [UIColor clearColor];
    [_tableView0 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView0 registerNib:[UINib nibWithNibName:@"ECPingJiaCell" bundle:nil] forCellReuseIdentifier:@"eCPingJiaCell"];
    [_tableView0 registerNib:[UINib nibWithNibName:@"ECPingJiaCell1" bundle:nil] forCellReuseIdentifier:@"eCPingJiaCell1"];
    _tableView0.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView0.tableFooterView = [UIView new];
    [self.scrollView addSubview:_tableView0];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 60)];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    
    UIView *viewLineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableHeaderView.frame), 0.5)];
    viewLineTop.backgroundColor = colorRGB(221, 221, 221);
    [tableHeaderView addSubview:viewLineTop];
    
    _tableHeaderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _tableHeaderButton.frame = CGRectMake(0, 0, kMainW/2, CGRectGetHeight(tableHeaderView.frame)-1);
    [_tableHeaderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_tableHeaderButton setTitle:[NSString stringWithFormat:@"%@年%@月",_stringYear,_stringMonth] forState:UIControlStateNormal];
    [_tableHeaderButton setImage:[UIImage imageNamed:@"ime_e_icon_down"] forState:UIControlStateNormal];
    
    [_tableHeaderButton setImageEdgeInsets:UIEdgeInsetsMake(0, _tableHeaderButton.titleLabel.intrinsicContentSize.width, 0, -_tableHeaderButton.titleLabel.intrinsicContentSize.width)];
    [_tableHeaderButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -_tableHeaderButton.currentImage.size.width, 0, _tableHeaderButton.currentImage.size.width)];
    
    [_tableHeaderButton addTarget:self action:@selector(tableHeaderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tableHeaderView addSubview:_tableHeaderButton];
    
    UIView *viewLineMid = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_tableHeaderButton.frame), 0, 0.5, CGRectGetHeight(tableHeaderView.frame))];
    viewLineMid.backgroundColor = colorRGB(221, 221, 221);
    [tableHeaderView addSubview:viewLineMid];
    
    _tableHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(viewLineMid.frame), 0, CGRectGetWidth(_tableHeaderButton.frame), CGRectGetHeight(_tableHeaderButton.frame))];
    _tableHeaderLabel.text = @"综合评分？分";
    _tableHeaderLabel.textAlignment = NSTextAlignmentCenter;
    [tableHeaderView addSubview:_tableHeaderLabel];
    
    UIView *viewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(tableHeaderView.frame)-0.5, kMainW, 0.5)];
    viewLineBottom.backgroundColor = colorRGB(221, 221, 221);
    [tableHeaderView addSubview:viewLineBottom];
    
    _tableView0.tableHeaderView = tableHeaderView;
    
    _tableViewECOrder = [[UITableView alloc] initWithFrame:CGRectMake(kMainW*2, 0, kMainW, kMainH-170-55-10) style:UITableViewStyleGrouped];
    _tableViewECOrder.delegate = self;
    _tableViewECOrder.dataSource = self;
    _tableViewECOrder.tag = 201;
    _tableViewECOrder.backgroundColor = [UIColor clearColor];
    [_tableViewECOrder registerNib:[UINib nibWithNibName:@"ECOrderCell" bundle:nil] forCellReuseIdentifier:@"eCOrderCell"];
    _tableViewECOrder.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableViewECOrder.tableFooterView = [UIView new];
    _tableViewECOrder.estimatedRowHeight = 226.5;
    _tableViewECOrder.rowHeight = UITableViewAutomaticDimension;
    [self.scrollView addSubview:_tableViewECOrder];

    _viewRequestTimeout = [UIView addView:CGRectMake(kMainW*2, 0, kMainW, kMainH-170-55-10) withTitle:@"请求超时"];
    [self.scrollView addSubview:_viewRequestTimeout];
    _viewRequestTimeout.hidden = YES;
    
    _viewNoContent = [UIView addViewNoNetWithScrollView:self.scrollView tableView:_tableViewECOrder imageNamed:@"ime_picture_empty" label0Text:@"无内容" label1Text:@"暂时没有订单"];
    _viewNoContent.hidden = YES;
    
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(kMainW*4, 0, kMainW, kMainH-170-55-10) style:UITableViewStylePlain];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.tag = 202;
    _tableView2.backgroundColor = [UIColor clearColor];
    [_tableView2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.tableFooterView = [UIView new];
    [self.scrollView addSubview:_tableView2];
    
    
    
    [self.scrollView addSubview:self.tableView3];
    _viewRequestTimeoutECInquiry = [UIView addView:CGRectMake(kMainW, 0, kMainW, kMainH-170-55-10) withTitle:@"请求超时"];
    [self.scrollView addSubview:_viewRequestTimeoutECInquiry];
    _viewRequestTimeoutECInquiry.hidden = YES;
    
    _viewNoContentECInquiry = [UIView addViewNoNetWithScrollView:self.scrollView tableView:self.tableView3 imageNamed:@"ime_picture_inquiry_empty" label0Text:@"无内容" label1Text:@"暂时没有询盘"];
    _viewNoContentECInquiry.hidden = YES;
    
    
    [self.scrollView addSubview:self.tableView4];
    
    if (isTemporary == 1) {//1临时用户 0线上用户
        _tableView2.hidden = YES;
    } else {
        _tableView2.hidden = NO;
    }
    
    _arrayYears =@[@"2017",@"2016",@"2015",@"2014",@"2013"];
    _arrayMonth = @[@"12",@"11",@"10",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1"];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    [self initEpRelationTrustRelationDetail:self.tableView4 WithNoContentView:nil];
   
    [self initRequestECOrderWithTableView:_tableViewECOrder WithNoContentView:_viewNoContent];
    
    [self initRequestECInquiryWithTableView:self.tableView3 WithNoContentView:_viewNoContentECInquiry];
    
    
    [self initRequestEnterpriseCommentRecentEpComment];
}

- (UITableView *)tableView3 {//询盘
    if (!_tableView3) {
        _tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(kMainW, 0, kMainW, kMainH-170-55-10) style:UITableViewStyleGrouped];
        _tableView3.delegate = self;
        _tableView3.dataSource = self;
        _tableView3.tag = 203;
        _tableView3.backgroundColor = [UIColor clearColor];
        [_tableView3 registerNib:[UINib nibWithNibName:@"ECInquiryCell122" bundle:nil] forCellReuseIdentifier:@"eCInquiryCell122"];
        _tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView3.tableFooterView = [UIView new];
        _tableView3.estimatedRowHeight = 226.5;
        _tableView3.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView3;
}

- (UITableView *)tableView4 {//供应商信息
    if (!_tableView4) {
        _tableView4 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH-170-55-10) style:UITableViewStylePlain];
        _tableView4.delegate = self;
        _tableView4.dataSource = self;
        _tableView4.tag = 204;
        _tableView4.backgroundColor = [UIColor clearColor];
        [_tableView4 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView4.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView4.tableFooterView = [UIView new];
    }
    return _tableView4;
}

- (void)buttonClick4:(UIButton *)sender {
    self.labelLineCenterX4.constant = 0;
    self.labelLineCenterX4.constant = CGRectGetWidth(sender.frame) * (sender.tag-100);
    NSArray *arrayImage0 = @[@"icon1_未选中",@"icon4_未选中",@"icon5_未选中",@"icon2_未选中",@"icon3_未选中"];
    NSArray *arrayImage1 = @[@"icon1_选中",@"icon4_选中",@"icon5_选中",@"icon2_选中",@"icon3_选中"];
    for (int i = 0; i < _arrayButton.count; i++) {
        UIButton *but = _arrayButton[i];
        if ((sender.tag-100) == i) {
            [but setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
            [but setImage:[UIImage imageNamed:arrayImage1[i]] forState:UIControlStateNormal];
        } else {
            [but setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
            [but setImage:[UIImage imageNamed:arrayImage0[i]] forState:UIControlStateNormal];
        }
    }
    [self.scrollView setContentOffset:CGPointMake((sender.tag-100)*kMainW, 0)];
    
    if ((sender.tag-100) == 1) {//询盘刷新
        [self.tableView3.mj_header beginRefreshing];
    }
    if ((sender.tag-100) == 2) {//订单刷新
        [_tableViewECOrder.mj_header beginRefreshing];
    }
}

- (void)buttonClick5:(UIButton *)sender {
    self.labelLineCenterX.constant = 0;
    self.labelLineCenterX.constant = CGRectGetWidth(sender.frame) * (sender.tag-100);
    NSArray *arrayImage0 = @[@"icon1_未选中",@"icon4_未选中",@"icon5_未选中",@"icon2_未选中",@"icon3_未选中"];
    NSArray *arrayImage1 = @[@"icon1_选中",@"icon4_选中",@"icon5_选中",@"icon2_选中",@"icon3_选中"];
    for (int i = 0; i < _arrayButton.count; i++) {
        UIButton *but = _arrayButton[i];
        if ((sender.tag-100) == i) {
            [but setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
            [but setImage:[UIImage imageNamed:arrayImage1[i]] forState:UIControlStateNormal];
        } else {
            [but setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
            [but setImage:[UIImage imageNamed:arrayImage0[i]] forState:UIControlStateNormal];
        }
    }
    [self.scrollView setContentOffset:CGPointMake((sender.tag-100)*kMainW, 0)];
    
    if ((sender.tag-100) == 1) {//询盘刷新
        [self.tableView3.mj_header beginRefreshing];
    }
    if ((sender.tag-100) == 2) {//订单刷新
        [_tableViewECOrder.mj_header beginRefreshing];
    }
}

- (void)tableHeaderButtonClick:(UIButton *)sender {
    [_tableHeaderButton setImage:[UIImage imageNamed:@"ime_e_icon_upper"] forState:UIControlStateNormal];
    
//    NSLog(@"%@",NSStringFromUIEdgeInsets(sender.titleEdgeInsets));
//    NSLog(@"%@",NSStringFromUIEdgeInsets(sender.imageEdgeInsets));
    
    _viewPicker.hidden = NO;
}
- (IBAction)buttonCancel:(UIButton *)sender {
    [_tableHeaderButton setImage:[UIImage imageNamed:@"ime_e_icon_down"] forState:UIControlStateNormal];
    _viewPicker.hidden = YES;
}
- (void)tapSelectorQuXiao:(UITapGestureRecognizer *)tap {
    [_tableHeaderButton setImage:[UIImage imageNamed:@"ime_e_icon_down"] forState:UIControlStateNormal];
    _viewPicker.hidden = YES;

}
- (IBAction)buttonFinish:(UIButton *)sender {
    [_tableHeaderButton setImage:[UIImage imageNamed:@"ime_e_icon_down"] forState:UIControlStateNormal];
    _viewPicker.hidden = YES;
    _stringYear = _stringYearTemp?_stringYearTemp:_stringYear;
    _stringMonth = _stringMonthTemp?_stringMonthTemp:_stringMonth;
    [_tableHeaderButton setTitle:[NSString stringWithFormat:@"%@年%@月",_stringYear,_stringMonth] forState:UIControlStateNormal];
    [self initRequestEnterpriseCommentEpCommentList];
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
        } else if (x < kMainW/2*7){
            index = 103;
        } else {
            index = 104;
        }
        if (index == 101) {//询盘刷新
            [self.tableView3.mj_header beginRefreshing];
        }
        if (index == 102) {//订单刷新
            [_tableViewECOrder.mj_header beginRefreshing];
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
        } else if (x < kMainW/2*7) {
            index = 103;
        } else {
            index = 104;
        }
        UIButton *but = [_arrayButton firstObject];
        
        NSInteger isTemporary = [self.enterpriseRelationSuper.passiveEnterprise.isTemporary integerValue];//1临时用户 0线上用户
        if (isTemporary == 1) {
            self.labelLineCenterX4.constant = 0;
            self.labelLineCenterX4.constant = CGRectGetWidth(but.frame) * (index-100);
        } else {
            self.labelLineCenterX.constant = 0;
            self.labelLineCenterX.constant = CGRectGetWidth(but.frame) * (index-100);
        }

        NSArray *arrayImage0 = @[@"icon1_未选中",@"icon4_未选中",@"icon5_未选中",@"icon2_未选中",@"icon3_未选中"];
        NSArray *arrayImage1 = @[@"icon1_选中",@"icon4_选中",@"icon5_选中",@"icon2_选中",@"icon3_选中"];
        for (int i = 0; i < _arrayButton.count; i++) {
            UIButton *but = _arrayButton[i];
            if ((index-100) == i) {
                [but setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
                [but setImage:[UIImage imageNamed:arrayImage1[i]] forState:UIControlStateNormal];
            } else {
                [but setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
                [but setImage:[UIImage imageNamed:arrayImage0[i]] forState:UIControlStateNormal];
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 200) {
        return 2;
    }
    if (tableView.tag == 201) {
        return _arrayTradeOrderModel.count;
    }
    if (tableView.tag == 202) {
        return 3;
    }
    if (tableView.tag == 203) {
        return _arrayInquiryOrderModel.count;
    }
    if (tableView.tag == 204) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 200) {
        if (section == 0) {
            return 5;
        }
        if (section == 1) {
            return 2;
        }
        if (section == 2) {
            return 1;
        }
    }
    if (tableView.tag == 201) {//订单
        return 1;
    }
    if (tableView.tag == 202) {
        if (section == 0) {
            return 8;
        } else {
            return 1;
        }
    }
    if (tableView.tag == 203) {//询盘
        return 1;
    }
    if (tableView.tag == 204) {//供应商信息
        if (section == 0) {
            return 8;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 200) {//供应商资料
        return 36;
    }
    if (tableView.tag == 201) {//订单
        if (section == 0) {
            return 0.01f;
        }
        return 10.f;
    }
    if (tableView.tag == 203) {//订单
        if (section == 0) {
            return 0.01f;
        }
        return 10.f;
    }
    if (tableView.tag == 204) {//供应商信息
        return 36;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 200) {//供应商评价
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 36)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *viewLineLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 6, 3.5, 24)];
        [view addSubview:viewLineLeft];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(viewLineLeft.frame)+4, 0, 55, 36)];
        if (section == 0) {
            viewLineLeft.backgroundColor = colorRGB(255, 132, 0);
            label.text = @"采购类";
        }
        if (section == 1) {
            viewLineLeft.backgroundColor = colorRGB(0, 168, 255);
            label.text = @"质量类";
        }
        if (section == 2) {
            viewLineLeft.backgroundColor = colorRGB(80, 189, 0);
            label.text = @"备注";
        }
        label.textColor = colorRGB(177, 177, 177);
        [view addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kMainW-80, 0, 80, 36);
        [button setTitleColor:colorRGB(177, 177, 177) forState:UIControlStateNormal];
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonEdit:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = section;
        [view addSubview:button];
        
        return view;
    }
    if (tableView.tag == 204) {//供应商信息
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 36)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *viewLineLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 6, 3.5, 24)];
        [view addSubview:viewLineLeft];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(viewLineLeft.frame)+11, 0, 74, 36)];
        if (section == 0) {
            viewLineLeft.backgroundColor = colorRGB(255, 132, 0);
            label.text = @"基本信息";
        }
//        [label sizeToFit];
        label.textColor = colorRGB(177, 177, 177);
        [view addSubview:label];
    
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 200) {
        if ((indexPath.section == 0 && indexPath.row == 4) || (indexPath.section == 1 && indexPath.row == 1)) {
            NSString *string = _arrayComment[indexPath.section];
            CGSize size = [string boundingRectWithSize:CGSizeMake(kMainW-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
            return 5+21+4+size.height+5+10;
        } else if (indexPath.section == 2 && indexPath.row == 0) {
            NSString *string = _arrayComment[indexPath.section];
            CGSize size = [string boundingRectWithSize:CGSizeMake(kMainW-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
            return 5+size.height+5;
        } else {
            return 50;
        }
    }
    if (tableView.tag == 201) {//订单
        return 226.5;//---------------------
    }
    if (tableView.tag == 202) {//供应商资料
        if (indexPath.section == 0) {
            return 30;
        } else {
            return 49;
        }
    }
    if (tableView.tag == 203) {//询盘
        return 226.5;//---------------------
    }
    if (tableView.tag == 204) {//供应商信息
        if (indexPath.section == 0) {
            NSString *str0 = self.enterpriseRelation.temporaryEnterpriseName.length>0?self.enterpriseRelation.temporaryEnterpriseName:@"--";//公司名称
            NSString *str1 = self.enterpriseRelation.temporaryContacts.length>0?self.enterpriseRelation.temporaryContacts:@"--";//联系人
            NSString *str2 = self.enterpriseRelation.temporaryPhoneNumber.length>0?self.enterpriseRelation.temporaryPhoneNumber:@"--";//手机
            NSString *str3 = self.enterpriseRelation.temporaryEmailAddress.length>0?self.enterpriseRelation.temporaryEmailAddress:@"--";//@"邮箱"
            NSString *str4 = self.enterpriseRelation.temporaryZoneStr.length>0?self.enterpriseRelation.temporaryZoneStr:@"--";//地址
            NSString *str5 = self.enterpriseRelation.temporaryPosition.length>0?self.enterpriseRelation.temporaryPosition:@"--";//职位
            NSString *str6Tmp;
            for (NSInteger i=0; i<self.enterpriseRelation.enterpriseRelationTag.count; i++) {
                EnterpriseRelationTag *enterpriseRelationTag = self.enterpriseRelation.enterpriseRelationTag[i];
                NSString *tagName = enterpriseRelationTag.tag.tagName;
                
                if (self.enterpriseRelation.enterpriseRelationTag.count == 1) {
                    str6Tmp = tagName;
                } else {
                    if (i == 0) {
                        str6Tmp = tagName;
                    } else {
                        str6Tmp = [NSString stringWithFormat:@"%@、%@",str6Tmp,tagName];
                    }
                }
            }
            NSString *str6 = str6Tmp.length>0?str6Tmp:@"--";
            NSString *str7 = self.enterpriseRelation.remark.length>0?self.enterpriseRelation.remark:@"--";
            NSArray *arr2 = @[str0,str1,str2,str3,str4,str5,str6,str7];
            
            CGSize size = [arr2[indexPath.row] boundingRectWithSize:CGSizeMake(kMainW-110-10, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            return 7+size.height+7;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 200) {
        if (indexPath.section == 0 || indexPath.section == 1) {
            if ((indexPath.section == 0 && indexPath.row == 4) || (indexPath.section == 1 && indexPath.row == 1)) {
                ECPingJiaCell1 *eCPingJiaCell1 = [tableView dequeueReusableCellWithIdentifier:@"eCPingJiaCell1" forIndexPath:indexPath];
                eCPingJiaCell1.selectionStyle = UITableViewCellSelectionStyleNone;
                eCPingJiaCell1.label0.text = _arrayComment[indexPath.section];
                return eCPingJiaCell1;
            } else {
                ECPingJiaCell *eCPingJiaCell = [tableView dequeueReusableCellWithIdentifier:@"eCPingJiaCell" forIndexPath:indexPath];
                eCPingJiaCell.selectionStyle = UITableViewCellSelectionStyleNone;
                eCPingJiaCell.label2.hidden = YES;
                eCPingJiaCell.label3.hidden = YES;
                eCPingJiaCell.label4.hidden = YES;
                if (indexPath.section == 0) {
                    eCPingJiaCell.label0.text = _arrayPurchase[indexPath.row];
                    eCPingJiaCell.label1.text = [NSString stringWithFormat:@"(权重:%@%@)",_arrayPurchaseComWeight[indexPath.row],@"%"];
                    if ([_returnCode isEqualToString:@"0"]) {
                        if (indexPath.row == 0) {
                            if ([_enterpriseCommentModel.puScore stringValue]) {
                                eCPingJiaCell.label2.hidden = NO;
                                eCPingJiaCell.label3.hidden = NO;
                                eCPingJiaCell.label2.text = [_enterpriseCommentModel.puScore stringValue];
                            } else {
                                eCPingJiaCell.label4.hidden = NO;
                            }
                        }
                        if (indexPath.row == 1) {
                            if ([_enterpriseCommentModel.puScore1 stringValue]) {
                                eCPingJiaCell.label2.hidden = NO;
                                eCPingJiaCell.label3.hidden = NO;
                                eCPingJiaCell.label2.text = [_enterpriseCommentModel.puScore1 stringValue];
                            } else {
                                eCPingJiaCell.label4.hidden = NO;
                            }
                        }
                        if (indexPath.row == 2) {
                            if ([_enterpriseCommentModel.puScore2 stringValue]) {
                                eCPingJiaCell.label2.hidden = NO;
                                eCPingJiaCell.label3.hidden = NO;
                                eCPingJiaCell.label2.text = [_enterpriseCommentModel.puScore2 stringValue];
                            } else {
                                eCPingJiaCell.label4.hidden = NO;
                            }                    }
                        if (indexPath.row == 3) {
                            if ([_enterpriseCommentModel.puScore3 stringValue]) {
                                eCPingJiaCell.label2.hidden = NO;
                                eCPingJiaCell.label3.hidden = NO;
                                eCPingJiaCell.label2.text = [_enterpriseCommentModel.puScore3 stringValue];
                            } else {
                                eCPingJiaCell.label4.hidden = NO;
                            }
                        }
                    }
                    if ([_returnCode isEqualToString:@"-99"]) {
                        eCPingJiaCell.label4.hidden = NO;
                    }
                }
                if (indexPath.section == 1) {
                    eCPingJiaCell.label0.text = _arrayQuality[indexPath.row];
                    eCPingJiaCell.label1.text = [NSString stringWithFormat:@"(权重:%@%@)",_arrayQualityComWeight[indexPath.row],@"%"];
                    if ([_returnCode isEqualToString:@"0"]) {
                        if (indexPath.row == 0) {
                            if ([_enterpriseCommentModel.quScore1 stringValue]) {
                                eCPingJiaCell.label2.hidden = NO;
                                eCPingJiaCell.label3.hidden = NO;
                                eCPingJiaCell.label2.text = [_enterpriseCommentModel.quScore1 stringValue];
                            } else {
                                eCPingJiaCell.label4.hidden = NO;
                            }
                        }
                    }
                    if ([_returnCode isEqualToString:@"-99"]) {
                        eCPingJiaCell.label4.hidden = NO;
                    }
                }
                return eCPingJiaCell;
            }
        }
        if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 1 || view.tag == 2) {
                    [view removeFromSuperview];
                }
            }
            
            UIView *viewLineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, kMainW, 0.5)];
            viewLineTop.tag = 1;
            viewLineTop.backgroundColor = colorRGB(221, 221, 221);
            [cell.contentView addSubview:viewLineTop];
            
            
            CGSize size = [_arrayComment[indexPath.section] boundingRectWithSize:CGSizeMake(kMainW-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kMainW-20, size.height)];
            label.tag = 2;
            label.numberOfLines = 0;
            label.textColor = colorRGB(23, 23, 23);
            label.text = _arrayComment[indexPath.section];
            [cell.contentView addSubview:label];

            
            return cell;
        }
        return nil;
    } else if (tableView.tag == 201) {//订单
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
    } else if (tableView.tag == 202) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (UIView *view in cell.contentView.subviews) {
            if ([view viewWithTag:1] || [view viewWithTag:2] ||[view viewWithTag:3] ||[view viewWithTag:4]||[view viewWithTag:5]||[view viewWithTag:6]) {
                [view removeFromSuperview];
            }
        }
        if (indexPath.section == 0) {
            NSArray *arr1 = @[@"公司性质",@"雇员数量",@"工厂面积",@"年采购额",@"成立年份",@"行业类型",@"进出口权",@"企业认证"];
            
            NSString *string1 = self.enterpriseRelationSuper.passiveEnterprise.enterpriseNature?self.enterpriseRelationSuper.passiveEnterprise.enterpriseNature:@"--";
            NSString *string2 = self.enterpriseRelationSuper.passiveEnterprise.employeeNum?[NSString stringWithFormat:@"%@人",self.enterpriseRelationSuper.passiveEnterprise.employeeNum]:@"--";
            NSString *string3 = self.enterpriseRelationSuper.passiveEnterprise.factorySize?[NSString stringWithFormat:@"%@(平方米)",self.enterpriseRelationSuper.passiveEnterprise.factorySize]:@"--";
            NSString *string4 = self.enterpriseRelationSuper.passiveEnterprise.annualProcurement?[NSString stringWithFormat:@"%@(万元)",self.enterpriseRelationSuper.passiveEnterprise.annualProcurement]:@"--";
            NSString *string5 = [self.enterpriseRelationSuper.passiveEnterprise.foundTimeY integerValue] != 0?[NSString stringWithFormat:@"%ld",[self.enterpriseRelationSuper.passiveEnterprise.foundTimeY integerValue]]:@"--";
            NSString *string6 = self.enterpriseRelationSuper.passiveEnterprise.industryType?self.enterpriseRelationSuper.passiveEnterprise.industryType:@"--";
            NSString *string7 = self.enterpriseRelationSuper.passiveEnterprise.hasIEPower?[self hasIEPower:[self.enterpriseRelationSuper.passiveEnterprise.hasIEPower integerValue]]:@"--";
            NSString *string8 = self.enterpriseRelationSuper.passiveEnterprise.renzheng?self.enterpriseRelationSuper.passiveEnterprise.renzheng:@"--";
            NSArray* _arr2 = @[string1,string2,string3,string4,string5,string6,string7,string8];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = arr1[indexPath.row];
            label1.textColor = colorRGB(117, 117, 117);
            label1.font = [UIFont systemFontOfSize:14];
            label1.tag = 1;
            [cell.contentView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(20);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            }];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.text = _arr2[indexPath.row];
            label2.textColor = colorRGB(32, 32, 32);
            label2.font = [UIFont systemFontOfSize:14];
            label2.tag = 2;
            [cell.contentView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(110);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            }];
            
        }
        if (indexPath.section == 1) {
            UIView *lineView = [LineView lineWithFrame:CGRectMake(20, 0, kMainW, 0.5) withColor:colorRGB(221, 221, 221)];
            lineView.tag = 5;
            [cell.contentView addSubview:lineView];
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = @"采购商综合评分";
            label1.textColor = colorRGB(117, 117, 117);
            label1.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(20);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            }];
            if (self.enterpriseRelationSuper.passiveEnterprise.buStartLevel) {
                if (indexPath.row == 0) {
                    for (int i = 0; i < 5; i++) {
                        UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_star_2t"]];
                        imageView5.frame = CGRectMake(150 + 20*i, 17, 15, 15);
                        [cell.contentView addSubview:imageView5];
                    }
                }
                NSInteger integerNum = [[[self.enterpriseRelationSuper.passiveEnterprise.buStartLevel stringValue] substringWithRange:NSMakeRange(0, 1)] integerValue];
                
                if (indexPath.row == 0) {
                    for (int i = 0; i < integerNum; i++) {
                        UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_star"]];
                        imageView5.frame = CGRectMake(150 + 20*i, 17, 15, 15);
                        [cell.contentView addSubview:imageView5];
                    }
                }
                UILabel *labelStart = [[UILabel alloc] initWithFrame:CGRectMake(160 + 20*5, 17, 38, 15)];
                labelStart.text = [NSString stringWithFormat:@"%.1f分",[self.enterpriseRelationSuper.passiveEnterprise.buStartLevel doubleValue]];
                labelStart.textColor = colorRGB(117, 117, 117);
                labelStart.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:labelStart];
            } else {
                UILabel *labelStart = [[UILabel alloc] initWithFrame:CGRectMake(160 + 20*4, 17, 58, 15)];
                labelStart.text = @"暂无评价";
                labelStart.textColor = colorRGB(117, 117, 117);
                labelStart.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:labelStart];
            }
        }
        if (indexPath.section == 2) {
            UIView *lineView = [LineView lineWithFrame:CGRectMake(20, 0, kMainW, 0.5) withColor:colorRGB(221, 221, 221)];
            lineView.tag = 6;
            [cell.contentView addSubview:lineView];
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = @"供应商综合评分";
            label1.textColor = colorRGB(117, 117, 117);
            label1.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(20);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            }];
            if (self.enterpriseRelationSuper.passiveEnterprise.suStartLevel) {
                if (indexPath.row == 0) {
                    for (int i = 0; i < 5; i++) {
                        UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_star_2t"]];
                        imageView5.frame = CGRectMake(150 + 20*i, 17, 15, 15);
                        [cell.contentView addSubview:imageView5];
                    }
                }
                NSInteger integerNum = [[[self.enterpriseRelationSuper.passiveEnterprise.suStartLevel stringValue] substringWithRange:NSMakeRange(0, 1)] integerValue];
                if (indexPath.row == 0) {
                    for (int i = 0; i < integerNum; i++) {
                        UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_star_3t-2"]];
                        imageView5.frame = CGRectMake(150 + 20*i, 17, 15, 15);
                        [cell.contentView addSubview:imageView5];
                    }
                }
                UILabel *labelStart = [[UILabel alloc] initWithFrame:CGRectMake(160 + 20*5, 17, 38, 15)];
                labelStart.text = [NSString stringWithFormat:@"%.1f分",[self.enterpriseRelationSuper.passiveEnterprise.suStartLevel doubleValue]];
                labelStart.textColor = colorRGB(117, 117, 117);
                labelStart.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:labelStart];
            } else {
                UILabel *labelStart = [[UILabel alloc] initWithFrame:CGRectMake(160 + 20*4, 17, 58, 15)];
                labelStart.text = @"暂无评价";
                labelStart.textColor = colorRGB(117, 117, 117);
                labelStart.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:labelStart];
            }
        }
        return cell;
    } else if (tableView.tag == 203) {//询盘
        ECInquiryCell122 *cell = [tableView dequeueReusableCellWithIdentifier:@"eCInquiryCell122" forIndexPath:indexPath];
        InquiryOrder *inquiryOrderModel = _arrayInquiryOrderModel[indexPath.section];
        
        [cell initDataWith:inquiryOrderModel andQuanXian:nil];
        
        [cell.buttonL addTarget:self action:@selector(buttonClickInquiryOrder:) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttonR addTarget:self action:@selector(buttonClickInquiryOrder:) forControlEvents:UIControlEventTouchUpInside];
        cell.buttonL.tag = indexPath.section;
        cell.buttonR.tag = indexPath.section;
        
        return cell;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (UIView *view in cell.contentView.subviews) {
            if ([view viewWithTag:1]||[view viewWithTag:2]) {
                [view removeFromSuperview];
            }
        }
        if (indexPath.section == 0) {
            NSArray *arr1 = @[@"公司名称",@"联系人",@"手机",@"邮箱",@"地址",@"职位",@"标签",@"备注"];
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = arr1[indexPath.row];
            label1.textColor = colorRGB(117, 117, 117);
            label1.font = [UIFont systemFontOfSize:14];
            label1.tag = 1;
            [cell.contentView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(15);
                make.top.equalTo(cell.contentView.mas_top).with.offset(7);
            }];
            
            NSString *str0 = self.enterpriseRelation.temporaryEnterpriseName.length>0?self.enterpriseRelation.temporaryEnterpriseName:@"--";//公司名称
            NSString *str1 = self.enterpriseRelation.temporaryContacts.length>0?self.enterpriseRelation.temporaryContacts:@"--";//联系人
            NSString *str2 = self.enterpriseRelation.temporaryPhoneNumber.length>0?self.enterpriseRelation.temporaryPhoneNumber:@"--";//手机
            NSString *str3 = self.enterpriseRelation.temporaryEmailAddress.length>0?self.enterpriseRelation.temporaryEmailAddress:@"--";//@"邮箱"
            NSString *str4 = self.enterpriseRelation.temporaryZoneStr.length>0?self.enterpriseRelation.temporaryZoneStr:@"--";//地址
            NSString *str5 = self.enterpriseRelation.temporaryPosition.length>0?self.enterpriseRelation.temporaryPosition:@"--";//职位
            
            NSString *str6Tmp;
            for (NSInteger i=0; i<self.enterpriseRelation.enterpriseRelationTag.count; i++) {
                EnterpriseRelationTag *enterpriseRelationTag = self.enterpriseRelation.enterpriseRelationTag[i];
                NSString *tagName = enterpriseRelationTag.tag.tagName;
                
                if (self.enterpriseRelation.enterpriseRelationTag.count == 1) {
                    str6Tmp = tagName;
                } else {
                    if (i == 0) {
                        str6Tmp = tagName;
                    } else {
                        str6Tmp = [NSString stringWithFormat:@"%@、%@",str6Tmp,tagName];
                    }
                }
            }
            NSString *str6 = str6Tmp.length>0?str6Tmp:@"--";
            NSString *str7 = self.enterpriseRelation.remark.length>0?self.enterpriseRelation.remark:@"--";//
            
            
            NSArray *arr2 = @[str0,str1,str2,str3,str4,str5,str6,str7];
            UILabel *label2 = [[UILabel alloc] init];
            label2.text = arr2[indexPath.row];
            label2.textColor = colorRGB(32, 32, 32);
            label2.font = [UIFont systemFontOfSize:14];
            label2.tag = 2;
            label2.numberOfLines = 0;
            [cell.contentView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(110);
                make.right.equalTo(cell.contentView.mas_right).with.offset(-10);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            }];
            
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 201) {//订单
        TradeOrder *tradeOrder = _arrayTradeOrderModel[indexPath.section];
        DingDanXiangQingCaiViewController *dingDanXiangQingCaiViewController = [[DingDanXiangQingCaiViewController alloc] init];
        dingDanXiangQingCaiViewController.stringResource = @"ECaiGouShangViewControllerR";
        dingDanXiangQingCaiViewController.tradeOrder = tradeOrder;
        [self.navigationController pushViewController:dingDanXiangQingCaiViewController animated:YES];
    }
    if (tableView.tag == 203) {//询盘
        InquiryOrder *inquiryOrderModel =  _arrayInquiryOrderModel[indexPath.section];;
        XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
        xunPanXiangQingViewController.inquiryOrderId = inquiryOrderModel.inquiryOrderId;
        [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _arrayYears.count;
    }
    return _arrayMonth.count;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        _stringYearTemp = [_arrayYears objectAtIndex:row];
    } else {
        _stringMonthTemp = [_arrayMonth objectAtIndex:row];
    }
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [_arrayYears objectAtIndex:row];
    } else {
        return [_arrayMonth objectAtIndex:row];
    }
}


- (void)buttonEdit:(UIButton *)sender {
    if (sender.tag == 0) {
        ECTGSPingJiaViewController *eCTGSPingJiaViewController = [[ECTGSPingJiaViewController alloc] init];
        eCTGSPingJiaViewController.returnCode = _returnCode;
        eCTGSPingJiaViewController.enterpriseCommentSuper = _enterpriseCommentModel;
        eCTGSPingJiaViewController.stringMonth = _stringMonth;
        eCTGSPingJiaViewController.stringYear = _stringYear;
        eCTGSPingJiaViewController.enterpriseRelationSuperSuper = self.enterpriseRelationSuper;
        [self.navigationController pushViewController:eCTGSPingJiaViewController animated:YES];
    }
    if (sender.tag == 1) {
        ECTGSPingJiaViewController1 *eCTGSPingJiaViewController1 = [[ECTGSPingJiaViewController1 alloc] init];
        eCTGSPingJiaViewController1.returnCode = _returnCode;
        eCTGSPingJiaViewController1.enterpriseCommentSuper = _enterpriseCommentModel;
        eCTGSPingJiaViewController1.stringMonth = _stringMonth;
        eCTGSPingJiaViewController1.stringYear = _stringYear;
        eCTGSPingJiaViewController1.enterpriseRelationSuperSuper = self.enterpriseRelationSuper;
        [self.navigationController pushViewController:eCTGSPingJiaViewController1 animated:YES];
    }
    if (sender.tag == 2) {
        ECTGSPingJiaViewController2 *eCTGSPingJiaViewController2 = [[ECTGSPingJiaViewController2 alloc] init];
        [self.navigationController pushViewController:eCTGSPingJiaViewController2 animated:YES];
    }
    NSLog(@"%s",__FUNCTION__);
}

- (IBAction)left:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//获取企业最近评价
- (void)initRequestEnterpriseCommentRecentEpComment {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    EnterpriseComment *enterpriseComment = [[EnterpriseComment alloc] init];
    enterpriseComment.srManufacturerId = self.enterpriseRelationSuper.initiatorId;
    enterpriseComment.trManufacturerId = self.enterpriseRelationSuper.passiveId;
    postEntityBean.entity = enterpriseComment.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_enterpriseComment_recentEpComment parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            if ([[model.returnCode stringValue] isEqualToString:@"-99"]) {
                _returnCode = @"-99";
                _enterpriseCommentModel = nil;
                _tableHeaderLabel.text = @"暂无综合评分";
                _arrayComment = @[@"暂无备注",@"暂无备注"];
                [_tableHeaderButton setTitle:[NSString stringWithFormat:@"%@年%@月",_stringYear,_stringMonth] forState:UIControlStateNormal];
                [_tableHeaderButton setImage:[UIImage imageNamed:@"ime_e_icon_down"] forState:UIControlStateNormal];
                [_tableView0 reloadData];
            } else {
                _returnCode = @"0";

                _enterpriseCommentModel = [EnterpriseComment mj_objectWithKeyValues:model.entity];
                
                _stringYear = [_enterpriseCommentModel.coYear stringValue];
                _stringMonth = [_enterpriseCommentModel.coMonth stringValue];
                
                [_tableHeaderButton setTitle:[NSString stringWithFormat:@"%@年%@月",_stringYear,_stringMonth] forState:UIControlStateNormal];
                [_tableHeaderButton setImage:[UIImage imageNamed:@"ime_e_icon_down"] forState:UIControlStateNormal];
                
                _tableHeaderLabel.text = [NSString stringWithFormat:@"综合评分%.1f分",[_enterpriseCommentModel.averageScore doubleValue]];
                
                _arrayComment = @[_enterpriseCommentModel.content?_enterpriseCommentModel.content:@"暂无备注",_enterpriseCommentModel.content2?_enterpriseCommentModel.content2:@"暂无备注"];
                [_tableView0 reloadData];
            }
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}



- (void)initRequestEnterpriseCommentEpCommentList{
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    EnterpriseComment *enterpriseComment = [[EnterpriseComment alloc] init];
    enterpriseComment.coYear = [NSNumber numberWithInteger:[_stringYear integerValue]];
    enterpriseComment.coMonth = [NSNumber numberWithInteger:[_stringMonth integerValue]];
    enterpriseComment.srManufacturerId = self.enterpriseRelationSuper.initiatorId;
    enterpriseComment.trManufacturerId = self.enterpriseRelationSuper.passiveId;
    postEntityBean.entity = enterpriseComment.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_enterpriseComment_epCommentList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            if ([[model.returnCode stringValue] isEqualToString:@"-99"]) {
                _returnCode = @"-99";
                _enterpriseCommentModel = nil;
                _tableHeaderLabel.text = @"暂无综合评分";
                _arrayComment = @[@"暂无备注",@"暂无备注"];
                [_tableView0 reloadData];
            } else {
                _returnCode = @"0";
                _arrayEnterpriseCommentModel = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *arrayEnterpriseComment = model.list;
                for (NSDictionary *dic in arrayEnterpriseComment) {
                    EnterpriseComment * obj = [EnterpriseComment mj_objectWithKeyValues:dic];
                    [_arrayEnterpriseCommentModel addObject:obj];
                    _enterpriseCommentModel = obj;
                }
                
                _tableHeaderLabel.text = [NSString stringWithFormat:@"综合评分%.1f分",[_enterpriseCommentModel.averageScore doubleValue]];
                
                _arrayComment = @[_enterpriseCommentModel.content?_enterpriseCommentModel.content:@"暂无备注",_enterpriseCommentModel.content2?_enterpriseCommentModel.content2:@"暂无备注"];
                [_tableView0 reloadData];
            }
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}
- (void)buttonClickInquiryOrder:(UIButton *)sender {
    InquiryOrder *inquiryOrderModel = _arrayInquiryOrderModel[sender.tag];
    if ([inquiryOrderModel.inquiryOrderStatus isEqualToString:@"IING"]) {
        if ([inquiryOrderModel.quotationNum integerValue] == 0) {
#pragma mark 待筛选(无报价) 取消询盘
            if ([sender.currentTitle isEqualToString:@"取消询盘"]) {
//                self.viewPickView0.hidden = NO;
//                self.viewPickView1.hidden = NO;
//                _inquiryOrderQuXiaoXunPan = inquiryOrderModel;
                self.tabBarController.tabBar.hidden = YES;
                
            }
        } else {
#pragma mark 待筛选(有报价) 筛选报价
            if ([sender.currentTitle isEqualToString:@"筛选报价"]) {
                InquiryOrder *inquiryOrderModel = _arrayInquiryOrderModel[sender.tag];
                ShaiXuanBaoJiaViewController *shaiXuanBaoJiaViewController = [[ShaiXuanBaoJiaViewController alloc] init];
                shaiXuanBaoJiaViewController.inquiryOrder = inquiryOrderModel;
                [self.navigationController pushViewController:shaiXuanBaoJiaViewController animated:YES];
            }
#pragma mark 待筛选(有报价) 取消询盘
            if ([sender.currentTitle isEqualToString:@"取消询盘"]) {
//                self.viewPickView0.hidden = NO;
//                self.viewPickView1.hidden = NO;
//                _inquiryOrderQuXiaoXunPan = inquiryOrderModel;
                self.tabBarController.tabBar.hidden = YES;
            }
        }
    }
    if ([inquiryOrderModel.inquiryOrderStatus isEqualToString:@"SQ"]) {
#pragma mark 等待接盘 查看授盘
        if ([sender.currentTitle isEqualToString:@"查看授盘"]) {
            InquiryOrder *inquiryOrderModel = _arrayInquiryOrderModel[sender.tag];
            
            if ([inquiryOrderModel.inquiryType isEqualToString:@"FTG"]) {
                ChaKanShouPanJiePanDingJiaViewController *vc = [[ChaKanShouPanJiePanDingJiaViewController alloc] init];
                vc.inquiryOrder = inquiryOrderModel;
                vc.quotationOrderId = inquiryOrderModel.quotationOrderId;
                vc.stringResource = @"ECaiGouShangViewController";
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
            
            if ([inquiryOrderModel.inquiryType isEqualToString:@"TTG"]) {
                ECChaKanShouPanYiJiaViewController *eCChaKanShouPanYiJiaViewController = [[ECChaKanShouPanYiJiaViewController alloc] init];
                eCChaKanShouPanYiJiaViewController.inquiryOrder = inquiryOrderModel;
                eCChaKanShouPanYiJiaViewController.quotationOrderId = inquiryOrderModel.quotationOrderId;
                [self.navigationController pushViewController:eCChaKanShouPanYiJiaViewController animated:YES];
                return;
            }
            
            ChaKanShouPanViewController *vc = [[ChaKanShouPanViewController alloc] init];
            vc.inquiryOrder = inquiryOrderModel;
            vc.quotationOrderId = inquiryOrderModel.quotationOrderId;
            vc.stringResource = @"ECaiGouShangViewController";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if ([inquiryOrderModel.inquiryOrderStatus isEqualToString:@"QS"]) {
        if ([inquiryOrderModel.inquiryType isEqualToString:@"TTG"] && [inquiryOrderModel.quotationOrder.canEditPrice integerValue]==1) {
#pragma mark 成功接盘 询盘议价 议价未完成
            if ([sender.currentTitle isEqualToString:@"询盘议价"]) {
                InquiryOrder *inquiryOrderModel = _arrayInquiryOrderModel[sender.tag];
                if ([inquiryOrderModel.inquiryType isEqualToString:@"TTG"]){
                    ECYiJiaViewController *eCYiJiaViewController = [[ECYiJiaViewController alloc] init];
                    eCYiJiaViewController.quotationOrderId = inquiryOrderModel.quotationOrderId;
                    [self.navigationController pushViewController:eCYiJiaViewController animated:YES];
                    return;
                }
            }
            
        } else {
#pragma mark 成功接盘 查看报价
            if ([sender.currentTitle isEqualToString:@"查看报价"]) {
                if ([inquiryOrderModel.inquiryType isEqualToString:@"FTG"]) {
                    ChaKanDingJiaViewController *vc = [[ChaKanDingJiaViewController alloc] init];
                    vc.inquiryOrder = inquiryOrderModel;
                    vc.quotationOrderId = inquiryOrderModel.quotationOrderId;
                    vc.stringResource = @"ECaiGouShangViewController";
                    [self.navigationController pushViewController:vc animated:YES];
                    return;
                }
                
                if ([inquiryOrderModel.inquiryType isEqualToString:@"TTG"]){
                    
                    ECChaKanBaoJiaYiJiaViewController *eCChaKanBaoJiaYiJiaViewController = [[ECChaKanBaoJiaYiJiaViewController alloc] init];
                    eCChaKanBaoJiaYiJiaViewController.quotationOrderId = inquiryOrderModel.quotationOrderId;
                    [self.navigationController pushViewController:eCChaKanBaoJiaYiJiaViewController animated:YES];
                    return;
                }
                
                ChaKanZiJiDeBaoJiaViewController *vc = [[ChaKanZiJiDeBaoJiaViewController alloc] init];
                vc.inquiryOrder = inquiryOrderModel;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
#pragma mark 成功接盘 进入订单
        if ([sender.currentTitle isEqualToString:@"进入订单"]) {
            InquiryOrder *inquiryOrderModel = _arrayInquiryOrderModel[sender.tag];
            DingDanXiangQingCaiViewController *dingDanXiangQingCaiViewController = [[DingDanXiangQingCaiViewController alloc] init];
            dingDanXiangQingCaiViewController.stringResource = @"ECaiGouShangViewControllerL";
            dingDanXiangQingCaiViewController.orderId = inquiryOrderModel.tradeOrderId;
            [self.navigationController pushViewController:dingDanXiangQingCaiViewController animated:YES];
        }
        
    }
    if ([inquiryOrderModel.inquiryOrderStatus isEqualToString:@"TO"]) {
        if ([inquiryOrderModel.quotationNum integerValue] == 0) {
            
        } else {
#pragma mark 已取消／过期／关闭(有报价) 查看报价
            if ([sender.currentTitle isEqualToString:@"查看报价"]) {
                
            }
        }
    }
    if ([inquiryOrderModel.inquiryOrderStatus isEqualToString:@"CL"]) {
        if ([inquiryOrderModel.quotationNum integerValue] == 0) {
            
        } else {
#pragma mark 已取消／过期／关闭(有报价) 查看报价
            if ([sender.currentTitle isEqualToString:@"查看报价"]) {
                
            }
            
        }
    }
    if ([inquiryOrderModel.inquiryOrderStatus isEqualToString:@"CC"]) {
        if ([inquiryOrderModel.quotationNum integerValue] == 0) {
            
        } else {
#pragma mark 已取消／过期／关闭(有报价) 查看报价
            if ([sender.currentTitle isEqualToString:@"查看报价"]) {
                
            }
        }
    }
}

- (void)buttonClickTradeOrder:(UIButton *)sender {
    TradeOrder *tradeOrder = _arrayTradeOrderModel[sender.tag];
    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"waitingPaymentForPurchase"]) {
#pragma mark 待付款 付款
        if ([sender.currentTitle isEqualToString:@"付款"]) {
            EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
            TradeOrder *tradeOrder1 = [[TradeOrder alloc] init];
            tradeOrder1.orderCode = tradeOrder.orderCode;
            postEntityBean.entity = tradeOrder1.mj_keyValues;
            postEntityBean.memberId = [DatabaseTool getLoginModel].memberId;
            NSDictionary *dic = postEntityBean.mj_keyValues;
            
            [HttpMamager postRequestWithURLString:DYZ_pay_createGuaranteeTrade parameters:dic success:^(id responseObjectModel) {
                ReturnMsgBean *model = responseObjectModel;
                
                if ([model.status isEqualToString:@"SUCCESS"]) {
                    
                    EH5FuKuanViewController *eH5FuKuanViewController = [[EH5FuKuanViewController alloc] init];
                    eH5FuKuanViewController.detailUrl = model.returnMsg;
                    [self.navigationController pushViewController:eH5FuKuanViewController animated:YES];
                } else {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"付款失败"];
                }
            } fail:^(NSError *error) {
                
            } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
        }
    }
    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"paymentOvertime"]) {
        
    }
    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"paymentConfirm"]) {
        
    }
    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"purchasePaid"]) {
#pragma mark 已付款 生产进度
        if ([sender.currentTitle isEqualToString:@"生产进度"]) {
//            EShengChangJingduXiangXiViewController *eShengChangJingduXiangXiViewController = [[EShengChangJingduXiangXiViewController alloc] init];
//            eShengChangJingduXiangXiViewController.tradeOrder = tradeOrder;
//            [self.navigationController pushViewController:eShengChangJingduXiangXiViewController animated:YES];
        }
    }
    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"supplierDelivered"]) {
#pragma mark 待收货 查看物流
        if ([sender.currentTitle isEqualToString:@"查看物流"]) {
            ECCheckTheLogisticsViewController *eCCheckTheLogisticsViewController = [[ECCheckTheLogisticsViewController alloc] init];
            eCCheckTheLogisticsViewController.logisticsCompany = tradeOrder.logisticsCompany;
            eCCheckTheLogisticsViewController.logisticsNo = tradeOrder.logisticsNo;
            eCCheckTheLogisticsViewController.logisticsRemark = tradeOrder.logisticsRemark;
            [self.navigationController pushViewController:eCCheckTheLogisticsViewController animated:YES];
        }
#pragma mark 待收货 确认收货
        if ([sender.currentTitle isEqualToString:@"确认收货"]) {
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"采购商收货" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定收货" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
                TradeOrder *tradeOrder1 = [[TradeOrder alloc] init];
                tradeOrder1.orderCode = tradeOrder.orderCode;
                LoginModel *loginModel = [DatabaseTool getLoginModel];
                tradeOrder1.purchaseEnterpriseId = loginModel.enterpriseId;
                postEntityBean.entity = tradeOrder1.mj_keyValues;
                NSDictionary *dic = postEntityBean.mj_keyValues;
                [HttpMamager postRequestWithURLString:DYZ_tradeOrder_confirmSupplierDelivere parameters:dic success:^(id responseObjectModel) {
                    ReturnMsgBean *returnMsgBean = responseObjectModel;
                    if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                        [_tableViewECOrder reloadData];
                        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"确认成功"];
                    } else {
                        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"确认失败"];
                    }
                } fail:^(NSError *error) {
                    
                } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
                
            }];
            [ac addAction:action];
            [ac addAction:action1];
            [self presentViewController:ac animated:YES completion:nil];
            
        }
    }
    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"examineCargoForPurchase"]) {
#pragma mark 待验货 确认验货
        if ([sender.currentTitle isEqualToString:@"确认验货"]) {
            EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
            TradeOrder *tradeOrder1 = [[TradeOrder alloc] init];
            tradeOrder1.orderCode = tradeOrder.orderCode;
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            tradeOrder1.purchaseEnterpriseId = loginModel.enterpriseId;
            postEntityBean.entity = tradeOrder1.mj_keyValues;
            NSDictionary *dic = postEntityBean.mj_keyValues;
            
            //            NSLog(@"%@",dic);
            
            [HttpMamager postRequestWithURLString:DYZ_tradeOrder_examineCargo parameters:dic success:^(id responseObjectModel) {
                ReturnMsgBean *returnMsgBean = responseObjectModel;
                if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                    [_tableViewECOrder reloadData];
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"验货成功"];
                } else {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"验货失败"];
                }
            } fail:^(NSError *error) {
                
            } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
        }
    }
    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"success"]) {
#pragma mark 交易成功 评价
        if ([tradeOrder.inquiryType isEqualToString:@"ATG"]||[tradeOrder.inquiryType isEqualToString:@"FTG"]||[tradeOrder.inquiryType isEqualToString:@"TTG"]) {//托管
            
            if ([tradeOrder.supplierIsComment boolValue] == 0) {
                if ([sender.currentTitle isEqualToString:@"去评价"]) {
                    FaBaoPingLunTuoGuanViewController *faBaoPingLunTuoGuanViewController = [[FaBaoPingLunTuoGuanViewController alloc] init];
                    faBaoPingLunTuoGuanViewController.tradeOrder = tradeOrder;
                    [self.navigationController pushViewController:faBaoPingLunTuoGuanViewController animated:YES];
                }
            } else {
                if ([sender.currentTitle isEqualToString:@"查看评价"]) {
                    FaBaoPingLunTuoGuanChaKanViewController *faBaoPingLunTuoGuanChaKanViewController = [[FaBaoPingLunTuoGuanChaKanViewController alloc] init];
                    faBaoPingLunTuoGuanChaKanViewController.tradeOrder = tradeOrder;
                    [self.navigationController pushViewController:faBaoPingLunTuoGuanChaKanViewController animated:YES];
                }
            }
        } else {
            
            if ([tradeOrder.supplierIsComment boolValue] == 0) {
                if ([sender.currentTitle isEqualToString:@"评价"]) {
                    FaBaoPingLunCaiViewController *faBaoPingLunViewController = [[FaBaoPingLunCaiViewController alloc] init];
                    faBaoPingLunViewController.tradeOrder = tradeOrder;
                    [self.navigationController pushViewController:faBaoPingLunViewController animated:YES];
                }
            }
        }
    }
    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"close"]) {
        
    }
    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"waitingRefund"]) {
        
    }
    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"refunded"]) {
        
    }
    
    //为了简洁、且按钮的文字都不一样，所以下面就只用文字判断，不再使用tradeOrder.tradeOrderPurchaseStatus
    if ([sender.currentTitle isEqualToString:@"催发货"]) {
        [self initRequesrCuiFaHuo:tradeOrder];
        return;
    }
    if ([sender.currentTitle isEqualToString:@"去收货"]) {
        ShouHuoLieBiaoVC *shouHuoLieBiaoVC = [[ShouHuoLieBiaoVC alloc] init];
        shouHuoLieBiaoVC.tradeOrderId = tradeOrder.orderId;
        [self.navigationController pushViewController:shouHuoLieBiaoVC animated:YES];
        return;
    }
    if ([sender.currentTitle isEqualToString:@"去验货"]) {
        YanHuoLieBiaoVC *yanHuoLieBiaoVC = [[YanHuoLieBiaoVC alloc] init];
        yanHuoLieBiaoVC.tradeOrderId = tradeOrder.orderId;
        [self.navigationController pushViewController:yanHuoLieBiaoVC animated:YES];
        return;
    }
}

- (void)initRequesrCuiFaHuo:(TradeOrder *)tradeOrder {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    PurchaseProjectInfo *purchasePI = [[PurchaseProjectInfo alloc] init];
    purchasePI.tradeOrderId = tradeOrder.orderId;
    postEntityBean.entity = purchasePI.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_purchaseProject_notifySend parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"催发货成功"];
        }
        if ([model.status isEqualToString:@"ERROR"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您已发过催发货提醒，请稍后再试"];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (NSString *)hasIEPower:(NSInteger)integer {
    if (integer == 0) {
        return @"无";
    }
    if (integer == 1) {
        return @"有";
    }
    return nil;
}

- (void)initRequestECInquiryWithTableView:(UITableView *)tableView WithNoContentView:(UIView *)viewNoContent{
    
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
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
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        inquiryOrder.manufacturerId = loginModel.manufacturerId;
        
        inquiryOrder.sei_inquiryType = [NSMutableArray arrayWithArray:@[@"ATG",@"FTG",@"TTG"]];
        
        inquiryOrder.sec_hasSendQuo = [NSNumber numberWithBool:YES];
        
        inquiryOrder.ioe__manufacturerId = self.enterpriseRelationSuper.passiveEnterprise.manufacturerId;
        
        postEntityBean.memberId = loginModel.memberId;
        
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_inquiry_list parameters:dic success:^(id responseObjectModel) {
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
                _aPageECInquiry = 2;
                _viewRequestTimeoutECInquiry.hidden = YES;
            } else {
                _viewRequestTimeoutECInquiry.hidden = NO;
                [tableView.mj_header endRefreshing];
            }
        } fail:^(NSError *error) {
            _viewRequestTimeoutECInquiry.hidden = NO;
            [tableView.mj_header endRefreshing];
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
    
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.isPurchase = [NSNumber numberWithInteger:1];
        OrderByBean *orderByBean = [[OrderByBean alloc] init];
        orderByBean.orderName = @"c.createTime";
        orderByBean.orderSort = @"desc";
        
        NSMutableArray <OrderByBean *> *arrayOrderByBean = [[NSMutableArray alloc] initWithCapacity:0];
        [arrayOrderByBean addObject:orderByBean];
        postEntityBean.order = arrayOrderByBean;
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:_aPageECInquiry];
        postEntityBean.pager = pagerBean;
        
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        inquiryOrder.manufacturerId = loginModel.manufacturerId;
        inquiryOrder.sei_inquiryType = [NSMutableArray arrayWithArray:@[@"ATG",@"FTG",@"TTG"]];
    
        inquiryOrder.sec_hasSendQuo = [NSNumber numberWithBool:YES];

        inquiryOrder.ioe__manufacturerId = self.enterpriseRelationSuper.passiveEnterprise.manufacturerId;
        
        postEntityBean.memberId = loginModel.memberId;
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        [HttpMamager postRequestWithURLString:DYZ_inquiry_list parameters:dic success:^(id responseObjectModel) {
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
                _aPageECInquiry++;
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
}

- (void)initRequestECOrderWithTableView:(UITableView *)tableView WithNoContentView:(UIView *)viewNoContent{
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
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
        
        tradeOrder.supplierEnterpriseId = self.enterpriseRelationSuper.passiveEnterprise.enterpriseId;
        
        tradeOrder.sei_inquiryType = [[NSMutableArray alloc] initWithObjects:@"ATG",@"FTG",@"TTG", nil];

        postEntityBean.entity = tradeOrder.mj_keyValues;
        
        postEntityBean.memberId = loginModel.memberId;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
//        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_tradeOrder_getTradeOrderList parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *returnListBean = responseObjectModel;
            
            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                _arrayTradeOrderModel = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *dic in returnListBean.list) {
                    TradeOrder *tradeOrder = [TradeOrder mj_objectWithKeyValues:dic];
                    NSLog(@"%@",tradeOrder.inquiryType);
                    
                    [_arrayTradeOrderModel addObject:tradeOrder];
                }
                [tableView reloadData];
                [tableView.mj_header endRefreshing];
                if (returnListBean.list.count != 0) {
                    [tableView.mj_footer endRefreshing];
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
        
        tradeOrder.supplierEnterpriseId = self.enterpriseRelationSuper.passiveEnterprise.enterpriseId;
        
        tradeOrder.sei_inquiryType = [[NSMutableArray alloc] initWithObjects:@"ATG",@"FTG",@"TTG", nil];
        
        postEntityBean.entity = tradeOrder.mj_keyValues;
        
        postEntityBean.memberId = loginModel.memberId;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_tradeOrder_getTradeOrderList parameters:dic success:^(id responseObjectModel) {
            
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

- (void)initEpRelationTrustRelationDetail:(UITableView *)tableView WithNoContentView:(UIView *)viewNoContent{
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = loginModel.memberId;
    
    EnterpriseRelation *enterpriseRelation = [[EnterpriseRelation alloc] init];
    enterpriseRelation.reId = self.enterpriseRelationSuper.reId;
    
    postEntityBean.entity = enterpriseRelation.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_epRelation_trustRelationDetail parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnListBean = responseObjectModel;
        
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            EnterpriseRelation *enterpriseRelation = [EnterpriseRelation mj_objectWithKeyValues:returnListBean.entity];
            self.enterpriseRelation = enterpriseRelation;
            
            [tableView reloadData];
    
        } else {

        }
        
    } fail:^(NSError *error) {

    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
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
