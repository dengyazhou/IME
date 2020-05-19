//
//  ECAddSupplierVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/6/29.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ECAddSupplierVC.h"
#import "VoHeader.h"

#import "ECAddSupplierCell.h"
#import "ECSupplierAddLabelVC.h"

@interface ECAddSupplierVC () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate> {
    NSMutableArray * _arrayEnterpriseInfoModel;
    NSInteger _aPage;
    
    UITextField *_textField0;//公司名称
    UITextField *_textField1;//联系人
    UITextField *_textField2;//职位
    UITextField *_textField3;//手机
    UITextField *_textField4;//邮箱
    UITextField *_textField5;//地区
    UITextField *_textField6;
    UITextField *_textField7;
    UITextField *_textField8;//备注
    
    NSMutableArray *_arrayZone0;
    NSMutableArray *_arrayZone1;
    NSMutableArray *_arrayZone2;
    NSInteger _indexArrayZone0;//默认值999
    NSInteger _indexArrayZone1;//默认值999
    NSInteger _indexArrayZone2;//默认值999
    
    UIView *_viewLoading1;//透明
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *view0;//公司名称
@property (nonatomic,strong) UIView *view1;//联系人
@property (nonatomic,strong) UIView *view2;//职位
@property (nonatomic,strong) UIView *view3;//手机
@property (nonatomic,strong) UIView *view4;//邮箱
@property (nonatomic,strong) UIView *view5;//地区
@property (nonatomic,strong) UIView *view6;
@property (nonatomic,strong) UIView *view7;
@property (nonatomic,strong) UIView *view8;//备注
@property (nonatomic,strong) UIView *view9;//添加供应商标签
@property (nonatomic,strong) UIView *view10;//标签

@property (nonatomic,strong) NSMutableArray *arrayLabel;
@property (nonatomic,strong) NSMutableArray *arrayTGSupplierTag;

@property (nonatomic,strong) UITableView *tableView;


@property (weak, nonatomic) IBOutlet UIView *viewPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation ECAddSupplierVC

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
    [self.scrollView addSubview:self.view7];
    [self.scrollView addSubview:self.view8];
    [self.scrollView addSubview:self.view9];
    [self.scrollView addSubview:self.view10];
    
    if (CGRectGetMaxY(self.view10.frame)+_height_NavBar > kMainH) {
        self.scrollView.contentSize = CGSizeMake(kMainW, CGRectGetMaxY(self.view10.frame));
    } else {
        self.scrollView.contentSize = CGSizeMake(kMainW, kMainH-_height_NavBar);
    }
    
    [self.scrollView addSubview:self.tableView];
    self.tableView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewLabel)];
    tap.delegate = self;
    [self.scrollView addGestureRecognizer:tap];
    
    _viewLoading1 = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    _viewLoading1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewLoading1];
    _viewLoading1.hidden = YES;
    
    [self.view bringSubviewToFront:_viewPicker];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

- (void)tapViewLabel {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (rect.origin.y == kMainH) {
        
        self.scrollView.frame = CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar);
    } else {
        
        self.scrollView.frame = CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-rect.size.height);
    }
}

- (NSMutableArray *)arrayLabel {
    if (!_arrayLabel) {
        _arrayLabel = [NSMutableArray arrayWithCapacity:0];
    }
    return _arrayLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view0.frame), kMainW, self.scrollView.contentSize.height) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"ECAddSupplierCell" bundle:nil] forCellReuseIdentifier:@"eCAddSupplierCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        self.tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayEnterpriseInfoModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ECAddSupplierCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eCAddSupplierCell" forIndexPath:indexPath];
    EnterpriseInfo *enterpriseInfoModel = _arrayEnterpriseInfoModel[indexPath.row];
    cell.labelName.text = enterpriseInfoModel.enterpriseName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.hidden = YES;
    
    EnterpriseInfo *enterpriseInfoModel = _arrayEnterpriseInfoModel[indexPath.row];
    _textField0.text = enterpriseInfoModel.enterpriseName;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
//        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (IBAction)buttonCancel:(UIButton *)sender {
    _viewPicker.hidden = YES;
    [_textField5 resignFirstResponder];
}
- (void)tapGestureCancel:(UITapGestureRecognizer *)tap {
    _viewPicker.hidden = YES;
    [_textField5 resignFirstResponder];
}
- (IBAction)buttonFinish:(UIButton *)sender {
    _viewPicker.hidden = YES;
    [_textField5 resignFirstResponder];
    Zone *zone0;
    Zone *zone1;
    Zone *zone2;
    if (_indexArrayZone1 == 999) {//没有滚动过pickerView
        zone0 = _arrayZone0[0];
        zone1 = _arrayZone1[0];
        zone2 = _arrayZone2[0];
        _textField5.text = [NSString stringWithFormat:@"%@ %@ %@",zone0.name,zone1.name,zone2.name];
    } else {
        zone0 = _arrayZone0[_indexArrayZone0];
        zone1 = _arrayZone1[_indexArrayZone1];
        if (_arrayZone2.count == 0) {
            _textField5.text = [NSString stringWithFormat:@"%@ %@",zone0.name,zone1.name];
        } else {
            zone2 = _arrayZone2[_indexArrayZone2];
            _textField5.text = [NSString stringWithFormat:@"%@ %@ %@",zone0.name,zone1.name,zone2.name];
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

- (IBAction)left:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)right:(id)sender {
    if (_textField0.text.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"公司名为空"];
        return;
    }
    if (_textField1.text.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"联系人为空"];
        return;
    }
//    if (_textField2.text.length == 0) {
//        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"职位为空"];
//        return;
//    }
    if (_textField3.text.length != 11) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"手机号格式不对"];
        return;
    }
//    if (!([_textField4.text containsString:@"@"] && [_textField4.text containsString:@".com"])) {
//        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"邮箱格式不对"];
//        return;
//    }
    if (_textField6.text.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"供应商编号为空"];
        return;
    }
    _viewLoading1.hidden = NO;
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];

    postEntityBean.memberId= [GlobalSettingManager shareGlobalSettingManager].memberId;
    
    EnterpriseRelation *enterpriseRelation = [[EnterpriseRelation alloc] init];
    enterpriseRelation.initiatorId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;//必填
    enterpriseRelation.temporaryEnterpriseName = _textField0.text;
    enterpriseRelation.erpEnterpriseNo = _textField6.text;//必填
    enterpriseRelation.temporaryContacts = _textField1.text;//必填
    enterpriseRelation.temporaryPhoneNumber = _textField3.text;//必填
    enterpriseRelation.temporaryEmailAddress = _textField4.text;
    enterpriseRelation.temporaryPosition = _textField2.text;
    enterpriseRelation.payTerm = _textField7.text;
    
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
    
    if (_textField5.text.length > 0) {
        enterpriseRelation.temporaryZoneId1 = zone0.name;
        enterpriseRelation.temporaryZoneId2 = zone1.name;
        if (zone2) {
            enterpriseRelation.temporaryZoneId3 = zone2.name;
        }
        enterpriseRelation.temporaryZoneStr = _textField5.text;
    }
    
    enterpriseRelation.tagList = self.arrayTGSupplierTag;
    
    enterpriseRelation.remark = _textField8.text;
    
    postEntityBean.entity = enterpriseRelation.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_epRelation_addTrustRelation parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
//        NSLog(@"%@",returnMsgBean.returnCode);
        
        _viewLoading1.hidden = YES;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            if ([returnMsgBean.returnCode integerValue] == -4) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"已添加过该供应商"];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"添加失败"];
            }
        }
        
    } fail:^(NSError *error) {
        _viewLoading1.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}


- (UIView *)view0 {
    if (!_view0) {
        _view0 = [[UIView alloc] initWithFrame:CGRectMake(0, 15, self.scrollView.bounds.size.width, 55)];
        _view0.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 0, 0)];
        imageView.image = [UIImage imageNamed:@"ime-Asterisk"];
        [imageView sizeToFit];
        [_view0 addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMinX(imageView.frame)+3, 0, 0)];
        label.text = @"公司名称";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view0 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(135, 1, kMainW-135-15, 53)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"请填写公司名称";
        [_view0 addSubview:textField];
        [textField addTarget:self action:@selector(textField0EditingChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField0 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 54, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view0 addSubview:viewLine];
    }
    return _view0;
}

- (UIView *)view1 {
    if (!_view1) {
        _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view0.frame), self.scrollView.bounds.size.width, 55)];
        _view1.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 0, 0)];
        imageView.image = [UIImage imageNamed:@"ime-Asterisk"];
        [imageView sizeToFit];
        [_view1 addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMinX(imageView.frame)+3, 0, 0)];
        label.text = @"联系人";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view1 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(135, 1, kMainW-135-15, 53)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"请填写联系人";
        [_view1 addSubview:textField];
        _textField1 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 54, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view1 addSubview:viewLine];
    }
    return _view1;
}

- (UIView *)view2 {
    if (!_view2) {
        _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view1.frame), self.scrollView.bounds.size.width, 55)];
        _view2.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 0, 0)];
        imageView.image = [UIImage imageNamed:@"ime-Asterisk"];
        [imageView sizeToFit];
        [_view2 addSubview:imageView];
        imageView.hidden = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMinX(imageView.frame)+3, 0, 0)];
        label.text = @"职位";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view2 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(135, 1, kMainW-135-15, 53)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"请填写职位";
        [_view2 addSubview:textField];
        _textField2 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 54, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view2 addSubview:viewLine];
    }
    return _view2;
}

- (UIView *)view3 {
    if (!_view3) {
        _view3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view2.frame), self.scrollView.bounds.size.width, 55)];
        _view3.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 0, 0)];
        imageView.image = [UIImage imageNamed:@"ime-Asterisk"];
        [imageView sizeToFit];
        [_view3 addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMinX(imageView.frame)+3, 0, 0)];
        label.text = @"手机";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view3 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(135, 1, kMainW-135-15, 53)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"请填写手机";
        [_view3 addSubview:textField];
        _textField3 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 54, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view3 addSubview:viewLine];
    }
    return _view3;
}

- (UIView *)view4 {
    if (!_view4) {
        _view4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view3.frame), self.scrollView.bounds.size.width, 55)];
        _view4.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 0, 0)];
        imageView.image = [UIImage imageNamed:@"ime-Asterisk"];
        [imageView sizeToFit];
        [_view4 addSubview:imageView];
        imageView.hidden = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMinX(imageView.frame)+3, 0, 0)];
        label.text = @"邮箱";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view4 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(135, 1, kMainW-135-15, 53)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"请填写邮箱";
        [_view4 addSubview:textField];
        _textField4 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 54, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view4 addSubview:viewLine];
    }
    return _view4;
}

- (UIView *)view5 {
    if (!_view5) {
        _view5 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view4.frame), self.scrollView.bounds.size.width, 55)];
        _view5.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 0, 0)];
        imageView.image = [UIImage imageNamed:@"ime-Asterisk"];
        [imageView sizeToFit];
        [_view5 addSubview:imageView];
        imageView.hidden = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMinX(imageView.frame)+3, 0, 0)];
        label.text = @"地区";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view5 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(135, 1, kMainW-135-15, 53)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"请选择地区";
        [_view5 addSubview:textField];
        textField.inputView = [[UIView alloc]initWithFrame:CGRectZero];
        [textField addTarget:self action:@selector(textField5ShowPickView:) forControlEvents:UIControlEventEditingDidBegin];
        _textField5 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 54, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view5 addSubview:viewLine];
    }
    return _view5;
}

- (UIView *)view6 {
    if (!_view6) {
        _view6 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view5.frame), self.scrollView.bounds.size.width, 55)];
        _view6.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 0, 0)];
        imageView.image = [UIImage imageNamed:@"ime-Asterisk"];
        [imageView sizeToFit];
        [_view6 addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMinX(imageView.frame)+3, 0, 0)];
        label.text = @"供应商编号";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view6 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(135, 1, kMainW-135-15, 53)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"请填写供应商编号";
        [_view6 addSubview:textField];
        _textField6 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 54, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view6 addSubview:viewLine];
    }
    return _view6;
}

- (UIView *)view7 {
    if (!_view7) {
        _view7 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view6.frame), self.scrollView.bounds.size.width, 55)];
        _view7.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 0, 0)];
        imageView.image = [UIImage imageNamed:@"ime-Asterisk"];
        [imageView sizeToFit];
        [_view7 addSubview:imageView];
        imageView.hidden = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMinX(imageView.frame)+3, 0, 0)];
        label.text = @"付款条件";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view7 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(135, 1, kMainW-135-15, 53)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"请填写付款条件";
        [_view7 addSubview:textField];
        _textField7 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 54, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view7 addSubview:viewLine];
    }
    return _view7;
}

- (UIView *)view8 {
    if (!_view8) {
        _view8 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view7.frame), self.scrollView.bounds.size.width, 55)];
        _view8.backgroundColor = [UIColor whiteColor];

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 0, 0)];
        imageView.image = [UIImage imageNamed:@"ime-Asterisk"];
        [imageView sizeToFit];
        [_view8 addSubview:imageView];
        imageView.hidden = YES;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMinX(imageView.frame)+3, 0, 0)];
        label.text = @"备注";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view8 addSubview:label];

        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(135, 1, kMainW-135-15, 53)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"请填写对供应商的备注";
        [_view8 addSubview:textField];
        _textField8 = textField;

        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 54, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view8 addSubview:viewLine];
    }
    return _view8;
}

- (UIView *)view9 {
    if (!_view9) {
        _view9 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view8.frame), self.scrollView.bounds.size.width, 55)];
        _view9.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 1, kMainW, 53);
        [button setTitleColor:colorRGB(51, 51, 51) forState:UIControlStateNormal];
        [button setTitle:@"+添加供应商标签" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button addTarget:self action:@selector(buttonAddSupplierlabel:) forControlEvents:UIControlEventTouchUpInside];
        [_view9 addSubview:button];
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 54, kMainW-30, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view9 addSubview:viewLine];
    }
    return _view9;
}

- (void)buttonAddSupplierlabel:(UIButton *)sender {
    ECSupplierAddLabelVC *eCSupplierAddLabelVC = [[ECSupplierAddLabelVC alloc] init];
    [eCSupplierAddLabelVC setBlockArrayTGSupplierTag:^(NSMutableArray *array) {//ECSupplierAddLabelVC 点击确认添加 执行
        self.arrayLabel = [NSMutableArray arrayWithCapacity:0];
        for (TGSupplierTag *tGSupplierTag in array) {
//            NSLog(@"%@",tGSupplierTag.tagName);
            [self.arrayLabel addObject:tGSupplierTag.tagName];
        }
        self.arrayTGSupplierTag = array;
        [self.view8 removeFromSuperview];
        self.view8 = nil;
        [self.scrollView addSubview:self.view8];
        if (CGRectGetMaxY(self.view8.frame)+_height_NavBar > kMainH) {
            self.scrollView.contentSize = CGSizeMake(kMainW, CGRectGetMaxY(self.view8.frame));
        } else {
            self.scrollView.contentSize = CGSizeMake(kMainW, kMainH-_height_NavBar);
        }
    }];
    [self.navigationController pushViewController:eCSupplierAddLabelVC animated:YES];
}

- (UIView *)view10 {
    if (!_view10) {
        _view10 = [[UIView alloc] init];
        _view10.backgroundColor = [UIColor whiteColor];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(0, 15, 0, 0);
        button1.backgroundColor = [UIColor redColor];
        [_view10 addSubview:button1];
    
        for (int i = 0; i < self.arrayLabel.count; i++) {
            CGSize size = [self.arrayLabel[i] boundingRectWithSize:CGSizeMake(1000, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            CGFloat arrW = size.width + 30;
            CGFloat arrB = CGRectGetMaxX(button1.frame);
            if ((arrB+10+arrW+10) > kMainW) {
                //换行
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 100 + i;
                button.frame = CGRectMake(15, CGRectGetMaxY(button1.frame)+15, arrW, 30);
                [button setTitle:self.arrayLabel[i] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                [button setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
                button.layer.borderWidth = 1;
                button.layer.borderColor = colorRGB(255, 132, 0).CGColor;
                button.layer.cornerRadius = 2;
                [_view10 addSubview:button];
                button1 = button;
            } else {
                //不换行
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 100 + i;
                button.frame = CGRectMake(arrB + 15, CGRectGetMinY(button1.frame), arrW, 30);
                [button setTitle:self.arrayLabel[i] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                [button setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
                button.layer.borderWidth = 1;
                button.layer.borderColor = colorRGB(255, 132, 0).CGColor;
                button.layer.cornerRadius = 2;
                [_view10 addSubview:button];
                button1 = button;
            }
        }
        
        _view10.frame = CGRectMake(0, CGRectGetMaxY(self.view9.frame), self.scrollView.bounds.size.width, CGRectGetMaxY(button1.frame));
    }
    return _view10;
}

- (void)textField0EditingChanged:(UITextField *)sender {
    self.tableView.hidden = NO;
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    EnterpriseInfo *enterpriseInfo = [[EnterpriseInfo alloc] init];
    enterpriseInfo.isSupplier = [NSNumber numberWithInteger:1];
    enterpriseInfo.se_enterpriseName = [NSString stringWithFormat:@"%@%@%@",@"%",sender.text,@"%"];
    
    postEntityBean.entity = enterpriseInfo.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
//    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_enterprise_enterpriseInfoList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _arrayEnterpriseInfoModel = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *arrayEnterpriseInfo = model.list;
            for (NSDictionary *dic in arrayEnterpriseInfo) {
                EnterpriseInfo *obj = [EnterpriseInfo mj_objectWithKeyValues:dic];
                [_arrayEnterpriseInfoModel addObject:obj];
            }
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
            if (arrayEnterpriseInfo.count != 0) {
                [_tableView.mj_footer endRefreshing];
            } else {
                _tableView.hidden = YES;
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }
            _aPage = 2;
        }
    } fail:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (void)textField5ShowPickView:(UITextField *)textField {
    _viewPicker.hidden = NO;
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
