//
//  ShouHuoXiangQingChaKanXiangQingVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/22.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ShouHuoXiangQingChaKanXiangQingVC.h"
#import "VoHeader.h"

#import "ShouHuoXiangQingChaKanXiangQingHeaderView0.h"
#import "ShouHuoXiangQingChaKanXiangQingHeaderView1.h"
#import "ShouHuoXiangQingChaKanXiangQingHeaderView2.h"
#import "ShouHuoXiangQingChaKanXiangQingCell0.h"
#import "ShouHuoXiangQingChaKanXiangQingCell1.h"
#import "ShouHuoXiangQingChaKanXiangQingCell2.h"
#import "ShouHuoXiangQingChaKanXiangQingCell3.h"
#import "CiPingChuLiModel.h"
#import "UIViewCiPingChuLiFangShi.h"
#import "UIViewTuiHou.h"


@interface ShouHuoXiangQingChaKanXiangQingVC () <UITableViewDelegate,UITableViewDataSource> {
    OrderOperate *_orderOperateQuHuo;//取货专用
    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewButton;
@property (weak, nonatomic) IBOutlet UIView *viewLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation ShouHuoXiangQingChaKanXiangQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoXiangQingChaKanXiangQingHeaderView0" bundle:nil] forHeaderFooterViewReuseIdentifier:@"shouHuoXiangQingChaKanXiangQingHeaderView0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoXiangQingChaKanXiangQingHeaderView1" bundle:nil] forHeaderFooterViewReuseIdentifier:@"shouHuoXiangQingChaKanXiangQingHeaderView1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoXiangQingChaKanXiangQingHeaderView2" bundle:nil] forHeaderFooterViewReuseIdentifier:@"shouHuoXiangQingChaKanXiangQingHeaderView2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoXiangQingChaKanXiangQingCell0" bundle:nil] forCellReuseIdentifier:@"shouHuoXiangQingChaKanXiangQingCell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoXiangQingChaKanXiangQingCell1" bundle:nil] forCellReuseIdentifier:@"shouHuoXiangQingChaKanXiangQingCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoXiangQingChaKanXiangQingCell2" bundle:nil] forCellReuseIdentifier:@"shouHuoXiangQingChaKanXiangQingCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoXiangQingChaKanXiangQingCell3" bundle:nil] forCellReuseIdentifier:@"shouHuoXiangQingChaKanXiangQingCell3"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    
    self.viewButton.hidden = YES;
    self.viewLabel.hidden = YES;
    self.tableViewBottom.constant = 0;
    
    for (OrderOperate *orderOperate in self.arrayData) {
        if ([orderOperate.orderOperateType isEqualToString:@"I"]) {
            _orderOperateQuHuo = orderOperate;
            if ([orderOperate.isSupplierRecevice integerValue] == 1) {//等待供应商收货
                self.viewButton.hidden = NO;
                self.tableViewBottom.constant = 50;
                break;
            }
            if ([orderOperate.isSupplierRecevice integerValue] == 2) {//供应商已收货
                self.viewLabel.hidden = NO;
                self.tableViewBottom.constant = 50;
                break;
            }
        }
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    OrderOperate *orderOperate = self.arrayData[section];
    if ([orderOperate.orderOperateType isEqualToString:@"R"]) {//收货信息
        return orderOperate.orderOperateItems.count;
    }
    if ([orderOperate.orderOperateType isEqualToString:@"RE"]) {//退货信息
        return orderOperate.orderOperateItems.count;
    }
    if ([orderOperate.orderOperateType isEqualToString:@"I"]) {//质检结果
        return orderOperate.orderOperateItems.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 95;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderOperate *orderOperate = self.arrayData[indexPath.section];
    if ([orderOperate.orderOperateType isEqualToString:@"R"]) {//收货信息
        OrderOperateItem *orderOperateItem = orderOperate.orderOperateItems[indexPath.row];
        if ([orderOperateItem.operateNum integerValue]>[orderOperateItem.refundQuantity integerValue] && [orderOperate.isInspect integerValue] != 1) {//出现退货
            return 180;
        } else {
            return 127;
        }
    }
    if ([orderOperate.orderOperateType isEqualToString:@"RE"]) {//退货信息
        return 127;
    }
    if ([orderOperate.orderOperateType isEqualToString:@"I"]) {//质检结果
        OrderOperateItem *orderOperateItem = orderOperate.orderOperateItems[indexPath.row];
        if ([orderOperateItem.defectiveQuantity integerValue] > 0) {//出现查看处理方式
            return 165;
        } else {
            return 127;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrderOperate *orderOperate = self.arrayData[section];
    if ([orderOperate.orderOperateType isEqualToString:@"R"]) {//收货信息
        ShouHuoXiangQingChaKanXiangQingHeaderView0 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"shouHuoXiangQingChaKanXiangQingHeaderView0"];
        view.viewLine0.hidden = YES;
        if (self.arrayData.count == 1) {
            view.viewLine0.hidden = YES;
        } else {
            view.viewLine0.hidden = NO;
        }
        
        view.label0.text = [NSString stringWithFormat:@"收货单号：%@",orderOperate.operateCode];
        view.label1.text = [NSString stringWithFormat:@"收货时间：%@",orderOperate.inspectTime];
        return view;
    }
    if ([orderOperate.orderOperateType isEqualToString:@"RE"]) {//退货信息
        ShouHuoXiangQingChaKanXiangQingHeaderView1 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"shouHuoXiangQingChaKanXiangQingHeaderView1"];
        view.viewLine0.hidden = YES;
        if (section == self.arrayData.count-1) {
            if (_orderOperateQuHuo) {
                view.viewLine0.hidden = NO;
            } else {
                view.viewLine0.hidden = YES;
            }
        } else {
            view.viewLine0.hidden = NO;
        }
        view.label0.text = [NSString stringWithFormat:@"退货单号：%@",orderOperate.operateCode];
        view.label1.text = [NSString stringWithFormat:@"提交时间：%@",orderOperate.inspectTime];
        return view;
    }
    if ([orderOperate.orderOperateType isEqualToString:@"I"]) {//质检结果
        ShouHuoXiangQingChaKanXiangQingHeaderView2 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"shouHuoXiangQingChaKanXiangQingHeaderView2"];
        view.label0.text = [NSString stringWithFormat:@"质检单号：%@",orderOperate.operateCode];
        view.label1.text = [NSString stringWithFormat:@"验货时间：%@",orderOperate.inspectTime];
        view.label2.text = [orderOperate.inspecStatus integerValue] == 0?@"合格":@"不合格";
        view.imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[orderOperate.inspecStatus integerValue] == 0?@"quality_testing_qualified":@"quality_testing_unqualified"]];
        return view;
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderOperate *orderOperate = self.arrayData[indexPath.section];
    if ([orderOperate.orderOperateType isEqualToString:@"R"]) {//收货信息
        OrderOperateItem *orderOperateItem = orderOperate.orderOperateItems[indexPath.row];
        if ([orderOperateItem.operateNum integerValue]>[orderOperateItem.refundQuantity integerValue] && [orderOperate.isInspect integerValue] != 1) {//出现退货
            ShouHuoXiangQingChaKanXiangQingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoXiangQingChaKanXiangQingCell0" forIndexPath:indexPath];
            cell.viewLine0.hidden = YES;
            if (self.arrayData.count == 1) {
                cell.viewLine0.hidden = YES;
            } else {
                cell.viewLine0.hidden = NO;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.viewBG.layer.cornerRadius = 6;
            cell.viewBG.layer.borderWidth = 0.5;
            cell.viewBG.layer.borderColor = colorLine.CGColor;
            
            cell.label0.text = orderOperateItem.tradeOrderItem.partName;
            cell.label1.text = [NSString stringWithFormat:@"零件号/图号：%@",orderOperateItem.tradeOrderItem.partNumber];
            cell.label2.text = [NSString stringWithFormat:@"入库数量：%ld",[orderOperateItem.operateNum integerValue]];
            cell.label3.text = [NSString stringWithFormat:@"可退货数量：%ld",[orderOperateItem.operateNum integerValue]-[orderOperateItem.refundQuantity integerValue]];
            cell.label4.text = [NSString stringWithFormat:@"收货备注：%@",orderOperateItem.remark.length>0?orderOperateItem.remark:@"--"];
            
            cell.buttonTuihou.tag = indexPath.row;
            [cell.buttonTuihou addTarget:self action:@selector(buttonClickTuihou:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        } else {
            ShouHuoXiangQingChaKanXiangQingCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoXiangQingChaKanXiangQingCell1" forIndexPath:indexPath];
            cell.viewLine0.hidden = YES;
            if (self.arrayData.count == 1) {
                cell.viewLine0.hidden = YES;
            } else {
                cell.viewLine0.hidden = NO;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.viewBG.layer.cornerRadius = 6;
            cell.viewBG.layer.borderWidth = 0.5;
            cell.viewBG.layer.borderColor = colorLine.CGColor;
            
            cell.label0.text = orderOperateItem.tradeOrderItem.partName;
            cell.label1.text = [NSString stringWithFormat:@"零件号/图号：%@",orderOperateItem.tradeOrderItem.partNumber];
            cell.label2.text = [NSString stringWithFormat:@"入库数量：%ld",[orderOperateItem.operateNum integerValue]];
            cell.label3.text = [NSString stringWithFormat:@"可退货数量：%ld",[orderOperateItem.operateNum integerValue]-[orderOperateItem.refundQuantity integerValue]];
            cell.label4.text = [NSString stringWithFormat:@"收货备注：%@",orderOperateItem.remark.length>0?orderOperateItem.remark:@"--"];
            return cell;
        }
    }
    if ([orderOperate.orderOperateType isEqualToString:@"RE"]) {//退货信息
        ShouHuoXiangQingChaKanXiangQingCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoXiangQingChaKanXiangQingCell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewLine0.hidden = YES;
        if (indexPath.section == self.arrayData.count-1) {
            if (_orderOperateQuHuo) {
                cell.viewLine0.hidden = NO;
            } else {
                cell.viewLine0.hidden = YES;
            }
        } else {
            cell.viewLine0.hidden = NO;
        }
        
        cell.viewBG.layer.cornerRadius = 6;
        cell.viewBG.layer.borderWidth = 0.5;
        cell.viewBG.layer.borderColor = colorLine.CGColor;
        
        OrderOperateItem *orderOperateItem = orderOperate.orderOperateItems[indexPath.row];
        
        cell.label0.text = orderOperateItem.tradeOrderItem.partName;
        cell.label1.text = [NSString stringWithFormat:@"零件号/图号：%@",orderOperateItem.tradeOrderItem.partNumber];
        cell.label2.text = [NSString stringWithFormat:@"退货数量：%ld",[orderOperateItem.operateNum integerValue]];
        cell.label3.text = [NSString stringWithFormat:@"退货类型：%@",[NSString StorageType:orderOperate.storageType]];
        cell.label4.text = [NSString stringWithFormat:@"退货备注：%@",orderOperate.remark.length>0?orderOperate.remark:@"--"];
        return cell;
    }
    if ([orderOperate.orderOperateType isEqualToString:@"I"]) {//质检结果
        OrderOperateItem *orderOperateItem = orderOperate.orderOperateItems[indexPath.row];
        if ([orderOperateItem.defectiveQuantity integerValue] > 0) {//出现查看处理方式
            ShouHuoXiangQingChaKanXiangQingCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoXiangQingChaKanXiangQingCell3" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.viewBG.layer.cornerRadius = 6;
            cell.viewBG.layer.borderWidth = 0.5;
            cell.viewBG.layer.borderColor = colorLine.CGColor;
            
            cell.label0.text = orderOperateItem.tradeOrderItem.partName;
            cell.label1.text = [NSString stringWithFormat:@"零件号/图号：%@",orderOperateItem.tradeOrderItem.partNumber];
            cell.label2.text = [NSString stringWithFormat:@"验货数量：%ld",[orderOperateItem.operateNum integerValue]];
            cell.label3.text = [NSString stringWithFormat:@"合格数量：%ld",[orderOperateItem.qualityQuantity integerValue]];
            cell.label4.text = [NSString stringWithFormat:@"次品数量：%ld",[orderOperateItem.defectiveQuantity integerValue]];
            cell.label5.text = [NSString stringWithFormat:@"补发数量：%ld",[orderOperateItem.reissueQuantity integerValue]];
            
            cell.viewBG.tag = indexPath.section;
            cell.buttonChaKanChuLiFangShi.tag = indexPath.row;
            [cell.buttonChaKanChuLiFangShi addTarget:self action:@selector(buttonClickChaKanChuLiFangShi:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        } else {
            ShouHuoXiangQingChaKanXiangQingCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoXiangQingChaKanXiangQingCell2" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.viewBG.layer.cornerRadius = 6;
            cell.viewBG.layer.borderWidth = 0.5;
            cell.viewBG.layer.borderColor = colorLine.CGColor;
            
            cell.label0.text = orderOperateItem.tradeOrderItem.partName;
            cell.label1.text = [NSString stringWithFormat:@"零件号/图号：%@",orderOperateItem.tradeOrderItem.partNumber];
            cell.label2.text = [NSString stringWithFormat:@"验货数量：%ld",[orderOperateItem.operateNum integerValue]];
            cell.label3.text = [NSString stringWithFormat:@"合格数量：%ld",[orderOperateItem.qualityQuantity integerValue]];
            cell.label4.text = [NSString stringWithFormat:@"次品数量：%ld",[orderOperateItem.defectiveQuantity integerValue]];
            cell.label5.text = [NSString stringWithFormat:@"补发数量：%ld",[orderOperateItem.reissueQuantity integerValue]];
            return cell;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

//退货
- (void)buttonClickTuihou:(UIButton *)sender {
    OrderOperate *orderOperate = self.arrayData[0];
    OrderOperateItem *orderOperateItem = orderOperate.orderOperateItems[sender.tag];
    NSLog(@"%s",__FUNCTION__);
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewTuiHou" owner:self options:nil];
    UIViewTuiHou *viewTuiHou = [nib objectAtIndex:0];
    viewTuiHou.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewTuiHou];
    viewTuiHou.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [viewTuiHou initViewTuiHuoButtonClick:^(NSString *string, NSString *string1) {
        [self initTuiHouOrderOperate:orderOperate orderOperateItem:orderOperateItem string:string string1:string1];
    }];
}

//查看处理方式
- (void)buttonClickChaKanChuLiFangShi:(UIButton *)sender {
    UIView *view = sender.superview;
    OrderOperate *orderOperate = self.arrayData[view.tag];
    OrderOperateItem *orderOperateItem = orderOperate.orderOperateItems[sender.tag];
    
    NSMutableArray *arrayCiPingChuLiModel = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i=0; i<5; i++) {
        if ([orderOperateItem valueForKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]]) {
            CiPingChuLiModel *model = [[CiPingChuLiModel alloc] init];
            model.defectiveOperateType = [orderOperateItem valueForKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]];
            model.reissueNum = [orderOperateItem valueForKey:[NSString stringWithFormat:@"reissueNum%ld",i+1]];
            model.isNeedSend = [orderOperateItem valueForKey:[NSString stringWithFormat:@"isNeedSend%ld",i+1]];
            model.unReason = [orderOperateItem valueForKey:[NSString stringWithFormat:@"unReason%ld",i+1]];
            [arrayCiPingChuLiModel addObject:model];
        } else {
            break;
        }
    }
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewCiPingChuLiFangShi" owner:self options:nil];
    UIViewCiPingChuLiFangShi *viewCPCLFS = [nib objectAtIndex:0];
    viewCPCLFS.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewCPCLFS];
    viewCPCLFS.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    viewCPCLFS.viewBG.backgroundColor = [UIColor whiteColor];
    
    viewCPCLFS.tabelViewBG.layer.borderColor = colorRGB(221, 221, 221).CGColor;
    viewCPCLFS.tabelViewBG.clipsToBounds = YES;
    [viewCPCLFS initTableView:arrayCiPingChuLiModel defectiveQuantity:orderOperateItem.defectiveQuantity];
}

//确认取货
- (IBAction)buttonQuRenQuHuo:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认供应商已取货" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _viewLoading.hidden = NO;
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        postEntityBean.memberId = loginModel.memberId;
        
        OrderOperate *orderOperate = [[OrderOperate alloc] init];
        orderOperate.memberId = loginModel.memberId;
        orderOperate.orderOperateId = _orderOperateQuHuo.orderOperateId;
        
        postEntityBean.entity = orderOperate.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_supplierRecevice parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *model = responseObjectModel;
            
            if ([model.status isEqualToString:@"SUCCESS"]) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"取货成功"];
                [self initRequestWithReceiveIndex:[_orderOperateQuHuo.receiveIndex integerValue]];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"取货失败"];
                _viewLoading.hidden = YES;
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    }];
    [alertController addAction:action0];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];

}

//退货接口
- (void)initTuiHouOrderOperate:(OrderOperate *)orderOperate1 orderOperateItem:(OrderOperateItem *)orderOperateItem1 string:(NSString *)string string1:(NSString *)string1 {
    _viewLoading.hidden = NO;
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = loginModel.memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.memberId = loginModel.memberId;
    orderOperate.manufacturerId = loginModel.manufacturerId;
    orderOperate.platform = [NSNumber numberWithInteger:1];
    orderOperate.linkOperateId = orderOperate1.orderOperateId;
    
    OrderOperateItem *orderOperateItem = [[OrderOperateItem alloc] init];
    orderOperateItem.tradeOrderItemId = orderOperateItem1.tradeOrderItemId;
    orderOperateItem.operateNum = [NSNumber numberWithInteger:[string integerValue]];
    orderOperate.remark = string1;
    
    NSMutableArray *arrayItem = [[NSMutableArray alloc] initWithCapacity:0];
    [arrayItem addObject:orderOperateItem];
    
    orderOperate.orderOperateItems = arrayItem;
    
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_refundOrderOperate parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"退货成功"];
            [self initRequestWithReceiveIndex:[orderOperate1.receiveIndex integerValue]];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"退货失败"];
            _viewLoading.hidden = YES;
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    
}

//退货后 获取数据
- (void)initRequestWithReceiveIndex:(NSInteger)receiveIndex {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = loginModel.memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.tradeOrderId = self.tradeOrderId;
    orderOperate.orderOperateId = self.orderOperateId;
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_receiveDetailList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.arrayData = [[NSMutableArray alloc] initWithCapacity:0];
        
            for (NSInteger i = 0; i < returnListBean.list.count; i++) {
                NSDictionary *dic = returnListBean.list[i];
                OrderOperate *orderOperate = [OrderOperate mj_objectWithKeyValues:dic];
                if ([orderOperate.receiveIndex integerValue] == receiveIndex) {
                    if ([orderOperate.orderOperateType isEqualToString:@"S"]||[orderOperate.orderOperateType isEqualToString:@"SR"]) {
                        
                    } else {
                        [self.arrayData addObject:orderOperate];
                    }
                }
            }
            for (OrderOperate *orderOperate in self.arrayData) {
                if ([orderOperate.orderOperateType isEqualToString:@"I"]) {
                    _orderOperateQuHuo = orderOperate;
                    if ([orderOperate.isSupplierRecevice integerValue] == 1) {//等待供应商收货
                        self.viewButton.hidden = NO;
                        self.tableViewBottom.constant = 50;
                        break;
                    }
                    if ([orderOperate.isSupplierRecevice integerValue] == 2) {//供应商已收货
                        self.viewLabel.hidden = NO;
                        self.tableViewBottom.constant = 50;
                        break;
                    }
                }
            }
            
            _viewLoading.hidden = YES;
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
