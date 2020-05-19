//
//  LogisticsInformationVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/3/13.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "LogisticsInformationVC.h"
#import "VoHeader.h"

#import "DingDanXiangQingGongViewController.h"

@interface LogisticsInformationVC () <UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate,UITextViewDelegate> {

    
    NSArray *_arrayData;
    NSString *_stringTemp;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UIButton *btnCommit;

@property (weak, nonatomic) IBOutlet UILabel *labelCompanyName;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view20;


@property (weak, nonatomic) IBOutlet UIView *view21;
@property (weak, nonatomic) IBOutlet UITextField *textField21;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1distance3;

@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextView *textView3;
@property (strong,nonatomic) UILabel *labelTextView;


@property (weak, nonatomic) IBOutlet UIView *pickerViewBG;
@property (weak, nonatomic) IBOutlet UIView *pickerViewbg;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation LogisticsInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    
//    textfield 输入中文时文字会下沉
//    在xib里面设置为默认有边框的，然后再在代码里面设为无边框的
    self.textField21.borderStyle = UITextBorderStyleNone;
    self.textField3.borderStyle = UITextBorderStyleNone;
    
    self.labelTextView = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, CGRectGetWidth(self.textField3.frame), 17)];
    self.labelTextView.font = [UIFont systemFontOfSize:17];
    self.labelTextView.textColor = colorRGB(177, 177, 177);
    self.labelTextView.text = @"需要备注，请在此说明";
    [self.textView3 addSubview:self.labelTextView];
    
    self.textView3.delegate = self;
    
    
    _arrayData = @[@"SF",@"DB",@"YT",@"ZT",@"ST",@"YD",@"XX",@"QT"];
    _stringTemp = _arrayData[0];
    
    self.labelCompanyName.text = [NSString LogisticsEnum:_stringTemp];
    
    UITapGestureRecognizer *tapGestureKeyboardDown = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureKeyboardDown:)];
    [self.view addGestureRecognizer:tapGestureKeyboardDown];
    
    self.pickerView.delegate = self;
    
    self.pickerViewBG.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureCancel:)];
    tapGesture.delegate = self;
    [self.pickerViewBG addGestureRecognizer:tapGesture];
    
    self.view20.hidden = NO;
    self.view21.hidden = YES;
    self.pickerViewBG.hidden = YES;
    
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.labelTextView.hidden = YES;
    } else {
        self.labelTextView.hidden = NO;
    }
}

- (void)tapGestureKeyboardDown:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (IBAction)commit:(id)sender {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    TradeOrder *tradeOrder = [[TradeOrder alloc] init];
    tradeOrder.orderCode = self.orderCode;
    tradeOrder.supplierEnterpriseId = loginModel.enterpriseId;
    
    tradeOrder.logisticsCompanyKey = _stringTemp;
    if ([_stringTemp isEqualToString:@"QT"]) {
        if (self.textField21.text.length == 0) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请填写物流公司"];
            return;
        }
        tradeOrder.logisticsCompany = self.textField21.text;
    } else{
        tradeOrder.logisticsCompany = self.labelCompanyName.text;
    }
    
    if ([_stringTemp isEqualToString:@"XX"]) {
        tradeOrder.logisticsNo = self.textField3.text;
    } else{
        if (self.textField3.text.length == 0) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请填运单号"];
            return;
        }
        tradeOrder.logisticsNo = self.textField3.text;
    }
    
    tradeOrder.logisticsRemark = self.textView3.text;
    
    postEntityBean.entity = tradeOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_tradeOrder_supplierDelivere parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"确认成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"确认失败"];
        }
        
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isMemberOfClass:[DingDanXiangQingGongViewController class]]) {
                DingDanXiangQingGongViewController *dingVC = (DingDanXiangQingGongViewController *)vc;
                dingVC.orderId = self.orderId;
            }
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshEGOrder" object:nil userInfo:nil];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)selectLogistics:(id)sender {
    self.pickerViewBG.hidden = NO;
}

- (IBAction)buttonQuXiao:(UIButton *)sender {
    self.pickerViewBG.hidden = YES;
}

- (void)tapGestureCancel:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    self.pickerViewBG.hidden = YES;
}

- (IBAction)buttonWanCheng:(UIButton *)sender {
    self.pickerViewBG.hidden = YES;
   
    self.labelCompanyName.text = [NSString LogisticsEnum:_stringTemp];
    
    if ([_stringTemp isEqualToString:@"SF"]) {
        self.view20.hidden = NO;
        self.view21.hidden = YES;
        self.view1distance3.constant = CGRectGetHeight(self.view20.frame)+10;
    } else if ([_stringTemp isEqualToString:@"QT"]) {
        self.view20.hidden = YES;
        self.view21.hidden = NO;
        self.view1distance3.constant = CGRectGetHeight(self.view21.frame)+10;
    } else{
        self.view20.hidden = YES;
        self.view21.hidden = YES;
        self.view1distance3.constant = 0;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString LogisticsEnum:_arrayData[row]];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arrayData.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _stringTemp = _arrayData[row];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.pickerViewbg]) {
        return NO;
    }
    return YES;
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
