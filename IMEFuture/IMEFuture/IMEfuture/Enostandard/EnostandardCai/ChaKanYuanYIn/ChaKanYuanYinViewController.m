
//
//  ChaKanShouPanViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ChaKanYuanYinViewController.h"
#import "VoHeader.h"

#import "ChaKanYuanYinCell.h"
#import "ChaKanYuanYinCell1.h"
#import "ChaKanYuanYinCell2.h"

#import "Masonry.h"


#import "QiYeXinXiXiangQingViewController.h"
#import "EChaKanXieYiController.h"
#import "XunPanXiangQingViewController.h"
#import "ECInquiryViewController.h"

#import "UIButtonIM.h"
#import "PartDetailsViewController.h"
#import "LingJianXiangQingViewController2.h"
#import "NSArray+Transition.h"
#import "IMETabBarViewController.h"
#import "ShouPanViewController.h"

#import "PartDetailsDingDanViewController.h"
#import "ShowBigImageVC.h"

#import "RefreshManager.h"

@interface ChaKanYuanYinViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayInquiryOrderItemModel;
    NSMutableArray *_quotationOrderItems;
    NSMutableArray *_arrayYesOpen;
    NSInteger _integerButtonLineColor;
    UIView *_viewLoading;
    QuotationOrder *_quotationOrder;
    InquiryOrder *_inquiryOrder;

    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    
    NSMutableArray *_arrayProjectDrawingResBean;
    
    
}

@property (nonatomic,strong) TradeOrder *tradeOrderHttp;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *buttonBiJiaShouPan;
@property (weak, nonatomic) IBOutlet UIButton *buttonQueRenShouPan;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation ChaKanYuanYinViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChaKanYuanYinCell" bundle:nil] forCellReuseIdentifier:@"chaKanYuanYinCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChaKanYuanYinCell1" bundle:nil] forCellReuseIdentifier:@"chaKanYuanYinCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChaKanYuanYinCell2" bundle:nil] forCellReuseIdentifier:@"chaKanYuanYinCell2"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = colorBG;
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 1;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    

    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    [self initPurchaseOrderDetail];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return self.tradeOrderHttp.tradeOrderItems.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ChaKanYuanYinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chaKanYuanYinCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tradeOrder = self.tradeOrderHttp;
        return cell;
    } else if (indexPath.section == 1) {
        ChaKanYuanYinCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"chaKanYuanYinCell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tradeOrder = self.tradeOrderHttp;
        return cell;
    } else if (indexPath.section == 2) {
        ChaKanYuanYinCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"chaKanYuanYinCell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TradeOrderItem *model = self.tradeOrderHttp.tradeOrderItems[indexPath.row];
        [cell initDataTradeOrderItem:model withNSIndexPath:indexPath];
        
        ProjectDrawingResBean *projectDrawingResBean;
        for (ProjectDrawingResBean *project in _arrayProjectDrawingResBean) {
            if ([model.tradeOrderItemId isEqualToString:project.idd]) {
                projectDrawingResBean = project;
                break;
            }
        }
        
        if (projectDrawingResBean == nil) {//无图纸
            cell.imageViewIcon.image = [UIImage imageNamed:@"img_nopicture"];
        } else {
            DrawInfoBean *drawInfoBean = projectDrawingResBean.drawInfo.firstObject;
            if (drawInfoBean.fileStatus.integerValue == -1) {//失败
                NSLog(@"——————————失败——————————");
            } else if (drawInfoBean.fileStatus.integerValue == 0) {//无图纸
                cell.imageViewIcon.image = [UIImage imageNamed:@"img_nopicture"];
            } else if (drawInfoBean.fileStatus.integerValue == 1) {//转换成功
                [cell.imageViewIcon sd_setImageWithURL:[NSURL URLWithString:drawInfoBean.smallPreviewUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
            } else if (drawInfoBean.fileStatus.integerValue == 2) {//转换中
                cell.imageViewIcon.image = [UIImage imageNamed:@"img_picture_conversion"];
            }
            
        }
        
        cell.buttonImage.tag = indexPath.row;
        //点击图片跳转到零件详情的图纸附件
        [cell.buttonImage addTarget:self action:@selector(goPartDetails:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.buttonDetail.tag = indexPath.row;
        [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
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


- (void)buttonDetailClick:(UIButton *)sender {

    PartDetailsDingDanViewController *vc = [[PartDetailsDingDanViewController alloc] init];
    vc.tradeOrderItem = self.tradeOrderHttp.tradeOrderItems[sender.tag];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark 修改订单
- (IBAction)buttonXiuGaiDianDan:(UIButton *)sender {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    
    TradeOrder *trader = [[TradeOrder alloc] init];
    trader.orderId = self.orderId;
    NSMutableArray *orderItems = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TradeOrderItem *orderItem in self.tradeOrderHttp.tradeOrderItems) {
        TradeOrderItem *item = [[TradeOrderItem alloc] init];
        item.tradeOrderItemId = orderItem.tradeOrderItemId;
        item.isSelect = [NSNumber numberWithInteger:1];
        [orderItems addObject:item];
    }
    trader.orderItems = orderItems;
    
    postEntityBean.entity = trader.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
//    WAITAPPROVAL("待审批")
//    WAITORDER("待接单")
//    purchasePaid("待发货")
//    supplierDelivered("待收货")
//    examineCargoForPurchase("待质检")
//    waitBalance("待对账")
//    success("已完成")
//    REFUSEDAPPROVAL("审批失败")
//    REFUSEDORDER("拒绝接单")
//    ACCEPTFAILED("验收不通过")
//    close("已关闭")
    NSString *urlStr = nil;
    if ([self.tradeOrderHttp.tradeOrderPurchaseStatus isEqualToString:@"REFUSEDORDER"]) {
        urlStr = DYZ_api_tradeOrder_purchase_reSendOrder;
    } else if ([self.tradeOrderHttp.tradeOrderPurchaseStatus isEqualToString:@"REFUSEDAPPROVAL"]) {
        urlStr = DYZ_api_tradeOrder_purchase_reApproval;
    }
    
    
    [HttpMamager postRequestWithURLString:urlStr parameters:dic success:^(id responseObjectModel) {
        
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"修改成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
        }
        
        [self.navigationController popViewControllerAnimated:true];
        [RefreshManager shareRefreshManager].eCInquiryVC = @"通知ECInquiryViewController刷新啦";
        //通知ECOrderViewController 刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshECOrder" object:nil userInfo:nil];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
 
}

#pragma mark 删除订单
- (IBAction)buttonCheckConferInquiry:(id)sender {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    
    TradeOrder *trader = [[TradeOrder alloc] init];
    trader.orderId = self.orderId;

    postEntityBean.entity = trader.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_api_tradeOrder_purchase_purchaseDeleteOrder parameters:dic success:^(id responseObjectModel) {
        
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"删除成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
        }
        
        [self.navigationController popViewControllerAnimated:true];
        [RefreshManager shareRefreshManager].eCInquiryVC = @"通知ECInquiryViewController刷新啦";
        //通知ECOrderViewController 刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshECOrder" object:nil userInfo:nil];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)line:(UIView *)view withY:(CGFloat)y withTag:(NSInteger)tag{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, kMainW, 0.5)];
    label.tag = tag;
    label.backgroundColor = colorLine;
    [view addSubview:label];
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 采购商订单明细查询接口
- (void)initPurchaseOrderDetail {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    
    TradeOrder *tradeOrder = [[TradeOrder alloc] init];
    tradeOrder.orderId = self.orderId;
    postEntityBean.entity = tradeOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_tradeOrder_purchase_purchaseOrderDetail parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        _viewLoading.hidden = true;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            self.tradeOrderHttp = [TradeOrder mj_objectWithKeyValues:returnEntityBean.entity];
            
            NSMutableArray <NSString *> *strA = [[NSMutableArray alloc] init];
            for (TradeOrderItem *item in self.tradeOrderHttp.tradeOrderItems) {
                [strA addObject:item.tradeOrderItemId];
            }
            
            [self.tableView reloadData];
            
            [self api_Image_drawingCloudUrl:strA];
        }
        
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

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
