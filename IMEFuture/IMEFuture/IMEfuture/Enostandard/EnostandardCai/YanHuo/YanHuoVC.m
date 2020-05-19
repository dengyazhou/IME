//
//  YanHuoVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/24.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "YanHuoVC.h"
#import "VoHeader.h"

#import "YanHuoCell2.h"


#import "YanHuoXiangQingCell1.h"
#import "FaHuoHeaderView.h"

#import "PartDetailsDingDanViewController.h"

#import "CiPingChuLiFangShiViewController.h"
#import "CiPingChuLiModel.h"

@interface YanHuoVC () <UITableViewDelegate,UITableViewDataSource> {
    OrderOperate *_orderOperate;
    UIView *_viewLoading;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation YanHuoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoCell2" bundle:nil] forCellReuseIdentifier:@"yanHuoCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoXiangQingCell1" bundle:nil] forCellReuseIdentifier:@"yanHuoXiangQingCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"faHuoHeaderView"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 407.5;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    [self initRequest];
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 65;
    } else {
        self.tableViewBottom.constant = rect.size.height;
    }
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return 31;
    }
    return 10.f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        FaHuoHeaderView *faHuoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"faHuoHeaderView"];
        faHuoHeaderView.label1.hidden = YES;
        faHuoHeaderView.label0.text = @"订单信息";
        return faHuoHeaderView;
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _orderOperate.orderOperateItems.count+1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section < _orderOperate.orderOperateItems.count) {
//        return 405;
//    } else if (indexPath.section < _orderOperate.orderOperateItems.count +1) {
//        return 196;
//    }
//    return 0;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _orderOperate.orderOperateItems.count) {
        YanHuoCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoCell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.view1.hidden = NO;
        cell.view2.hidden = NO;
        cell.view3.hidden = NO;
        cell.view4.hidden = NO;
        
//        if (indexPath.section == 0) {
//            cell.view3.hidden = YES;
//        }
//        if (indexPath.section == 1) {
//            cell.view1.hidden = YES;
//            cell.view2.hidden = YES;
//            cell.view4.hidden = YES;
//        }
//        if (indexPath.section == 2) {
//            cell.view2.hidden = YES;
//            cell.view3.hidden = YES;
//        }
        
        OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[indexPath.section];
        
        if ([orderOperateItem.isMianjian integerValue] == 1) {//免检
            cell.view1.hidden = YES;
            cell.view2.hidden = YES;
            cell.view4.hidden = YES;
        } else {
            if ([orderOperateItem.defectiveQuantity integerValue] > 0) {
                cell.view3.hidden = YES;
            } else {
                cell.view2.hidden = YES;
                cell.view3.hidden = YES;
            }
        }
        cell.labelBiTian.hidden = YES;
        cell.labelBiTian1.hidden = YES;
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"hhmmss";
        NSString *stringDate = [formatter stringFromDate:date];
        stringDate = [stringDate substringToIndex:5];
        if ([orderOperateItem.tradeOrderItem.isMatchDrawingCloud integerValue] == 0) {
            if (orderOperateItem.tradeOrderItem.thumbnailUrl.length > 0) {
                [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:orderOperateItem.tradeOrderItem.thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
            } else {
                cell.imageView1.image = [UIImage imageNamed:@"img_nopicture"];
            }
        } else {
            NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@&t=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_orderOperate.tradeOrder.purchaseEnterpriseId,orderOperateItem.tradeOrderItem.partNumber,orderOperateItem.tradeOrderItem.picVersion,stringDate] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
        }
        cell.label0.text = [NSString stringWithFormat:@"%ld、%@",indexPath.section+1,orderOperateItem.tradeOrderItem.partName];
        cell.label1.text = orderOperateItem.tradeOrderItem.materialName2.length>0?orderOperateItem.tradeOrderItem.materialName2:@"--";
        NSArray *arrayTags = [orderOperateItem.tradeOrderItem.tags componentsSeparatedByString:@"."];
        NSMutableArray *arrayTags1 = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSString *string in arrayTags) {
            if (![string isEqualToString:@""]) {
                [arrayTags1 addObject:string];
            }
        }
        NSString *stringTag;
        for (int i = 0; i < arrayTags1.count; i++) {
            if (i == 0) {
                stringTag = arrayTags1[i];
            } else {
                stringTag = [NSString stringWithFormat:@"%@、%@",stringTag,arrayTags1[i]];
            }
        }
        cell.label2.text = [NSString stringWithFormat:@"%@",stringTag.length != 0?stringTag:@"详见图纸"];
        if ([NSString SizeUnit:orderOperateItem.tradeOrderItem.sizeUnit]) {
            cell.label3.text = [NSString stringWithFormat:@"长 %.2f * 宽 %.2f * 高 %.2f %@",[orderOperateItem.tradeOrderItem.length doubleValue],[orderOperateItem.tradeOrderItem.width doubleValue],[orderOperateItem.tradeOrderItem.height doubleValue],[NSString SizeUnit:orderOperateItem.tradeOrderItem.sizeUnit]];
        } else {
            cell.label3.text = @"--";
        }
        cell.label4.text = [NSString stringWithFormat:@"%ld%@",[orderOperateItem.tradeOrderItem.num integerValue],[NSString QuantityUnit:orderOperateItem.tradeOrderItem.quantityUnit].length>0?[NSString QuantityUnit:orderOperateItem.tradeOrderItem.quantityUnit]:@""];
        cell.buttonLingJianXiangQing.tag = indexPath.section;
        [cell.buttonLingJianXiangQing addTarget:self action:@selector(buttonDeatailClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.label11.text = [NSString stringWithFormat:@"可验货数量：%ld",[orderOperateItem.canInspectNum integerValue]];
        cell.label12.text = [NSString stringWithFormat:@"验货数量：%ld",[orderOperateItem.qualityQuantity integerValue]+[orderOperateItem.defectiveQuantity integerValue]];
        
        cell.textField0.text = [orderOperateItem.operateNum integerValue]==0?nil:[NSString stringWithFormat:@"%ld",[orderOperateItem.operateNum integerValue]];
        cell.textField0.inputAccessoryView = [self addToolbar];
        [cell.textField0 addTarget:self action:@selector(textFieldYanHuoEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.textField0 addTarget:self action:@selector(textFieldYanHuoDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        cell.textField0.tag = indexPath.section;
        
        cell.textField1.text = [orderOperateItem.qualityQuantity integerValue]==0?nil:[NSString stringWithFormat:@"%ld",[orderOperateItem.qualityQuantity integerValue]];
        cell.textField1.inputAccessoryView = [self addToolbar];
        [cell.textField1 addTarget:self action:@selector(textFieldLiangPingEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.textField1 addTarget:self action:@selector(textFieldLiangPingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        cell.textField1.tag = indexPath.section;
        
        cell.textField2.text = [orderOperateItem.defectiveQuantity integerValue]==0?nil:[NSString stringWithFormat:@"%ld",[orderOperateItem.defectiveQuantity integerValue]];
        cell.textField2.inputAccessoryView = [self addToolbar];
        [cell.textField2 addTarget:self action:@selector(textFieldCiPingEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.textField2 addTarget:self action:@selector(textFieldCiPingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        cell.textField2.tag = indexPath.section;
        
        cell.buttonBiTian1.tag = indexPath.section;
        [cell.buttonBiTian1 addTarget:self action:@selector(buttonClickBiTian:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.buttonMianJian.tag = indexPath.section;
        [cell.buttonMianJian addTarget:self action:@selector(buttonClickMianJian:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.buttonQuXiaoMianJian.tag = indexPath.section;
        [cell.buttonQuXiaoMianJian addTarget:self action:@selector(buttonClickQuXiaoMianJian:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i=0; i<5; i++) {
            if ([orderOperateItem valueForKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]]) {
                CiPingChuLiModel *model = [[CiPingChuLiModel alloc] init];
                [array addObject:model];
            } else {
                break;
            }
        }
        if (array.count == 0) {
            cell.labelBiTian.hidden = NO;
        } else {
            cell.labelBiTian1.hidden = NO;
            cell.labelBiTian1.text = [NSString stringWithFormat:@"%ld种处理方式",array.count];
        }
        
        return cell;
    } else if (indexPath.section < _orderOperate.orderOperateItems.count+1) {
        YanHuoXiangQingCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoXiangQingCell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = _orderOperate.receviceTime;
        cell.label1.text = _orderOperate.receiveCode.length>0?_orderOperate.receiveCode:@"暂无";
        cell.label2.text = _orderOperate.tradeOrder.insideOrderCode;
        cell.label3.text = _orderOperate.deliverCode.length>0?_orderOperate.deliverCode:@"暂无";
        cell.label4.text = _orderOperate.deliverNumber.length>0?_orderOperate.deliverNumber:@"暂无";
        cell.label5.text = _orderOperate.logisticsCompany.length>0?_orderOperate.logisticsCompany:@"暂无";
        cell.label6.text = _orderOperate.logisticsNo.length>0?_orderOperate.logisticsNo:@"暂无";
        cell.label7.text = _orderOperate.tradeOrder.supplierEnterpriseName;
        return cell;
    }
    return nil;
}

//次品处理方式
- (void)buttonClickBiTian:(UIButton *)sender {
    
    __block OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    CiPingChuLiFangShiViewController *cpclfsVC = [[CiPingChuLiFangShiViewController alloc] init];
    cpclfsVC.orderOperateItem = orderOperateItem;
    [cpclfsVC setBlock:^(OrderOperateItem *item) {
        orderOperateItem = item;
        
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:cpclfsVC animated:YES];
}

//免检
- (void)buttonClickMianJian:(UIButton *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    orderOperateItem.isMianjian = [NSNumber numberWithInteger:1];
    orderOperateItem.qualityQuantity = [NSNumber numberWithInteger:0];
    orderOperateItem.defectiveQuantity = [NSNumber numberWithInteger:0];
    
    for (NSInteger i=0; i<5; i++) {
        [orderOperateItem setValue:nil forKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
}

//取消免检
- (void)buttonClickQuXiaoMianJian:(UIButton *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    orderOperateItem.isMianjian = [NSNumber numberWithInteger:0];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
}

//验货
- (void)textFieldYanHuoEditingChanged:(UITextField *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    orderOperateItem.operateNum = [NSNumber numberWithInteger:[sender.text integerValue]];
}
- (void)textFieldYanHuoDidEnd:(UITextField *)sender {
    
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    orderOperateItem.operateNum = [NSNumber numberWithInteger:[sender.text integerValue]];
    
    if ([orderOperateItem.operateNum integerValue] > [orderOperateItem.canInspectNum integerValue]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"验货数量不能超过可验货数量"];
        orderOperateItem.operateNum = orderOperateItem.canInspectNum;
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
}

//良品
- (void)textFieldLiangPingEditingChanged:(UITextField *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    orderOperateItem.qualityQuantity = [NSNumber numberWithInteger:[sender.text integerValue]];
}
- (void)textFieldLiangPingDidEnd:(UITextField *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    orderOperateItem.qualityQuantity = [NSNumber numberWithInteger:[sender.text integerValue]];
    
    if ([orderOperateItem.qualityQuantity integerValue] > [orderOperateItem.canInspectNum integerValue]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"合格数量不能超过可验货数量"];
        orderOperateItem.qualityQuantity = orderOperateItem.canInspectNum;
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
    
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

//次品
- (void)textFieldCiPingEditingChanged:(UITextField *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    orderOperateItem.defectiveQuantity = [NSNumber numberWithInteger:[sender.text integerValue]];
}
- (void)textFieldCiPingDidEnd:(UITextField  *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    orderOperateItem.defectiveQuantity = [NSNumber numberWithInteger:[sender.text integerValue]];
    if ([orderOperateItem.defectiveQuantity integerValue] > [orderOperateItem.canInspectNum integerValue]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"次品数量不能超过可验货数量"];
        orderOperateItem.defectiveQuantity = orderOperateItem.canInspectNum;
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
    
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

//验货
- (IBAction)buttonYanHuoWanCheng:(UIButton *)sender {
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    orderOperate.manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    orderOperate.orderOperateId = _orderOperate.orderOperateId;
    orderOperate.isInspect = [NSNumber numberWithInteger:1];
    
    
    orderOperate.orderOperateItems = _orderOperate.orderOperateItems;
    
    for (OrderOperateItem *item in _orderOperate.orderOperateItems) {
        if ([item.isMianjian integerValue] == 1) {//免检
            //过
        } else {
            if ([item.defectiveQuantity integerValue] > 0) {//有次品数
                NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSInteger i=0; i<5; i++) {
                    if ([item valueForKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]]) {
                        CiPingChuLiModel *model = [[CiPingChuLiModel alloc] init];
                        model.defectiveOperateType = [item valueForKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]];
                        model.reissueNum = [item valueForKey:[NSString stringWithFormat:@"reissueNum%ld",i+1]];
                        model.isNeedSend = [item valueForKey:[NSString stringWithFormat:@"isNeedSend%ld",i+1]];
                        model.unReason = [item valueForKey:[NSString stringWithFormat:@"unReason%ld",i+1]];
                        [array addObject:item];
                    } else {
                        break;
                    }
                }
                if (array.count > 0) {
                    //过
                } else {
                    //不过
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请填次品处理方式"];
                    return;
                }
            } else {
                if ([item.operateNum integerValue] > 0 || [item.qualityQuantity integerValue] > 0) {
                    //过
                } else {
                    //不过
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请去验货"];
                    return;
                }
            }
        }
    }
    
    _viewLoading.hidden = NO;
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_inspectOrderOperate parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *model = responseObjectModel;
        _viewLoading.hidden = YES;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"验货成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"验货失败"];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)buttonDeatailClick:(UIButton *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    
    PartDetailsDingDanViewController *ljxqVC = [[PartDetailsDingDanViewController alloc] init];
    ljxqVC.tradeOrderItem = orderOperateItem.tradeOrderItem;
    //    ljxqVC.factoryProductInfo = _factoryProductInfo;
    ljxqVC.enterpriseId = _orderOperate.tradeOrder.purchaseEnterpriseId;
    ljxqVC.inquiryType = _orderOperate.tradeOrder.inquiryType;
    ljxqVC.sourceCaiOrGong = @"gong";
    [self.navigationController pushViewController:ljxqVC animated:YES];
}

- (UIToolbar *)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 38)];
    toolbar.tintColor = colorRGB(0, 168, 255);
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space,bar];
    return toolbar;
}

- (void)textFieldDone {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.orderOperateId = self.orderOperateId;
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_inspectOperate parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _orderOperate = [OrderOperate mj_objectWithKeyValues:model.entity];
            
            for (OrderOperateItem *orderOperateItem in _orderOperate.orderOperateItems) {
                orderOperateItem.operateNum = orderOperateItem.canInspectNum;
            }
            
            _viewLoading.hidden = YES;
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
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
