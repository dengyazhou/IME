//
//  TiWenViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "TiWenViewController.h"
#import "VoHeader.h"


@interface TiWenViewController () <UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    UILabel *_labelTextView;
    NSMutableArray <__kindof InquiryOrderItem *> *_inquiryOrderItems;
    NSMutableArray *_arrayXuanZeLingJian;
    NSString *_partNameTmp;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation TiWenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [self initUI];
}

- (void)initUI {
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, 0.5)];
    labelLine.backgroundColor = colorRGB(221, 221, 221);
    [self.view addSubview:labelLine];
    
    UILabel *labelLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, _height_NavBar+46-0.5, kMainW, 0.5)];
    labelLine1.backgroundColor = colorRGB(221, 221, 221);
    [self.view addSubview:labelLine1];
    
    
    self.textViewTiWen.delegate = self;
    
    _labelTextView = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, kMainW-20, 17)];
    _labelTextView.font = [UIFont systemFontOfSize:17];
    _labelTextView.textColor = colorRGB(177, 177, 177);
    _labelTextView.text = @"请输入要询问的问题";
    [_textViewTiWen addSubview:_labelTextView];
    
    _inquiryOrderItems = self.inquiryOrder.inquiryOrderItems;

    _partNameTmp = _inquiryOrderItems[0].partName;
    if (_inquiryOrderItems.count == 1) {
        self.labelXuanZeYaoTiWenDeLingJian.text = _partNameTmp;
        self.labelXunZeYaoTiWenDeLingJianTrailing.constant = 10;
        self.imageViewNext.hidden = YES;
    }
    
    
    self.viewPickView0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH)];
    self.viewPickView0.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
    [self.view addSubview:self.viewPickView0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [self.viewPickView0 addGestureRecognizer:tap];
    
    self.viewPickView1 = [[UIView alloc] initWithFrame:CGRectMake(0, kMainH-250, kMainW, 250)];
    self.viewPickView1.backgroundColor = colorRGB(241, 241, 241);
    [self.view addSubview:self.viewPickView1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainW, 40)];
    label.text = @"请选择零件";
    label.textAlignment = NSTextAlignmentCenter;
    [self.viewPickView1 addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(kMainW - 80, 0, 80, 40);
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonOK:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewPickView1 addSubview:button];
    
    _arrayXuanZeLingJian = [[NSMutableArray alloc] initWithCapacity:0];
    for (InquiryOrderItem *inquiryOrderItem in _inquiryOrderItems) {
        [_arrayXuanZeLingJian addObject:inquiryOrderItem.partName];
    }
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, kMainW, CGRectGetHeight(self.viewPickView1.frame)-40)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [self.viewPickView1 addSubview:self.pickerView];
    self.viewPickView0.hidden = YES;
    self.viewPickView1.hidden = YES;
    
}

- (void)tapSelector:(UITapGestureRecognizer *)tap {
    self.viewPickView0.hidden = YES;
    self.viewPickView1.hidden = YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        _labelTextView.hidden = YES;
    } else {
        _labelTextView.hidden = NO;
    }
}
- (IBAction)buttonClickXuanZelingjian:(UIButton *)sender {
    
    //[self.pickerView resignFirstResponder];
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
    
    if (_inquiryOrderItems.count != 1) {
        self.viewPickView0.hidden = NO;
        self.viewPickView1.hidden = NO;
    }
}
- (IBAction)buttonTiJiao:(UIButton *)sender {
    
    if ([self.labelXuanZeYaoTiWenDeLingJian.text isEqualToString:@"选择需要提问的零件"]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择零件"];
        return;
    }
    if (_textViewTiWen.text.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入内容"];
        return;
    }

    
    NSInteger row = [self.pickerView selectedRowInComponent:0];    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    InquiryOrderQA *inquiryOrderQA = [[InquiryOrderQA alloc] init];
    inquiryOrderQA.inquiryOrderId = self.inquiryOrder.inquiryOrderId;
    inquiryOrderQA.inquiryOrderItemId = _inquiryOrderItems[0].inquiryOrderItemId;//需要选择的

    inquiryOrderQA.partName = _partNameTmp;
    inquiryOrderQA.lineNumber = _inquiryOrderItems[row].lineNumber;//需要选择的
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    inquiryOrderQA.memberId = loginModel.memberId;
    inquiryOrderQA.content = _textViewTiWen.text;
    inquiryOrderQA.qaType = [NSNumber numberWithInteger:0];
    postEntityBean.entity = inquiryOrderQA.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
//    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_qa_add parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        [self.navigationController popViewControllerAnimated:YES];
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"问题成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"问题失败"];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arrayXuanZeLingJian.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _arrayXuanZeLingJian[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _partNameTmp = _arrayXuanZeLingJian[row];
}
- (void)buttonOK:(UIButton *)sender {
    self.viewPickView0.hidden = YES;
    self.viewPickView1.hidden = YES;
    self.labelXuanZeYaoTiWenDeLingJian.text = _partNameTmp;
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
