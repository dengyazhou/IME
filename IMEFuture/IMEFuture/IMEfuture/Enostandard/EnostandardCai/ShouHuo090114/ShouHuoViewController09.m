//
//  ShouHuoViewController09.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ShouHuoViewController09.h"
#import "VoHeader.h"
#import "ShouHuoCell0900.h"
#import "ShouHuoCell090100.h"
#import "ShouHuoCell090101.h"
#import "ShouHuoCell090102.h"
#import "FaHuoCell0901.h"
#import "ShouHuoCell0903.h"

#import "UIViewXuanZeShiJian.h"
#import "UIViewXuanZeSongHuoFangShi.h"
#import "PartDetailsView.h"
#import "IMETabBarViewController.h"
#import "UIViewXuanZeShuoHuoArea.h"
#import "GlobalSettingManager.h"

@interface ShouHuoViewController09 () <UITableViewDelegate,UITableViewDataSource> {
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *buttonReceiveconfirmation;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger index;

@end

@implementation ShouHuoViewController09

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *pickerFormatter1 = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.deliverOrderDetailBean.receiveTimeDYZ = [pickerFormatter1 stringFromDate:date];
    self.deliverOrderDetailBean.arrivalTimeDYZ = [pickerFormatter1 stringFromDate:date];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoCell0900" bundle:nil] forCellReuseIdentifier:@"shouHuoCell0900"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoCell090100" bundle:nil] forCellReuseIdentifier:@"shouHuoCell090100"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoCell090101" bundle:nil] forCellReuseIdentifier:@"shouHuoCell090101"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoCell090102" bundle:nil] forCellReuseIdentifier:@"shouHuoCell090102"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell0901" bundle:nil] forCellReuseIdentifier:@"faHuoCell0901"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoCell0903" bundle:nil] forCellReuseIdentifier:@"shouHuoCell0903"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    for (DeliverOrderItemBean *model in self.deliverOrderDetailBean.items) {
        model.receiveQuantity = model.deliverNum;
    }
    
    self.buttonReceiveconfirmation.backgroundColor = colorCai;
    self.buttonReceiveconfirmation.enabled = true;
    
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
    return 4;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return  UITableViewAutomaticDimension;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (section == 3) {
        return self.deliverOrderDetailBean.items.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ShouHuoCell0900 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoCell0900" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.labelTitle.text = @"收货日期";
            cell.labelReceiveTiem.text = self.deliverOrderDetailBean.receiveTimeDYZ;
            __weak ShouHuoCell0900 *weakCell = cell;
            [cell setButtonReceiveTime:^{
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeShiJian" owner:self options:nil];
                UIViewXuanZeShiJian *viewXZSJ = [nib objectAtIndex:0];
                viewXZSJ.frame = CGRectMake(0, 0, kMainW, kMainH);
                [self.view addSubview:viewXZSJ];
                viewXZSJ.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
                [viewXZSJ initDataPickerButtonClick:^(NSString *string) {
                    self.deliverOrderDetailBean.receiveTimeDYZ = string;
                    weakCell.labelReceiveTiem.text = string;
                } formatter:@"yyyy-MM-dd HH:mm:ss"];
            }];
        } else if (indexPath.row == 1) {
            cell.labelTitle.text = @"到仓日期";
            cell.labelReceiveTiem.text = self.deliverOrderDetailBean.arrivalTimeDYZ;
            __weak ShouHuoCell0900 *weakCell = cell;
            [cell setButtonReceiveTime:^{
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeShiJian" owner:self options:nil];
                UIViewXuanZeShiJian *viewXZSJ = [nib objectAtIndex:0];
                viewXZSJ.frame = CGRectMake(0, 0, kMainW, kMainH);
                [self.view addSubview:viewXZSJ];
                viewXZSJ.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
                [viewXZSJ initDataPickerButtonClick:^(NSString *string) {
                    self.deliverOrderDetailBean.arrivalTimeDYZ = string;
                    weakCell.labelReceiveTiem.text = string;
                } formatter:@"yyyy-MM-dd HH:mm:ss"];
            }];
        }
        return cell;
    } else if (indexPath.section == 1) {
        if ([self.deliverOrderDetailBean.deliveryMethods isEqualToString:@"SUPPLIER"]) {
            ShouHuoCell090100 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoCell090100" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.deliverOrderDetailBean;
            return cell;
        } else if ([self.deliverOrderDetailBean.deliveryMethods isEqualToString:@"LOGISTICS"]) {
            ShouHuoCell090101 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoCell090101" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.deliverOrderDetailBean;
            return cell;
        } else if ([self.deliverOrderDetailBean.deliveryMethods isEqualToString:@"SELF"]) {
            ShouHuoCell090102 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoCell090102" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.deliverOrderDetailBean;
            return cell;
        }
    } else if (indexPath.section == 2) {
        FaHuoCell0901 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0901" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 3) {
        ShouHuoCell0903 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoCell0903" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        DeliverOrderItemBean *model = self.deliverOrderDetailBean.items[indexPath.row];
        cell.model = model;
        [cell setTextFieldCallBack:^{
            [self changebuttonColor];
        }];
        __weak ShouHuoCell0903 *weakCell = cell;
        [cell setButtonReceiveArea:^{
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeShuoHuoArea" owner:self options:nil];
            UIViewXuanZeShuoHuoArea *viewXZWL = [nib objectAtIndex:0];
            viewXZWL.frame = CGRectMake(0, 0, kMainW, kMainH);
            [self.view addSubview:viewXZWL];
            viewXZWL.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//            [viewXZWL initPickerViewButtonClick:^(NSString *string) {
//                NSLog(@"%@",string);
//                model.receivingArea = string;
//                weakCell.textField1.text = string;
//            } with:self.dataArray];
            [viewXZWL initPickerViewButtonClick:^(AreaResBean *model1) {
                model.receivingArea = model1.attributeName;
                model.isMianJianDYZ = model1.isMianjian;
                weakCell.textField1.text = model.receivingArea;
            } with:self.dataArray];
        }];
        [cell setButtonOrderOtemCallBack:^{
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PartDetailsView" owner:self options:nil];
            PartDetailsView *partDetailsView = [nib objectAtIndex:0];
            partDetailsView.frame = CGRectMake(0, 0, kMainW, kMainH);
            [self.view addSubview:partDetailsView];
            [partDetailsView initDataIsDeliverOrderItemBean:model];
        }];
        cell.textFieldReceiveQuantity.inputAccessoryView = [self addToolbar];
        cell.textFieldReceiveRemark.inputAccessoryView = [self addToolbar];
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)changebuttonColor {
    BOOL flag = true;
    for (DeliverOrderItemBean *model in self.deliverOrderDetailBean.items) {
        if (model.receiveQuantity.integerValue == 0) {
            flag = false;
        }
    }
    if (flag) {
        self.buttonReceiveconfirmation.backgroundColor = colorCai;
        self.buttonReceiveconfirmation.enabled = true;
    } else {
        self.buttonReceiveconfirmation.backgroundColor = colorRGB(180, 180, 180);
        self.buttonReceiveconfirmation.enabled = false;
    }
}

- (IBAction)buttonSubmit:(id)sender {
    
    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:37]]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
        return;
    }
    
    _viewLoading.hidden = false;
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    ReceiveBean *receiveOrder = [ReceiveBean new];
    receiveOrder.deliverOrderId = self.deliverOrderDetailBean.deliverOrderId;
    receiveOrder.isOpenErp = self.deliverOrderDetailBean.isOpenErp;
    receiveOrder.receiveTime = self.deliverOrderDetailBean.receiveTimeDYZ;
    receiveOrder.arrivalTime = self.deliverOrderDetailBean.arrivalTimeDYZ;
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:0];
    for (DeliverOrderItemBean *model in self.deliverOrderDetailBean.items) {
        ReceiveItemBean *receiveItemBean = [ReceiveItemBean new];
        receiveItemBean.deliverOrderItemId = model.deliverOrderItemId;
        receiveItemBean.receiveNum = model.receiveQuantity;
        receiveItemBean.receivingArea = model.receivingArea;
        receiveItemBean.isMianjian = [NSNumber numberWithInteger:model.isMianJianDYZ.integerValue];
        receiveItemBean.receiveRemark = model.receiveRemark;
        [items addObject:receiveItemBean];
    }
    receiveOrder.receiveOrderItems = items;
    postEntityBean.entity = receiveOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_receiveOrder_purchaseAddReceiveOrder parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"收货成功"];
            [self.navigationController popViewControllerAnimated:true];
            _viewLoading.hidden = true;
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
        }
        NSLog(@"%@",model.returnMsg);
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}


- (void)initRequest{
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    EnterpriseExpand *enterpriseExpand = [EnterpriseExpand new];
    enterpriseExpand.manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    postEntityBean.entity = enterpriseExpand.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_receiveOrder_areaList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (id any in model.list) {
                AreaResBean *areaResBean = [AreaResBean mj_objectWithKeyValues:any];
                [self.dataArray addObject:areaResBean];
            }
        } else {
            
        }
        _viewLoading.hidden = YES;
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    
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


- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:true];
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
