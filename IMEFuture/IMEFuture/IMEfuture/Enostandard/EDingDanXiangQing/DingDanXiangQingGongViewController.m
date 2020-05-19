//
//  DingDanXiangQingViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/15.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "DingDanXiangQingGongViewController.h"
#import "VoHeader.h"

#import "FaBaoPingLunGongViewController.h"
#import "HDQCircleProgressView.h"

#import "PartDetailsDingDanViewController.h"


#import "EShengChangJingduXiangXiViewController.h"
#import "LogisticsInformationVC.h"
#import "EGYiJiaViewController.h"
#import "EGOrderViewController.h"

#import "ECCheckTheLogisticsViewController.h"
#import "UIButtonIM.h"

#import "FaHuoLieBiaoVC.h"
#import "BuFaHuoLieBiaoVC.h"
#import "YiCiFaHuoVC.h"

#import "ViewLine.h"
#import "Masonry.h"

#import "QiYeXinXiXiangQingViewController.h"

#import "FaHuoLieBiaoViewController09.h"



#import "ChaKanShouPanJiePanYiJiaViewController.h"

#import "DingDanXQCell0.h"
#import "DingDanXQCell1.h"
#import "DingDanXQCell2.h"

#import "XunPanXiangQingViewController.h"
#import "ShowBigImageVC.h"

@interface DingDanXiangQingGongViewController () <UITableViewDelegate,UITableViewDataSource> {
//    NSString *_sectionHeaderTitle;
    NSMutableArray *_arrayDingDanzhuangTai;
    TradeOrder *_tradeOrderHttp;
    NSMutableArray *_arrayTradeOrderItems;
    UIView *_viewLoading;
    BOOL _isYES;
    FactoryProductInfo *_factoryProductInfo;
    UIView *_viewNetworkAnomaly;
    
    InquiryOrder *_inquiryOrderHttp;//为查看议价
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    
    NSMutableArray *_arrayProjectDrawingResBean;
}

@property (nonatomic, strong) HDQCircleProgressView *progressView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation DingDanXiangQingGongViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    _viewLoading.hidden = NO;
    _viewNetworkAnomaly.hidden = NO;
    self.button1.hidden = YES;
    self.button2.hidden = YES;
    self.button3.hidden = YES;
    self.button4.hidden = YES;
    
    [self initRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    
    
    [self line:self.view withY:_height_NavBar];
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DingDanXQCell0" bundle:nil] forCellReuseIdentifier:@"dingDanXQCell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DingDanXQCell1" bundle:nil] forCellReuseIdentifier:@"dingDanXQCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DingDanXQCell2" bundle:nil] forCellReuseIdentifier:@"dingDanXQCell2"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = colorRGB(241, 241, 241);
    self.tableView.hidden = YES;
    
    
    
    _viewNetworkAnomaly = [UIView networkAnomalyWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) withTitle:@"数据错误！"];
    [self.view addSubview:_viewNetworkAnomaly];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    
    
//    NSDictionary *dicHelp =  [[NSUserDefaults standardUserDefaults] objectForKey:@"hangZhuYeDic"];
//    if ([dicHelp[@"help6"] isEqualToString:@"no"]) {
//        UIButton *buttonHelp = [UIButton buttonWithType:UIButtonTypeCustom];
//        buttonHelp.frame = CGRectMake(0, 0, kMainW, kMainH);
//        buttonHelp.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
//        [buttonHelp addTarget:self action:@selector(buttonHelpClick:) forControlEvents:UIControlEventTouchUpInside];
//        buttonHelp.adjustsImageWhenHighlighted = NO;
//        [[UIApplication sharedApplication].keyWindow addSubview:buttonHelp];
//
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ime_help_order_supplier"]];
//        imageView.frame = CGRectMake(0, 54, kMainW, 208);
//        [buttonHelp addSubview:imageView];
//    }
}

//#pragma mark 帮助页 点击事件
//- (void)buttonHelpClick:(UIButton *)sender{
//    NSDictionary *dicHelp =  [[NSUserDefaults standardUserDefaults] objectForKey:@"hangZhuYeDic"];
//    NSMutableDictionary *muDicHelp = [NSMutableDictionary dictionaryWithDictionary:dicHelp];
//    [muDicHelp setValue:@"yes" forKey:@"help6"];
//    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:muDicHelp
//                                                      ] forKey:@"hangZhuYeDic"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [sender removeFromSuperview];
//
//}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return _tradeOrderHttp.tradeOrderItems.count;
    } else {
        return 1;
    }
}

- (void)goPartDetails:(UIButton *)sender {
    
    TradeOrderItem *tradeOrderItem = _tradeOrderHttp.tradeOrderItems[sender.tag];
    ProjectDrawingResBean *projectDrawingResBean;
    for (ProjectDrawingResBean *project in _arrayProjectDrawingResBean) {
        if ([tradeOrderItem.tradeOrderItemId isEqualToString:project.idd]) {
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
    if (indexPath.section == 1) {
        if (indexPath.row != _arrayTradeOrderItems.count) {
            if (_isYES == YES) {
                PartDetailsDingDanViewController *ljxqVC = [[PartDetailsDingDanViewController alloc] init];
                ljxqVC.indexNum = 1;
                ljxqVC.isHaveDanTouMingGongChang = @"yes";
                ljxqVC.tradeOrderItem = _arrayTradeOrderItems[indexPath.row];
                ljxqVC.factoryProductInfo = _factoryProductInfo;
                ljxqVC.enterpriseId = _tradeOrderHttp.purchaseEnterpriseId;
                ljxqVC.inquiryType = _tradeOrderHttp.inquiryType;
                ljxqVC.sourceCaiOrGong = @"gong";
                [self.navigationController pushViewController:ljxqVC animated:YES];
            } else {
                PartDetailsDingDanViewController *ljxqVC = [[PartDetailsDingDanViewController alloc] init];
                ljxqVC.tradeOrderItem = _arrayTradeOrderItems[indexPath.row];
                ljxqVC.factoryProductInfo = _factoryProductInfo;
                ljxqVC.enterpriseId = _tradeOrderHttp.purchaseEnterpriseId;
                ljxqVC.inquiryType = _tradeOrderHttp.inquiryType;
                ljxqVC.sourceCaiOrGong = @"gong";
                [self.navigationController pushViewController:ljxqVC animated:YES];
            }
        }
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DingDanXQCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"dingDanXQCell0" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tradeOrder = _tradeOrderHttp;
        return cell;
    } else if (indexPath.section == 1) {
        DingDanXQCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"dingDanXQCell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TradeOrderItem *tradeOrderItem =  _tradeOrderHttp.tradeOrderItems[indexPath.row];
        [cell initData:tradeOrderItem with:indexPath];
        
        ProjectDrawingResBean *projectDrawingResBean;
        for (ProjectDrawingResBean *project in _arrayProjectDrawingResBean) {
            if ([tradeOrderItem.tradeOrderItemId isEqualToString:project.idd]) {
                projectDrawingResBean = project;
                break;
            }
        }
        
        if (projectDrawingResBean == nil) {//无图纸
            cell.thumbnailUrl.image = [UIImage imageNamed:@"img_nopicture"];
        } else {
            DrawInfoBean *drawInfoBean = projectDrawingResBean.drawInfo.firstObject;
            if (drawInfoBean.fileStatus.integerValue == -1) {//失败
                NSLog(@"——————————失败——————————");
            } else if (drawInfoBean.fileStatus.integerValue == 0) {//无图纸
                cell.thumbnailUrl.image = [UIImage imageNamed:@"img_nopicture"];
            } else if (drawInfoBean.fileStatus.integerValue == 1) {//转换成功
                [cell.thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:drawInfoBean.smallPreviewUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
            } else if (drawInfoBean.fileStatus.integerValue == 2) {//转换中
                cell.thumbnailUrl.image = [UIImage imageNamed:@"img_picture_conversion"];
            }
        }
        cell.thumbnailUrlBtn.tag = indexPath.row;
        [cell.thumbnailUrlBtn addTarget:self action:@selector(goPartDetails:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else {
        DingDanXQCell2 *cell =  [tableView dequeueReusableCellWithIdentifier:@"dingDanXQCell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell initDate:_tradeOrderHttp withColor:colorGong];
        return cell;
    }
}

- (void)line:(UIView *)view withY:(CGFloat)y {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, kMainW, 0.5)];
    label.backgroundColor = colorLine;
    [view addSubview:label];
}

- (UIView *)addScrolleViewDYZ:(UIView *)view tradeOrder:(TradeOrder *)tradeOrder {
    CGFloat height;
    if ([tradeOrder.inquiryType isEqualToString:@"COM"]&&[tradeOrder.isOfflineSign integerValue] == 1) {//线下签约
        height = 70;
    } else {
        height = 140;
    }
    
    UIView *viewBG140 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, height)];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)colorRGB(0, 204, 255).CGColor,  (__bridge id)colorRGB(0, 168, 255).CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, kMainW, 140);
    [viewBG140.layer addSublayer:gradientLayer];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(18, 24, 0, 0)];
    imageView1.image = [UIImage imageNamed:@"state_supplier"];
    [imageView1 sizeToFit];
    [viewBG140 addSubview:imageView1];
    
    UILabel *labelState = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame)+8.5, CGRectGetMinY(imageView1.frame), 200, CGRectGetHeight(imageView1.frame))];
    labelState.textColor = colorRGB(255, 255, 255);
    labelState.font = [UIFont systemFontOfSize:18];
    labelState.text = [NSString TradeOrderPurchaseStatus:tradeOrder.tradeOrderPurchaseStatus];
    [viewBG140 addSubview:labelState];
    
    UIButton *buttonXianXiaQianYue = [UIButton buttonWithType:UIButtonTypeCustom];
    [viewBG140 addSubview:buttonXianXiaQianYue];
    [buttonXianXiaQianYue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labelState.mas_centerY);
        make.right.mas_equalTo(-15);
    }];
    buttonXianXiaQianYue.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonXianXiaQianYue setTitle:@"线下签约 " forState:UIControlStateNormal];
    [buttonXianXiaQianYue setImage:[UIImage imageNamed:@"icon_information_white"] forState:UIControlStateNormal];
    
    [buttonXianXiaQianYue setImageEdgeInsets:UIEdgeInsetsMake(0, buttonXianXiaQianYue.titleLabel.intrinsicContentSize.width, 0, -buttonXianXiaQianYue.titleLabel.intrinsicContentSize.width)];
    [buttonXianXiaQianYue setTitleEdgeInsets:UIEdgeInsetsMake(0, -buttonXianXiaQianYue.currentImage.size.width, 0, buttonXianXiaQianYue.currentImage.size.width)];
    [buttonXianXiaQianYue addTarget:self action:@selector(buttonXianXiaQianYueClick:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonXianXiaQianYue.hidden = YES;
    if ([tradeOrder.inquiryType isEqualToString:@"COM"]&&[tradeOrder.isOfflineSign integerValue] == 1) {//线下签约
        buttonXianXiaQianYue.hidden = NO;
    } else {
        buttonXianXiaQianYue.hidden = YES;
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 140-_height_NavBar-10, kMainW, _height_NavBar)];
    scrollView.showsHorizontalScrollIndicator = NO;
    [viewBG140 addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake((77+10)*8,_height_NavBar);
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollView.contentSize.width, _height_NavBar)];
    [scrollView addSubview:view1];
    
    NSArray *arrayTitel;
    arrayTitel = @[@"创建订单",@"审批通过",@"供应商接单",@"供应商发货",@"仓库收货",@"质检验货",@"对账成功",@"订单完成"];
    
    for (int i = 0; i < arrayTitel.count; i ++) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((77+10)*i, 17, 77+10, 15)];
        label1.textColor = colorRGB(1, 126, 186);
        label1.text = arrayTitel[i];
        label1.font = [UIFont systemFontOfSize:13];
        label1.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:label1];
    }
    
    [self drawTraderOrderStatus:tradeOrder.tradeOrderPurchaseStatus superView:view1];
    
    
//    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"waitingPaymentForPurchase"]) {
//        for (int i = 0; i < 1; i ++) {
//            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((77+10)*i, 17, 77+10, 15)];
//            label1.textColor = colorRGB(255, 255, 255);
//            label1.text = arrayTitel[i];
//            label1.font = [UIFont systemFontOfSize:13];
//            label1.textAlignment = NSTextAlignmentCenter;
//            [view1 addSubview:label1];
//        }
//    }
//    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"paymentOvertime"]) {
//
//    }
//    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"paymentConfirm"]) {
//        for (int i = 0; i < 1; i ++) {
//            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((77+10)*i, 17, 77+10, 15)];
//            label1.textColor = colorRGB(255, 255, 255);
//            label1.text = arrayTitel[i];
//            label1.font = [UIFont systemFontOfSize:13];
//            label1.textAlignment = NSTextAlignmentCenter;
//            [view1 addSubview:label1];
//        }
//    }
//    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"purchasePaid"]) {
//        for (int i = 0; i < 2; i ++) {
//            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((77+10)*i, 17, 77+10, 15)];
//            label1.textColor = colorRGB(255, 255, 255);
//            label1.text = arrayTitel[i];
//            label1.font = [UIFont systemFontOfSize:13];
//            label1.textAlignment = NSTextAlignmentCenter;
//            [view1 addSubview:label1];
//        }
//    }
//    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"supplierDelivered"]) {
//        for (int i = 0; i < 3; i ++) {
//            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((77+10)*i, 17, 77+10, 15)];
//            label1.textColor = colorRGB(255, 255, 255);
//            label1.text = arrayTitel[i];
//            label1.font = [UIFont systemFontOfSize:13];
//            label1.textAlignment = NSTextAlignmentCenter;
//            [view1 addSubview:label1];
//        }
//    }
//    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"examineCargoForPurchase"]) {
//        for (int i = 0; i < 4; i ++) {
//            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((77+10)*i, 17, 77+10, 15)];
//            label1.textColor = colorRGB(255, 255, 255);
//            label1.text = arrayTitel[i];
//            label1.font = [UIFont systemFontOfSize:13];
//            label1.textAlignment = NSTextAlignmentCenter;
//            [view1 addSubview:label1];
//        }
//    }
//    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"success"]) {
//        if ([tradeOrder.purchaseIsComment boolValue] == 0) {
//            for (int i = 0; i < 5; i ++) {
//                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((77+10)*i, 17, 77+10, 15)];
//                label1.textColor = colorRGB(255, 255, 255);
//                label1.text = arrayTitel[i];
//                label1.font = [UIFont systemFontOfSize:13];
//                label1.textAlignment = NSTextAlignmentCenter;
//                [view1 addSubview:label1];
//            }
//        } else {
//            for (int i = 0; i < arrayTitel.count; i ++) {
//                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((77+10)*i, 17, 77+10, 15)];
//                label1.textColor = colorRGB(255, 255, 255);
//                label1.text = arrayTitel[i];
//                label1.font = [UIFont systemFontOfSize:13];
//                label1.textAlignment = NSTextAlignmentCenter;
//                [view1 addSubview:label1];
//            }
//        }
//    }
//    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"close"]) {
//
//    }
//    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"waitingRefund"]) {
//
//    }
//    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"refunded"]) {
//
//    }
    viewBG140.clipsToBounds = YES;
    [view addSubview:viewBG140];
    return viewBG140;
}

- (void)buttonXianXiaQianYueClick:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"选择线下签约的询盘无须在智造家平台付款，供应商接盘后生成的订单仅作为单据记录，后续的发货、收货等操作需要在线下进行！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction0 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alertAction0];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (Boolean)lineNumAdd {
    if ([_tradeOrderHttp.inquiryType isEqualToString:@"TTG"]||[_tradeOrderHttp.inquiryType isEqualToString:@"ATG"]||[_tradeOrderHttp.inquiryType isEqualToString:@"FTG"]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)drawTraderOrderStatus:(NSString *)status superView:(UIView *)superView {
    int whiteLineCount = 0;
    int grayLineCount = 0;
    Boolean isYes = [self lineNumAdd];
    if ([status isEqualToString:@"WAITAPPROVAL"]) {//待审批
        whiteLineCount = 1;
        grayLineCount = 6;
    }
    if ([status isEqualToString:@"WAITORDER"]) {//待接单
        whiteLineCount = 2;
        grayLineCount = 5;
    }
    if ([status isEqualToString:@"purchasePaid"]) {//待发货
        whiteLineCount = 3;
        grayLineCount = 4;
    }
    if ([status isEqualToString:@"supplierDelivered"]) {//待收货
        whiteLineCount = 4;
        grayLineCount = 3;
    }
    if ([status isEqualToString:@"examineCargoForPurchase"]) {//待质检
        whiteLineCount = 5;
        grayLineCount = 2;
    }
    if ([status isEqualToString:@"waitBalance"]) {//待对账
        whiteLineCount = 6;
        grayLineCount = 1;
    }
    if ([status isEqualToString:@"success"]) {//已完成
        whiteLineCount = 7;
        grayLineCount = 0;
    }
    if ([status isEqualToString:@"REFUSEDAPPROVAL"]) {//审批失败
        whiteLineCount = 0;
        grayLineCount = 7;
    }
    if ([status isEqualToString:@"REFUSEDORDER"]) {//拒绝接单
        whiteLineCount = 0;
        grayLineCount = 7;
    }
    if ([status isEqualToString:@"ACCEPTFAILED"]) {//验收不通过
        whiteLineCount = 0;
        grayLineCount = 7;
    }
    if ([status isEqualToString:@"close"]) {//已关闭
        whiteLineCount = 0;
        grayLineCount = 7;
    }
    float xCenter = 40;
    float yCenter = 44;
    if ([status isEqualToString:@"REFUSEDAPPROVAL"] || [status isEqualToString:@"REFUSEDORDER"] || [status isEqualToString:@"ACCEPTFAILED"] || [status isEqualToString:@"close"]) {
        [self drawCicleSuperView:superView type:2 X:xCenter Y:yCenter];
        xCenter = xCenter + 5.5;
    } else {
        [self drawCicleSuperView:superView type:0 X:xCenter Y:yCenter];
        xCenter = xCenter + 5.5;
    }
    
    for (int i = 0; i < whiteLineCount; i++) {
        if (i < whiteLineCount - 1) {
            [self drawLineSuperView:superView type:0 x1:xCenter y1:yCenter-1];
            xCenter = xCenter + 77 + 5.5;
            [self drawCicleSuperView:superView type:0 X:xCenter Y:yCenter];
            xCenter = xCenter + 5.5;
        } else {
            if ([status isEqualToString:@"success"]) {
                [self drawLineSuperView:superView type:0 x1:xCenter y1:yCenter-1];
                xCenter = xCenter + 77 + 5.5;
                [self drawCicleSuperView:superView type:0 X:xCenter Y:yCenter];
                xCenter = xCenter + 5.5;
            } else {
                [self drawLineSuperView:superView type:1 x1:xCenter y1:yCenter-1];
                xCenter = xCenter + 77 + 8.5;
                [self drawCicleSuperView:superView type:1 X:xCenter Y:yCenter];
                xCenter = xCenter + 8.5;
            }
        }
    }
    for (int i = 0; i < grayLineCount; i++) {
        [self drawLineSuperView:superView type:2 x1:xCenter y1:yCenter-1];
        xCenter = xCenter + 77 + 5.5;
        [self drawCicleSuperView:superView type:2 X:xCenter Y:yCenter];
        xCenter = xCenter + 5.5;
    }
}

- (void)drawCicleSuperView:(UIView *)superView type:(int)type X:(float)x Y:(float)y{
    if (type == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        imageView.center = CGPointMake(x, y);
        imageView.image = [UIImage imageNamed:@"schedule_completed"];
        [superView addSubview:imageView];//根据实际效果估算半径是5.5
        return;
    }
    if (type == 1) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
        imageView.center = CGPointMake(x, y);
        imageView.image = [UIImage imageNamed:@"schedule_in_hand"];
        [superView addSubview:imageView];//根据实际效果估算半径是8.5
        return;
    }
    if (type == 2) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 11, 11)];
        imageView.center = CGPointMake(x, y);
        imageView.image = [UIImage imageNamed:@"supplier_not_started"];
        [superView addSubview:imageView];
        return;
    }
}

- (void)drawLineSuperView:(UIView *)superView type:(int)type x1:(float)x1 y1:(float)y1 {
    if (type == 0) {
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(x1, y1, 77, 2)];
        viewLine.backgroundColor = [UIColor whiteColor];
        [superView addSubview:viewLine];
        return;
    }
    if (type == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x1, y1, 77, 2)];
        [superView addSubview:view];
        [ViewLine drawDashLine:view lineLength:10 lineSpacing:5 lineColor1:[UIColor whiteColor]];
        return;
    }
    if (type == 2) {
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(x1, y1, 77, 2)];
        viewLine.backgroundColor = colorRGB(1, 126, 186);
        [superView addSubview:viewLine];
        return;
    }
}

- (UIView *)creatView1WithSubview:(UIView *)view withY:(CGFloat)y withTradeOrder:(TradeOrder *)tradeOrder{
    NSString *string1 = [NSString stringWithFormat:@"%@ %@",tradeOrder.zoneStr,tradeOrder.address];
    CGSize label1Size = [string1 boundingRectWithSize:CGSizeMake(kMainW-56-15, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, y, kMainW, 15+16+8.5+label1Size.height+15)];
    view1.backgroundColor = [UIColor whiteColor];
    [view addSubview:view1];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"address"]];
    [view1 addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(view1.mas_centerY);
    }];
    
    UILabel *label0 = [[UILabel alloc] init];
    [view1 addSubview:label0];
    [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(56);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(16);
    }];
    label0.font = [UIFont systemFontOfSize:16];
    label0.textColor = colorRGB(51, 51, 51);
    label0.text = [NSString stringWithFormat:@"%@  %@  %@  %@",tradeOrder.name,tradeOrder.phone,tradeOrder.telZip,tradeOrder.tel];
    UILabel *label1 = [[UILabel alloc] init];
    [view1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(label0.mas_leading);
        make.trailing.equalTo(label0.mas_trailing);
        make.top.equalTo(label0.mas_bottom).with.offset(8.5);
    }];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = colorRGB(102, 102, 102);
    label1.text = [NSString stringWithFormat:@"%@ %@",tradeOrder.zoneStr,tradeOrder.address];
    label1.numberOfLines = 0;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(view1.frame)-0.5, kMainW, 0.5)];
    line.backgroundColor = colorLine;
    [view1 addSubview:line];
    return view1;
}

//发货列表
- (void)buttonClickFaHuoLieBiao:(UIButton *)sender {
    FaHuoLieBiaoVC *faHuoLieBiaoVC = [[FaHuoLieBiaoVC alloc] init];
    faHuoLieBiaoVC.tradeOrderId = _tradeOrderHttp.orderId;
    [self.navigationController pushViewController:faHuoLieBiaoVC animated:YES];
}
//补发货列表
- (void)buttonClickBuFaHuoLieBiao:(UIButton *)sender {
    BuFaHuoLieBiaoVC *buFaHuoLieBiaoVC = [[BuFaHuoLieBiaoVC alloc] init];
    buFaHuoLieBiaoVC.tradeOrderId = _tradeOrderHttp.orderId;
    [self.navigationController pushViewController:buFaHuoLieBiaoVC animated:YES];
}

- (void)initTradeOrder:(TradeOrder *)tradeOrder {
    
    UIView *tmpView = [[UIView alloc] init];
    
    UIView *view0 = [self addScrolleViewDYZ:tmpView tradeOrder:tradeOrder];
    
    UIView *view1 = [self creatView1WithSubview:tmpView withY:CGRectGetMaxY(view0.frame) withTradeOrder:tradeOrder];
    
    BOOL isHaveButton = NO;
    if (([_tradeOrderHttp.inquiryType isEqualToString:@"ATG"]||[_tradeOrderHttp.inquiryType isEqualToString:@"FTG"]||[_tradeOrderHttp.inquiryType isEqualToString:@"TTG"])&&[_tradeOrderHttp.deliverStatus integerValue] > 0) {
        //发货列表
        isHaveButton = YES;
    }
    if (([_tradeOrderHttp.inquiryType isEqualToString:@"ATG"]||[_tradeOrderHttp.inquiryType isEqualToString:@"FTG"]||[_tradeOrderHttp.inquiryType isEqualToString:@"TTG"])&&[_tradeOrderHttp.hasReissue integerValue] > 0) {
        //补发货列表
        isHaveButton = YES;
    }
    isHaveButton = NO;
    UIView *buttonView;
    if (isHaveButton == YES) {
        buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), kMainW, 40)];
        buttonView.backgroundColor = [UIColor whiteColor];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(10, 0, 75, 40);
        [button1 setTitle:@"发货列表" forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont systemFontOfSize:12];
        [button1 setTitleColor:colorText153 forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"icon_deliver_goods"] forState:UIControlStateNormal];
        button1.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [button1 addTarget:self action:@selector(buttonClickFaHuoLieBiao:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:button1];
        button1.hidden = YES;
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(CGRectGetMaxX(button1.frame)+15, 0, 85, 40);
        [button2 setTitle:@"补发货列表" forState:UIControlStateNormal];
        button2.titleLabel.font = [UIFont systemFontOfSize:12];
        [button2 setTitleColor:colorText153 forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"icon_reissue"] forState:UIControlStateNormal];
        button2.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [buttonView addSubview:button2];
        [button2 addTarget:self action:@selector(buttonClickBuFaHuoLieBiao:) forControlEvents:UIControlEventTouchUpInside];
        button2.hidden = YES;
        
        [tmpView addSubview:buttonView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, kMainW, 0.5)];
        line.backgroundColor = colorLine;
        [buttonView addSubview:line];
        
        if (([_tradeOrderHttp.inquiryType isEqualToString:@"ATG"]||[_tradeOrderHttp.inquiryType isEqualToString:@"FTG"]||[_tradeOrderHttp.inquiryType isEqualToString:@"TTG"])&&[_tradeOrderHttp.deliverStatus integerValue] > 0) {
            //收获列表
            button1.hidden = NO;
        }
        if (([_tradeOrderHttp.inquiryType isEqualToString:@"ATG"]||[_tradeOrderHttp.inquiryType isEqualToString:@"FTG"]||[_tradeOrderHttp.inquiryType isEqualToString:@"TTG"])&&[_tradeOrderHttp.hasReissue integerValue] > 0) {
            //验货列表
            button2.hidden = NO;
        }
    }
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DingDanXiangQingHeaderView" owner:self options:nil];
    UIView *tmpCustomView = [nib objectAtIndex:0];
    if (isHaveButton == YES) {
        tmpCustomView.frame = CGRectMake(0, CGRectGetMaxY(buttonView.frame)+10, kMainW, 170);
    } else {
        tmpCustomView.frame = CGRectMake(0, CGRectGetMaxY(view1.frame)+10, kMainW, 170);
    }
    
    if (isHaveButton == YES) {
        if (_isYES == YES) {
            tmpView.frame = CGRectMake(0, 0, kMainW, CGRectGetMaxY(tmpCustomView.frame));
        } else {
            tmpView.frame = CGRectMake(0, 0, kMainW, CGRectGetMaxY(buttonView.frame)+10);
        }
    } else {
        if (_isYES == YES) {
            tmpView.frame = CGRectMake(0, 0, kMainW, CGRectGetMaxY(tmpCustomView.frame));
        } else {
            tmpView.frame = CGRectMake(0, 0, kMainW, CGRectGetMaxY(view1.frame)+10);
        }
    }
    
    if (_isYES == YES) {
        [tmpView addSubview:tmpCustomView];//这句话必须在确定tmpView.frame的下面
    }
    
    tmpView.clipsToBounds = YES;
    self.tableView.tableHeaderView = tmpView;
    self.tableView.tableHeaderView.backgroundColor = colorRGB(241, 241, 241);
    
    [self.button1 setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
    self.button1.layer.borderColor = colorLine.CGColor;
    [self.button2 setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
    self.button2.layer.borderColor = colorLine.CGColor;
    [self.button3 setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
    self.button3.layer.borderColor = colorLine.CGColor;
    [self.button4 setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
    self.button4.layer.borderColor = colorLine.CGColor;
    
    //标准 ATG  寻源 COM
    if ([tradeOrder.inquiryType isEqualToString:@"ATG"] || [tradeOrder.inquiryType isEqualToString:@"COM"]) {
        //待接单 WAITORDER
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"WAITORDER"]) {
            self.button4.hidden = NO;
            [self.button4 setTitle:@"立即接单" forState:UIControlStateNormal];
        }
        //待发货 purchasePaid
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"purchasePaid"]) {
//            self.button3.hidden = NO;
//            [self.button3 setTitle:@"打印合同" forState:UIControlStateNormal];
            self.button4.hidden = NO;
            [self.button4 setTitle:@"发货" forState:UIControlStateNormal];
        }
        //待收货 supplierDelivered
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"supplierDelivered"]) {
//            self.button4.hidden = NO;
//            [self.button4 setTitle:@"打印合同" forState:UIControlStateNormal];
        }
        //待质检 examineCargoForPurchase
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"examineCargoForPurchase"]) {
//            self.button4.hidden = NO;
//            [self.button4 setTitle:@"打印合同" forState:UIControlStateNormal];
        }
        //验收不通过 ACCEPTFAILED
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"ACCEPTFAILED"]) {
//            self.button4.hidden = NO;
//            [self.button4 setTitle:@"打印合同" forState:UIControlStateNormal];
        }
        //待对账 waitBalance 已完成 success
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"waitBalance"] || [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"success"]) {
//            self.button4.hidden = NO;
//            [self.button4 setTitle:@"打印合同" forState:UIControlStateNormal];
        }
        //拒绝接单 REFUSEDORDER
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"REFUSEDORDER"]) {
            self.button4.hidden = NO;
            [self.button4 setTitle:@"查看原因" forState:UIControlStateNormal];
        }
        //已关闭 close
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"close"]) {
//            self.button4.hidden = NO;
//            [self.button4 setTitle:@"打印合同" forState:UIControlStateNormal];
        }
    }
    
    //后议价 TTG
    if ([tradeOrder.inquiryType isEqualToString:@"TTG"]) {
        //待接单 WAITORDER
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"WAITORDER"]) {
            self.button4.hidden = NO;
            [self.button4 setTitle:@"立即接单" forState:UIControlStateNormal];
        }
        //待发货 purchasePaid
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"purchasePaid"]) {
//            self.button3.hidden = NO;
//            [self.button3 setTitle:@"打印合同" forState:UIControlStateNormal];
            self.button4.hidden = NO;
            [self.button4 setTitle:@"发货" forState:UIControlStateNormal];
        }
        //待收货 supplierDelivered 待质检 examineCargoForPurchase
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"supplierDelivered"]||[tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"examineCargoForPurchase"]) {
//            self.button4.hidden = NO;
//            [self.button4 setTitle:@"打印合同" forState:UIControlStateNormal];
        }
        //验收不通过 ACCEPTFAILED
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"ACCEPTFAILED"]) {
            self.button3.hidden = NO;
            [self.button3 setTitle:@"查看原因" forState:UIControlStateNormal];
//            self.button4.hidden = NO;
//            [self.button4 setTitle:@"打印合同" forState:UIControlStateNormal];
        }
        //待对账 waitBalance 已完成 success
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"waitBalance"] || [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"success"]) {
//            self.button4.hidden = NO;
//            [self.button4 setTitle:@"打印合同" forState:UIControlStateNormal];
        }
        //拒绝接单 REFUSEDORDER
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"REFUSEDORDER"]) {
            self.button4.hidden = NO;
            [self.button4 setTitle:@"查看原因" forState:UIControlStateNormal];
        }
    }
    
    //指定价 FTG
    if ([tradeOrder.inquiryType isEqualToString:@"FTG"]) {
        //待接单 WAITORDER
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"WAITORDER"]) {
            self.button4.hidden = NO;
            [self.button4 setTitle:@"立即接单" forState:UIControlStateNormal];
        }
        //待发货 purchasePaid
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"purchasePaid"]) {
//            self.button3.hidden = NO;
//            [self.button3 setTitle:@"打印合同" forState:UIControlStateNormal];
            self.button4.hidden = NO;
            [self.button4 setTitle:@"发货" forState:UIControlStateNormal];
        }
        //待收货 supplierDelivered 待质检 examineCargoForPurchase  待对账 waitBalance 已完成 success
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"supplierDelivered"] || [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"examineCargoForPurchase"]) {
//            self.button4.hidden = NO;
//            [self.button4 setTitle:@"打印合同" forState:UIControlStateNormal];
        }
        //验收不通过 ACCEPTFAILED
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"ACCEPTFAILED"]) {
            self.button3.hidden = NO;
            [self.button3 setTitle:@"查看原因" forState:UIControlStateNormal];
//            self.button4.hidden = NO;
//            [self.button4 setTitle:@"打印合同" forState:UIControlStateNormal];
        }
        //拒绝接单 REFUSEDORDER
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"REFUSEDORDER"]) {
            self.button4.hidden = NO;
            [self.button4 setTitle:@"查看原因" forState:UIControlStateNormal];
        }
    }

    self.button1.hidden = NO;
    [self.button1 setTitle:@"生产详情" forState:UIControlStateNormal];
    
    [self.button1 addTarget:self action:@selector(buttonClickTradeOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 addTarget:self action:@selector(buttonClickTradeOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.button3 addTarget:self action:@selector(buttonClickTradeOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.button4 addTarget:self action:@selector(buttonClickTradeOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.tableViewBottom.constant = 50;
    self.view1.hidden = NO;
    if (self.button1.isHidden == YES && self.button2.isHidden == YES && self.button3.isHidden == YES && self.button4.isHidden == YES) {
        self.tableViewBottom.constant = 0;
        self.view1.hidden = YES;
    }
}


//查看原因
- (void)checkReason:(NSString *)inquiryOrderId {
    XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
    xunPanXiangQingViewController.inquiryOrderId = inquiryOrderId;
    xunPanXiangQingViewController.isDefaultPurchase = DefaultSupplier;
    [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
}

- (void)buttonClickTradeOrder:(UIButton *)sender {
    TradeOrder *tradeOrder = _tradeOrderHttp;
    
    if ([sender.currentTitle isEqualToString:@"生产详情"]) {
#pragma mark 生产详情
        EShengChangJingduXiangXiViewController *vc = [[EShengChangJingduXiangXiViewController alloc] init];
        vc.orderId = tradeOrder.orderId;
        vc.isDefaultPurchase = DefaultSupplier;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
#pragma mark 标准-ATG  寻源-COM
    //标准 ATG  寻源 COM
    if ([tradeOrder.inquiryType isEqualToString:@"ATG"] || [tradeOrder.inquiryType isEqualToString:@"COM"]) {
        //待接单 WAITORDER
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"WAITORDER"]) {
#pragma mark 立即接单
            ChaKanShouPanJiePanYiJiaViewController *vc = [[ChaKanShouPanJiePanYiJiaViewController alloc] init];
            vc.orderId = tradeOrder.orderId;
            vc.inquiryOrderId = tradeOrder.inquiryOrderId;
            [self.navigationController pushViewController:vc animated:YES];

        }
        //待发货 purchasePaid
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"purchasePaid"]) {
            if ([sender.currentTitle isEqualToString:@"打印合同"]) {
#pragma mark 打印合同
            }
            if ([sender.currentTitle isEqualToString:@"发货"]) {
#pragma mark 发货
                FaHuoLieBiaoViewController09 *vc = [[FaHuoLieBiaoViewController09 alloc] init];
                vc.insideOrderCode = tradeOrder.insideOrderCode;
                vc.isOpenErp = tradeOrder.isOpenErp;
                [self.navigationController pushViewController:vc animated:true];
            }
        }
        //待收货 supplierDelivered
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"supplierDelivered"]) {
#pragma mark 打印合同

        }
        //待质检 examineCargoForPurchase
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"examineCargoForPurchase"]) {
#pragma mark 打印合同

        }
        //验收不通过 ACCEPTFAILED
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"ACCEPTFAILED"]) {
#pragma mark 打印合同
            
        }
        //待对账 waitBalance 已完成 success
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"waitBalance"] || [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"success"]) {
#pragma mark 打印合同
          
        }
        //拒绝接单 REFUSEDORDER
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"REFUSEDORDER"]) {
#pragma mark 查看原因
            [self checkReason:tradeOrder.inquiryOrderId];
           
        }
        //已关闭 close
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"close"]) {
#pragma mark 打印合同
    
        }
    }
#pragma mark 后议价-TTG
    //后议价 TTG
    if ([tradeOrder.inquiryType isEqualToString:@"TTG"]) {
        //待接单 WAITORDER
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"WAITORDER"]) {
#pragma mark 立即接单
            ChaKanShouPanJiePanYiJiaViewController *vc = [[ChaKanShouPanJiePanYiJiaViewController alloc] init];
            vc.orderId = tradeOrder.orderId;
            vc.inquiryOrderId = tradeOrder.inquiryOrderId;
            [self.navigationController pushViewController:vc animated:YES];
        }
        //待发货 purchasePaid
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"purchasePaid"]) {
            if ([sender.currentTitle isEqualToString:@"打印合同"]) {
#pragma mark 打印合同
            }
            if ([sender.currentTitle isEqualToString:@"发货"]) {
#pragma mark 发货
                FaHuoLieBiaoViewController09 *vc = [[FaHuoLieBiaoViewController09 alloc] init];
                vc.insideOrderCode = tradeOrder.insideOrderCode;
                vc.isOpenErp = tradeOrder.isOpenErp;
                [self.navigationController pushViewController:vc animated:true];
            }
        }
        //待收货 supplierDelivered 待质检 examineCargoForPurchase
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"supplierDelivered"]||[tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"examineCargoForPurchase"]) {
#pragma mark 打印合同
        }
        //验收不通过 ACCEPTFAILED
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"ACCEPTFAILED"]) {
            if ([sender.currentTitle isEqualToString:@"查看原因"]) {
#pragma mark 查看原因
                [self checkReason:tradeOrder.inquiryOrderId];
            }
            if ([sender.currentTitle isEqualToString:@"打印合同"]) {
#pragma mark 打印合同
            }
        }
        //待对账 waitBalance 已完成 success
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"waitBalance"] || [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"success"]) {
#pragma mark 打印合同
        }
        //拒绝接单 REFUSEDORDER
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"REFUSEDORDER"]) {
#pragma mark 查看原因
            [self checkReason:tradeOrder.inquiryOrderId];
        }
    }
#pragma mark 指定价—FTG
    //指定价 FTG
    if ([tradeOrder.inquiryType isEqualToString:@"FTG"]) {
        //待接单 WAITORDER
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"WAITORDER"]) {
#pragma mark 立即接单
            ChaKanShouPanJiePanYiJiaViewController *vc = [[ChaKanShouPanJiePanYiJiaViewController alloc] init];
            vc.orderId = tradeOrder.orderId;
            vc.inquiryOrderId = tradeOrder.inquiryOrderId;
            [self.navigationController pushViewController:vc animated:YES];
        }
        //待发货 purchasePaid
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"purchasePaid"]) {
            if ([sender.currentTitle isEqualToString:@"打印合同"]) {
#pragma mark 打印合同
            }
            if ([sender.currentTitle isEqualToString:@"发货"]) {
#pragma mark 发货
                FaHuoLieBiaoViewController09 *vc = [[FaHuoLieBiaoViewController09 alloc] init];
                vc.insideOrderCode = tradeOrder.insideOrderCode;
                vc.isOpenErp = tradeOrder.isOpenErp;
                [self.navigationController pushViewController:vc animated:true];
            }
        }
        //待收货 supplierDelivered 待质检 examineCargoForPurchase  待对账 waitBalance 已完成 success
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"supplierDelivered"] || [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"examineCargoForPurchase"]) {
#pragma mark 打印合同
        }
        //验收不通过 ACCEPTFAILED
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"ACCEPTFAILED"]) {
            if ([sender.currentTitle isEqualToString:@"查看原因"]) {
#pragma mark 打印合同
            }
            if ([sender.currentTitle isEqualToString:@"打印合同"]) {
#pragma mark 发货
                FaHuoLieBiaoViewController09 *vc = [[FaHuoLieBiaoViewController09 alloc] init];
                vc.insideOrderCode = tradeOrder.insideOrderCode;
                vc.isOpenErp = tradeOrder.isOpenErp;
                [self.navigationController pushViewController:vc animated:true];
            }
        }
        //拒绝接单 REFUSEDORDER
        if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"REFUSEDORDER"]) {
#pragma mark 查看原因
            [self checkReason:tradeOrder.inquiryOrderId];
        }
    }
    

        
//        if ([quotationOrder.inquiryOrder.isDesignated integerValue] == 1) {
////            ChaKanShouPanHeJiaVC *chaKanShouPanHeJiaVC = [[ChaKanShouPanHeJiaVC alloc] init];
////            chaKanShouPanHeJiaVC.quotationOrderId = quotationOrder.quotationOrderId;
////            [self.navigationController pushViewController:chaKanShouPanHeJiaVC animated:YES];
//            return;
//        }
//        ChaKanShouPanViewController *chaKanShouPanViewController = [[ChaKanShouPanViewController alloc] init];
//        chaKanShouPanViewController.stringResource = @"EGongYingShangViewController";
//        chaKanShouPanViewController.quotationOrderId = quotationOrder.quotationOrderId;
//        [self.navigationController pushViewController:chaKanShouPanViewController animated:YES];
//    }
    

    
//    TradeOrder *tradeOrder;
//    if ([self.stringResource isEqualToString:@"EGongYingShangViewControllerL"]) {
//        tradeOrder = _tradeOrderHttp;
//    }
//    if ([self.stringResource isEqualToString:@"EGongYingShangViewControllerR"]) {
//        tradeOrder = self.tradeOrder;
//    }
//
//
//    if ([tradeOrder.tradeOrderSupplierStatus isEqualToString:@"waitingPaymentForPurchase"]) {
//        //提醒付款
//#pragma mark 等待采购商付款 提醒付款
//        if ([sender.currentTitle isEqualToString:@"提醒付款"]) {
//
//        }
//    }
//    if ([tradeOrder.tradeOrderSupplierStatus isEqualToString:@"paymentOvertime"]) {
//
//    }
//    if ([tradeOrder.tradeOrderSupplierStatus isEqualToString:@"paymentConfirm"]) {
//
//    }
//    if ([tradeOrder.tradeOrderSupplierStatus isEqualToString:@"purchasePaid"]) {
//        if ([tradeOrder.inquiryType isEqualToString:@"ATG"]||[tradeOrder.inquiryType isEqualToString:@"FTG"]||[tradeOrder.inquiryType isEqualToString:@"TTG"]) {
//            //管家询盘
//            if ([tradeOrder.deliverStatus integerValue] < 2) {
////                [cell.button4 setTitle:@"去发货" forState:UIControlStateNormal];
//
//            }
//        } else {
//            //e非标询盘
//            if ([sender.currentTitle isEqualToString:@"去发货"]) {
//                LogisticsInformationVC *logisticsInformationVC = [[LogisticsInformationVC alloc] init];
//                logisticsInformationVC.orderCode = tradeOrder.orderCode;
//                logisticsInformationVC.orderId = self.tradeOrder.orderId;
//                [self.navigationController pushViewController:logisticsInformationVC animated:YES];
//                return;
//            }
//        }
//    }
//    if ([tradeOrder.tradeOrderSupplierStatus isEqualToString:@"supplierDelivered"]) {
//#pragma mark 已发货 查看物流
//        if ([sender.currentTitle isEqualToString:@"查看物流"]) {
//            ECCheckTheLogisticsViewController *eCCheckTheLogisticsViewController = [[ECCheckTheLogisticsViewController alloc] init];
//            eCCheckTheLogisticsViewController.logisticsCompany = tradeOrder.logisticsCompany;
//            eCCheckTheLogisticsViewController.logisticsNo = tradeOrder.logisticsNo;
//            eCCheckTheLogisticsViewController.logisticsRemark = tradeOrder.logisticsRemark;
//            [self.navigationController pushViewController:eCCheckTheLogisticsViewController animated:YES];
//        }
//    }
//    if ([tradeOrder.tradeOrderSupplierStatus isEqualToString:@"examineCargoForPurchase"]) {
//
//    }
//    if ([tradeOrder.tradeOrderSupplierStatus isEqualToString:@"success"]) {
//        if ([tradeOrder.purchaseIsComment boolValue] == 0) {
//#pragma mark 交易成功 评价
//            if ([sender.currentTitle isEqualToString:@"去评价"]) {
//                FaBaoPingLunGongViewController *faBaoPingLunViewController = [[FaBaoPingLunGongViewController alloc] init];
//                faBaoPingLunViewController.tradeOrder = tradeOrder;//_tradeOrderHttp
//                [self.navigationController pushViewController:faBaoPingLunViewController animated:YES];
//            }
//        }
//    }
//    if ([tradeOrder.tradeOrderSupplierStatus isEqualToString:@"close"]) {
//
//    }
//    //只要议价没结束，任何状态下都能议价
//#pragma mark 查看议价
//    if ([tradeOrder.inquiryType isEqualToString:@"TTG"]&&[tradeOrder.canEditPrice integerValue]==1) {
//        if ([sender.currentTitle isEqualToString:@"查看议价"]) {
//            EGYiJiaViewController *eGYiJiaViewController = [[EGYiJiaViewController alloc] init];
//            eGYiJiaViewController.quotationOrderId = _inquiryOrderHttp.quotationOrderId;
//            [self.navigationController pushViewController:eGYiJiaViewController animated:YES];
//        }
//    }
//
//    //为了简洁、且按钮的文字都不一样，所以下面就只用文字判断，不再使用tradeOrder.tradeOrderPurchaseStatus
//    if ([sender.currentTitle isEqualToString:@"去发货"]) {
//        FaHuoLieBiaoViewController09 *vc = [[FaHuoLieBiaoViewController09 alloc] init];
//        vc.insideOrderCode = tradeOrder.insideOrderCode;
//        vc.isOpenErp = tradeOrder.isOpenErp;
//        [self.navigationController pushViewController:vc animated:true];
//    }
//    if ([sender.currentTitle isEqualToString:@"补发货"]) {
//        BuFaHuoLieBiaoVC *buFaHuoLieBiaoVC = [[BuFaHuoLieBiaoVC alloc] init];
//        buFaHuoLieBiaoVC.tradeOrderId = tradeOrder.orderId;
//        [self.navigationController pushViewController:buFaHuoLieBiaoVC animated:YES];
//        return;
//    }
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark 供应商订单明细查询接口
- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    TradeOrder *tradeOrder = [[TradeOrder alloc] init];
    tradeOrder.orderId = self.orderId;
    postEntityBean.entity = tradeOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    //    NSLog(@"%@",dic)
    [HttpMamager postRequestWithURLString:DYZ_tradeOrder_supplier_supplierOrderDetail parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            _tradeOrderHttp = [TradeOrder mj_objectWithKeyValues:returnEntityBean.entity];
            _arrayTradeOrderItems = _tradeOrderHttp.tradeOrderItems;
            [self initTradeOrder:_tradeOrderHttp];
            
            NSMutableArray <NSString *> *strA = [[NSMutableArray alloc] init];
            for (TradeOrderItem *item in _tradeOrderHttp.tradeOrderItems) {
                [strA addObject:item.tradeOrderItemId];
            }
            [self api_Image_drawingCloudUrl:strA];
        }
        
        [self.tableView reloadData];
        self.tableView.hidden = NO;
        _viewLoading.hidden = YES;
        _viewNetworkAnomaly.hidden = YES;
    } fail:^(NSError *error) {
        _viewNetworkAnomaly.hidden = NO;
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

#pragma mark 采购清单，询盘，订单查询图纸信息
- (void)api_Image_drawingCloudUrl:(NSMutableArray <__kindof NSString *> *)strA {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    DrawingCloudBean *drawingCloudBean = [[DrawingCloudBean alloc] init];
    drawingCloudBean.ids = strA;
    drawingCloudBean.type = [NSNumber numberWithInt:3];
    postEntityBean.entity = drawingCloudBean.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;

    
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
