//
//  DuoCiFaHuoVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/16.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "YiCiFaHuoVC.h"
#import "VoHeader.h"

#import "FaHuoCell0.h"
#import "YiCiFaHuoCell1.h"
#import "YiCiFaHuoCell11.h"
#import "FaHuoCell2.h"
#import "FaHuoCell3.h"
#import "FaHuoHeaderView.h"
#import "YiCiFaHuoXiangQingVC.h"

#import "UIViewWuLiuShuoMing.h"
#import "UIViewXuanZeWuLiuGongSi.h"
#import "UIViewXuanZeShiJian.h"
#import "UIButtonIM.h"


@interface YiCiFaHuoVC () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate> {
    UIView *_viewLoading;
    TradeOrder *_tradeOrder;
    NSString *_deliverNumber;
    NSString *_operateCode0;
    NSString *_operateCode1;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}
@property (weak, nonatomic) IBOutlet UIButton *buttonIM;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation YiCiFaHuoVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for (UIView *view in self.buttonIM.subviews) {
        if (view.tag == 100) {
            [view removeFromSuperview];
        }
    }
    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"icon_Private_letter_blue.gif" ofType:nil];
    UIButtonIM *button = [[UIButtonIM alloc] initWithFrame:CGRectMake(0, 0, 60, 25) withGIFFile:gifPath withColor:colorRGB(0, 168, 255)];
    [button addTarget:self action:@selector(buttonSiXinGong:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 100;
    [self.buttonIM addSubview:button];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    NSDate *date = [NSDate date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyMMdd"];
    NSString *dateString = [pickerFormatter stringFromDate:date];
    
    _operateCode0 = dateString;
    
    int num = (arc4random() % 1000);
    _operateCode1 = [NSString stringWithFormat:@"%.3d", num];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell0" bundle:nil] forCellReuseIdentifier:@"faHuoCell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiCiFaHuoCell1" bundle:nil] forCellReuseIdentifier:@"yiCiFaHuoCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiCiFaHuoCell11" bundle:nil] forCellReuseIdentifier:@"yiCiFaHuoCell11"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell2" bundle:nil] forCellReuseIdentifier:@"faHuoCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell3" bundle:nil] forCellReuseIdentifier:@"faHuoCell3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"faHuoHeaderView"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    [self initRequestTradeOrderDetail];
}

- (void)buttonSiXinGong:(UIButton *)sender {
    _viewLoading.hidden = NO;
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    Member *meber = [[Member alloc] init];
    meber.memberId = _tradeOrder.purchaseMember.memberId;
    postEntityBean.entity = meber.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_user_getMemberInfo parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            Member *member = [Member mj_objectWithKeyValues:returnEntityBean.entity];
            
        }
        _viewLoading.hidden = YES;
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    
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
    return 1+_tradeOrder.tradeOrderItems.count+2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 83;
    } else if (indexPath.section < 1+_tradeOrder.tradeOrderItems.count) {
        TradeOrderItem *tradeOrderItem = _tradeOrder.tradeOrderItems[indexPath.section-1];
        if ([tradeOrderItem.num integerValue]-[tradeOrderItem.deliverNums integerValue]>0) {
            return 169;
        } else {
            return 147;
        }
    } else if (indexPath.section == 1+_tradeOrder.tradeOrderItems.count) {
        return 213;
    } else if (indexPath.section == 1+_tradeOrder.tradeOrderItems.count+1) {
        return 89;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    } else if (section == 1) {
        return 31;
    } else if (section == 1+_tradeOrder.tradeOrderItems.count) {
        return 31;
    } else if (section == 1+_tradeOrder.tradeOrderItems.count+1) {
        return 31;
    } else {
        return 10;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        FaHuoHeaderView *faHuoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"faHuoHeaderView"];
        faHuoHeaderView.label1.hidden = YES;
        faHuoHeaderView.label0.text = @"零件信息";
        return faHuoHeaderView;
    } else if (section == 1+_tradeOrder.tradeOrderItems.count) {
        FaHuoHeaderView *faHuoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"faHuoHeaderView"];
        faHuoHeaderView.label1.hidden = YES;
        faHuoHeaderView.label0.text = @"发货信息";
        return faHuoHeaderView;
    } else if (section == 1+_tradeOrder.tradeOrderItems.count+1) {
        FaHuoHeaderView *faHuoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"faHuoHeaderView"];
        faHuoHeaderView.label1.hidden = YES;
        faHuoHeaderView.label0.text = @"物流信息";
        return faHuoHeaderView;
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FaHuoCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = _tradeOrder.name;
        cell.label1.text = _tradeOrder.phone;
        cell.label2.text = [NSString stringWithFormat:@"%@%@",_tradeOrder.zoneStr,_tradeOrder.address];
        return cell;
    } else if (indexPath.section < 1+_tradeOrder.tradeOrderItems.count) {
        TradeOrderItem *tradeOrderItem = _tradeOrder.tradeOrderItems[indexPath.section-1];
        if ([tradeOrderItem.num integerValue]-[tradeOrderItem.deliverNums integerValue]>0) {
            YiCiFaHuoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiCiFaHuoCell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            TradeOrderItem *tradeOrderItem = _tradeOrder.tradeOrderItems[indexPath.section-1];
            
            cell.label0.text = tradeOrderItem.partName;
            cell.label1.text = [NSString stringWithFormat:@"零件号/图号：%@",tradeOrderItem.partNumber];
            cell.label2.text = [NSString stringWithFormat:@"%ld",[tradeOrderItem.num integerValue]];
            cell.label3.text = [NSString stringWithFormat:@"%ld",[tradeOrderItem.num integerValue]-[tradeOrderItem.deliverNums integerValue]>0?[tradeOrderItem.num integerValue]-[tradeOrderItem.deliverNums integerValue]:0];
            
            cell.textField.tag = indexPath.section-1;
            cell.textField.text = [tradeOrderItem.purchaseNum integerValue]==0?nil:[NSString stringWithFormat:@"%ld",[tradeOrderItem.purchaseNum integerValue]];
            [cell.textField addTarget:self action:@selector(textFieldOperateNum:) forControlEvents:UIControlEventEditingChanged];
            cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            
            cell.buttonQuanBuFaHuo.tag = indexPath.section-1;
            [cell.buttonQuanBuFaHuo addTarget:self action:@selector(buttonClickQuanBuFaHuo:) forControlEvents:UIControlEventTouchUpInside];
            cell.textField.inputAccessoryView = [self addToolbar];
            return cell;
        } else {
            YiCiFaHuoCell11 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiCiFaHuoCell11" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            TradeOrderItem *tradeOrderItem = _tradeOrder.tradeOrderItems[indexPath.section-1];
            
            cell.label0.text = tradeOrderItem.partName;
            cell.label1.text = [NSString stringWithFormat:@"零件号/图号：%@",tradeOrderItem.partNumber];
            cell.label2.text = [NSString stringWithFormat:@"%ld",[tradeOrderItem.num integerValue]];
            cell.label3.text = [NSString stringWithFormat:@"%ld",[tradeOrderItem.num integerValue]-[tradeOrderItem.deliverNums integerValue]>0?[tradeOrderItem.num integerValue]-[tradeOrderItem.deliverNums integerValue]:0];
            
            return cell;
        }
    } else if (indexPath.section == 1+_tradeOrder.tradeOrderItems.count) {
        FaHuoCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.labelBeiZhu.hidden = YES;
        
        cell.label1.text = _tradeOrder.insideOrderCode;
        cell.textField2.text = _deliverNumber;
        [cell.textField2 addTarget:self action:@selector(textFieldSongHuoDanHao:) forControlEvents:UIControlEventEditingChanged];
        cell.textField2.inputAccessoryView = [self addToolbar];
        
        if (_tradeOrder.remark.length>0) {
            cell.labelBeiZhu.hidden = YES;
        } else {
            cell.labelBeiZhu.hidden = NO;
        }
        
        cell.textView.text = _tradeOrder.remark;
        cell.textView.delegate = self;
        cell.textView.inputAccessoryView = [self addToolbar];
        cell.textView.tag = indexPath.section;
        
        [cell.buttonXuanZeShijian setTitle:_operateCode0 forState:UIControlStateNormal];
        [cell.buttonXuanZeShijian addTarget:self action:@selector(buttonClickXuanZeShijian:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.textField00.text = _operateCode1;
        cell.textField00.delegate = self;
        [cell.textField00 addTarget:self action:@selector(textFieldOperateCode1DidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        cell.textField00.inputAccessoryView = [self addToolbar];
        
        return cell;
    } else if (indexPath.section == 1+_tradeOrder.tradeOrderItems.count+1) {
        FaHuoCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewWuLiu.hidden = YES;
        cell.viewWuLiuShunFen.hidden = YES;
        
        cell.textField.text = _tradeOrder.logisticsNo;
        [cell.textField addTarget:self action:@selector(textFieldYunDanHao:) forControlEvents:UIControlEventEditingChanged];
        cell.textField.inputAccessoryView = [self addToolbar];
        
        [cell.buttonWuLiuGongSi addTarget:self action:@selector(buttonClickWuLiuGongSi:) forControlEvents:UIControlEventTouchUpInside];
        
        
//        [cell.buttonXianXiaWuLiu setTitle:[NSString LogisticsEnum:_tradeOrder.logisticsCompanyKey]?[NSString LogisticsEnum:_tradeOrder.logisticsCompanyKey]:@"线下物流" forState:UIControlStateNormal];
        
        if ([_tradeOrder.logisticsCompanyKey isEqualToString:@"SF"]) {
            cell.viewWuLiuShunFen.hidden = NO;
        } else {
            cell.viewWuLiu.hidden = NO;
            cell.labelWuLiu.text = [NSString LogisticsEnum:_tradeOrder.logisticsCompanyKey]?[NSString LogisticsEnum:_tradeOrder.logisticsCompanyKey]:@"线下物流";
        }
        
        [cell.buttonXianXiaWuLiu addTarget:self action:@selector(buttonClickXianXiaWuLiu:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else {
        return nil;
    }
}

//全部发货
- (void)buttonClickQuanBuFaHuo:(UIButton *)sender {
    TradeOrderItem *tradeOrderItem = _tradeOrder.tradeOrderItems[sender.tag];
    tradeOrderItem.purchaseNum = [NSNumber numberWithInteger:[tradeOrderItem.num integerValue]-[tradeOrderItem.deliverNums integerValue]>0?[tradeOrderItem.num integerValue]-[tradeOrderItem.deliverNums integerValue]:0];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag+1] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)textFieldOperateNum:(UITextField *)sender {
    TradeOrderItem *tradeOrderItem = _tradeOrder.tradeOrderItems[sender.tag];
    tradeOrderItem.purchaseNum = [NSNumber numberWithInteger:[sender.text integerValue]];
}

//_operateCode1
- (void)textFieldOperateCode1DidEnd:(UITextField *)sender {
    if (sender.text.length == 0) {
        _operateCode1 = @"000";
    } else if (sender.text.length == 1) {
        _operateCode1 = [NSString stringWithFormat:@"00%@",sender.text];
    } else if (sender.text.length == 2) {
        _operateCode1 = [NSString stringWithFormat:@"0%@",sender.text];
    } else if (sender.text.length == 3) {
        _operateCode1 = sender.text;
    } else {
        _operateCode1 = [sender.text substringToIndex:3];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1+_tradeOrder.tradeOrderItems.count] withRowAnimation:UITableViewRowAnimationNone];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string length]==0) {
        return YES;
    }
    if ([textField.text length]>3)
        return NO;
    NSMutableString *fieldText=[NSMutableString stringWithString:textField.text];
    [fieldText replaceCharactersInRange:range withString:string];
    NSString *finalText=[fieldText copy];
    if ([finalText length]>3) {
        textField.text=[finalText substringToIndex:3];
        return NO;
    }
    return YES;
}

//送货单号
- (void)textFieldSongHuoDanHao:(UITextField *)sender {
     _deliverNumber = sender.text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.tableView setContentOffset:CGPointMake(0, 10000)];
}

//备注
- (void)textViewDidChange:(UITextView *)textView {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:textView.tag];
    FaHuoCell2 *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UILabel *label = [cell viewWithTag:100];
    if (textView.text.length > 0) {
        label.hidden = YES;
    } else {
        label.hidden = NO;
    }
    _tradeOrder.remark = textView.text;
}

//运单号
- (void)textFieldYunDanHao:(UITextField *)sender {
    _tradeOrder.logisticsNo = sender.text;
}

//选择时间
- (void)buttonClickXuanZeShijian:(UIButton *)sender {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeShiJian" owner:self options:nil];
    UIViewXuanZeShiJian *viewXZSJ = [nib objectAtIndex:0];
    viewXZSJ.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewXZSJ];
    viewXZSJ.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [viewXZSJ initDataPickerButtonClick:^(NSString *string) {
        _operateCode0 = string;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1+_tradeOrder.tradeOrderItems.count] withRowAnimation:UITableViewRowAnimationNone];
    } formatter:@"yyMMdd"];
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

- (void)buttonClickWuLiuGongSi:(UIButton *)sender {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewWuLiuShuoMing" owner:self options:nil];
    UIViewWuLiuShuoMing *viewWL = [nib objectAtIndex:0];
    viewWL.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewWL];
    viewWL.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    viewWL.viewBG.backgroundColor = [UIColor whiteColor];
}

//线下物流
- (void)buttonClickXianXiaWuLiu:(UIButton *)sender {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeWuLiuGongSi" owner:self options:nil];
    UIViewXuanZeWuLiuGongSi *viewXZWL = [nib objectAtIndex:0];
    viewXZWL.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewXZWL];
    viewXZWL.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [viewXZWL initPickerViewButtonClick:^(NSString *string) {
        NSLog(@"%@",string);
        _tradeOrder.logisticsCompanyKey = string;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1+_tradeOrder.tradeOrderItems.count+1] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (IBAction)buttonClickQueRenFaHuo:(UIButton *)sender {
    
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = loginModel.memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.tradeOrderId = _tradeOrder.orderId;
    orderOperate.orderCode = _tradeOrder.orderCode;
    orderOperate.inquiryOrderId = _tradeOrder.inquiryOrderId;
    orderOperate.inquiryOrderCode = _tradeOrder.inquiryOrderCode;
    orderOperate.memberId = loginModel.memberId;
    orderOperate.manufacturerId = loginModel.manufacturerId;
    orderOperate.platform = [NSNumber numberWithInteger:1];
    orderOperate.insideOrderCode = _tradeOrder.insideOrderCode;

    
    NSMutableArray *arrayItem = [[NSMutableArray alloc] initWithCapacity:0];
    for (TradeOrderItem *item in _tradeOrder.tradeOrderItems) {
        OrderOperateItem *orderOperateItem = [[OrderOperateItem alloc] init];
        orderOperateItem.tradeOrderItemId = item.tradeOrderItemId;
        orderOperateItem.operateNum = item.purchaseNum;//发货数量 //purchaseNum不存在 所以用TradeOrderItem.purchaseNum 存储operateNum
        orderOperateItem.purchaseNum = item.num;//采购数量
        [arrayItem addObject:orderOperateItem];
    }
    BOOL isBuGuo = YES;
    for (TradeOrderItem *item in _tradeOrder.tradeOrderItems) {
        if ([item.purchaseNum integerValue] > 0) {
            isBuGuo = NO;
        }
    }
    if (isBuGuo == YES) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"发货数量必需大于0"];
        return;
    }
    
    orderOperate.orderOperateItems = arrayItem;
    
    orderOperate.operateCode = [NSString stringWithFormat:@"%@%@",_operateCode0,_operateCode1];//发货单号
    orderOperate.deliverNumber = _deliverNumber;//送货单号
    orderOperate.remark = _tradeOrder.remark;//备注
    orderOperate.logisticsCompanyKey = _tradeOrder.logisticsCompanyKey?_tradeOrder.logisticsCompanyKey:@"XX";//物流公司
    orderOperate.logisticsCompany = [NSString LogisticsEnum:_tradeOrder.logisticsCompanyKey]?[NSString LogisticsEnum:_tradeOrder.logisticsCompanyKey]:@"线下物流";
    orderOperate.logisticsNo = _tradeOrder.logisticsNo;//运单号
    
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_deliverOrderOperate parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *model = responseObjectModel;
        _viewLoading.hidden = YES;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"恭喜您发货成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if ([model.status isEqualToString:@"ERROR"]) {
            if ([model.returnCode integerValue] == -100) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"发货单号已存在，请重新输入"];
            } else if ([model.returnCode integerValue] == -200) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"送货单号重复"];
            } else if ([model.returnCode integerValue] == -300 || [model.returnCode integerValue] == -400) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"发货数量错误"];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
            };
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    
//    YiCiFaHuoXiangQingVC *yiCiFaHuoXiangQingVC = [[YiCiFaHuoXiangQingVC alloc] init];
//    [self.navigationController pushViewController:yiCiFaHuoXiangQingVC animated:YES];
}

//订单详情
- (void)initRequestTradeOrderDetail {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    TradeOrder *tradeOrder = [[TradeOrder alloc] init];
    tradeOrder.orderId = self.orderId;
    postEntityBean.entity = tradeOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    //    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_tradeOrder_getTradeOrderDetail parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            _tradeOrder= [TradeOrder mj_objectWithKeyValues:returnEntityBean.entity];
            for (TradeOrderItem *item in _tradeOrder.tradeOrderItems) {
                item.purchaseNum = [NSNumber numberWithInteger:0];
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
