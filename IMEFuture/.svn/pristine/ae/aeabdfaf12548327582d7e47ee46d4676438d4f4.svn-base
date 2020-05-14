//
//  XinZengShouHuoDiZhiVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/1/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "XinZengShouHuoDiZhiVC.h"
#import "VoHeader.h"

#import "Masonry.h"


@interface XinZengShouHuoDiZhiVC () <UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    UITextField *_textField0;//收货人
    UITextField *_textField1;//手机号
    UITextField *_textField2;//座机号码
    UITextField *_textField3;//邮政编码
    UITextField *_textField4;//收货地址
    UITextView *_textView;//请填写详细地址
    UISwitch *_switch1;//设为默认地址
    
    NSMutableArray *_arrayZone0;
    NSMutableArray *_arrayZone1;
    NSMutableArray *_arrayZone2;
    NSInteger _indexArrayZone0;//默认值999
    NSInteger _indexArrayZone1;//默认值999
    NSInteger _indexArrayZone2;//默认值999
    
    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *view0;//收货人
@property (nonatomic,strong) UIView *view1;//手机号
@property (nonatomic,strong) UIView *view2;//座机号码
@property (nonatomic,strong) UIView *view3;//邮政编码
@property (nonatomic,strong) UIView *view4;//收货地址
@property (nonatomic,strong) UIView *view5;//请填写详细地址
@property (nonatomic,strong) UIView *view6;//设为默认地址

@property (weak, nonatomic) IBOutlet UIView *viewPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation XinZengShouHuoDiZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    _indexArrayZone0 = 999;
    _indexArrayZone1 = 999;
    _indexArrayZone2 = 999;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    _viewPicker.hidden = YES;
    _viewPicker.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    _arrayZone0 = [DatabaseTool t_ZoneSelectArrayWithMyid:[NSNumber numberWithInteger:1]];
    
    Zone *zone0 = _arrayZone0[0];
    _arrayZone1 = [DatabaseTool t_ZoneSelectArrayWithMyid:zone0.Myid];
    
    Zone *zone1 = _arrayZone1[0];
    _arrayZone2 = [DatabaseTool t_ZoneSelectArrayWithMyid:zone1.Myid];
    
    UITapGestureRecognizer *tapCancel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureCancel:)];
    [_viewPicker addGestureRecognizer:tapCancel];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.view0];
    [self.scrollView addSubview:self.view1];
    [self.scrollView addSubview:self.view2];
    [self.scrollView addSubview:self.view3];
    [self.scrollView addSubview:self.view4];
    [self.scrollView addSubview:self.view5];
    [self.scrollView addSubview:self.view6];
    
    self.scrollView.contentSize = CGSizeMake(kMainW, CGRectGetMaxY(self.view6.frame));
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self.view bringSubviewToFront:_viewPicker];
    
    _textField0.text = self.enterpriseAddressBean.name;
    _textField1.text = self.enterpriseAddressBean.phone;
    _textField2.text = self.enterpriseAddressBean.tel;
    _textField3.text = self.enterpriseAddressBean.zipcode;
    _textField4.text = self.enterpriseAddressBean.zoneStr;
    _textView.text = self.enterpriseAddressBean.address;
    
    if ([self.enterpriseAddressBean.isDefault integerValue] == 1) {
        _switch1.on = YES;
    } else {
        _switch1.on = NO;
    }
    
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (rect.origin.y == kMainH) {
        
        self.scrollView.frame = CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-_height_TabBar);
    } else {
        
        self.scrollView.frame = CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-rect.size.height);
    }
}

#pragma mark 保存
- (IBAction)buttonBaoCun:(UIButton *)sender {
    
    
    
    if (_textField0.text.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请填写收货人"];
        return;
    } else if (_textField0.text.length > 0) {
        if (_textField0.text.length > 11) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"长度不超过10个字符"];
            return;
        }
    }
    if (_textField1.text.length == 0 && _textField2.text.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"手机号、座机号码必填一项"];
        return;
    } else if (_textField1.text.length > 0 && _textField2.text.length == 0) {
        if (_textField1.text.length != 11) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"手机号格式不对"];
            return;
        }
    } else if (_textField1.text.length == 0 && _textField2.text.length > 0) {
    
    }
    
    if (_textField4.text.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择省市区"];
        return;
    }
    
    if (_textView.text.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请填写详细地址"];
        return;
    }
    
    _viewLoading.hidden = NO;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    EnterpriseAddressBean *enterpriseAddressBean = [[EnterpriseAddressBean alloc] init];
    enterpriseAddressBean.enterpriseId = loginModel.enterpriseId;
    
    enterpriseAddressBean.name = _textField0.text;//收货人
    enterpriseAddressBean.phone = _textField1.text;//手机号
    enterpriseAddressBean.tel = _textField2.text;//座机号码
    enterpriseAddressBean.zipcode = _textField3.text;//邮政编号
    
    Zone *zone0;
    Zone *zone1;
    Zone *zone2;
    if (_indexArrayZone1 == 999) {//没有滚动过pickerView
        zone0 = _arrayZone0[0];
        zone1 = _arrayZone1[0];
        zone2 = _arrayZone2[0];
    } else {
        zone0 = _arrayZone0[_indexArrayZone0];
        zone1 = _arrayZone1[_indexArrayZone1];
        zone2 = _arrayZone2.count==0?nil:_arrayZone2[_indexArrayZone2];
    }
    
    if (_textField4.text.length > 0) {
        enterpriseAddressBean.zoneId1 = [zone0.Myid stringValue];
        enterpriseAddressBean.zoneId2 = [zone1.Myid stringValue];
        if (zone2) {
            enterpriseAddressBean.zoneId3 = [zone2.Myid stringValue];
        }
        enterpriseAddressBean.zoneStr = _textField4.text;//收货地址
    }
    
    enterpriseAddressBean.address = _textView.text;//详细地址
    
    if (_switch1.on == YES) {//设置默认地址
        enterpriseAddressBean.isDefault = [NSNumber numberWithInteger:1];
    } else {
        enterpriseAddressBean.isDefault = [NSNumber numberWithInteger:0];
    }
    
    if (self.isEdit == 1) {//编辑
        enterpriseAddressBean.addressId = self.enterpriseAddressBean.addressId;
        enterpriseAddressBean.telZip = self.enterpriseAddressBean.telZip;
        enterpriseAddressBean.extension = self.enterpriseAddressBean.extension;
        if (_indexArrayZone1 == 999) {
            enterpriseAddressBean.zoneId1 = self.enterpriseAddressBean.zoneId1;
            enterpriseAddressBean.zoneId2 = self.enterpriseAddressBean.zoneId2;
            enterpriseAddressBean.zoneId3 = self.enterpriseAddressBean.zoneId3;
            enterpriseAddressBean.zoneStr = self.enterpriseAddressBean.zoneStr;
        }
    } else {//添加
        
    }
    
    postEntityBean.entity = enterpriseAddressBean.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    
    NSString *urlString;
    if (self.isEdit == 1) {//编辑
        urlString = DYZ_enterpriseAddress_updateEnterpriseAddress;
    } else {
        urlString = DYZ_enterpriseAddress_addEnterpriseAddress;
    }
    
    [HttpMamager postRequestWithURLString:urlString parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = YES;
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)textField4ShowPickView:(UITextField *)textField {
    _viewPicker.hidden = NO;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-_height_TabBar)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

- (IBAction)buttonCancel:(id)sender {
    _viewPicker.hidden = YES;
    [_textField4 resignFirstResponder];
}

- (void)tapGestureCancel:(UITapGestureRecognizer *)tap {
    _viewPicker.hidden = YES;
    [_textField4 resignFirstResponder];
}

- (IBAction)buttonFinish:(id)sender {
    _viewPicker.hidden = YES;
    [_textField4 resignFirstResponder];
    Zone *zone0;
    Zone *zone1;
    Zone *zone2;
    if (_indexArrayZone1 == 999) {//没有滚动过pickerView
        zone0 = _arrayZone0[0];
        zone1 = _arrayZone1[0];
        zone2 = _arrayZone2[0];
        _textField4.text = [NSString stringWithFormat:@"%@ %@ %@",zone0.name,zone1.name,zone2.name];
    } else {
        zone0 = _arrayZone0[_indexArrayZone0];
        zone1 = _arrayZone1[_indexArrayZone1];
        if (_arrayZone2.count == 0) {
            _textField4.text = [NSString stringWithFormat:@"%@ %@",zone0.name,zone1.name];
        } else {
            zone2 = _arrayZone2[_indexArrayZone2];
            _textField4.text = [NSString stringWithFormat:@"%@ %@ %@",zone0.name,zone1.name,zone2.name];
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _arrayZone0?_arrayZone0.count:0;
    }
    if (component == 1) {
        return _arrayZone1?_arrayZone1.count:0;
    }
    if (component == 2) {
        return _arrayZone2?_arrayZone2.count:0;
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        Zone *zone0 = _arrayZone0[row];
        
        _arrayZone1 = [DatabaseTool t_ZoneSelectArrayWithMyid:zone0.Myid];
        [pickerView reloadComponent:1];
        
        Zone *zone1 = _arrayZone1[0];
        _arrayZone2 = [DatabaseTool t_ZoneSelectArrayWithMyid:zone1.Myid];
        [pickerView reloadComponent:2];
    }
    if (component == 1) {
        Zone *zone1 = _arrayZone1[row];
        _arrayZone2 = [DatabaseTool t_ZoneSelectArrayWithMyid:zone1.Myid];
        
        [pickerView reloadComponent:2];
    }
    
    _indexArrayZone0 = [pickerView selectedRowInComponent:0];
    _indexArrayZone1 = [pickerView selectedRowInComponent:1];
    _indexArrayZone2 = [pickerView selectedRowInComponent:2];
    NSLog(@"_indexArrayZone0:%ld _indexArrayZone1:%ld _indexArrayZone2:%ld",_indexArrayZone0,_indexArrayZone1,_indexArrayZone2);
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        Zone *zone0 = _arrayZone0[row];
        return zone0.name;
    }
    if (component == 1) {
        Zone *zone1 = _arrayZone1[row];
        return zone1.name;
    }
    if (component == 2) {
        Zone *zone2 = _arrayZone2[row];
        return zone2.name;
    }
    return @"";
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
//        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        pickerLabel.textColor = colorRGB(51, 51, 51);
        pickerLabel.numberOfLines = 0;
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (UIView *)view0 {
    if (!_view0) {
        _view0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.bounds.size.width, 44.5)];
        _view0.backgroundColor = [UIColor whiteColor];
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 0)];
        label.text = @"收货人";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view0 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 1, kMainW-100-15, 42.5)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"长度不超过10个字符";
        textField.inputAccessoryView = [self addToolbar];
        [_view0 addSubview:textField];
        _textField0 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 44, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view0 addSubview:viewLine];
    }
    return _view0;
}

- (UIView *)view1 {
    if (!_view1) {
        _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view0.frame), self.scrollView.bounds.size.width, 44.5)];
        _view1.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 0)];
        label.text = @"手机号";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view1 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 1, kMainW-100-15, 42.5)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"手机号、座机号码必填一项";
        textField.inputAccessoryView = [self addToolbar];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [_view1 addSubview:textField];
        _textField1 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 44, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view1 addSubview:viewLine];
    }
    return _view1;
}

- (UIView *)view2 {
    if (!_view2) {
        _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view1.frame), self.scrollView.bounds.size.width, 44.5)];
        _view2.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 0)];
        label.text = @"座机号码";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view2 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 1, kMainW-100-15, 42.5)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"手机号、座机号码必填一项";
        textField.inputAccessoryView = [self addToolbar];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [_view2 addSubview:textField];
        _textField2 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 44, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view2 addSubview:viewLine];
    }
    return _view2;
}

- (UIView *)view3 {
    if (!_view3) {
        _view3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view2.frame), self.scrollView.bounds.size.width, 44.5)];
        _view3.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 0)];
        label.text = @"邮政编码";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view3 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 1, kMainW-100-15, 42.5)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"请填写邮政编码";
        textField.inputAccessoryView = [self addToolbar];
        [_view3 addSubview:textField];
        _textField3 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 44, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view3 addSubview:viewLine];
    }
    return _view3;
}

- (UIView *)view4 {
    if (!_view4) {
        _view4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view3.frame), self.scrollView.bounds.size.width, 44.5)];
        _view4.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 0)];
        label.text = @"收货地址";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view4 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 1, kMainW-100-15, 42.5)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"省、市、区";
        textField.inputView = [[UIView alloc]initWithFrame:CGRectZero];
        [textField addTarget:self action:@selector(textField4ShowPickView:) forControlEvents:UIControlEventEditingDidBegin];
        [_view4 addSubview:textField];
        _textField4 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 44, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view4 addSubview:viewLine];
    }
    return _view4;
}

- (UIView *)view5 {
    if (!_view5) {
        _view5 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view4.frame), self.scrollView.bounds.size.width, 77.5)];
        _view5.backgroundColor = [UIColor whiteColor];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, kMainW-30, 77.5-13.5-5)];
        textView.font = [UIFont systemFontOfSize:14];
        textView.textColor = colorRGB(51, 51, 51);
        textView.inputAccessoryView = [self addToolbar];
        
        UILabel *label = [UILabel new];
        label.font = textView.font;
        label.text = @"请填写详细地址";
        label.numberOfLines = 0;
        label.textColor = colorRGB(204, 204, 204);
        [label sizeToFit];
        [textView addSubview:label];
        
        [textView setValue:label forKey:@"_placeholderLabel"];
        _textView = textView;
        
        [_view5 addSubview:textView];
        
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 77, kMainW, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view5 addSubview:viewLine];
    }
    return _view5;
}


- (UIView *)view6 {
    if (!_view6) {
        _view6 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view5.frame)+10, self.scrollView.bounds.size.width, 44.5)];
        _view6.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 0)];
        label.text = @"设为默认地址";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view6 addSubview:label];
        
        UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake(kMainW-51-15, 6, 51, 33)];
        [switch1 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [_view6 addSubview:switch1];
        _switch1 = switch1;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view6 addSubview:viewLine];
        
        UIView *viewLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kMainW, 0.5)];
        viewLine1.backgroundColor = colorRGB(204, 204, 204);
        [_view6 addSubview:viewLine1];
    
    }
    return _view6;
}

- (void)switchAction:(UISwitch *)sender {
    NSLog(@"%s",__FUNCTION__);
    BOOL isButtonOn = [sender isOn];
    if (isButtonOn) {
        NSLog(@"开");
        self.enterpriseAddressBean.isDefault = [NSNumber numberWithInteger:1];
    } else {
        NSLog(@"关");
        self.enterpriseAddressBean.isDefault = [NSNumber numberWithInteger:0];
    }
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
