//
//  DuoCiFaHuoVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/16.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "DuoCiFaHuoVC.h"
#import "VoHeader.h"

#import "FaHuoCell0.h"
#import "FaHuoCell1.h"
#import "FaHuoCell2.h"
#import "FaHuoCell3.h"
#import "FaHuoHeaderView.h"
#import "DuoCiFaHuoXiangQingVC.h"

#import "UIViewWuLiuShuoMing.h"
#import "UIViewXuanZeWuLiuGongSi.h"
#import "UIViewXuanZeShiJian.h"

#import "UIButtonIM.h"


@interface DuoCiFaHuoVC () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate> {
    OrderOperate *_orderOperate;
    UIView *_viewLoading;
    NSString *_operateCode0;
    NSString *_operateCode1;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UIButton *buttonIM;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation DuoCiFaHuoVC
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
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell1" bundle:nil] forCellReuseIdentifier:@"faHuoCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell2" bundle:nil] forCellReuseIdentifier:@"faHuoCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell3" bundle:nil] forCellReuseIdentifier:@"faHuoCell3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"faHuoHeaderView"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    [self initRequest];
}

- (void)buttonSiXinGong:(UIButton *)sender {
    _viewLoading.hidden = NO;
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    Member *meber = [[Member alloc] init];
    meber.memberId =  _orderOperate.tradeOrder.purchaseMemberId;
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
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 83;
    } else if (indexPath.section == 1) {
        return 169;
    } else if (indexPath.section == 2) {
        return 213;
    } else if (indexPath.section == 3) {
        return 89;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    } else if (section == 1) {
        return 31;
    } else if (section == 2) {
        return 31;
    } else if (section == 3) {
        return 31;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else  {
        FaHuoHeaderView *faHuoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"faHuoHeaderView"];
        faHuoHeaderView.label1.hidden = YES;
        
        if (section == 1) {
            faHuoHeaderView.label1.hidden = NO;
            faHuoHeaderView.label0.text = @"零件信息";
            faHuoHeaderView.label1.text = @"注：发货数量不得小于要求到货数量";
        } else if (section == 2) {
            faHuoHeaderView.label0.text = @"发货信息";
        } else if (section == 3) {
            faHuoHeaderView.label0.text = @"物流信息";
        }
        
        return faHuoHeaderView;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FaHuoCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = _orderOperate.tradeOrder.name;
        cell.label1.text = _orderOperate.tradeOrder.phone;
        cell.label2.text = [NSString stringWithFormat:@"%@%@",_orderOperate.tradeOrder.zoneStr,_orderOperate.tradeOrder.address];
        return cell;
    } else if (indexPath.section == 1) {
        FaHuoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[0];
        cell.label2.text = @"要求到货数量";
        cell.label0.text = orderOperateItem.tradeOrderItem.partName;
        cell.label1.text = [NSString stringWithFormat:@"零件号/图号：%@",orderOperateItem.tradeOrderItem.partNumber];
        cell.label3.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.preNum integerValue]];
        
        orderOperateItem.operateNum = orderOperateItem.preNum;
        cell.textField.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.operateNum integerValue]];
        [cell.textField addTarget:self action:@selector(textFieldFaHuoShuLiang:) forControlEvents:UIControlEventEditingChanged];
        [cell.textField addTarget:self action:@selector(textFieldFaHuoShuLiangDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        cell.textField.inputAccessoryView = [self addToolbar];
        return cell;
    } else if (indexPath.section == 2) {
        FaHuoCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.label1.text = _orderOperate.insideOrderCode;

        cell.textField2.text = _orderOperate.deliverNumber;
        [cell.textField2 addTarget:self action:@selector(textFieldSongHuoDanHao:) forControlEvents:UIControlEventEditingChanged];
        cell.textField2.inputAccessoryView = [self addToolbar];
        
        cell.textView.text = _orderOperate.remark;
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
    } else if (indexPath.section == 3) {
        FaHuoCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewWuLiu.hidden = YES;
        cell.viewWuLiuShunFen.hidden = YES;
        
        cell.textField.text = _orderOperate.logisticsNo;
        [cell.textField addTarget:self action:@selector(textFieldYunDanHao:) forControlEvents:UIControlEventEditingChanged];
        cell.textField.inputAccessoryView = [self addToolbar];
        
        [cell.buttonWuLiuGongSi addTarget:self action:@selector(buttonClickWuLiuGongSi:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.buttonXianXiaWuLiu setTitle:[NSString LogisticsEnum:_orderOperate.logisticsCompanyKey]?[NSString LogisticsEnum:_orderOperate.logisticsCompanyKey]:@"线下物流" forState:UIControlStateNormal];
        if ([_orderOperate.logisticsCompanyKey isEqualToString:@"SF"]) {
            cell.viewWuLiuShunFen.hidden = NO;
        } else {
            cell.viewWuLiu.hidden = NO;
            cell.labelWuLiu.text = [NSString LogisticsEnum:_orderOperate.logisticsCompanyKey]?[NSString LogisticsEnum:_orderOperate.logisticsCompanyKey]:@"线下物流";
        }
        [cell.buttonXianXiaWuLiu addTarget:self action:@selector(buttonClickXianXiaWuLiu:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else {
        return nil;
    }
}

- (void)textFieldFaHuoShuLiang:(UITextField *)sender {
    NSLog(@"%@",sender.text);
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[0];
    orderOperateItem.operateNum = [NSNumber numberWithInteger:[sender.text integerValue]];
    
}

- (void)textFieldFaHuoShuLiangDidEnd:(UITextField *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[0];
    if ([orderOperateItem.preNum integerValue] > [orderOperateItem.operateNum integerValue]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"发货数量不得小于要求到货数量"];
        orderOperateItem.operateNum = orderOperateItem.preNum;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];//刷新单独一个区
    }
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
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1+1] withRowAnimation:UITableViewRowAnimationNone];
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
    _orderOperate.deliverNumber = sender.text;
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
    _orderOperate.remark = textView.text;
}

//运单号
- (void)textFieldYunDanHao:(UITextField *)sender {
    _orderOperate.logisticsNo = sender.text;
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
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1+1] withRowAnimation:UITableViewRowAnimationNone];
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
        _orderOperate.logisticsCompanyKey = string;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1+1+1] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = loginModel.memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.orderOperateId = self.orderOperateId;
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_deliverDetail parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _orderOperate = [OrderOperate mj_objectWithKeyValues:model.entity];
            
            _viewLoading.hidden = YES;
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

- (IBAction)buttonClickQueRenFaHuo:(UIButton *)sender {
    _viewLoading.hidden = NO;
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = loginModel.memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.tradeOrderId = _orderOperate.tradeOrderId;
    orderOperate.orderCode = _orderOperate.orderCode;
    orderOperate.inquiryOrderId = _orderOperate.inquiryOrderId;
    orderOperate.inquiryOrderCode = _orderOperate.inquiryOrderCode;
    orderOperate.memberId = loginModel.memberId;
    orderOperate.manufacturerId = _orderOperate.manufacturerId;
    orderOperate.platform = _orderOperate.platform;
    orderOperate.insideOrderCode = _orderOperate.insideOrderCode;
    orderOperate.orderOperateId = _orderOperate.orderOperateId;
    
    NSMutableArray *arrayItem = [[NSMutableArray alloc] initWithCapacity:0];
    for (OrderOperateItem *item in _orderOperate.orderOperateItems) {
        OrderOperateItem *orderOperateItem = [[OrderOperateItem alloc] init];
        orderOperateItem.tradeOrderItemId = item.tradeOrderItemId;
        orderOperateItem.operateNum = item.operateNum;//发货数量
        orderOperateItem.purchaseNum = item.purchaseNum;//采购数量
        [arrayItem addObject:orderOperateItem];
    }
    orderOperate.orderOperateItems = arrayItem;
    
    orderOperate.operateCode = [NSString stringWithFormat:@"%@%@",_operateCode0,_operateCode1];//发货单号
    orderOperate.deliverNumber = _orderOperate.deliverNumber;//送货单号
    orderOperate.remark = _orderOperate.remark;//备注
    orderOperate.logisticsCompanyKey = _orderOperate.logisticsCompanyKey?_orderOperate.logisticsCompanyKey:@"XX";//物流公司
    orderOperate.logisticsCompany = [NSString LogisticsEnum:_orderOperate.logisticsCompanyKey]?[NSString LogisticsEnum:_orderOperate.logisticsCompanyKey]:@"线下物流";
    orderOperate.logisticsNo = _orderOperate.logisticsNo;//运单号
    
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
    
//    DuoCiFaHuoXiangQingVC *duoCiFaHuoXiangQingVC = [[DuoCiFaHuoXiangQingVC alloc] init];
//    [self.navigationController pushViewController:duoCiFaHuoXiangQingVC animated:YES];
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
