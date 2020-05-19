//
//  EFBFaPanViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/2/5.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BJFaPanViewController.h"
#import "Masonry.h"

#import "EFBFaPanCell0.h"
#import "EFBFaPanCell1.h"
#import "EFBFaPanCell2.h"
#import "EFBFaPanCell3.h"
#import "EFBFaPanCell4.h"

#import "UIViewXuanZeBaoJiaMoBan.h"
#import "UIViewXuanZeYaoQiuDaoHuoRiQi.h"
#import "UIViewXuanZeXunPanTianShu.h"
#import "UIViewXuanZeHuoYunFangShi.h"

#import "XuanZeXunPanGongYiVC.h"
#import "BJFaPanViewController1.h"
#import "ToolTransition.h"

#import "EChooseTaxRateView5Kind.h"

@interface BJFaPanViewController () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate> {
    NSArray *_dataArray;
    NSMutableArray *_arrayQuotationTemplate;
    NSString *_endTime;//询盘天数 1天、3天、7天、15天、30天；只在页面显示使用
    NSMutableArray *_arrayTempBaseTag;//工艺
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    
    EChooseTaxRateView5Kind *_eChooseTaxRateView5Kind;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation BJFaPanViewController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initRequestQuotationTemplateList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    if ([self.inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
        self.labelTitle.text = @"标准询盘-发盘";
    } else if ([self.inquiryOrder.inquiryType isEqualToString:@"TTG"]) {
        self.labelTitle.text = @"后议价询盘-发盘";
    } else if ([self.inquiryOrder.inquiryType isEqualToString:@"FTG"]) {
        self.labelTitle.text = @"指定价询盘-发盘";
    }
    
    //初始化 self.inquiryOrder
    self.inquiryOrder.isQuotationTemplate = [NSNumber numberWithInteger:0];//默认为零件总价
    self.inquiryOrder.inquiryOrderItems = [NSMutableArray arrayWithCapacity:0];
    self.inquiryOrder.inquiryOrderEnterprises = [NSMutableArray arrayWithCapacity:0];
    if ([self.inquiryOrder.inquiryType isEqualToString:@"ATG"] || [self.inquiryOrder.inquiryType isEqualToString:@"TTG"]) {
        self.inquiryOrder.isVisiblePrice = [NSNumber numberWithInteger:0];
    } else {
        self.inquiryOrder.isVisiblePrice = [NSNumber numberWithInteger:1];
    }
    
    
    self.inquiryOrder.deliveryMethod = @"F";//货运方式
    self.inquiryOrder.partType = @"FBJ";//零件类型
    self.inquiryOrder.processType = @"BGBL";//加工类型
    self.inquiryOrder.isUrgent = [NSNumber numberWithInteger:0];
    
    
    
//    NSDate *date1 = [NSDate date];
    NSDate *date1 = [ToolTransition dateFromString:@"2016-01-01 00:00:00"];
    NSTimeInterval interval = 60*60*24*[@"7" integerValue];
    NSDate *date2 = [NSDate dateWithTimeInterval:interval sinceDate:date1];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString1 = [formatter1 stringFromDate:date2];
    self.inquiryOrder.endTm = dateString1;//询盘天数
    _endTime = @"7天";
    self.inquiryOrder.inquiryDay = [NSNumber numberWithInteger:7];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    self.inquiryOrder.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    self.inquiryOrder.manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyMMdd"];
    NSString *dateString = [pickerFormatter stringFromDate:date];
    
    int num = (arc4random() % 1000);
    NSString *str1 = [NSString stringWithFormat:@"%.3d", num];
    self.inquiryOrder.insideOrderCode = [NSString stringWithFormat:@"%@%@",dateString,str1];
    
    
    MemberResBean *member = [GlobalSettingManager shareGlobalSettingManager].member;
//    NSString *member = loginModel.member;
//    Member *memberModel = [Member mj_objectWithKeyValues:member];
    
    self.inquiryOrder.purchaserAccountPeriod = member.enterpriseInfo.accountPeriod;
    
//    self.inquiryOrder.member = memberModel;
    
    
    self.inquiryOrder.supplierTaxRate = member.enterpriseInfo.supplierTaxRate;
    
    self.inquiryOrder.isUrgent = [NSNumber numberWithInteger:0];
    self.inquiryOrder.isPre = [NSNumber numberWithInteger:0];//一次0 多次1

    //初始化 self.inquiryOrder
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    if (_arrayQuotationTemplate.count > 0) {
        NSLog(@"_arrayQuotationTemplate.count > 0");
    } else {
        NSLog(@"!_arrayQuotationTemplate.count > 0");
    }
    
    //FTG
    if ([self.inquiryOrder.inquiryType isEqualToString:@"FTG"]) {
        
    } else {
        
    }
//    _dataArray = @[@"询盘名称",@"目标价供应商可见",@"订单编号",@"报价方式",@"到货方式",@"交货日期",@"询盘天数",@"货运方式",@"询盘工艺"];
    _dataArray = @[@"目标价供应商可见",@"订单编号",@"报价方式",@"到货方式",@"交货日期",@"货运方式",@"询盘工艺",@"零件类型",@"加工类型",@"期望供应商税率",@"是否加急"];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EFBFaPanCell0" bundle:nil] forCellReuseIdentifier:@"eFBFaPanCell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EFBFaPanCell1" bundle:nil] forCellReuseIdentifier:@"eFBFaPanCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EFBFaPanCell2" bundle:nil] forCellReuseIdentifier:@"eFBFaPanCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EFBFaPanCell3" bundle:nil] forCellReuseIdentifier:@"eFBFaPanCell3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EFBFaPanCell4" bundle:nil] forCellReuseIdentifier:@"eFBFaPanCell4"];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 50;
    } else {
        self.tableViewBottom.constant = rect.size.height;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 30)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = colorRGB(153, 153, 153);
    label.text = @"步骤一：采购要求";
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5, kMainW, 0.5)];
    viewLine.backgroundColor = colorRGB(221, 221, 221);
    [view addSubview:viewLine];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _dataArray.count) {
        if (indexPath.row == 0) {
            if ([self.inquiryOrder.inquiryType isEqualToString:@"FTG"]) {
                return 0;
            } else {
                return 44;
            }
        }
        if (indexPath.row == 4) {
            if ([self.inquiryOrder.isPre integerValue] == 0) {
                return 44;
            } else if ([self.inquiryOrder.isPre integerValue] == 1) {
                return 0;
            }
        }
        if (indexPath.row == 8) {
            if ([self.inquiryOrder.partType isEqualToString:@"SCYL"]) {
                return 0;
            } else {
                return 44;
            }
        }
        return 44;
    } else if (indexPath.row < _dataArray.count + 1) {
        return 77;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {//目标价供应商可见
        EFBFaPanCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"eFBFaPanCell4" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = _dataArray[indexPath.row];
        if ([self.inquiryOrder.inquiryType isEqualToString:@"FTG"]) {
            cell.hidden = YES;
        } else {
            cell.hidden = NO;
        }
        cell.switch0.on = [self.inquiryOrder.isVisiblePrice integerValue] == 1?YES:NO;
        [cell.switch0 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        cell.switch0.tag = indexPath.row;
        return cell;
    } else if (indexPath.row == 1) {//订单编号
        EFBFaPanCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"eFBFaPanCell0" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = _dataArray[indexPath.row];
        cell.textField.text = self.inquiryOrder.insideOrderCode;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        [cell.textField addTarget:self action:@selector(textFieldDingDanBianHao:) forControlEvents:UIControlEventEditingChanged];
        cell.textField.inputAccessoryView = [self addToolbar];
        return cell;
    } else if (indexPath.row == 2) {//报价方式
        EFBFaPanCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"eFBFaPanCell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = _dataArray[indexPath.row];
        
        cell.labelMingXi00.hidden = YES;
        cell.labelMingXi01.hidden = YES;
        [cell.button1 setTitleColor:colorRGB(102, 102, 102) forState:UIControlStateNormal];
        if ([self.inquiryOrder.isQuotationTemplate integerValue] == 0) {//零件总价
            [cell.button0 setImage:[UIImage imageNamed:@"icon_defaultaddress"] forState:UIControlStateNormal];
            [cell.button1 setImage:[UIImage imageNamed:@"icon_unchecked"] forState:UIControlStateNormal];
        } else {//零件明细
            [cell.button0 setImage:[UIImage imageNamed:@"icon_unchecked"] forState:UIControlStateNormal];
            [cell.button1 setImage:[UIImage imageNamed:@"icon_defaultaddress"] forState:UIControlStateNormal];
            cell.labelMingXi00.hidden = NO;
            cell.labelMingXi01.hidden = NO;
            [cell.button1 setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            cell.labelMingXi01.text = self.inquiryOrder.quotationTemplateName;
        }
        
        [cell.button0 addTarget:self action:@selector(button0Click:) forControlEvents:UIControlEventTouchUpInside];
        cell.button0.tag = indexPath.row;
        
        [cell.button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
        cell.button1.tag = indexPath.row;
        
        return cell;
    } else if (indexPath.row < 9) {//到货方式、交货日期、货运方式、询盘工艺、零件类型、加工类型
        EFBFaPanCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"eFBFaPanCell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = _dataArray[indexPath.row];
        
        cell.textField.tintColor = [UIColor clearColor];
        cell.textField.inputView = [UIView new];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
        cell.textField.rightView = imageView;
        cell.textField.rightViewMode = UITextFieldViewModeAlways;
        
        cell.buttonTextField.tag = indexPath.row;
        [cell.buttonTextField addTarget:self action:@selector(buttonTextFieldClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (indexPath.row == 3) {//到货方式
            if ([self.inquiryOrder.isPre integerValue] == 0) {
                cell.textField.text = @"一次交货";
            } else if ([self.inquiryOrder.isPre integerValue] == 1) {
                cell.textField.text = @"分批交货";
            }
        }
        if (indexPath.row == 4) {//交货日期
            if ([self.inquiryOrder.isPre integerValue] == 0) {

                cell.textField.text = [[self.inquiryOrder.expectRcvTm componentsSeparatedByString:@" "] firstObject];
            } else if ([self.inquiryOrder.isPre integerValue] == 1) {

                cell.textField.rightView = nil;
                cell.textField.rightViewMode = UITextFieldViewModeAlways;
                cell.textField.text = @"请在零件详情内填写交货批次";
            }
            cell.textField.placeholder = @"请选择，必填项";
            
            if ([self.inquiryOrder.isPre integerValue] == 0) {
                cell.hidden = NO;
            } else if ([self.inquiryOrder.isPre integerValue] == 1) {
                cell.hidden = YES;
            }
            
        }
        if (indexPath.row == 5) {//货运方式
            cell.textField.text = [NSString DeliveryMethod:self.inquiryOrder.deliveryMethod];
            cell.textField.placeholder = @"请选择，必填项";
        }
        if (indexPath.row == 6) {//询盘工艺
            if (self.inquiryOrder.tags) {
                cell.textField.text = [NSString stringWithFormat:@"已选择%ld个工艺",_arrayTempBaseTag.count];
            } else {
                cell.textField.text = nil;
            }
            cell.textField.placeholder = @"请选择";
        }
        
        if (indexPath.row == 7) {//零件类型
            cell.textField.text = [NSString PartType:self.inquiryOrder.partType];
        }
        
        if (indexPath.row == 8) {//加工类型
            if ([self.inquiryOrder.partType isEqualToString:@"SCYL"]) {
                cell.hidden = YES;
            } else {
                cell.hidden = NO;
            }
            
            cell.textField.text = [NSString ProcessType:self.inquiryOrder.processType];
        }
        
        return cell;
    } else if (indexPath.row == 9) {//采购期望供应商税率
        EFBFaPanCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"eFBFaPanCell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = _dataArray[indexPath.row];
        cell.textField.rightView = nil;
        if (self.inquiryOrder.supplierTaxRate == nil) {
            cell.textField.placeholder = @"请选择，必填项";
        } else {
            NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f%%",[self.inquiryOrder.supplierTaxRate doubleValue]*100];
            cell.textField.text = stringTaxRate;
        }
        
        [cell.buttonTextField addTarget:self action:@selector(buttonTextFieldClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.buttonTextField.tag = indexPath.row;
        return cell;
    } else if (indexPath.row == 10) {
        EFBFaPanCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"eFBFaPanCell4" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = _dataArray[indexPath.row];
        cell.switch0.on = [self.inquiryOrder.isUrgent integerValue] == 1?YES:NO;
        [cell.switch0 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        cell.switch0.tag = indexPath.row;
        return cell;
    } else if (indexPath.row < _dataArray.count + 1) {
        EFBFaPanCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"eFBFaPanCell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        for (UIView *view in cell.textView.subviews) {
            if (view.tag == 20180206) {
                [view removeFromSuperview];
            }
        }
        // placeholder
        UILabel *label = [UILabel new];
        label.font = cell.textView.font;
        label.text = @"请输入订单要求";
        label.numberOfLines = 0;
        label.textColor = [UIColor lightGrayColor];
        [label sizeToFit];
        label.tag = 20180206;
        [cell.textView addSubview:label];
        // kvc
        [cell.textView setValue:label forKey:@"_placeholderLabel"];
        
        cell.textView.delegate = self;
        
        cell.textView.text = self.inquiryOrder.supplierRemark;
        cell.textView.inputAccessoryView = [self addToolbar];
        cell.textView.backgroundColor = [UIColor whiteColor];
        return cell;
    } else {
        return nil;
    }
}




#pragma mark 目标价供应商可见
- (void)switchAction:(UISwitch *)sender {
    BOOL isButtonOn = [sender isOn];
    if (sender.tag == 0) {//目标价供应商可见
        if (isButtonOn) {
            self.inquiryOrder.isVisiblePrice = [NSNumber numberWithInteger:1];
        } else {
            self.inquiryOrder.isVisiblePrice = [NSNumber numberWithInteger:0];
        }
    } else if (sender.tag == 10) {//是否加急
        if (isButtonOn) {
            self.inquiryOrder.isUrgent = [NSNumber numberWithInteger:1];
        } else {
            self.inquiryOrder.isUrgent = [NSNumber numberWithInteger:0];
        }
    }
    
}

#pragma mark 订单编号
- (void)textFieldDingDanBianHao:(UITextField *)sender {
    if (sender.text.length > 14) {
        sender.text = [sender.text substringToIndex:14];
    }
    self.inquiryOrder.insideOrderCode = sender.text;
    NSLog(@"insideOrderCode:%@",self.inquiryOrder.insideOrderCode);
}
#pragma mark 零件总价
- (void)button0Click:(UIButton *)sender {
    self.inquiryOrder.isQuotationTemplate = [NSNumber numberWithInteger:0];
    self.inquiryOrder.quotationTemplateId = nil;
    self.inquiryOrder.quotationTemplateName = nil;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

#pragma mark 零件明细
- (void)button1Click:(UIButton *)sender {
    if (_arrayQuotationTemplate.count > 0) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UIViewXuanZeBaoJiaMoBan" owner:self options:nil];
        UIViewXuanZeBaoJiaMoBan *viewXZBJMB = [nib objectAtIndex:0];
        viewXZBJMB.frame = CGRectMake(0, 0, kMainW, kMainH);
        [self.view addSubview:viewXZBJMB];
        viewXZBJMB.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [viewXZBJMB initPickerViewWithArray:_arrayQuotationTemplate ButtonClick:^(NSInteger index) {
            NSLog(@"%ld",index);
            QuotationTemplate *quotationTemplate = _arrayQuotationTemplate[index];
            self.inquiryOrder.isQuotationTemplate = [NSNumber numberWithInteger:1];
            self.inquiryOrder.quotationTemplateId = quotationTemplate.quotationTemplateId;
            self.inquiryOrder.quotationTemplateName = quotationTemplate.quotationTemplateName;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"暂无模板，需先去电脑端新增" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

#pragma mark 到货方式、交货日期、货运方式、询盘工艺、零件类型、加工类型
- (void)buttonTextFieldClick:(UIButton *)sender {
    NSLog(@"----------%s",__FUNCTION__);
    if (sender.tag == 3) {//到货方式
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"一次交货" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.inquiryOrder.isPre = [NSNumber numberWithInteger:0];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0],[NSIndexPath indexPathForRow:sender.tag+1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"分批交货" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.inquiryOrder.isPre = [NSNumber numberWithInteger:1];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0],[NSIndexPath indexPathForRow:sender.tag+1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [action0 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [action2 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [alertController addAction:action0];
        [alertController addAction:action1];
        [alertController addAction:action2];
        
        if ([alertController respondsToSelector:@selector(popoverPresentationController)]) {
            alertController.popoverPresentationController.sourceView = self.view;//必须加
            alertController.popoverPresentationController.sourceRect = CGRectMake(0, kMainH, kMainW, kMainH);//可选
        }
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (sender.tag == 4) {//交货日期
        if ([self.inquiryOrder.isPre integerValue] == 0) {
            
        } else if ([self.inquiryOrder.isPre integerValue] == 1) {
            return;
        }
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeYaoQiuDaoHuoRiQi" owner:self options:nil];
        UIViewXuanZeYaoQiuDaoHuoRiQi *viewXZSJ = [nib objectAtIndex:0];
        viewXZSJ.frame = CGRectMake(0, 0, kMainW, kMainH);
        [self.view addSubview:viewXZSJ];
        viewXZSJ.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [viewXZSJ initDataPickerButtonClick:^(NSString *string) {
            NSLog(@"%@",string);
            self.inquiryOrder.expectRcvTm = string;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        } buttonQuXiao:^{
            [sender resignFirstResponder];
        }];
    }
    /*
     else if (sender.tag == 6) {//询盘天数
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UIViewXuanZeXunPanTianShu" owner:self options:nil];
        UIViewXuanZeXunPanTianShu *viewXZXPTS = [nib objectAtIndex:0];
        viewXZXPTS.frame = CGRectMake(0, 0, kMainW, kMainH);
        [self.view addSubview:viewXZXPTS];
        viewXZXPTS.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [viewXZXPTS initPickerViewButtonClick:^(NSString *string) {
//            NSLog(@"%@",string);
            _endTime = string;
            NSString *string1 = [string stringByReplacingOccurrencesOfString:@"天" withString:@""];
            
//            NSDate *date = [NSDate date];
            NSDate *date = [ToolTransition dateFromString:@"2016-01-01 00:00:00"];
            NSTimeInterval interval = 60*60*24*[string1 integerValue];
            NSDate *date2 = [NSDate dateWithTimeInterval:interval sinceDate:date];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateString = [formatter stringFromDate:date2];
            
            NSLog(@"-->%@",dateString);
            self.inquiryOrder.endTm = dateString;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        } buttonQuXiao:^{
            [sender resignFirstResponder];
        }];
    }
     */
    
    else if (sender.tag == 5) {//货运方式
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UIViewXuanZeHuoYunFangShi" owner:self options:nil];
        UIViewXuanZeHuoYunFangShi *viewXZHYFS = [nib objectAtIndex:0];
        viewXZHYFS.frame = CGRectMake(0, 0, kMainW, kMainH);
        [self.view addSubview:viewXZHYFS];
        viewXZHYFS.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [viewXZHYFS initPickerViewButtonClick:^(NSString *string) {
            NSLog(@"%@",string);
            self.inquiryOrder.deliveryMethod = string;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        } buttonQuXiao:^{
            [sender resignFirstResponder];
        }];
    } else if (sender.tag == 6) {//询盘工艺
        XuanZeXunPanGongYiVC *xuanZeXunPanGongYiVC = [[XuanZeXunPanGongYiVC alloc] init];
        if (self.inquiryOrder.tags) {//选择了工艺
            xuanZeXunPanGongYiVC.arrayTempBaseTag = [_arrayTempBaseTag mutableCopy];//传入需要的array
        }
        xuanZeXunPanGongYiVC.buttonBackBlock = ^(NSMutableArray *arrayBaseTag) {//一、回传值 二、阻止再次打开询盘工艺界面
            _arrayTempBaseTag = arrayBaseTag;
            
            if (arrayBaseTag.count > 0) {
                NSString *string = @"";
                for (NSInteger i=0; i<arrayBaseTag.count; i++) {
                    BaseTag * baseTag = arrayBaseTag[i];
                    string = [string stringByAppendingString:[NSString stringWithFormat:@".%@",baseTag.name]];
                    if (i == arrayBaseTag.count-1) {
                        string = [string stringByAppendingString:[NSString stringWithFormat:@"."]];
                    }
                }
                self.inquiryOrder.tags = string;
            } else {
                self.inquiryOrder.tags = nil;
            }
            
            NSLog(@"tags:%@",self.inquiryOrder.tags);
            
            NSLog(@"array:%@",arrayBaseTag);
            
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:xuanZeXunPanGongYiVC animated:YES];
    } else if (sender.tag == 7) {//零件类型
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:[NSString PartType:@"FBJ"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.inquiryOrder.partType = @"FBJ";
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0],[NSIndexPath indexPathForRow:sender.tag+1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:[NSString PartType:@"BZJ"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.inquiryOrder.partType = @"BZJ";
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0],[NSIndexPath indexPathForRow:sender.tag+1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:[NSString PartType:@"SCYL"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.inquiryOrder.partType = @"SCYL";
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0],[NSIndexPath indexPathForRow:sender.tag+1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:[NSString PartType:@"GXWX"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.inquiryOrder.partType = @"GXWX";
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0],[NSIndexPath indexPathForRow:sender.tag+1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        UIAlertAction *action4 = [UIAlertAction actionWithTitle:[NSString PartType:@"FWJ"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.inquiryOrder.partType = @"FWJ";
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0],[NSIndexPath indexPathForRow:sender.tag+1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [action0 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [action2 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [action3 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [action4 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [action setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [alertController addAction:action0];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController addAction:action3];
        [alertController addAction:action4];
        [alertController addAction:action];
        
        if ([alertController respondsToSelector:@selector(popoverPresentationController)]) {
            alertController.popoverPresentationController.sourceView = self.view;//必须加
            alertController.popoverPresentationController.sourceRect = CGRectMake(0, kMainH, kMainW, kMainH);//可选
        }
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (sender.tag == 8) {//加工类型
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:[NSString ProcessType:@"BGBL"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.inquiryOrder.processType = @"BGBL";
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0],[NSIndexPath indexPathForRow:sender.tag+1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:[NSString ProcessType:@"QLJG"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.inquiryOrder.processType = @"QLJG";
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0],[NSIndexPath indexPathForRow:sender.tag+1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:[NSString ProcessType:@"ZJG"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.inquiryOrder.processType = @"ZJG";
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0],[NSIndexPath indexPathForRow:sender.tag+1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [action0 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [action2 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [action setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [alertController addAction:action0];
        [alertController addAction:action1];
        [alertController addAction:action2];
        
        [alertController addAction:action];
        
        if ([alertController respondsToSelector:@selector(popoverPresentationController)]) {
            alertController.popoverPresentationController.sourceView = self.view;//必须加
            alertController.popoverPresentationController.sourceRect = CGRectMake(0, kMainH, kMainW, kMainH);//可选
        }
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (sender.tag == 9) {
#pragma mark 采购期望供应商税率
        if (!_eChooseTaxRateView5Kind) {
            NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[self.inquiryOrder.supplierTaxRate doubleValue]*100];
            _eChooseTaxRateView5Kind = [[EChooseTaxRateView5Kind alloc] initWithFrame:self.view.frame defaultTax:stringTaxRate buttonConfirmClick:^(NSString *confirmTax) {
                double tax = [confirmTax doubleValue]/100.0;
                NSLog(@"-->%@",[NSNumber numberWithDouble:tax]);//56时 有问题 0.5600000000000001
                self.inquiryOrder.supplierTaxRate = [NSNumber numberWithDouble:tax];
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }];
            [self.view addSubview:_eChooseTaxRateView5Kind];
        } else {
            _eChooseTaxRateView5Kind.hidden = NO;
        }
    }
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}



#pragma 优选供应商
- (void)textViewDidChange:(UITextView *)textView {
    self.inquiryOrder.tradeOrderRemark = textView.text;
    NSLog(@"优选供应商:%@",self.inquiryOrder.tradeOrderRemark);
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.tableView setContentOffset:CGPointMake(0, 10000)];
}

#pragma mark 下一步
- (IBAction)buttonXiaYiBu:(UIButton *)sender {
    if (!(self.inquiryOrder.insideOrderCode.length > 0)) {//订单编号
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入订单编号"];
        return;
    }
    if ([self.inquiryOrder.isPre integerValue] == 0) {//一次交货
        if (!(self.inquiryOrder.expectRcvTm.length > 0)) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择日期"];
            return;
        }
    } else if ([self.inquiryOrder.isPre integerValue] == 1) {//多次交货

    }
    
    if (!(_endTime.length > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择询盘天数"];
        return;
    }
    if (!(self.inquiryOrder.deliveryMethod.length > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择货运方式"];
        return;
    }
    if (self.inquiryOrder.supplierTaxRate == nil) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择期望供应商税率"];
        return;
    }
    if (self.inquiryOrder.supplierTaxRate.doubleValue == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"期望供应商税率不能为0"];
        return;
    }
    
    NSDictionary *dic = [self.inquiryOrder mj_keyValues];
    NSLog(@"%@",dic);
    
    BJFaPanViewController1 *bJFaPanViewController1 = [[BJFaPanViewController1 alloc] init];
    bJFaPanViewController1.inquiryOrder = self.inquiryOrder;
    bJFaPanViewController1.buttonBackBlock = ^(InquiryOrder *inquiryOrder) {
        self.inquiryOrder = inquiryOrder;
    };
    [self.navigationController pushViewController:bJFaPanViewController1 animated:YES];
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


- (void)initRequestQuotationTemplateList {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    QuotationTemplate *quotationTemplate = [[QuotationTemplate alloc] init];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    quotationTemplate.manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    
    postEntityBean.entity = quotationTemplate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_i_quotationTemplate_quotationTemplateList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            _arrayQuotationTemplate = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in returnListBean.list) {
                QuotationTemplate *quotationTemplate = [QuotationTemplate mj_objectWithKeyValues:dic];
                [_arrayQuotationTemplate addObject:quotationTemplate];
            }
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
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
