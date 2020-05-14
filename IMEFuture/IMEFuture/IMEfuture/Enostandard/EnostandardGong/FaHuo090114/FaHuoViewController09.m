//
//  FaHuoViewController09.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "FaHuoViewController09.h"
#import "VoHeader.h"

#import "FaHuoCell0.h"
#import "FaHuoCell0901.h"
#import "FaHuoCell0902.h"
#import "FaHuoCell0903.h"
#import "FaHuoCell0904.h"
#import "FaHuoCell090500.h"
#import "FaHuoCell090501.h"
#import "FaHuoCell090502.h"
#import "FaHuoCell0906.h"

#import "PartDetailsView.h"


#import "UIViewXuanZeShiJian.h"
#import "UIViewXuanZeSongHuoFangShi.h"
#import "UIViewXuanZeWuLiuGongSi.h"
#import "DingDanXiangQingGongViewController.h"
#import "GlobalSettingManager.h"`

@interface FaHuoViewController09 ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {
    UIView *_viewLoading;
    
    NSString *_operateCode0;
    NSString *_operateCode1;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonDeliveryconfirmation;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@property (strong, nonatomic) PurchaseInfo *purchaseInfo;

@property (strong, nonatomic) DeliverOrderDetailBean *deliverOrderDetailBean;

@property (assign, nonatomic) NSInteger index;

//eliveryconfirmation

@end

@implementation FaHuoViewController09

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    NSDate *date = [NSDate date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyMMdd"];
    NSString *dateString = [pickerFormatter stringFromDate:date];
    
    _operateCode0 = dateString;
    
    int num = (arc4random() % 1000000);
    _operateCode1 = [NSString stringWithFormat:@"%.6d", num];
    
    
    
    NSDateFormatter *pickerFormatter1 = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.deliverOrderDetailBean = [[DeliverOrderDetailBean alloc] init];
    self.deliverOrderDetailBean.deliveryTime = [pickerFormatter1 stringFromDate:date];
    self.deliverOrderDetailBean.expectedArrivalTime = [pickerFormatter1 stringFromDate:date];
    self.deliverOrderDetailBean.deliveryMethods = @"SUPPLIER";
//    self.deliverOrderDetailBean.logisticsCompanyKey = @"SF";
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell0" bundle:nil] forCellReuseIdentifier:@"faHuoCell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell0901" bundle:nil] forCellReuseIdentifier:@"faHuoCell0901"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell0902" bundle:nil] forCellReuseIdentifier:@"faHuoCell0902"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell0903" bundle:nil] forCellReuseIdentifier:@"faHuoCell0903"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell0904" bundle:nil] forCellReuseIdentifier:@"faHuoCell0904"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell090500" bundle:nil] forCellReuseIdentifier:@"faHuoCell090500"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell090501" bundle:nil] forCellReuseIdentifier:@"faHuoCell090501"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell090502" bundle:nil] forCellReuseIdentifier:@"faHuoCell090502"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell0906" bundle:nil] forCellReuseIdentifier:@"faHuoCell0906"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    for (PurchaseOrderResBean *model in self.dataArray) {
        model.num = model.waitDeliverNum;
    }
    
    self.buttonDeliveryconfirmation.backgroundColor = colorGong;
    self.buttonDeliveryconfirmation.enabled = true;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar)];
    [self.view addSubview:_viewLoading];
    
    [self initRequest];
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 0;
    } else {
        self.tableViewBottom.constant = rect.size.height-60-Height_BottomBar;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.dataArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FaHuoCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.purchaseInfo;
        return cell;
    } else if (indexPath.section == 1) {//零件信息
        FaHuoCell0901 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0901" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 2) {
        FaHuoCell0902 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0902" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PurchaseOrderResBean *model = self.dataArray[indexPath.row];
        cell.model = model;
        [cell setTextFieldCallBack:^{
            [self changebuttonColor];
        }];
        [cell setButtonClickCallBack:^{
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PartDetailsView" owner:self options:nil];
            PartDetailsView *partDetailsView = [nib objectAtIndex:0];
            partDetailsView.frame = CGRectMake(0, 0, kMainW, kMainH);
            [self.view addSubview:partDetailsView];
            [partDetailsView initData:model];
        }];
        
        cell.textField.inputAccessoryView = [self addToolbar];
        return cell;
    } else if (indexPath.section == 3) {//发货信息
        FaHuoCell0903 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0903" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 4) {
        FaHuoCell0904 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0904" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.deliverOrderDetailBean;
        
        [cell.buttonFaHuoDanHao setTitle:_operateCode0 forState:UIControlStateNormal];
        [cell.buttonFaHuoDanHao setTitleColor:colorRGB(153, 153, 153) forState:UIControlStateNormal];
//        [cell setButtonSelectFaHuoDanHao:^(UIButton * _Nonnull btn) {
//            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeShiJian" owner:self options:nil];
//            UIViewXuanZeShiJian *viewXZSJ = [nib objectAtIndex:0];
//            viewXZSJ.frame = CGRectMake(0, 0, kMainW, kMainH);
//            [self.view addSubview:viewXZSJ];
//            viewXZSJ.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//            [viewXZSJ initDataPickerButtonClick:^(NSString *string) {
//                _operateCode0 = string;
//                [btn setTitle:_operateCode0 forState:UIControlStateNormal];
//            } formatter:@"yyMMdd"];
//        }];
        
        cell.textField0.text = _operateCode1;
        cell.textField0.delegate = self;
        cell.textField0.textColor = colorRGB(153, 153, 153);
//        [cell.textField0 addTarget:self action:@selector(textFieldOperateCode1DidEnd:) forControlEvents:UIControlEventEditingDidEnd];
//        cell.textField0.inputAccessoryView = [self addToolbar];
        cell.textField0.enabled = false;
        __weak FaHuoCell0904 *weakCell = cell;
        [cell setButtonSelectFaHuoRiQi:^{
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeShiJian" owner:self options:nil];
            UIViewXuanZeShiJian *viewXZSJ = [nib objectAtIndex:0];
            viewXZSJ.frame = CGRectMake(0, 0, kMainW, kMainH);
            [self.view addSubview:viewXZSJ];
            viewXZSJ.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            [viewXZSJ initDataPickerButtonClick:^(NSString *string) {
                self.deliverOrderDetailBean.deliveryTime = string;
                weakCell.labeldeliveryTime.text = string;
            } formatter:@"yyyy-MM-dd HH:mm:ss"];
        }];
        [cell setButtonSelectDaoHuoRiQi:^{
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeShiJian" owner:self options:nil];
            UIViewXuanZeShiJian *viewXZSJ = [nib objectAtIndex:0];
            viewXZSJ.frame = CGRectMake(0, 0, kMainW, kMainH);
            [self.view addSubview:viewXZSJ];
            viewXZSJ.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            [viewXZSJ initDataPickerButtonClick:^(NSString *string) {
                self.deliverOrderDetailBean.expectedArrivalTime = string;
                weakCell.labelexpectedArrivalTime.text = string;
            } formatter:@"yyyy-MM-dd HH:mm:ss"];
        }];
        [cell setButtonSelectSongHuoFangShi:^{
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeSongHuoFangShi" owner:self options:nil];
            UIViewXuanZeSongHuoFangShi *viewXZWL = [nib objectAtIndex:0];
            viewXZWL.frame = CGRectMake(0, 0, kMainW, kMainH);
            [self.view addSubview:viewXZWL];
            viewXZWL.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            [viewXZWL initPickerViewButtonClick:^(NSString *string) {
                NSLog(@"%@",string);
                self.deliverOrderDetailBean.deliveryMethods = string;
                weakCell.labeldeliveryMethods.text = [NSString DeliveryMethod:string];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
            } with:@[@"SUPPLIER",@"LOGISTICS",@"SELF"]];
        }];
        cell.textField0.inputAccessoryView = [self addToolbar];
        cell.textFieldDeliverNumber.inputAccessoryView = [self addToolbar];
        return cell;
    } else if (indexPath.section == 5) {
        if ([self.deliverOrderDetailBean.deliveryMethods isEqualToString:@"SUPPLIER"]) {
            FaHuoCell090500 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell090500" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.deliverOrderDetailBean;
            
            cell.textFieldLianLuoRen.inputAccessoryView = [self addToolbar];
            cell.textFieldLianLuoDianHua.inputAccessoryView = [self addToolbar];
            cell.textFieldLianLuoChePaiHao.inputAccessoryView = [self addToolbar];
            return cell;
        } else if ([self.deliverOrderDetailBean.deliveryMethods isEqualToString:@"LOGISTICS"]) {
            FaHuoCell090501 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell090501" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.deliverOrderDetailBean;
            
            if (self.deliverOrderDetailBean.logisticsCompanyKey) {
                cell.labelWuLiuGongSi.text = [NSString LogisticsEnum:self.deliverOrderDetailBean.logisticsCompanyKey];
                cell.labelWuLiuGongSi.textColor = colorRGB(102, 102, 102);
            } else {
                cell.labelWuLiuGongSi.text = @"请选择";
                cell.labelWuLiuGongSi.textColor = colorRGB(177, 177, 177);
            }
            
            __weak FaHuoCell090501 *weakCell = cell;
            [cell setButtonClickCallBack:^{
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeWuLiuGongSi" owner:self options:nil];
                UIViewXuanZeWuLiuGongSi *viewXZWL = [nib objectAtIndex:0];
                viewXZWL.frame = CGRectMake(0, 0, kMainW, kMainH);
                [self.view addSubview:viewXZWL];
                viewXZWL.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
                [viewXZWL initPickerViewButtonClick:^(NSString *string) {
                    NSLog(@"%@",string);
                    self.deliverOrderDetailBean.logisticsCompanyKey = string;
                    weakCell.labelWuLiuGongSi.textColor = colorRGB(102, 102, 102);
                    weakCell.labelWuLiuGongSi.text = [NSString LogisticsEnum:string];
                }];
            }];
            cell.textFieldWuLiuDanHao.inputAccessoryView = [self addToolbar];
            return cell;
        } else if ([self.deliverOrderDetailBean.deliveryMethods isEqualToString:@"SELF"]) {
            FaHuoCell090502 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell090502" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.deliverOrderDetailBean;
            cell.textView.inputAccessoryView = [self addToolbar];
            [cell setTextFieldBeginDYZCallBack:^{
                tableView.contentOffset = CGPointMake(0, tableView.contentOffset.y+250);
            }];
            return cell;
        }
    } else if (indexPath.section == 6) {
        FaHuoCell0906 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0906" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.deliverOrderDetailBean;
        [cell setTextFieldBeginDYZCallBack:^{
            tableView.contentOffset = CGPointMake(0, tableView.contentOffset.y+250);
        }];
        cell.textView.inputAccessoryView = [self addToolbar];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)changebuttonColor {
    BOOL flag = true;
    for (PurchaseOrderResBean *model in self.dataArray) {
        if (model.num.doubleValue == 0) {
            flag = false;
        }
    }
    if (flag) {
        self.buttonDeliveryconfirmation.backgroundColor = colorGong;
        self.buttonDeliveryconfirmation.enabled = true;
    } else {
        self.buttonDeliveryconfirmation.backgroundColor = colorRGB(180, 180, 180);
        self.buttonDeliveryconfirmation.enabled = false;
    }
}

//_operateCode1
- (void)textFieldOperateCode1DidEnd:(UITextField *)sender {
    if (sender.text.length == 0) {
        _operateCode1 = @"000000";
    } else if (sender.text.length == 1) {
        _operateCode1 = [NSString stringWithFormat:@"00000%@",sender.text];
    } else if (sender.text.length == 2) {
        _operateCode1 = [NSString stringWithFormat:@"0000%@",sender.text];
    } else if (sender.text.length == 3) {
        _operateCode1 = [NSString stringWithFormat:@"000%@",sender.text];
    } else if (sender.text.length == 4) {
        _operateCode1 = [NSString stringWithFormat:@"00%@",sender.text];
    } else if (sender.text.length == 5) {
        _operateCode1 = [NSString stringWithFormat:@"0%@",sender.text];
    } else {
        _operateCode1 = [sender.text substringToIndex:6];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1+1] withRowAnimation:UITableViewRowAnimationNone];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string length]==0) {
        return YES;
    }
    if ([textField.text length]>6)
        return NO;
    NSMutableString *fieldText=[NSMutableString stringWithString:textField.text];
    [fieldText replaceCharactersInRange:range withString:string];
    NSString *finalText=[fieldText copy];
    if ([finalText length]>6) {
        textField.text=[finalText substringToIndex:6];
        return NO;
    }
    return YES;
}

- (IBAction)deliveryconfirmation:(id)sender {
    NSLog(@"%@",self.navigationController.viewControllers);
    
//    if (self.deliverOrderDetailBean.deliverNumber.length==0) {
//        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入送货单号"];
//        return;
//    }
    
    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:92]]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
        return;
    }
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];

    DeliverOrderDetailBean *deliverOrderDetailBean = [DeliverOrderDetailBean new];
    deliverOrderDetailBean.deliverCode = [NSString stringWithFormat:@"%@%@",_operateCode0,_operateCode1];
    deliverOrderDetailBean.deliveryTime = self.deliverOrderDetailBean.deliveryTime;
    deliverOrderDetailBean.deliveryMethods = self.deliverOrderDetailBean.deliveryMethods;
    deliverOrderDetailBean.isOpenErp = self.isOpenErp;
    deliverOrderDetailBean.deliverNumber = self.deliverOrderDetailBean.deliverNumber;
    deliverOrderDetailBean.deliveryContact = self.deliverOrderDetailBean.deliveryContact;
    deliverOrderDetailBean.deliveryPhone = self.deliverOrderDetailBean.deliveryPhone;
    deliverOrderDetailBean.license = self.deliverOrderDetailBean.license;
    deliverOrderDetailBean.logisticsCompanyKey = self.deliverOrderDetailBean.logisticsCompanyKey;//LogisticsEnum
    deliverOrderDetailBean.logisticsNo = self.deliverOrderDetailBean.logisticsNo;
    deliverOrderDetailBean.selfAddress = self.deliverOrderDetailBean.selfAddress;
    deliverOrderDetailBean.remark = self.deliverOrderDetailBean.remark;
    deliverOrderDetailBean.zoneStr = self.purchaseInfo.zoneStr;
    deliverOrderDetailBean.address = self.purchaseInfo.address;
    deliverOrderDetailBean.phone = self.purchaseInfo.phone;
    deliverOrderDetailBean.name = self.purchaseInfo.name;
    deliverOrderDetailBean.expectedArrivalTime = self.deliverOrderDetailBean.expectedArrivalTime;
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:0];
    for (PurchaseOrderResBean *model in self.dataArray) {
        DeliverOrderItemBean *deliverOrderItemBean = [DeliverOrderItemBean new];
        deliverOrderItemBean.tradeOrderItemId = model.itemId;
        deliverOrderItemBean.deliverNum = model.num;
        [items addObject:deliverOrderItemBean];
    }
    deliverOrderDetailBean.items = items;
    postEntityBean.entity = deliverOrderDetailBean.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
//    NSLog(@"%@",dic);

    [HttpMamager postRequestWithURLString:DYZ_deliverOrder_supplierDeliverOrder parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *model = responseObjectModel;
        
        NSLog(@"%@",model.status);
        NSLog(@"%@",model.returnMsg);
        NSLog(@"%@",model.returnCode.stringValue);
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"发货成功"];
            if (model.returnCode.integerValue == 0) {
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isMemberOfClass:[DingDanXiangQingGongViewController class]]) {
                        [self.navigationController popToViewController:vc animated:true];
                        return;
                    }
                }
                NSInteger index = 0;
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isMemberOfClass:[UITabBarController class]]) {
                        if (index == 1) {
                            [self.navigationController popToViewController:vc animated:true];
                            return;
                        }
                        index = 1;
                    }
                }
            }
        }
        
        if (model.returnCode.integerValue == -10) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"发货单号错误"];
        } else if (model.returnCode.integerValue == -20) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"送货单号错误"];
        } else if (model.returnCode.integerValue == -30) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"送货时间异常"];
        } else if (model.returnCode.integerValue == -40) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"发货数量错误"];
        } else if (model.returnCode.integerValue == -50) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"透明工厂收货质检，物料号为空"];
        } else if (model.returnCode.integerValue == -60) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"透明工厂收货质检，采购商不能代供应商发货"];
        } else if (model.returnCode.integerValue == -70) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"透明工厂收货质检，管家供应商编号为空"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"未知错误"];
        }
        
    } fail:^(NSError *error) {

    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}
- (void)initRequest{
    PurchaseOrderResBean *model = [self.dataArray firstObject];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    CreateDeliverOrderBean *createDeliverOrderBean = [CreateDeliverOrderBean new];
    createDeliverOrderBean.itemIds = [NSMutableArray arrayWithObjects:model.itemId, nil];
    postEntityBean.entity = createDeliverOrderBean.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_deliverOrder_purchaseInfo parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            PurchaseInfo *purchaseInfo = [PurchaseInfo mj_objectWithKeyValues:model.entity];
            self.purchaseInfo = purchaseInfo;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            _viewLoading.hidden = YES;
        } else {
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
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


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
