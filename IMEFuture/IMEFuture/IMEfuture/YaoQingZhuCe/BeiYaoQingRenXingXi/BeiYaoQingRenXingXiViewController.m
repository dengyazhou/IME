//
//  BeiYaoQingRenXingXiViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/7/24.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BeiYaoQingRenXingXiViewController.h"
#import "VoHeader.h"

#import "LianXiRenViewController1.h"


@interface BeiYaoQingRenXingXiViewController () <LianXiRenViewController1Delegate,UITextViewDelegate,UIScrollViewDelegate,UITextFieldDelegate> {
    UIView *_viewLoading1;//透明
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) UIView *view0;//手机
@property (nonatomic,strong) UITextField *textField0;//手机号
@property (nonatomic,strong) UIView *view1;//姓名
@property (nonatomic,strong) UITextField *textField1;//姓名
@property (nonatomic,strong) UIView *view2;//公司
@property (nonatomic,strong) UITextField *textField2;
@property (nonatomic,strong) UIView *view3;//职位
@property (nonatomic,strong) UITextField *textField3;
@property (nonatomic,strong) UIView *view4;//邮箱
@property (nonatomic,strong) UITextField *textField4;
@property (nonatomic,strong) UIView *view5;//部门
@property (nonatomic,strong) UITextField *textField5;
//@property (nonatomic,strong) UIView *view6;//推荐语
//@property (nonatomic,strong) UITextView *textView6;
@property (nonatomic,strong) UIView *view7;//勾选任意服务分享给对方吧：
@property (nonatomic,strong) UIView *view8;//

@property (nonatomic,strong) NSMutableArray *arrayStart;//

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation BeiYaoQingRenXingXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.arrayStart = [NSMutableArray arrayWithArray:@[@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"]];
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.delegate = self;
    
    [self.scrollView addSubview:self.view0];
    [self.scrollView addSubview:self.view1];
    [self.scrollView addSubview:self.view2];
    [self.scrollView addSubview:self.view3];
    [self.scrollView addSubview:self.view4];
    [self.scrollView addSubview:self.view5];
//    [self.scrollView addSubview:self.view6];
    [self.scrollView addSubview:self.view7];
    [self.scrollView addSubview:self.view8];
    self.scrollView.contentSize = CGSizeMake(kMainW, CGRectGetMaxY(self.view8.frame)+10);
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewLabel)];
    [self.scrollView addGestureRecognizer:tap];
    
    _viewLoading1 = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    _viewLoading1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewLoading1];
    _viewLoading1.hidden = YES;
}

- (void)tapViewLabel {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (rect.origin.y == kMainH) {
        self.scrollView.frame = CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-49);
    } else {
        self.scrollView.frame = CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-rect.size.height);
    }
}

- (UIView *)view0 {
    if (!_view0) {
        _view0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 44)];
        _view0.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14, 15, 0, 0)];
        label.text = @"手机";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view0 addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+3, CGRectGetMidY(label.frame)-4, 0, 0)];
        imageView.image = [UIImage imageNamed:@"icon_必填"];
        [imageView sizeToFit];
        [_view0 addSubview:imageView];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"对方的手机号";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        textField.delegate = self;
        [_view0 addSubview:textField];
        textField.text = self.strPhoneNumber;
        self.textField0 = textField;
        
        UIButton *buttonTongXunLu = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTongXunLu.frame = CGRectMake(kMainW-44, 0, 44, 44);
        [buttonTongXunLu setImage:[UIImage imageNamed:@"icon_通讯录"] forState:UIControlStateNormal];
        [buttonTongXunLu addTarget:self action:@selector(buttonLianXiRen:) forControlEvents:UIControlEventTouchUpInside];
        [_view0 addSubview:buttonTongXunLu];
        buttonTongXunLu.hidden = YES;
        
        if ([self.isLianXiRen isEqualToString:@"YES"]) {
            textField.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+20, 0.5, kMainW-CGRectGetMaxX(imageView.frame)-20-44, 43);
            buttonTongXunLu.hidden = NO;
        } else {
            textField.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+20, 0.5, kMainW-CGRectGetMaxX(imageView.frame)-20-14, 43);
            buttonTongXunLu.hidden = YES;
        }
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(14, 43.5, kMainW-28, 0.5)];
        viewLine.backgroundColor = colorRGB(228, 228, 228);
        [_view0 addSubview:viewLine];
    }
    return _view0;
}

- (void)buttonLianXiRen:(UIButton *)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    LianXiRenViewController1 *lianXiRenViewController1 = [[LianXiRenViewController1 alloc] init];
    lianXiRenViewController1.delegate = self;
    [self presentViewController:lianXiRenViewController1 animated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

#pragma mark LianXiRenViewController1Delegate
- (void)selectLianXiRenWhithStrPhoneNumber:(NSString *)strPhoneNumber whithStrName:(NSString *)strName {
    self.textField0.text = strPhoneNumber;
    self.textField1.text = strName;
    
}

- (UIView *)view1 {
    if (!_view1) {
        _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view0.frame), kMainW, 44)];
        _view1.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14, 15, 0, 0)];
        label.text = @"姓名";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view1 addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+3, CGRectGetMidY(label.frame)-4, 0, 0)];
        imageView.image = [UIImage imageNamed:@"icon_必填"];
        [imageView sizeToFit];
        [_view1 addSubview:imageView];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+20, 0.5, kMainW-CGRectGetMaxX(imageView.frame)-20-14, 43)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"对方的真实姓名";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_view1 addSubview:textField];
        textField.text = self.strName;
        self.textField1 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(14, 43.5, kMainW-28, 0.5)];
        viewLine.backgroundColor = colorRGB(228, 228, 228);
        [_view1 addSubview:viewLine];
    }
    return _view1;
}

- (UIView *)view2 {
    if (!_view2) {
        _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view1.frame), kMainW, 44)];
        _view2.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14, 15, 0, 0)];
        label.text = @"公司";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view2 addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+3, CGRectGetMidY(label.frame)-4, 0, 0)];
        imageView.image = [UIImage imageNamed:@"icon_必填"];
        [imageView sizeToFit];
        [_view2 addSubview:imageView];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+20, 0.5, kMainW-CGRectGetMaxX(imageView.frame)-14, 43)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"对方的公司名称";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_view2 addSubview:textField];
        self.textField2 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(14, 43.5, kMainW-28, 0.5)];
        viewLine.backgroundColor = colorRGB(228, 228, 228);
        [_view2 addSubview:viewLine];
    }
    return _view2;
}

- (UIView *)view3 {
    if (!_view3) {
        _view3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view2.frame), kMainW, 44)];
        _view3.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14, 15, 0, 0)];
        label.text = @"职位";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view3 addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+3, CGRectGetMidY(label.frame)-4, 0, 0)];
        imageView.image = [UIImage imageNamed:@"icon_必填"];
        [imageView sizeToFit];
        [_view3 addSubview:imageView];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+20, 0.5, kMainW-CGRectGetMaxX(imageView.frame)-14, 43)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"对方的公司职位";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_view3 addSubview:textField];
        self.textField3 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(14, 43.5, kMainW-28, 0.5)];
        viewLine.backgroundColor = colorRGB(228, 228, 228);
        [_view3 addSubview:viewLine];
    }
    return _view3;
}

- (UIView *)view4 {
    if (!_view4) {
        _view4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view3.frame), kMainW, 44)];
        _view4.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14, 15, 0, 0)];
        label.text = @"邮箱";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view4 addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+3, CGRectGetMidY(label.frame)-4, 0, 0)];
        imageView.image = [UIImage imageNamed:@"icon_必填"];
        [imageView sizeToFit];
        [_view4 addSubview:imageView];
        imageView.hidden = YES;
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+20, 0.5, kMainW-CGRectGetMaxX(imageView.frame)-14, 43)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"对方的邮箱";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_view4 addSubview:textField];
        self.textField4 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(14, 43.5, kMainW-28, 0.5)];
        viewLine.backgroundColor = colorRGB(228, 228, 228);
        [_view4 addSubview:viewLine];
    }
    return _view4;
}

- (UIView *)view5 {
    if (!_view5) {
        _view5 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view4.frame), kMainW, 44)];
        _view5.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14, 15, 0, 0)];
        label.text = @"部门";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view5 addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+3, CGRectGetMidY(label.frame)-4, 0, 0)];
        imageView.image = [UIImage imageNamed:@"icon_必填"];
        [imageView sizeToFit];
        [_view5 addSubview:imageView];
        imageView.hidden = YES;
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+20, 0.5, kMainW-CGRectGetMaxX(imageView.frame)-14, 43)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = colorRGB(51, 51, 51);
        textField.placeholder = @"对方所在部门";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_view5 addSubview:textField];
        self.textField5 = textField;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(14, 43.5, kMainW-28, 0.5)];
        viewLine.backgroundColor = colorRGB(228, 228, 228);
        [_view5 addSubview:viewLine];
    }
    return _view5;
}

//- (UIView *)view6 {
//    if (!_view6) {
//        _view6 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view5.frame), kMainW, 123)];
//        _view6.backgroundColor = [UIColor whiteColor];
//        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14, 15, 0, 0)];
//        label.text = @"推荐语";
//        label.font = [UIFont systemFontOfSize:14];
//        label.textColor = colorRGB(51, 51, 51);
//        [label sizeToFit];
//        [_view6 addSubview:label];
//        
//        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(label.frame)+2, kMainW-28, 123-(CGRectGetMaxY(label.frame)+5)-5)];
//        textView.delegate = self;
//        textView.font = [UIFont systemFontOfSize:14];
//        textView.textColor = colorRGB(51, 51, 51);
//        [_view6 addSubview:textView];
//        self.textView6 = textView;
//        
//        UILabel *labelPlaceHolder = [[UILabel alloc] initWithFrame:CGRectMake(4, 9, CGRectGetWidth(textView.frame)-4, 14)];
//        labelPlaceHolder.text = @"例如：我们公司正在用智造家询盘，推荐您也来使用。";
//        labelPlaceHolder.textColor = colorRGB(204, 204, 204);
//        labelPlaceHolder.font = [UIFont systemFontOfSize:14];
//        labelPlaceHolder.tag = 99;
//        [textView addSubview:labelPlaceHolder];
//        
//        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(14, 122.5, kMainW-28, 0.5)];
//        viewLine.backgroundColor = colorRGB(228, 228, 228);
//        [_view6 addSubview:viewLine];
//    }
//    return _view6;
//}

- (void)textViewDidChange:(UITextView *)textView {
    UILabel *label = [textView viewWithTag:99];
    if (textView.text.length > 0) {
        label.hidden = YES;
    } else {
        label.hidden = NO;
    }
}

- (UIView *)view7 {
    if (!_view7) {
        _view7 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view5.frame), kMainW, 40)];
        _view7.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14, 15, 0, 0)];
        label.text = @"勾选任意服务分享给对方吧：";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(51, 51, 51);
        [label sizeToFit];
        [_view7 addSubview:label];
    }
    return _view7;
}

- (UIView *)view8 {
    if (!_view8) {
        CGFloat fw = (kMainW-14*4)/3.0;
        _view8 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view7.frame), kMainW, 14*3+fw*2)];
        _view8.backgroundColor = [UIColor whiteColor];
        
        NSArray *imageArray = @[@"icon_e非标(供应商)",@"icon_透明工厂",@"icon_非标管家",@"icon_图纸云",@"icon_e非标(采购商)",@"icon_设备备件云"];
        NSArray *labelArray = @[@"e非标(供应商)",@"透明工厂",@"非标管家",@"图纸云",@"非标(采购商)",@"设备备件云"];
        for (NSInteger i=0; i<6; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(14+(fw+14)*(i%3), 14+(fw+14)*(i/3), fw, fw);
            button.layer.borderWidth = 0.5;
            button.layer.cornerRadius = 2;
            button.layer.borderColor = colorRGB(228, 228, 228).CGColor;
            [button addTarget:self action:@selector(buttonDuiGou:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            [_view8 addSubview:button];
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageArray[i]]];
            [imageView sizeToFit];
            imageView.center = CGPointMake(fw/2.0, fw/2.0-15);
            [button addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] init];
            label.text = labelArray[i];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = colorRGB(102, 102, 102);
            label.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame)+15, fw, 15);
            label.textAlignment = NSTextAlignmentCenter;
            [button addSubview:label];
            
            UIImageView *imageViewDuiGou = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_选中"]];
            imageViewDuiGou.tag = 100;
            [imageViewDuiGou sizeToFit];
            imageViewDuiGou.frame = CGRectMake(fw-9-CGRectGetWidth(imageViewDuiGou.frame), fw-9-CGRectGetHeight(imageViewDuiGou.frame), CGRectGetWidth(imageViewDuiGou.frame), CGRectGetHeight(imageViewDuiGou.frame));
            [button addSubview:imageViewDuiGou];
            imageViewDuiGou.hidden = YES;
        }
        
    }
    return _view8;
}

- (void)buttonDuiGou:(UIButton *)sender {
    UIImageView *imageView = [sender viewWithTag:100];
    NSString *str = self.arrayStart[sender.tag];
    if ([str isEqualToString:@"NO"]) {
        imageView.hidden = NO;
        [self.arrayStart replaceObjectAtIndex:sender.tag withObject:@"YES"];
        return;
    }
    if ([str isEqualToString:@"YES"]) {
        imageView.hidden = YES;
        [self.arrayStart replaceObjectAtIndex:sender.tag withObject:@"NO"];
        return;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark 发送邀请
- (IBAction)sendInvitations:(id)sender {
    if (_textField0.text.length == 0) {//手机号
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"手机号为空"];
        return;
    }
    if (_textField0.text.length != 11) {//手机号
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"手机号格式不对"];
        return;
    }
    if (_textField1.text.length == 0) {//姓名
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"姓名为空"];
        return;
    }
    if (_textField2.text.length == 0) {//公司
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"公司为空"];
        return;
    }
    if (_textField3.text.length == 0) {//职位
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"职位为空"];
        return;
    }
    if (_textField4.text.length > 0) {//邮箱
        if (!([_textField4.text containsString:@"@"] && [_textField4.text containsString:@".com"])) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"邮箱格式不对"];
            return;
        }
    }
//    _textField5.text //部门
//    _textView6.text //推荐语
    _viewLoading1.hidden = NO;
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *arraySource = @[@"e非标（供应商）",@"透明工厂",@"非标管家",@"图纸云",@"e非标（采购商）",@"设备备件云"];
    for (NSInteger i=0; i<self.arrayStart.count; i++) {
        if ([self.arrayStart[i] isEqualToString:@"YES"]) {
            [array addObject:arraySource[i]];
        }
    }
    NSLog(@"%@",array);
    
    NSString *string;
    for (NSInteger i = 0; i<array.count; i++) {
        if (i == 0) {
            string = [NSString stringWithFormat:@"%@",array[i]];
        } else {
            //                string = [string stringByAppendingString:[NSString stringWithFormat:@",%@",array[i]]];
            string = [NSString stringWithFormat:@"%@,%@",string,array[i]];
        }
    }
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    InviteInfo *inviteInfo = [[InviteInfo alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    inviteInfo.userId = loginModel.userId;
    inviteInfo.mobile = _textField0.text;
    inviteInfo.email = _textField4.text;
    inviteInfo.name = _textField1.text;
    inviteInfo.dept = _textField5.text;
    inviteInfo.job = _textField3.text;
    inviteInfo.company = _textField2.text;
    inviteInfo.awuluans = string;
    
    
    postEntityBean.entity = inviteInfo.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
//    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_user_createInviteForAppUc parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        _viewLoading1.hidden = YES;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"发送邀请成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"邀请失败"];
        }
    } fail:^(NSError *error) {
        _viewLoading1.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    
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
