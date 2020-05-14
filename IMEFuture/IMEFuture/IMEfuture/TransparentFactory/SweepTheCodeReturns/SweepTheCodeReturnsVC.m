//
//  SweepTheCodeReturnsVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/3/2.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "SweepTheCodeReturnsVC.h"
#import "VoHeader.h"
#import "SweepTheCodeReturnsCell.h"
#import "SaoYiSaoVC.h"

@interface SweepTheCodeReturnsVC () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    UIView * _viewLoading;
    NSInteger _returnTypeIndex;
}

@property (nonatomic,strong) NSMutableArray *materialOutgoingOrderDetailVoArray;


@property (weak, nonatomic) IBOutlet UIView *viewZhong0;
@property (weak, nonatomic) IBOutlet UIView *viewZhong1;

@property (weak, nonatomic) IBOutlet UIView *viewBottom0;
@property (weak, nonatomic) IBOutlet UIView *viewBottom1;


@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;//输入发货单号
@property (weak, nonatomic) IBOutlet UILabel *label;//摄像头对准工序流转卡或条码标签，\n点击扫描

@property (weak, nonatomic) IBOutlet UIView *buttonReturnType;

@property (weak, nonatomic) IBOutlet UILabel *labelReturnType;//退货类型
@property (weak, nonatomic) IBOutlet UITextField *textFieldReasonForReturn;//退货原因

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@property (weak, nonatomic) IBOutlet UIView *selectButtonView;


@end

@implementation SweepTheCodeReturnsVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.heightNavBar.constant = Height_NavBar;
    self.heightBottomBar.constant = Height_BottomBar;
    self.heightBottomBar1.constant = Height_BottomBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
//    self.viewZhong0.hidden = true;
//    self.viewBottom0.hidden = true;
    self.viewZhong1.hidden = true;
    self.viewBottom1.hidden = true;
    self.selectButtonView.hidden = true;
    
    
    
    self.labelReturnType.text = @"返修";
    _returnTypeIndex = 0;
    
    
    self.buttonReturnType.layer.cornerRadius = 8;
    self.buttonReturnType.clipsToBounds = YES;
    self.buttonReturnType.layer.borderWidth = 1;
    self.buttonReturnType.layer.borderColor = colorRGB(221, 221, 221).CGColor;
    
    self.selectButtonView.layer.cornerRadius = 8;
    self.selectButtonView.clipsToBounds = YES;
    self.selectButtonView.layer.borderWidth = 1;
    self.selectButtonView.layer.borderColor = colorRGB(221, 221, 221).CGColor;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SweepTheCodeReturnsCell" bundle:nil] forCellReuseIdentifier:@"sweepTheCodeReturnsCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.estimatedRowHeight = 0.1;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH) color:[UIColor clearColor] imageView:CGRectMake((kMainW-34)/2, 100, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    
    
    [self setAttributedString:@"摄像头对准工序流转卡或条码标签，\n点击扫描"];
    
    self.textFieldSearch.delegate = self;
//    self.textFieldSearch.tag = 1000;
//    self.textFieldSearch.returnKeyType = UIReturnKeySearch;//搜索
    self.textFieldReasonForReturn.delegate = self;
//    self.textFieldReasonForReturn.tag = 1001;
//    self.textFieldReasonForReturn.returnKeyType = UIReturnKeyDone;//完成
    
}


- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 0;
    } else {
        self.tableViewBottom.constant = rect.size.height-(62+Height_BottomBar);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.materialOutgoingOrderDetailVoArray.count;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1000) {
        if (textField.text.length == 0) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入发货单号"];
            [textField resignFirstResponder];
            return NO;
        }
        [self request:textField.text];
        [textField resignFirstResponder];
    }
    if (textField.tag == 1001) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SweepTheCodeReturnsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sweepTheCodeReturnsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MaterialOutgoingOrderDetailVo *model = self.materialOutgoingOrderDetailVoArray[indexPath.row];
    cell.label0.text = model.outgoingOrderNum;
    cell.label1.text = model.materialText;
    cell.label2.text = model.actualQuantity.stringValue;
    cell.label3.text = model.rejectedQuantity.stringValue;
    cell.textField.text = model.rejectedQuantityDyz.stringValue;
    
    [cell.textField addTarget:self action:@selector(textFieldChangeValuedyz:) forControlEvents:UIControlEventEditingChanged];
    cell.textField.tag = indexPath.row;
    cell.textField.inputAccessoryView = [self addToolbar];
    
    return cell;
}

- (void)textFieldChangeValuedyz:(UITextField *)sender {
    MaterialOutgoingOrderDetailVo *model = self.materialOutgoingOrderDetailVoArray[sender.tag];
    if (sender.text.doubleValue > (model.actualQuantity.doubleValue - model.rejectedQuantity.doubleValue)) {
        model.rejectedQuantityDyz = [NSNumber numberWithDouble:(model.actualQuantity.doubleValue - model.rejectedQuantity.doubleValue)];
        sender.text = [NSNumber numberWithDouble:(model.actualQuantity.doubleValue - model.rejectedQuantity.doubleValue)].stringValue;
    } else {
        model.rejectedQuantityDyz = [NSNumber numberWithDouble:sender.text.doubleValue];
    }
    NSLog(@"---%@---",sender.text);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textFieldSearch resignFirstResponder];
    [self.textFieldReasonForReturn resignFirstResponder];
}



- (IBAction)selectButtonClick:(id)sender {
    self.selectButtonView.hidden = false;
}

- (IBAction)selectButtonTypeClick:(UIButton *)sender {
    if (sender.tag == 0) {
        self.labelReturnType.text = @"返修";
        _returnTypeIndex = 0;
    } else if (sender.tag == 1) {
        self.labelReturnType.text = @"报废";
        _returnTypeIndex = 1;
    } else if (sender.tag == 2) {
        self.labelReturnType.text = @"送错";
        _returnTypeIndex = 2;
    } else if (sender.tag == 3) {
        self.labelReturnType.text = @"其他";
        _returnTypeIndex = 3;
    }
    self.selectButtonView.hidden = true;
}



#pragma mark 扫描
- (IBAction)buttonScan:(id)sender {
    SaoYiSaoVC *vc = [[SaoYiSaoVC alloc] init];
    vc.scanTitle = @"扫工序流转卡或条码标签";
    vc.resultBlock = ^(NSString *result) {
        self.textFieldSearch.text = result;
        [self request:result];
    };
    [self presentViewController:vc animated:true completion:nil];
}

- (void)request:(NSString *)result {
    _viewLoading.hidden = NO;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    MaterialOutgoingOrderDetailVo *materialOutgoingOrderDetailVo = [[MaterialOutgoingOrderDetailVo alloc] init];
    materialOutgoingOrderDetailVo.siteCode = userInfo.siteCode;
    materialOutgoingOrderDetailVo.productionControlNum = result;
    postEntityBean.entity = materialOutgoingOrderDetailVo.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_mes_materialOutgoingOrder_getMaterialOutgoingOrderByProductionControlNum parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.viewZhong0.hidden = true;
            self.viewBottom0.hidden = true;
            self.viewZhong1.hidden = true;
            self.viewBottom1.hidden = true;
            
            self.materialOutgoingOrderDetailVoArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dicTemp in returnListBean.list) {
                MaterialOutgoingOrderDetailVo *vo = [MaterialOutgoingOrderDetailVo mj_objectWithKeyValues:dicTemp];
                [self.materialOutgoingOrderDetailVoArray addObject:vo];
            }
            
            if (self.materialOutgoingOrderDetailVoArray.count == 0) {
                self.viewZhong0.hidden = NO;
                self.viewBottom0.hidden = NO;
            } else {
                self.viewZhong1.hidden = NO;
                self.viewBottom1.hidden = NO;
            }
            [self.tableView reloadData];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = true;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    
}

#pragma mark 提交
- (IBAction)buttonCommit:(id)sender {
    _viewLoading.hidden = NO;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    
    for (MaterialOutgoingOrderDetailVo *bean in self.materialOutgoingOrderDetailVoArray) {
        if (!bean.rejectedQuantityDyz) {
            bean.rejectedQuantity = [NSNumber numberWithInt:0];
        } else {
            bean.rejectedQuantity = bean.rejectedQuantityDyz;
        }
        bean.remark = self.textFieldReasonForReturn.text;
        bean.status = [NSNumber numberWithInteger:_returnTypeIndex];
        bean.modifyUser = userInfo.userCode;
    }

    postEntityBean.entity = self.materialOutgoingOrderDetailVoArray.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_mes_materialOutgoingOrder_backMaterialOutgoingOrderByProductionControlNum parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [self.navigationController popViewControllerAnimated:true];
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"退货成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = true;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)setAttributedString:(NSString *)text {
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:colorRGB(0, 122, 254) range:NSMakeRange(5, text.length-9)];
    self.label.attributedText = attributeStr;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
