//
//  FaBaoPingLunViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "FaBaoPingLunTuoGuanViewController.h"
#import "VoHeader.h"
#import "IMETabBarViewController.h"

#import "DingDanXiangQingCaiViewController.h"
#import "ECTuoGuanSupplierViewController.h"


@interface FaBaoPingLunTuoGuanViewController () <UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    UILabel *_labelTextView;
    UIView *_viewTag;//为了让键盘下去 添加的view
    NSArray *_arrayNum;
    NSString *_stringTemp;
    EnterpriseInfo *_enterpriseInfo;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation FaBaoPingLunTuoGuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    _arrayNum = @[@"10",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1"];

    self.textView.delegate = self;
    
    
    
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    EnterpriseInfo *enterpriseInfo = [[EnterpriseInfo alloc] init];
    enterpriseInfo.enterpriseId = self.tradeOrder.supplierEnterpriseId;
    postEntityBean.entity = enterpriseInfo.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_enterprise_epInfo parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        _enterpriseInfo = [EnterpriseInfo mj_objectWithKeyValues:returnEntityBean.entity];
        [self.thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:_enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    
    
    
    self.enterpriseName.text = self.tradeOrder.supplierEnterpriseName;
    self.label2.text = [NSString stringWithFormat:@"订单信息：%@ %@",self.tradeOrder.orderCode,self.tradeOrder.title];
    self.label3.text = self.tradeOrder.averageScore?[NSString stringWithFormat:@"%@分",[self.tradeOrder.averageScore stringValue]]:@"请打分";
   
    
    
    _labelTextView = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, kMainW-20, 17)];
    _labelTextView.font = [UIFont systemFontOfSize:17];
    _labelTextView.textColor = colorRGB(177, 177, 177);
    _labelTextView.text = @"请输入评价内容";
    [self.textView addSubview:_labelTextView];
    
    
    if (self.tradeOrder.content) {
        self.textView.text = self.tradeOrder.content;
        _labelTextView.hidden = YES;
    }
    
    _viewTag = [[UIView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, 320-_height_NavBar)];
    _viewTag.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewTag];
    _viewTag.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [_viewTag addGestureRecognizer:tap];
    
    
    self.pickerViewBG.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureCancel:)];
    [self.pickerViewBG addGestureRecognizer:tapGesture];
    
    self.pickerViewBG.hidden = YES;
}

- (void)tapSelector:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
    _viewTag.hidden = YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _viewTag.hidden = NO;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        _labelTextView.hidden = YES;
    } else {
        _labelTextView.hidden = NO;
    }
}

- (IBAction)buttonTiJiao:(UIButton *)sender {
    
    
    //NSLog(@"%@",self.navigationController.viewControllers);
    
    if ([self.tradeOrder.supplierIsComment boolValue] == 0) {
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
        
        EnterpriseComment *enterpriseComment = [[EnterpriseComment alloc] init];
        enterpriseComment.orderId = self.tradeOrder.orderId;
        enterpriseComment.orderCode = self.tradeOrder.orderCode;
        enterpriseComment.srManufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
        enterpriseComment.srEnterpriseName = loginModel.enterpriseName;
        enterpriseComment.srMemberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
        enterpriseComment.trManufacturerId = _enterpriseInfo.manufacturerId;
        enterpriseComment.trEnterpriseName = self.tradeOrder.supplierEnterpriseName;
        enterpriseComment.commentStatus = [NSNumber numberWithInteger:1];
        enterpriseComment.content = self.textView.text;
        enterpriseComment.averageScore = [NSNumber numberWithDouble:[[[self.label3.text componentsSeparatedByString:@"分"] firstObject] doubleValue]];
        
        postEntityBean.entity = enterpriseComment.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_enterpriseComment_addEpOrderComment parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"评价成功"];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"评价失败"];
            }
            
            BOOL isBreak = false;
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isMemberOfClass:[ECTuoGuanSupplierViewController class]]) {
                    isBreak = true;
                    [self.navigationController popToViewController:vc animated:YES];
                    break;
                }
            }
            if (!isBreak) {
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isMemberOfClass:[DingDanXiangQingCaiViewController class]]) {
                        isBreak = true;
                        [self.navigationController popToViewController:vc animated:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshECOrder" object:nil userInfo:nil];
                        break;
                    }
                }
            }
            
            if (!isBreak) {
                NSInteger aa = 1;
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isMemberOfClass:[IMETabBarViewController class]]) {
                        if (aa == 2) {
                            [self.navigationController popToViewController:vc animated:YES];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshECOrder" object:nil userInfo:nil];
                            break;
                        }
                        aa++;
                    }
                }
            }

        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    } else {
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
        
        EnterpriseComment *enterpriseComment = [[EnterpriseComment alloc] init];
        enterpriseComment.orderId = self.tradeOrder.orderId;
        enterpriseComment.orderCode = self.tradeOrder.orderCode;
        enterpriseComment.content = self.textView.text;
        enterpriseComment.averageScore = [NSNumber numberWithDouble:[[[self.label3.text componentsSeparatedByString:@"分"] firstObject] doubleValue]];
        postEntityBean.entity = enterpriseComment.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
//        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_enterpriseComment_updateEpOrderComment parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"评价成功"];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"评价失败"];
            }
            
            BOOL isBreak = false;
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isMemberOfClass:[ECTuoGuanSupplierViewController class]]) {
                    isBreak = true;
                    [self.navigationController popToViewController:vc animated:YES];
                    break;
                }
            }
            if (!isBreak) {
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isMemberOfClass:[DingDanXiangQingCaiViewController class]]) {
                        isBreak = true;
                        [self.navigationController popToViewController:vc animated:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshECOrder" object:nil userInfo:nil];
                        break;
                    }
                }
            }
            
            if (!isBreak) {
                NSInteger aa = 1;
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isMemberOfClass:[IMETabBarViewController class]]) {
                        if (aa == 2) {
                            [self.navigationController popToViewController:vc animated:YES];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshECOrder" object:nil userInfo:nil];
                            break;
                        }
                        aa++;
                    }
                }
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    }
    
    
}

- (IBAction)buttonSelect:(UIButton *)sender {
    self.pickerViewBG.hidden = NO;
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buttonQuXiao:(UIButton *)sender {
    self.pickerViewBG.hidden = YES;
}

- (void)tapGestureCancel:(UITapGestureRecognizer *)tap {
     self.pickerViewBG.hidden = YES;
}
- (IBAction)buttonWanCheng:(UIButton *)sender {
    if (!_stringTemp) {
        _stringTemp = @"10";
    }
    self.label3.text = [NSString stringWithFormat:@"%@分",_stringTemp];
    self.pickerViewBG.hidden = YES;
}

- (void)line:(UIView *)view withY:(CGFloat)y {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, kMainW, 0.5)];
    label.backgroundColor = colorLine;
    [view addSubview:label];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _arrayNum[row];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arrayNum.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _stringTemp = _arrayNum[row];
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
