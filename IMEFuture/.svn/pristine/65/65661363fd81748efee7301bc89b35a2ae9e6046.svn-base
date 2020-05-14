//
//  ShouHuoVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/21.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ShouHuoVC.h"
#import "VoHeader.h"

#import "ShouHuoCell0.h"
#import "ShouHuoCell1.h"
#import "ShouHuoCell2.h"
#import "FaHuoHeaderView.h"


@interface ShouHuoVC () <UITableViewDelegate,UITableViewDataSource> {
    OrderOperate *_orderOperate;
    NSMutableArray *_arrayOrderOperateItem;
    UIView *_viewLoading;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation ShouHuoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoCell0" bundle:nil] forCellReuseIdentifier:@"shouHuoCell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoCell1" bundle:nil] forCellReuseIdentifier:@"shouHuoCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoCell2" bundle:nil] forCellReuseIdentifier:@"shouHuoCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"faHuoHeaderView"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _orderOperate.orderOperateItems.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _orderOperate.orderOperateItems.count) {
        OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[indexPath.section];
        if ([orderOperateItem.operateNum integerValue] - [orderOperateItem.receiveQuantity integerValue] > 0) {
            return 220;
        } else {
            return 146;
        }
    } else if (indexPath.section == _orderOperate.orderOperateItems.count) {
        return 211;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 31;
    } else if (section == _orderOperate.orderOperateItems.count) {
        return 31;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        FaHuoHeaderView *faHuoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"faHuoHeaderView"];
        faHuoHeaderView.label1.hidden = YES;
        faHuoHeaderView.label0.text = @"零件信息";
        return faHuoHeaderView;
    } else if (section == _orderOperate.orderOperateItems.count) {
        FaHuoHeaderView *faHuoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"faHuoHeaderView"];
        faHuoHeaderView.label1.hidden = YES;
        faHuoHeaderView.label0.text = @"订单信息";
        return faHuoHeaderView;
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _orderOperate.orderOperateItems.count) {
        OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[indexPath.section];
        if ([orderOperateItem.operateNum integerValue] - [orderOperateItem.receiveQuantity integerValue] > 0) {
            ShouHuoCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoCell0" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.labelQingTianXieWeiNengQuanRuKuYuanYing.hidden = YES;
            cell.label0.text = orderOperateItem.tradeOrderItem.partName;
            cell.label1.text = orderOperateItem.tradeOrderItem.partNumber;
            cell.label2.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.purchaseNum integerValue]];
            cell.label3.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.operateNum integerValue]];
            cell.label4.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.operateNum integerValue]-[orderOperateItem.receiveQuantity integerValue]];
            
            OrderOperateItem *orderOperateItem1 = _arrayOrderOperateItem[indexPath.section];
            if ([orderOperateItem1.operateNum integerValue] < [orderOperateItem.operateNum integerValue]-[orderOperateItem.receiveQuantity integerValue]) {
                if ([orderOperateItem1.operateNum integerValue] == 0) {
                    cell.labelQingTianXieWeiNengQuanRuKuYuanYing.hidden = YES;
                } else {
                    cell.labelQingTianXieWeiNengQuanRuKuYuanYing.hidden = NO;
                }
            } else {
                cell.labelQingTianXieWeiNengQuanRuKuYuanYing.hidden = YES;
            }
            
            cell.textField.text = [orderOperateItem1.operateNum integerValue]==0?nil:[NSString stringWithFormat:@"%ld",[orderOperateItem1.operateNum integerValue]];
            cell.textField.tag = indexPath.section;
            [cell.textField addTarget:self action:@selector(textFieldRuKuShuLiangDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
            cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            cell.textField.inputAccessoryView = [self addToolbar];
            
            cell.textField1.text = orderOperateItem1.remark;
            cell.textField1.tag = indexPath.section;
            [cell.textField1 addTarget:self action:@selector(textFieldRemarkDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
            cell.textField1.inputAccessoryView = [self addToolbar];
            
            cell.buttonQuanBuRuKu.tag = indexPath.section;
            [cell.buttonQuanBuRuKu addTarget:self action:@selector(buttonQuanBuRuKuClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        } else {
            ShouHuoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoCell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label0.text = orderOperateItem.tradeOrderItem.partName;
            cell.label1.text = orderOperateItem.tradeOrderItem.partNumber;
            cell.label2.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.purchaseNum integerValue]];
            cell.label3.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.operateNum integerValue]];
            cell.label4.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.operateNum integerValue]-[orderOperateItem.receiveQuantity integerValue]];
            return cell;
        }
    } else if (indexPath.section == _orderOperate.orderOperateItems.count) {
        ShouHuoCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoCell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = _orderOperate.deliveryTime;
        cell.label1.text = _orderOperate.insideOrderCode;
        cell.label2.text = _orderOperate.deliverNumber.length>0?_orderOperate.deliverNumber:@"暂无";
        cell.label3.text = _orderOperate.logisticsCompany;
        cell.label4.text = _orderOperate.logisticsNo.length>0?_orderOperate.logisticsNo:@"暂无";
        cell.label5.text = _orderOperate.tradeOrder.supplierEnterpriseName;
        cell.label6.text = [NSString stringWithFormat:@"备注：%@",_orderOperate.remark.length>0?_orderOperate.remark:@"暂无"];
        return cell;
    }
    return nil;
}

//入库数量
- (void)textFieldRuKuShuLiangDidEnd:(UITextField *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    OrderOperateItem *orderOperateItem1 = _arrayOrderOperateItem[sender.tag];
    orderOperateItem1.operateNum = [NSNumber numberWithInteger:[sender.text integerValue]];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
    ShouHuoCell0 *cell = [self.tableView cellForRowAtIndexPath:index];
    if ([sender.text integerValue] < [orderOperateItem.operateNum integerValue]-[orderOperateItem.receiveQuantity integerValue]) {
        cell.labelQingTianXieWeiNengQuanRuKuYuanYing.hidden = NO;
    } else {
        cell.labelQingTianXieWeiNengQuanRuKuYuanYing.hidden = YES;
        
        if ([sender.text integerValue] == [orderOperateItem.operateNum integerValue]-[orderOperateItem.receiveQuantity integerValue]) {
            
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"入库数量不能大于可入库数量"];
        }
        
        orderOperateItem1.operateNum = [NSNumber numberWithInteger:[orderOperateItem.operateNum integerValue]-[orderOperateItem.receiveQuantity integerValue]];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
    }
    if (sender.text.length == 0) {
        cell.labelQingTianXieWeiNengQuanRuKuYuanYing.hidden = YES;
    }
}
//备注
- (void)textFieldRemarkDidEnd:(UITextField *)sender {
    OrderOperateItem *orderOperateItem = _arrayOrderOperateItem[sender.tag];
    orderOperateItem.remark = sender.text;
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
    ShouHuoCell0 *cell = [self.tableView cellForRowAtIndexPath:index];
    
    if (sender.text.length > 0) {
        cell.labelQingTianXieWeiNengQuanRuKuYuanYing.hidden = YES;
    } else {
        cell.labelQingTianXieWeiNengQuanRuKuYuanYing.hidden = NO;
    }
}

//全部入库
- (void)buttonQuanBuRuKuClick:(UIButton *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    OrderOperateItem *orderOperateItem1 = _arrayOrderOperateItem[sender.tag];
    orderOperateItem1.operateNum = [NSNumber numberWithInteger:[orderOperateItem.operateNum integerValue]-[orderOperateItem.receiveQuantity integerValue]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
    
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

//确认收货
- (IBAction)buttonQueRenShouHuo:(UIButton *)sender {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = loginModel.memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.memberId = loginModel.memberId;
    orderOperate.manufacturerId = loginModel.manufacturerId;
    orderOperate.platform = [NSNumber numberWithInteger:1];
    orderOperate.linkOperateId = _orderOperate.orderOperateId;
    
    
    NSMutableArray *arrayItem = [[NSMutableArray alloc] initWithCapacity:0];
    for (OrderOperateItem *item in _arrayOrderOperateItem) {
        OrderOperateItem *orderOperateItem = [[OrderOperateItem alloc] init];
        orderOperateItem.tradeOrderItemId = item.tradeOrderItemId;
        orderOperateItem.operateNum = item.operateNum;
        orderOperateItem.remark = item.remark;
        if ([item.operateNum integerValue] > 0) {
            [arrayItem addObject:orderOperateItem];
        }
    }
    
    orderOperate.orderOperateItems = arrayItem;
    
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    
    BOOL isBuGuo = YES;
    BOOL isBuGou1 = YES;
    BOOL isBuGou2 = NO;//单独针对 一次收获 多个零件 多个Item
    
    /*
        多次收货 只有一个Item
        一次收获 一个零件 只有一个Item
        一次收获 多个零件 多个Item
     */
    
    if (_arrayOrderOperateItem.count == 1) {
        OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[0];
        OrderOperateItem *orderOperateItem1 = _arrayOrderOperateItem[0];
        if ([orderOperateItem1.operateNum integerValue] == 0) {
            if ([orderOperateItem.operateNum integerValue]-[orderOperateItem.receiveQuantity integerValue]==0) {
                
            } else {
//                isBuGuo = NO;
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"入库数量必须大于零"];
                return;
            }
        }
        
        if ([orderOperateItem1.operateNum integerValue] < [orderOperateItem.operateNum integerValue]-[orderOperateItem.receiveQuantity integerValue]) {
            if (orderOperateItem1.remark.length <= 0) {
//                isBuGou1 = NO;
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请填写未能全入库原因"];
                return;
            }
        }
    } else {
        for (int i=0; i<_arrayOrderOperateItem.count; i++) {
            OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[i];
            OrderOperateItem *orderOperateItem1 = _arrayOrderOperateItem[i];
            if ([orderOperateItem1.operateNum integerValue] > 0) {
                if ([orderOperateItem1.operateNum integerValue] < [orderOperateItem.operateNum integerValue]-[orderOperateItem.receiveQuantity integerValue]) {
                    if (orderOperateItem1.remark.length > 0) {
                        isBuGou2 = YES;
                    } else {
                        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请填写未能全入库原因"];
                        return;
                    }
                } else {
                    isBuGou2 = YES;
                }
            }
        }
        
        if (isBuGou2 == NO) {
            
            for (int i=0; i<_arrayOrderOperateItem.count; i++) {
                OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[i];
                OrderOperateItem *orderOperateItem1 = _arrayOrderOperateItem[i];
                if ([orderOperateItem1.operateNum integerValue] == 0) {
                    if ([orderOperateItem.operateNum integerValue]-[orderOperateItem.receiveQuantity integerValue]==0) {
                        
                    } else {
                        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"入库数量必须大于零"];
                        return;
                    }
                }
                if ([orderOperateItem1.operateNum integerValue] < [orderOperateItem.operateNum integerValue]-[orderOperateItem.receiveQuantity integerValue]) {
                    if (orderOperateItem1.remark.length <= 0) {
                        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请填写未能全入库原因"];
                        return;
                    }
                }
            }
//            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"入库数量必须大于零或请填写未能全入库原因"];
            return;
        }
    }
    
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_receiveOrderOperate parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *model = responseObjectModel;
        _viewLoading.hidden = YES;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"收货成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"收货失败"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = loginModel.memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.orderOperateId = self.orderOperateId;
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_deliverOperate parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _orderOperate = [OrderOperate mj_objectWithKeyValues:model.entity];
            _arrayOrderOperateItem = [[NSMutableArray alloc] initWithCapacity:0];
            for (OrderOperateItem *item in _orderOperate.orderOperateItems) {
                OrderOperateItem *item1 = [[OrderOperateItem alloc] init];
                item1.tradeOrderItemId = item.tradeOrderItemId;
//                item1.operateNum = [NSNumber numberWithInteger:[item.operateNum integerValue]-[item.receiveQuantity integerValue]];
                item1.operateNum = [NSNumber numberWithInteger:0];
                item1.remark = item.remark;
                [_arrayOrderOperateItem addObject:item1];
            }
            _viewLoading.hidden = YES;
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

- (IBAction)back:(id)sender {
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
