//
//  XunPanXiangQingViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "XunPanXiangQingViewController.h"
#import "VoHeader.h"

#import "Masonry.h"

#import "XunPanXiangQingCell0.h"
#import "XunPanXiangQingCell1.h"

#import "XPXQInquiryActionCell.h"


#import "BaoJiaViewController.h"


#import "QiYeXinXiXiangQingViewController.h"

#import "ChaKanZiJiDeBaoJiaViewController.h"
#import "AFNetworkReachabilityManager.h"

#import "EnterpriseRelation.h"

#import "ShaiXuanBaoJiaViewController.h"
#import "ChaKanShouPanViewController.h"
#import "XiuGaiBaoJiaViewController.h"
#import "DingDanXiangQingCaiViewController.h"
#import "ChaKanZiJiDeBaoJiaQuotationOrderViewController.h"
#import "CommentUtils.h"
#import "PartDetailsViewController.h"
#import "EInquiryActionViewController.h"
#import "ShenHeBaoJiaViewController.h"
#import "DingDanXiangQingGongViewController.h"

#import "ChaKanShouPanJiePanDingJiaViewController.h"
#import "ECChaKanShouPanYiJiaViewController.h"
#import "ChaKanShouPanJiePanYiJiaViewController.h"

#import "ECAddProjectViewController.h"
#import "LingJianXiangQingViewController2.h"

#import "UIButtonIM.h"
#import "EGJuJueJiePanYiJiaViewController.h"
#import "NSArray+Transition.h"
#import "EGYiJiaViewController.h"
#import "ECYiJiaViewController.h"
#import "ShenHeShouPanViewController.h"
#import "ShenHeShouPanYiJiaViewController.h"
#import "ShenHeShouPanDingJiaViewController.h"
#import "ShenHeShouPanHeJiaVC.h"
#import "ChaKanShouPanHeJiaVC.h"
#import "ECChaKanShouPanHeJiaVC.h"
#import "ShouHuooDetailCell0901.h"

#import "ECOrderViewController.h"
#import "EGOrderViewController.h"

#import "InquiryHistoryBean.h"
#import "ShowBigImageVC.h"
#import "RefreshManager.h"

#import "GlobalSettingManager.h"

@interface XunPanXiangQingViewController () <UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource> {
    InquiryOrder *_inquiryOrderModel;
    QuotationOrder *_quotationOrderHttp;
    NSMutableArray *_arrayInquiryOrderItemModel;
    EnterpriseInfo *_enterpriseInfoModel;
    UIView *_viewNoNet;
    BOOL _checkAttention;//NO 已关注 //YES 未关注
//    BOOL _hasRelation;//NO 已关注 //YES 未关注
//    UIButton *_hasRelationBut;

    NSArray *_arrayJuJueShouPan;
    NSArray *_arrayQuXiaoXunPan;
    
    UIView *_viewLoading;
    
    NSMutableArray *_inquiryHistoryBeanList;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    
    NSMutableArray *_arrayProjectDrawingResBean;
}

@property (weak, nonatomic) IBOutlet UIView *viewPurchaseBG;
@property (weak, nonatomic) IBOutlet UIButton *buttonPurchaseL;
@property (weak, nonatomic) IBOutlet UIButton *buttonPurchaseR;
@property (weak, nonatomic) IBOutlet UIButton *buttonPurchase;

@property (weak, nonatomic) IBOutlet UIView *viewSupplierBG;
@property (weak, nonatomic) IBOutlet UIButton *buttonSupplierL;
@property (weak, nonatomic) IBOutlet UIButton *buttonSupplierR;
@property (weak, nonatomic) IBOutlet UIButton *buttonSupplier;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (assign,nonatomic) NSInteger index;

@end

static NSString *xunPanXiangQingCell0 = @"xunPanXiangQingCell0";
static NSString *shouHuooDetailCell0901 = @"shouHuooDetailCell0901";
static NSString *xunPanXiangQingCell1 = @"xunPanXiangQingCell1";
static NSString *xPXQInquiryActionCell = @"xPXQInquiryActionCell";
static NSString *cellIdentifier = @"cellIdentifier";

@implementation XunPanXiangQingViewController

//属性 isDefaultPurchase 默认 值为 @"Purchase"
- (NSString *)isDefaultPurchase {
    if (!_isDefaultPurchase) {
        _isDefaultPurchase = DefaultPurchase;
    }
    return _isDefaultPurchase;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.buttonInquiryAttention.hidden = YES;
    
    
  
    self.viewPurchaseBG.hidden = YES;
    self.viewSupplierBG.hidden = YES;

    
    self.buttonHasProject.hidden = YES;
    
    _viewLoading.hidden = NO;
    [self initRequest];//查询询盘详细接口
    [self initRequestInquiryHistory];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    
    [self initUI];
    
    self.viewJuJueShouPan.hidden = YES;
    self.viewJuJueShouPan.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector1:)];
    [self.viewJuJueShouPan addGestureRecognizer:tap1];
    _arrayJuJueShouPan = @[@"报价有问题",@"还在磋商中",@"工厂产能不足",@"不能按时完成",@"其他原因"];
    self.pickerViewYiJia.dataSource = self;
    self.pickerViewYiJia.delegate = self;
    self.pickerViewYiJia.tag = 10;
    
    self.viewPickView0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH)];
    self.viewPickView0.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:self.viewPickView0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [self.viewPickView0 addGestureRecognizer:tap];
    
    self.viewPickView1 = [[UIView alloc] initWithFrame:CGRectMake(0, kMainH-250, kMainW, 250)];
    self.viewPickView1.backgroundColor = colorRGB(241, 241, 241);
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
    
    _arrayQuXiaoXunPan = @[@"不需要询盘了",@"零件描述有误",@"收获地址有误",@"询盘时间太短",@"线下已找到供应商",@"其他原因"];
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, kMainW, CGRectGetHeight(self.viewPickView1.frame)-45)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.tag = 9;
    [self.viewPickView1 addSubview:self.pickerView];
    self.viewPickView0.hidden = YES;
    self.viewPickView1.hidden = YES;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    
}

- (void)initUI {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"XunPanXiangQingCell0" bundle:nil] forCellReuseIdentifier:xunPanXiangQingCell0];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuooDetailCell0901" bundle:nil] forCellReuseIdentifier:shouHuooDetailCell0901];
    [self.tableView registerNib:[UINib nibWithNibName:@"XunPanXiangQingCell1" bundle:nil] forCellReuseIdentifier:xunPanXiangQingCell1];
    [self.tableView registerNib:[UINib nibWithNibName:@"XPXQInquiryActionCell" bundle:nil] forCellReuseIdentifier:xPXQInquiryActionCell];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return _arrayInquiryOrderItemModel.count;
    } else if (section == 2) {
        return 1;
    } else {
        if (_inquiryHistoryBeanList.count == 0) {
            return 0;
        } else {
            return 1;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *string1;
            if ([_inquiryOrderModel.inquiryType isEqualToString:@"COM"] || [_inquiryOrderModel.inquiryType isEqualToString:@"DIR"]) {
                string1 = [NSString stringWithFormat:@"优选供应商：%@",_inquiryOrderModel.supplierRemark.length != 0?_inquiryOrderModel.supplierRemark:@"暂无"];
            }
            if ([_inquiryOrderModel.inquiryType isEqualToString:@"ATG"] || [_inquiryOrderModel.inquiryType isEqualToString:@"FTG"] || [_inquiryOrderModel.inquiryType isEqualToString:@"TTG"]) {
                string1 = [NSString stringWithFormat:@"订单要求：%@",_inquiryOrderModel.tradeOrderRemark.length != 0?_inquiryOrderModel.tradeOrderRemark:@"暂无"];
            }
            
            CGSize label1Size = [string1 boundingRectWithSize:CGSizeMake(kMainW-10-10, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            if (self.index == 0) {
                return 101+6;
            } else if (self.index == 1) {
                return 199+label1Size.height+6;
            }
        } else if (indexPath.row == 1) {
            return 40;
        }
        return 0;
    } else if (indexPath.section == 1) {
        return 169;
    } else if (indexPath.section == 2) {
        return 10;
    } else {
        if (_inquiryHistoryBeanList.count == 1) {
            return 120;;
        } else {
            return 155;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else if (section == 1) {
        return 30;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 30)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *labelLineHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainW, 0.5)];
        labelLineHeader.backgroundColor = colorRGB(221, 221, 221);
        [view addSubview:labelLineHeader];
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = colorRGB(255, 132, 0);
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).with.offset(5);
            make.left.equalTo(view.mas_left).with.offset(0);
            make.bottom.equalTo(view.mas_bottom).with.offset(-5);
            make.width.mas_equalTo(3);
        }];
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.font = [UIFont systemFontOfSize:14];
        label1.textColor = colorRGB(255, 132, 0);
        label1.text = [NSString stringWithFormat:@"零件(%ld)",_arrayInquiryOrderItemModel.count];
        [view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top);
            make.bottom.equalTo(view.mas_bottom);
            make.left.equalTo(label.mas_right).with.offset(5);
        }];
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        if (![_inquiryOrderModel.manufacturerId isEqualToString:loginModel.manufacturerId]) {
            label.backgroundColor = colorRGB(0, 168, 255);
            label1.textColor = colorRGB(0, 168, 255);
        }
        return view;
        
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 10)];
        view.backgroundColor = colorRGB(241, 241, 241);
        return view;
    } else if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 10)];
        view.backgroundColor = colorRGB(241, 241, 241);
        return view;
    } else {
        return nil;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            XunPanXiangQingCell0 *cell0 = [tableView dequeueReusableCellWithIdentifier:xunPanXiangQingCell0 forIndexPath:indexPath];
            cell0.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell0.inquiryOrder = _inquiryOrderModel;
            
            cell0.clipsToBounds = YES;
            return cell0;
        } else {
            ShouHuooDetailCell0901 * cell = [tableView dequeueReusableCellWithIdentifier:shouHuooDetailCell0901 forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setButtonUpOrDownCallBack:^(UIButton * _Nonnull sender) {
                self.index = self.index==0?1:0;
                [sender setTitle:self.index==0?@"展开更多":@"收起" forState:UIControlStateNormal];
                [sender setImage:[UIImage imageNamed:self.index==0?@"Down":@"up1"] forState:UIControlStateNormal];
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }];
            return cell;
        }
        
    } else if (indexPath.section == 1) {
        XunPanXiangQingCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:xunPanXiangQingCell1 forIndexPath:indexPath];
        
        
        if (indexPath.row == 0) {
            UILabel *labelLineHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainW, 0.5)];
            labelLineHeader.backgroundColor = colorRGB(221, 221, 221);
            [cell1.contentView addSubview:labelLineHeader];
        }
        UILabel *labelLineFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 168.5, kMainW, 0.5)];
        labelLineFooter.backgroundColor = colorRGB(221, 221, 221);
        [cell1.contentView addSubview:labelLineFooter];
        InquiryOrderItem *model = _arrayInquiryOrderItemModel[indexPath.row];
        
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        if ([_inquiryOrderModel.manufacturerId isEqualToString:loginModel.manufacturerId]) {
            //采购商
            [cell1 initDate:model with:indexPath isPurchaser:YES];
        } else {
            //供应商
            [cell1 initDate:model with:indexPath isPurchaser:NO];
        }
        
        
        
        ProjectDrawingResBean *projectDrawingResBean;
        for (ProjectDrawingResBean *project in _arrayProjectDrawingResBean) {
            if ([model.inquiryOrderItemId isEqualToString:project.idd]) {
                projectDrawingResBean = project;
                break;
            }
        }
        
        if (projectDrawingResBean == nil) {//无图纸
            cell1.sec_thumbnailUrl.image = [UIImage imageNamed:@"img_nopicture"];
        } else {
            DrawInfoBean *drawInfoBean = projectDrawingResBean.drawInfo.firstObject;
            if (drawInfoBean.fileStatus.integerValue == -1) {//失败
                NSLog(@"——————————失败——————————");
            } else if (drawInfoBean.fileStatus.integerValue == 0) {//无图纸
                cell1.sec_thumbnailUrl.image = [UIImage imageNamed:@"img_nopicture"];
            } else if (drawInfoBean.fileStatus.integerValue == 1) {//转换成功
                [cell1.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:drawInfoBean.smallPreviewUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
            } else if (drawInfoBean.fileStatus.integerValue == 2) {//转换中
                cell1.sec_thumbnailUrl.image = [UIImage imageNamed:@"img_picture_conversion"];
            }

        }
        
        cell1.sec_thumbnailUrlBtn.tag = indexPath.row;
        //点击图片跳转到零件详情的图纸附件
        [cell1.sec_thumbnailUrlBtn addTarget:self action:@selector(goPartDetails:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell1;
    } else if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = colorRGB(241, 241, 241);
        return cell;
    } else {
        XPXQInquiryActionCell *cell = [tableView dequeueReusableCellWithIdentifier:xPXQInquiryActionCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.button.hidden = YES;
        [cell.button addTarget:self action:@selector(ChaKanQuanBu:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_inquiryHistoryBeanList.count == 1) {
            cell.button.hidden = YES;
        } else {
            cell.button.hidden = NO;
        }
        
        InquiryHistoryBean *inquiryHistoryBean = _inquiryHistoryBeanList[indexPath.row];
        cell.label0.text = [NSString stringWithFormat:@"询盘动态（%ld）",_inquiryHistoryBeanList.count];
        cell.label1.text = inquiryHistoryBean.purEnterprise.length!=0?inquiryHistoryBean.purEnterprise:@"--";
        cell.label2.text = inquiryHistoryBean.msg.length!=0?inquiryHistoryBean.msg:@"--";
        cell.label3.text = inquiryHistoryBean.createTime.length!=0?inquiryHistoryBean.createTime:@"--";
        
        return cell;
    }
}

- (void)ChaKanQuanBu:(UIButton *)sender {
    EInquiryActionViewController *eInquiryActionViewController = [[EInquiryActionViewController alloc] init];
    eInquiryActionViewController.inquiryHistoryBeanList = _inquiryHistoryBeanList;
    [self.navigationController pushViewController:eInquiryActionViewController animated:YES];
}

- (void)goPartDetails:(UIButton *)sender {
    InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
    ProjectDrawingResBean *projectDrawingResBean;
    for (ProjectDrawingResBean *project in _arrayProjectDrawingResBean) {
        if ([inquiryOrderItem.inquiryOrderItemId isEqualToString:project.idd]) {
            projectDrawingResBean = project;
            break;
        }
    }
    
    if (projectDrawingResBean == nil) {//无图纸
        
    } else {
        DrawInfoBean *drawInfoBean = projectDrawingResBean.drawInfo.firstObject;
        if (drawInfoBean.fileStatus.integerValue == -1) {//失败
       
        } else if (drawInfoBean.fileStatus.integerValue == 0) {//无图纸
            
        } else if (drawInfoBean.fileStatus.integerValue == 1) {//转换成功
            ShowBigImageVC *vc = [[ShowBigImageVC alloc] init];
            vc.urlString = drawInfoBean.bigPreviewUrl;
            [self.navigationController pushViewController:vc animated:true];
        } else if (drawInfoBean.fileStatus.integerValue == 2) {//转换中
            
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        NSString *sourceCaiOrGong;
        if ([_inquiryOrderModel.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采购商身份进来
            sourceCaiOrGong = @"cai";
        } else {
            sourceCaiOrGong = @"gong";
        }
        PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
        partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.row];
        partDetailsViewController.enterpriseId = _inquiryOrderModel.member.enterpriseInfo.enterpriseId;
        partDetailsViewController.inquiryType = _inquiryOrderModel.inquiryType;
        partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
        
        [self.navigationController pushViewController:partDetailsViewController animated:YES];
    }
}

- (void)tapSelector1:(UITapGestureRecognizer *)tap {
    self.viewJuJueShouPan.hidden = YES;
}

- (void)tapSelector:(UITapGestureRecognizer *)tap {
    self.viewPickView0.hidden = YES;
    self.viewPickView1.hidden = YES;
}

//采购商订单列表
- (void)goPurchaseTradeOrderList{
    ECOrderViewController *vc = [[ECOrderViewController alloc] init];
    vc.se_enterpriseOrderCode = _inquiryOrderModel.enterpriseOrderCode;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)goSupplierTradeOrderList{
    EGOrderViewController *vc = [[EGOrderViewController alloc] init];
    vc.se_enterpriseOrderCode = _inquiryOrderModel.enterpriseOrderCode;
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)buttonCaiGong:(UIButton *)sender {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    if ([_inquiryOrderModel.manufacturerId isEqualToString:loginModel.manufacturerId]) {
        //采购商 进来
#pragma mark ----------采购商----------
        if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"COM"] || [self->_inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
            
            //COM 寻源，ATG 标准
            if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"NEW"]) {
                //未报价
#pragma mark 取消询盘
                self.viewPickView0.hidden = NO;
                self.viewPickView1.hidden = NO;
            } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"QUOTATION"]) {
                //已报价
                if (self->_inquiryOrderModel.sendItemNums.integerValue > 0) {
#pragma mark 查看订单
                    if ([sender.currentTitle isEqualToString:@"查看订单"]) {
                        [self goPurchaseTradeOrderList];
                    }
#pragma mark 筛选报价
                    if ([sender.currentTitle isEqualToString:@"筛选报价"]) {
                        ShaiXuanBaoJiaViewController *shaiXuanBaoJiaViewController = [[ShaiXuanBaoJiaViewController alloc] init];
                        shaiXuanBaoJiaViewController.inquiryOrder = _inquiryOrderModel;
                        [self.navigationController pushViewController:shaiXuanBaoJiaViewController animated:YES];

                    }
                } else {
#pragma mark 取消询盘
                    if ([sender.currentTitle isEqualToString:@"取消询盘"]) {
                        self.viewPickView0.hidden = NO;
                        self.viewPickView1.hidden = NO;
                    }
#pragma mark 筛选报价
                    if ([sender.currentTitle isEqualToString:@"筛选报价"]) {
                        ShaiXuanBaoJiaViewController *shaiXuanBaoJiaViewController = [[ShaiXuanBaoJiaViewController alloc] init];
                        shaiXuanBaoJiaViewController.inquiryOrder = _inquiryOrderModel;
                        [self.navigationController pushViewController:shaiXuanBaoJiaViewController animated:YES];
                    }
                }
            } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"SEND"]) {
                //已授单
#pragma mark 查看订单
                [self goPurchaseTradeOrderList];
            } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"REFUSE"]) {
                //拒绝报价
#pragma mark 取消询盘
                self.viewPickView0.hidden = NO;
                self.viewPickView1.hidden = NO;
            } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
                //询盘取消
                
            }
        } else if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"TTG"]) {
            //TTG 议价
            if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"SEND"]) {
                //已授单
                if (self->_inquiryOrderModel.inquiryOrderEnterprises[0].canEditPrice.integerValue == 0) {
#pragma mark 查看订单
                   [self goPurchaseTradeOrderList];
                } else {
                    if (self->_inquiryOrderModel.inquiryOrderEnterprises[0].purchaseHasQuoed.integerValue == 1) {
#pragma mark 查看订单
                        if ([sender.currentTitle isEqualToString:@"查看订单"]) {
                            [self goPurchaseTradeOrderList];
                        }
#pragma mark 修改报价
                        if ([sender.currentTitle isEqualToString:@"修改报价"]) {
                            ECYiJiaViewController *vc = [[ECYiJiaViewController alloc] init];
                            vc.inquiryOrderId = _inquiryOrderModel.inquiryOrderId;
//                            _inquiryOrderModel.quotationOrderId 取不到quotationOrderId
                            vc.quotationOrderId = _inquiryOrderModel.inquiryOrderEnterprises[0].quotationOrderId;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    } else {
#pragma mark 查看订单
                        if ([sender.currentTitle isEqualToString:@"查看订单"]) {
                            [self goPurchaseTradeOrderList];
                        }
#pragma mark 立即报价
                        if ([sender.currentTitle isEqualToString:@"立即报价"]) {
                            ECYiJiaViewController *vc = [[ECYiJiaViewController alloc] init];
                            vc.inquiryOrderId = _inquiryOrderModel.inquiryOrderId;
                            vc.quotationOrderId = _inquiryOrderModel.inquiryOrderEnterprises[0].quotationOrderId;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }
                }
                
            } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
                //询盘取消
                
            }
        } else if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"FTG"]) {
            //FTG 指定
            if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"SEND"]) {
                //已授单
#pragma mark 查看订单
               [self goPurchaseTradeOrderList];
            } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
                //询盘取消
                
            }
        }
        
        
        
        
//        if ([_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"IING"]||[_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"SQ"]||[_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"QS"]) {
//            //询盘有效
//            if ([_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"IING"]) {
//                if ([_inquiryOrderModel.quotationNum integerValue] == 0) {
//                    if ([sender.currentTitle isEqualToString:@"审核授盘"]) {
//                        if ([_inquiryOrderModel.inquiryType isEqualToString:@"FTG"]) {//指定价询盘
//                            ShenHeShouPanDingJiaViewController *vc = [[ShenHeShouPanDingJiaViewController alloc] init];
//                            vc.inquiryOrder = _inquiryOrderModel;
//                            [self.navigationController pushViewController:vc animated:YES];
//                            return;
//                        }
//
//                        if ([_inquiryOrderModel.inquiryType isEqualToString:@"TTG"]) {//后议价询盘
//                            ShenHeShouPanYiJiaViewController *vc = [[ShenHeShouPanYiJiaViewController alloc] init];
//                            vc.inquiryOrder = _inquiryOrderModel;
//                            [self.navigationController pushViewController:vc animated:YES];
//                            return;
//                        }
//                    }
//                } else {
//                    if ([sender.currentTitle isEqualToString:@"筛选报价"]) {
//                        ShaiXuanBaoJiaViewController *shaiXuanBaoJiaViewController = [[ShaiXuanBaoJiaViewController alloc] init];
//                        shaiXuanBaoJiaViewController.inquiryOrder = _inquiryOrderModel;
//                        [self.navigationController pushViewController:shaiXuanBaoJiaViewController animated:YES];
//                    }
//                    if ([sender.currentTitle isEqualToString:@"审核授盘"]) {
//                        if ([_inquiryOrderModel.isDesignated integerValue] == 1) {
//                            ShenHeShouPanHeJiaVC *shenHeShouPanHeJiaVC = [[ShenHeShouPanHeJiaVC alloc] init];
//                            shenHeShouPanHeJiaVC.quotationOrderId = _inquiryOrderModel.quotationOrderId;
//                            [self.navigationController pushViewController:shenHeShouPanHeJiaVC animated:YES];
//                            return;
//                        }
//                        ShenHeShouPanViewController *shenHeShouPanViewController = [[ShenHeShouPanViewController alloc] init];
//                        shenHeShouPanViewController.quotationOrderId = _inquiryOrderModel.quotationOrderId;
//                        [self.navigationController pushViewController:shenHeShouPanViewController animated:YES];
//                    }
//                }
//            }
//            if ([_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"SQ"]) {
//                if ([sender.currentTitle isEqualToString:@"查看授盘"]) {
//                    if ([_inquiryOrderModel.inquiryType isEqualToString:@"FTG"]) {
//                        ChaKanShouPanJiePanDingJiaViewController *vc = [[ChaKanShouPanJiePanDingJiaViewController alloc] init];
//                        vc.inquiryOrder = _inquiryOrderModel;
//                        vc.quotationOrderId = _inquiryOrderModel.quotationOrderId;
//                        vc.stringResource = @"ECaiGouShangViewController";
//                        [self.navigationController pushViewController:vc animated:YES];
//                        return;
//                    }
//
//                    if ([_inquiryOrderModel.inquiryType isEqualToString:@"TTG"]) {
//                        ECChaKanShouPanYiJiaViewController *eCChaKanShouPanYiJiaViewController = [[ECChaKanShouPanYiJiaViewController alloc] init];
//                        eCChaKanShouPanYiJiaViewController.inquiryOrder = _inquiryOrderModel;
//                        eCChaKanShouPanYiJiaViewController.quotationOrderId = _inquiryOrderModel.quotationOrderId;
//                        [self.navigationController pushViewController:eCChaKanShouPanYiJiaViewController animated:YES];
//                        return;
//                    }
//
//                    if ([_inquiryOrderModel.isDesignated integerValue] == 1) {
//                        ECChaKanShouPanHeJiaVC *eCChaKanShouPanHeJiaVC = [[ECChaKanShouPanHeJiaVC alloc] init];
//                        eCChaKanShouPanHeJiaVC.quotationOrderId = _inquiryOrderModel.quotationOrderId;
//                        [self.navigationController pushViewController:eCChaKanShouPanHeJiaVC animated:YES];
//                        return;
//                    }
//                    ChaKanShouPanViewController *vc = [[ChaKanShouPanViewController alloc] init];
//                    vc.inquiryOrder = _inquiryOrderModel;
//                    vc.quotationOrderId = _inquiryOrderModel.quotationOrderId;
//                    vc.stringResource = @"ECaiGouShangViewController";
//                    [self.navigationController pushViewController:vc animated:YES];
//                }
//            }
//            if ([_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"QS"]) {
//                if ([sender.currentTitle isEqualToString:@"进入订单"]) {
//                    DingDanXiangQingCaiViewController *dingDanXiangQingCaiViewController = [[DingDanXiangQingCaiViewController alloc] init];
//                    dingDanXiangQingCaiViewController.stringResource = @"ECaiGouShangViewControllerL";
//                    dingDanXiangQingCaiViewController.orderId = _inquiryOrderModel.tradeOrderId;
//                    [self.navigationController pushViewController:dingDanXiangQingCaiViewController animated:YES];
//                }
//            }
//        } else {
//            //询盘无效
//            if ([_inquiryOrderModel.quotationNum integerValue] > 0) {
//
//            } else {
//
//            }
//        }
    } else {
        //供应商 进来
#pragma mark ----------供应商----------
        NSInteger shoupan = 0;
        if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"COM"] || [self->_inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
            for (InquiryOrderItem *item in self->_inquiryOrderModel.inquiryOrderItems) {
                if ([item.inquiryOrderItemStatus isEqualToString:@"SEND"]) {
                    if (![item.sendManufacturerId isEqualToString:loginModel.enterpriseId]) {
                        item.inquiryOrderItemStatusDesc = @"授单他人";
                    } else {
                        shoupan++;
                    }
                }
            }
        }
        
        if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
            //ATG 标准
            if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"NEW"]) {
                //未报价
#pragma mark 立即报价
                BaoJiaViewController *bjVC = [[BaoJiaViewController alloc] init];
                bjVC.inquiryOrderId = _inquiryOrderModel.inquiryOrderId;
                [self.navigationController pushViewController:bjVC animated:YES];
            } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"QUOTATION"]) {
                //已报价
                if (shoupan>0) {
#pragma mark 查看报价
                    if ([sender.currentTitle isEqualToString:@"查看报价"]) {
                        if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:82]]) {
                            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
                            return;
                        }
                        ChaKanZiJiDeBaoJiaViewController *vc = [[ChaKanZiJiDeBaoJiaViewController alloc] init];
                        vc.inquiryOrder = _inquiryOrderModel;
                        [self.navigationController pushViewController:vc animated:YES];

                    }
#pragma mark 查看订单
                    if ([sender.currentTitle isEqualToString:@"查看订单"]) {
                        [self goSupplierTradeOrderList];
                    }
                } else {
#pragma mark 查看报价
                    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:82]]) {
                        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
                        return;
                    }
                    ChaKanZiJiDeBaoJiaViewController *vc = [[ChaKanZiJiDeBaoJiaViewController alloc] init];
                    vc.inquiryOrder = _inquiryOrderModel;
                    [self.navigationController pushViewController:vc animated:YES];

                }
            } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SEND"]) {
                //已授单
#pragma mark 查看订单
                [self goSupplierTradeOrderList];
    
            } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"REFUSE"]) {
                //已拒绝

            } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SENDOTHER"]) {
                //授单他人
                
            } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"CANCEL"]) {
                //询盘取消
                
            }
            
        } else if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"COM"]) {
            //COM 寻源
            if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
                //询盘取消

            } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"REFUSE"]) {
                //拒绝报价

            } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"SEND"]) {
                if (shoupan>0) {
                    
                } else {
                    
                }
            } else {
                if (self->_inquiryOrderModel.inquiryOrderEnterprises == nil || self->_inquiryOrderModel.inquiryOrderEnterprises.count == 0) {
#pragma mark 立即报价
                    BaoJiaViewController *bjVC = [[BaoJiaViewController alloc] init];
                    bjVC.inquiryOrderId = _inquiryOrderModel.inquiryOrderId;
                    [self.navigationController pushViewController:bjVC animated:YES];
                } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"QUOTATION"]) {
                    if (shoupan>0) {
#pragma mark 查看报价
                        if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:82]]) {
                            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
                            return;
                        }
                        if ([sender.currentTitle isEqualToString:@"查看报价"]) {
                            ChaKanZiJiDeBaoJiaViewController *vc = [[ChaKanZiJiDeBaoJiaViewController alloc] init];
                            vc.inquiryOrder = _inquiryOrderModel;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
#pragma mark 查看订单
                        if ([sender.currentTitle isEqualToString:@"查看订单"]) {
                            [self goSupplierTradeOrderList];
                        }
                    } else {
#pragma mark 查看报价
                        if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:82]]) {
                            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
                            return;
                        }
                        ChaKanZiJiDeBaoJiaViewController *vc = [[ChaKanZiJiDeBaoJiaViewController alloc] init];
                        vc.inquiryOrder = _inquiryOrderModel;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SEND"]) {
                    if (shoupan>0) {
#pragma mark 查看订单
                        [self goSupplierTradeOrderList];
                    }
                }
            }
            
        } else if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"TTG"]) {
            //TTG 议价
            if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SEND"]) {
                if (self->_inquiryOrderModel.inquiryOrderEnterprises[0].canEditPrice.integerValue == 0) {
#pragma mark 查看订单
                    [self goSupplierTradeOrderList];
                } else {
                    if (self->_inquiryOrderModel.inquiryOrderEnterprises[0].supplierHasQuoed.integerValue == 1) {
#pragma mark 查看订单
                        if ([sender.currentTitle isEqualToString:@"查看订单"]) {
                            [self goSupplierTradeOrderList];
                        }
#pragma mark 修改报价
                        if ([sender.currentTitle isEqualToString:@"修改报价"]) {
                            EGYiJiaViewController *vc = [[EGYiJiaViewController alloc] init];
                            vc.inquiryOrderId = _inquiryOrderModel.inquiryOrderId;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    } else {
#pragma mark 查看订单
                        if ([sender.currentTitle isEqualToString:@"查看订单"]) {
                            [self goSupplierTradeOrderList];
                        }
#pragma mark 立即报价
                        if ([sender.currentTitle isEqualToString:@"立即报价"]) {
                            EGYiJiaViewController *vc = [[EGYiJiaViewController alloc] init];
                            vc.inquiryOrderId = _inquiryOrderModel.inquiryOrderId;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }
                }
            } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"CANCEL"]) {

            }
        } else if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"FTG"]) {
            //FTG 指定
            if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SEND"]) {
#pragma mark 查看订单
                [self goSupplierTradeOrderList];
            } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"CANCEL"]) {

            }
        }
        
    }
}

- (void)buttonWanCheng:(UIButton *)sender {
    if (sender.tag == 2) {
        self.viewPickView0.hidden = YES;
        self.viewPickView1.hidden = YES;
    }
    if (sender.tag == 3) {
        if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:21]]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
            return;
        }
        
        self->_viewLoading.hidden = NO;
        NSInteger row = [self.pickerView selectedRowInComponent:0];
        
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
        
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        inquiryOrder.inquiryOrderId = self.inquiryOrderId;//必填
        inquiryOrder.cancelMsg = _arrayQuXiaoXunPan[row];//必填
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
#pragma mark 采购商取消询盘接口
        [HttpMamager postRequestWithURLString:DYZ_inquiry_purchase_inquiry_cancel parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"取消成功"];
                
                [RefreshManager shareRefreshManager].eCInquiryVC = @"通知ECInquiryViewController刷新啦";
                
                [self initRequest];
                self.viewPickView0.hidden = YES;
                self.viewPickView1.hidden = YES;
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"取消失败"];
            }
        } fail:^(NSError *error) {
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    }
}

#pragma mark 询盘单关注
- (IBAction)inquiryAttention:(UIButton *)sender {
    //ime_e_icon_concern 未关注
    //ime_e_icon_concern_2t 已关注2
    
    //已关注
//    _checkAttention = NO;
    //已关注 点击取消关注
    if (_checkAttention == NO) {
        [self initRequestInquiryAttentionCancel];
    }
    
    //未关注
//    _checkAttention = YES;
    //未关注 点击关注
    if (_checkAttention == YES) {
        [self initRequestInquiryAttentionAdd];
    }
}

#pragma mark 询盘单关注接口
- (void)initRequestInquiryAttentionAdd {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    InquiryOrderEnterprise *inquiryOrderEnterprise = [[InquiryOrderEnterprise alloc] init];
    inquiryOrderEnterprise.inquiryOrderId = self.inquiryOrderId;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    inquiryOrderEnterprise.manufacturerId = loginModel.manufacturerId;
    inquiryOrderEnterprise.memberId = loginModel.memberId;
    postEntityBean.entity = inquiryOrderEnterprise.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_inquiryAttention_add parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            _checkAttention = NO;
            [self.buttonInquiryAttention setImage:[UIImage imageNamed:@"ime_e_icon_concern_2t"] forState:UIControlStateNormal];
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"关注成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"关注失败"];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}
#pragma mark 询盘单取消关注接口
- (void)initRequestInquiryAttentionCancel {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    InquiryOrderEnterprise *inquiryOrderEnterprise = [[InquiryOrderEnterprise alloc] init];
    inquiryOrderEnterprise.inquiryOrderId = self.inquiryOrderId;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    inquiryOrderEnterprise.manufacturerId = loginModel.manufacturerId;
    postEntityBean.entity = inquiryOrderEnterprise.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_inquiryAttention_cancel parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            _checkAttention = YES;
            [self.buttonInquiryAttention setImage:[UIImage imageNamed:@"ime_e_icon_concern"] forState:UIControlStateNormal];
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"取消成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"取消失败"];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

#pragma mark 询盘历史web端展示
- (void)initRequestInquiryHistory{
    NSString *fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    NSDictionary *entity = @{@"id":self.inquiryOrderId};

    NSDictionary *dic = @{@"fbToken":fbToken,@"entity":entity};
    
    [HttpMamager postRequestWithURLString:DYZ_api_inquiryHistory_history parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        _inquiryHistoryBeanList = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *array = model.list;
        for (NSDictionary *dic in array) {
            InquiryHistoryBean *inquiryHistoryBean = [InquiryHistoryBean mj_objectWithKeyValues:dic];
            [_inquiryHistoryBeanList addObject:inquiryHistoryBean];
        }
        [_tableView reloadData];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}


- (void)requestData:(void (^)(id))dataBlock {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    
    InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
    inquiryOrder.inquiryOrderId = self.inquiryOrderId;
    NSString *urlString;
    if ([self.isDefaultPurchase isEqualToString:DefaultPurchase]) {
        urlString = DYZ_inquiry_purchase_detail;//采购商
    } else if ([self.isDefaultPurchase isEqualToString:DefaultSupplier]) {
        urlString = DYZ_inquiry_supplier_detail;//供应商
    } else if ([self.isDefaultPurchase isEqualToString:DefaultCenter]) {
        urlString = DYZ_inquiry_supplier_detail;
        inquiryOrder.inquiryType = @"COM";
    }
    postEntityBean.entity = inquiryOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:urlString parameters:dic success:^(id responseObjectModel) {
        dataBlock(responseObjectModel);
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

#pragma mark 查询询盘详细接口
- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    
    InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
    inquiryOrder.inquiryOrderId = self.inquiryOrderId;
    NSString *urlString;
    if ([self.isDefaultPurchase isEqualToString:DefaultPurchase]) {
        urlString = DYZ_inquiry_purchase_detail;//采购商
    } else if ([self.isDefaultPurchase isEqualToString:DefaultSupplier]) {
        urlString = DYZ_inquiry_supplier_detail;//供应商
    } else if ([self.isDefaultPurchase isEqualToString:DefaultCenter]) {
        urlString = DYZ_inquiry_supplier_detail;
        inquiryOrder.inquiryType = @"COM";
    }
    postEntityBean.entity = inquiryOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:urlString parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            self.tableView.hidden = NO;
            self->_viewLoading.hidden = YES;
            
            self->_inquiryOrderModel = [InquiryOrder mj_objectWithKeyValues:model.entity];
            self->_arrayInquiryOrderItemModel = self->_inquiryOrderModel.inquiryOrderItems;
    
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            
            if ([self->_inquiryOrderModel.manufacturerId isEqualToString:loginModel.manufacturerId]) {
                //采购商 进来
                self.viewPurchaseBG.hidden = NO;
                self.buttonPurchase.hidden = YES;
                self.buttonPurchaseL.hidden = YES;
                self.buttonPurchaseR.hidden = YES;
                self.tableViewBottom.constant = 0;
                
                if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"COM"] || [self->_inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
                    //COM 寻源，ATG 标准
                    if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"NEW"]) {
                        //未报价
                        self.buttonPurchase.hidden = NO;
                        [self.buttonPurchase setTitle:@"取消询盘" forState:UIControlStateNormal];
                    } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"QUOTATION"]) {
                        //已报价
                        if (self->_inquiryOrderModel.sendItemNums.integerValue > 0) {
                            self.buttonPurchaseL.hidden = NO;
                            [self.buttonPurchaseL setTitle:@"查看订单" forState:UIControlStateNormal];
                            self.buttonPurchaseR.hidden = NO;
                            [self.buttonPurchaseR setTitle:@"筛选报价" forState:UIControlStateNormal];
                        } else {
                            self.buttonPurchaseL.hidden = NO;
                            [self.buttonPurchaseL setTitle:@"取消询盘" forState:UIControlStateNormal];
                            self.buttonPurchaseR.hidden = NO;
                            [self.buttonPurchaseR setTitle:@"筛选报价" forState:UIControlStateNormal];
                        }
                    } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"SEND"]) {
                        //已授单
                        self.buttonPurchase.hidden = NO;
                        [self.buttonPurchase setTitle:@"查看订单" forState:UIControlStateNormal];
                    } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"REFUSE"]) {
                        //拒绝报价
                        self.buttonPurchase.hidden = NO;
                        [self.buttonPurchase setTitle:@"取消询盘" forState:UIControlStateNormal];
                    } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
                        //询盘取消
                        
                    }
                } else if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"TTG"]) {
                    //TTG 议价
                    if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"SEND"]) {
                        //已授单
                        if (self->_inquiryOrderModel.inquiryOrderEnterprises[0].canEditPrice.integerValue == 0) {
                            self.buttonPurchase.hidden = NO;
                            [self.buttonPurchase setTitle:@"查看订单" forState:UIControlStateNormal];
                        } else {
                            if (self->_inquiryOrderModel.inquiryOrderEnterprises[0].purchaseHasQuoed.integerValue == 1) {
                                self.buttonPurchaseL.hidden = NO;
                                [self.buttonPurchaseL setTitle:@"查看订单" forState:UIControlStateNormal];
                                self.buttonPurchaseR.hidden = NO;
                                [self.buttonPurchaseR setTitle:@"修改报价" forState:UIControlStateNormal];
                            } else {
                                self.buttonPurchaseL.hidden = NO;
                                [self.buttonPurchaseL setTitle:@"查看订单" forState:UIControlStateNormal];
                                self.buttonPurchaseR.hidden = NO;
                                [self.buttonPurchaseR setTitle:@"立即报价" forState:UIControlStateNormal];
                            }
                        }
                        
                    } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
                        //询盘取消
                        
                    }
                } else if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"FTG"]) {
                    //FTG 指定
                    if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"SEND"]) {
                        //已授单
                        self.buttonPurchase.hidden = NO;
                        [self.buttonPurchase setTitle:@"查看订单" forState:UIControlStateNormal];
                    } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
                        //询盘取消
                        
                    }
                }
                
                if (self.buttonPurchaseL.isHidden == NO || self.buttonPurchaseR.isHidden == NO || self.buttonPurchase.isHidden == NO) {
                    //只要有一个不隐藏
                    self.tableViewBottom.constant = 50;
                } else {
                    self.viewPurchaseBG.hidden = YES;
                }

            } else {
                //供应商 进来
                self.viewSupplierBG.hidden = NO;
                self.buttonSupplier.hidden = YES;
                self.buttonSupplierL.hidden = YES;
                self.buttonSupplierR.hidden = YES;
                self.tableViewBottom.constant = 0;
                
                NSInteger shoupan = 0;
                if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"COM"] || [self->_inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
                    
                    for (InquiryOrderItem *item in self->_inquiryOrderModel.inquiryOrderItems) {
                        if ([item.inquiryOrderItemStatus isEqualToString:@"SEND"]) {
                            if (![item.sendManufacturerId isEqualToString:loginModel.enterpriseId]) {
                                item.inquiryOrderItemStatusDesc = @"授单他人";
                            } else {
                                shoupan++;
                            }
                        }
                    }
                }
                
                if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
                    //ATG 标准
                    if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"NEW"]) {
                        //未报价
                        self.buttonSupplier.hidden = NO;
                        [self.buttonSupplier setTitle:@"立即报价" forState:UIControlStateNormal];
                        
                    } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"QUOTATION"]) {
                        //已报价
                        if (shoupan>0) {
                            self.buttonSupplierL.hidden = NO;
                            [self.buttonSupplierL setTitle:@"查看报价" forState:UIControlStateNormal];
                            self.buttonSupplierR.hidden = NO;
                            [self.buttonSupplierR setTitle:@"查看订单" forState:UIControlStateNormal];
                        } else {
                            self.buttonSupplier.hidden = NO;
                            [self.buttonSupplier setTitle:@"查看报价" forState:UIControlStateNormal];
                        }
                    } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SEND"]) {
                        //已授单
                        self.buttonSupplier.hidden = NO;
                        [self.buttonSupplier setTitle:@"查看订单" forState:UIControlStateNormal];
                    } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"REFUSE"]) {
                        //已拒绝
//                        self.buttonSupplier.hidden = NO;
//                        [self.buttonSupplier setTitle:@"查看原因" forState:UIControlStateNormal];
                    } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SENDOTHER"]) {
                        //授单他人
                        
                    } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"CANCEL"]) {
                        //询盘取消
//                        self.buttonSupplier.hidden = NO;
//                        [self.buttonSupplier setTitle:@"查看询盘" forState:UIControlStateNormal];
                    }

                } else if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"COM"]) {
                    //COM 寻源
                    if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
                        //询盘取消
//                        self.buttonSupplier.hidden = NO;
//                        [self.buttonSupplier setTitle:@"查看询盘" forState:UIControlStateNormal];
                    } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"REFUSE"]) {
                        //拒绝报价
//                        self.buttonSupplier.hidden = NO;
//                        [self.buttonSupplier setTitle:@"查看原因" forState:UIControlStateNormal];
                    } else if ([self->_inquiryOrderModel.inquiryOrderStatus isEqualToString:@"SEND"]) {
                        if (shoupan>0) {
                            
                        } else {
                            
                        }
                    } else {
                        if (self->_inquiryOrderModel.inquiryOrderEnterprises == nil || self->_inquiryOrderModel.inquiryOrderEnterprises == [NSNull null] || self->_inquiryOrderModel.inquiryOrderEnterprises.count == 0) {
                            self.buttonSupplier.hidden = NO;
                            [self.buttonSupplier setTitle:@"立即报价" forState:UIControlStateNormal];
                        } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"QUOTATION"]) {
                            if (shoupan>0) {
                                self.buttonSupplierL.hidden = NO;
                                [self.buttonSupplierL setTitle:@"查看报价" forState:UIControlStateNormal];
                                self.buttonSupplierR.hidden = NO;
                                [self.buttonSupplierR setTitle:@"查看订单" forState:UIControlStateNormal];
                            } else {
                                self.buttonSupplier.hidden = NO;
                                [self.buttonSupplier setTitle:@"查看报价" forState:UIControlStateNormal];
                            }
                        } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SEND"]) {
                            if (shoupan>0) {
                                self.buttonSupplier.hidden = NO;
                                [self.buttonSupplier setTitle:@"查看订单" forState:UIControlStateNormal];
                            }
                        }
                    }
                    
                } else if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"TTG"]) {
                    //TTG 议价
                    if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SEND"]) {
                        if (self->_inquiryOrderModel.inquiryOrderEnterprises[0].canEditPrice.integerValue == 0) {
                            self.buttonSupplier.hidden = NO;
                            [self.buttonSupplier setTitle:@"查看订单" forState:UIControlStateNormal];
                        } else {
                            if (self->_inquiryOrderModel.inquiryOrderEnterprises[0].supplierHasQuoed.integerValue == 1) {
                                self.buttonSupplierL.hidden = NO;
                                [self.buttonSupplierL setTitle:@"查看订单" forState:UIControlStateNormal];
                                self.buttonSupplierR.hidden = NO;
                                [self.buttonSupplierR setTitle:@"修改报价" forState:UIControlStateNormal];
                            } else {
                                self.buttonSupplierL.hidden = NO;
                                [self.buttonSupplierL setTitle:@"查看订单" forState:UIControlStateNormal];
                                self.buttonSupplierR.hidden = NO;
                                [self.buttonSupplierR setTitle:@"立即报价" forState:UIControlStateNormal];
                            }
                        }
                    } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"CANCEL"]) {
//                        self.buttonSupplier.hidden = NO;
//                        [self.buttonSupplier setTitle:@"查看询盘" forState:UIControlStateNormal];
                    }
                } else if ([self->_inquiryOrderModel.inquiryType isEqualToString:@"FTG"]) {
                    //FTG 指定
                    if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"SEND"]) {
                        self.buttonSupplier.hidden = NO;
                        [self.buttonSupplier setTitle:@"查看订单" forState:UIControlStateNormal];
                    } else if ([self->_inquiryOrderModel.inquiryOrderEnterprises[0].inquiryAndEpStatus isEqualToString:@"CANCEL"]) {
//                        self.buttonSupplier.hidden = NO;
//                        [self.buttonSupplier setTitle:@"查看询盘" forState:UIControlStateNormal];
                    }
                }
                
                
                
                if (self.buttonSupplierL.isHidden == NO || self.buttonSupplierR.isHidden == NO || self.buttonSupplier.isHidden == NO) {
                    //只要有一个不隐藏
                    self.tableViewBottom.constant = 50;
                } else {
                    self.viewSupplierBG.hidden = YES;
                }
                
//                self.buttonInquiryAttention.hidden = NO;
//                [self initRequestInquiryAttentionCheckAttention];//验证询盘单是否已关注
////                [self initRequestEpRelationHasRelation];//验证企业是否已关注
            }
            
            NSMutableArray <NSString *> *strA = [[NSMutableArray alloc] init];
            for (InquiryOrderItem *item in _inquiryOrderModel.inquiryOrderItems) {
                [strA addObject:item.inquiryOrderItemId];
            }
            [self.tableView reloadData];
            [self api_Image_drawingCloudUrl:strA];
            
        }
        
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}


#pragma mark 验证询盘单是否已关注
- (void)initRequestInquiryAttentionCheckAttention {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    InquiryOrderEnterprise *inquiryOrderEnterprise = [[InquiryOrderEnterprise alloc] init];
    inquiryOrderEnterprise.inquiryOrderId = _inquiryOrderModel.inquiryOrderId;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    inquiryOrderEnterprise.manufacturerId = loginModel.manufacturerId;
    postEntityBean.entity = inquiryOrderEnterprise.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_inquiryAttention_checkAttention parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            
            if ([returnMsgBean.returnCode integerValue] == 0) {
                //已关注
                _checkAttention = NO;
                [self.buttonInquiryAttention setImage:[UIImage imageNamed:@"ime_e_icon_concern_2t"] forState:UIControlStateNormal];
            }
            if ([returnMsgBean.returnCode integerValue] == 1) {
                //未关注
                _checkAttention = YES;
                [self.buttonInquiryAttention setImage:[UIImage imageNamed:@"ime_e_icon_concern"] forState:UIControlStateNormal];
                
            }
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    
}

#pragma mark 议价
- (IBAction)quotationRefu:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"拒绝授盘"]) {
        self.viewJuJueShouPan.hidden = NO;
        self.buttonWanCheng.tag = 1000;//拒绝授盘
        [self.pickerViewYiJia reloadAllComponents];
    }
    if ([sender.currentTitle isEqualToString:@"询盘议价"]) {
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        if ([_inquiryOrderModel.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采
            ECYiJiaViewController *eCYiJiaViewController = [[ECYiJiaViewController alloc] init];
            eCYiJiaViewController.quotationOrderId = _inquiryOrderModel.quotationOrderId;
            [self.navigationController pushViewController:eCYiJiaViewController animated:YES];
        } else {
            EGYiJiaViewController *eGYiJiaViewController = [[EGYiJiaViewController alloc] init];
//            eGYiJiaViewController.quotationOrderId = _quotationOrderHttp.quotationOrderId;
            [self.navigationController pushViewController:eGYiJiaViewController animated:YES];
        }
    }
}

- (IBAction)buttonYiJiaJuJueWanCheng:(UIButton *)sender {
    if (sender.tag == 999) {
        self.viewJuJueShouPan.hidden = YES;
    }
    if (sender.tag == 1000) {//拒绝授盘
        NSInteger row = [self.pickerViewYiJia selectedRowInComponent:0];
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        postEntityBean.memberId = loginModel.memberId;
        QuotationOrder *quotationOrder1 = [[QuotationOrder alloc] init];
        
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        inquiryOrder.inquiryOrderId = _inquiryOrderModel.inquiryOrderId;
        inquiryOrder.inquiryType = _inquiryOrderModel.inquiryType;
        inquiryOrder.quotationOrderId = _inquiryOrderModel.quotationOrderId;
        inquiryOrder.manufacturerId = loginModel.manufacturerId;
        inquiryOrder.cancelId = loginModel.memberId;
        inquiryOrder.cancelMsg = _arrayJuJueShouPan[row];
        inquiryOrder.cancelName = loginModel.accountName;
        
        
        quotationOrder1.inquiryOrder = inquiryOrder;
        postEntityBean.entity = quotationOrder1.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_quotation_refu parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [self viewWillAppear:YES];
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"拒绝成功"];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"拒绝失败"];
            }
            self.viewJuJueShouPan.hidden = YES;
            BOOL isBreak = false;
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isMemberOfClass:[XunPanXiangQingViewController class]]) {
                    isBreak = true;
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }

            if (!isBreak) {
                [CommentUtils goToSupplierView:1 withInquiryOrder:_inquiryOrderModel.inquiryType withViewConTroller:self];
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    }
}

#pragma mark 议价
- (IBAction)quotationAcc:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"接受授盘"]) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"供应商接盘" message:@"确认接盘后开始与采购商协商零件价格。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定接盘" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            postEntityBean.memberId = loginModel.memberId;
            QuotationOrder *quotationOrder1 = [[QuotationOrder alloc] init];
            quotationOrder1.inquiryOrderId = _quotationOrderHttp.inquiryOrderId;
            quotationOrder1.quotationOrderId = _quotationOrderHttp.quotationOrderId;
            quotationOrder1.manufacturerId = loginModel.manufacturerId;
            InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
            inquiryOrder.manufacturerId = _inquiryOrderModel.manufacturerId;
            inquiryOrder.inquiryOrderCode = _inquiryOrderModel.inquiryOrderCode;
            quotationOrder1.inquiryOrder = inquiryOrder;
            quotationOrder1.acceptId = loginModel.memberId;
            quotationOrder1.acceptName = loginModel.accountName;
            
            quotationOrder1.isTemporary = _quotationOrderHttp.isTemporary;
            
            quotationOrder1.supplierTaxRate = [NSNumber numberWithDouble:0.16];//0.16、0.03 //刚加
            postEntityBean.entity = quotationOrder1.mj_keyValues;
            NSDictionary *dic = postEntityBean.mj_keyValues;
            
            [HttpMamager postRequestWithURLString:DYZ_quotation_acc parameters:dic success:^(id responseObjectModel) {
                ReturnMsgBean *returnMsgBean = responseObjectModel;
                
                if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                    [self viewWillAppear:YES];
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接盘成功"];
                } else {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"提交失败"];
                }
                BOOL isBreak = false;
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isMemberOfClass:[XunPanXiangQingViewController class]]) {
                        isBreak = true;
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
                
                if (!isBreak) {
                    [CommentUtils goToSupplierView:2 withInquiryOrder:_inquiryOrderModel.inquiryType withViewConTroller:self];
                }
                
            } fail:^(NSError *error) {
                
            } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
            
        }];
        [ac addAction:action];
        [ac addAction:action1];
        [self presentViewController:ac animated:YES completion:nil];
    }
    if ([sender.currentTitle isEqualToString:@"进入订单"]) {
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        if ([_inquiryOrderModel.manufacturerId isEqualToString:loginModel.manufacturerId]) {
            DingDanXiangQingCaiViewController *dingDanXiangQingCaiViewController = [[DingDanXiangQingCaiViewController alloc] init];
            dingDanXiangQingCaiViewController.stringResource = @"ECaiGouShangViewControllerL";
            dingDanXiangQingCaiViewController.orderId = _inquiryOrderModel.tradeOrderId;
            [self.navigationController pushViewController:dingDanXiangQingCaiViewController animated:YES];
        } else {
            DingDanXiangQingGongViewController *dingDanXiangQingViewController = [[DingDanXiangQingGongViewController alloc] init];
            dingDanXiangQingViewController.stringResource = @"EGongYingShangViewControllerL";
            dingDanXiangQingViewController.orderId = _inquiryOrderModel.tradeOrderId;
            [self.navigationController pushViewController:dingDanXiangQingViewController animated:YES];
        }
    }
}

//#pragma mark 验证企业是否已关注
//- (void)initRequestEpRelationHasRelation {
//    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
//    EnterpriseRelation *enterpriseRelation = [[EnterpriseRelation alloc] init];
//    LoginModel *loginModel = [DatabaseTool getLoginModel];
//    enterpriseRelation.initiatorId = loginModel.manufacturerId;
//    enterpriseRelation.passiveId = _inquiryOrderModel.manufacturerId;
//    enterpriseRelation.relationType = @"A";
//    postEntityBean.entity = enterpriseRelation.mj_keyValues;
//    NSDictionary *dic = postEntityBean.mj_keyValues;
//    [HttpMamager postRequestWithURLString:DYZ_epRelation_hasRelation parameters:dic success:^(id responseObjectModel) {
//        ReturnMsgBean *returnMsgBean = responseObjectModel;
//        
//        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
//            
//            if ([returnMsgBean.returnCode integerValue] == 0) {
//                //已关注
//                _hasRelation = NO;
//                [_tableView reloadData];
//            }
//            if ([returnMsgBean.returnCode integerValue] == 1) {
//                //未关注
//                _hasRelation = YES;
//                [_tableView reloadData];
//                
//            }
//        }
//    } fail:^(NSError *error) {
//        
//    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
//}

//- (void)quotationDetail {
//    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
//    QuotationOrderItem *quotationOrderItem = [[QuotationOrderItem alloc] init];
//    quotationOrderItem.q__quotationOrderId = _inquiryOrderModel.quotationOrder.quotationOrderId;
//    LoginModel *loginModel = [DatabaseTool getLoginModel];
//    if ([_inquiryOrderModel.manufacturerId isEqualToString:loginModel.manufacturerId]) {
//        quotationOrderItem.i__manufacturerId = loginModel.manufacturerId;
//    } else {
//        quotationOrderItem.qm__manufacturerId = loginModel.manufacturerId;
//    }
//
//    postEntityBean.entity = quotationOrderItem.mj_keyValues;
//    NSDictionary *dic = postEntityBean.mj_keyValues;
//
//    [HttpMamager postRequestWithURLString:DYZ_quotation_detail parameters:dic success:^(id responseObjectModel) {
//        ReturnListBean *returnListBean = responseObjectModel;
//
//        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
//            for (NSDictionary *dic in returnListBean.list) {
//                QuotationOrderItem *quotationOrderItem = [QuotationOrderItem mj_objectWithKeyValues:dic];
//                _quotationOrderHttp = quotationOrderItem.quotationOrder;
//            }
//            if ([_inquiryOrderModel.inquiryType isEqualToString:@"TTG"]&&[_quotationOrderHttp.canEditPrice integerValue] == 1) {
//                [self.buttonYiJiaL setTitle:@"询盘议价" forState:UIControlStateNormal];
//                [self.buttonYiJiaR setTitle:@"进入订单" forState:UIControlStateNormal];
//            } else {
//                if ([_inquiryOrderModel.quotationOrder.status isEqualToString:@"SR"]) {
//                    self.buttonYiJiaL.hidden = YES;
//                    self.buttonYiJiaR.hidden = YES;
//                    self.buttonYiJia.hidden = NO;
//                }
//                [self.buttonYiJia setTitle:@"进入订单" forState:UIControlStateNormal];
//            }
//        }
//    } fail:^(NSError *error) {
//
//    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
//}

//DYZ_drawing_drawingCloud_drawingCloudUrl
- (void)api_Image_drawingCloudUrl:(NSMutableArray <__kindof NSString *> *)strA {
    EfeibiaoPostEntityBean *efeibiaoPostEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    efeibiaoPostEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    DrawingCloudBean *drawingCloudBean = [[DrawingCloudBean alloc] init];
    drawingCloudBean.ids = strA;
    drawingCloudBean.type = [NSNumber numberWithInt:2];
    efeibiaoPostEntityBean.entity = drawingCloudBean.mj_keyValues;
    NSDictionary *dic = efeibiaoPostEntityBean.mj_keyValues;
    
//    NSLog(@"%@",efeibiaoPostEntityBean.mj_JSONString);
    
    [HttpMamager postRequestWithURLString:DYZ_drawing_drawingCloud_drawingCloudUrl parameters:dic success:^(id responseObjectModel) {
        NSLog(@"%@",[responseObjectModel mj_JSONString]);
        ReturnListBean *returnListBean = responseObjectModel;
        
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            
            _arrayProjectDrawingResBean = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in returnListBean.list) {
                ProjectDrawingResBean *projectDrawingResBean = [ProjectDrawingResBean mj_objectWithKeyValues:dic];
                [_arrayProjectDrawingResBean addObject:projectDrawingResBean];
            }
            
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addProject:(id)sender {
    ECAddProjectViewController *eCAddProjectViewController = [[ECAddProjectViewController alloc] init];
    eCAddProjectViewController.inquiryOrderId = _inquiryOrderModel.inquiryOrderId;
    eCAddProjectViewController.tradeOrderId = _inquiryOrderModel.tradeOrderId;
    [self.navigationController pushViewController:eCAddProjectViewController animated:YES];
}

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:action0];
    [alertC addAction:action1];
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 9) {
        return _arrayQuXiaoXunPan.count;
    } else if (pickerView.tag == 10) {
        return _arrayJuJueShouPan.count;
    } else {
        return 0;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 9) {
        return _arrayQuXiaoXunPan[row];
    } else if (pickerView.tag == 10) {
        return _arrayJuJueShouPan[row];
    } else {
        return nil;
    }
}


- (NSTimeInterval)getDayWith:(NSString *)string {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate = [format dateFromString:string];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:fromdate];
    NSDate *localeDate = [fromdate  dateByAddingTimeInterval:interval];
    NSTimeInterval time = [localeDate timeIntervalSinceDate:[NSDate date]]/60/60/24;
    return time;
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
