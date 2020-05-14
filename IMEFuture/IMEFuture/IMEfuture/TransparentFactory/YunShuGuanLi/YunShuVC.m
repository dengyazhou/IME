//
//  YunShuVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/8.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "YunShuVC.h"
#import "VoHeader.h"
#import "SaoYiSaoVC.h"
#import "YunShuYuTiJiaoVC.h"
#import "YunShuDetailVC.h"

@interface YunShuVC () <UITextFieldDelegate> {
    UIView *_viewLoading;
    
    dispatch_source_t timer;
}


@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation YunShuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.heightNavBar.constant = Height_NavBar;
//    self.view.layer.cornerRadius = 5;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW-34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self setAttributedString:@"摄像头对准发货单二维码，\n点击扫描"];//设置中间字颜色
    
    self.textField.delegate = self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self request:textField.text];
    
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}

#pragma mark 扫描
- (IBAction)buttonScan:(id)sender {
    SaoYiSaoVC *saoYiSaoVC = [[SaoYiSaoVC alloc] init];
    saoYiSaoVC.scanTitle = @"扫描发货单二维码";
    [saoYiSaoVC setResultBlock:^(NSString *result) {
        NSArray *arr = [result componentsSeparatedByString:@"/"];
        [self request:arr.lastObject];
    }];
    [self presentViewController:saoYiSaoVC animated:YES completion:nil];
    
}

- (void)request:(NSString *)result {
    _viewLoading.hidden = NO;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserBean *userBean = [UserBean mj_objectWithKeyValues:loginModel.ucenterUser];
    NSString * siteCode = userBean.enterpriseInfo.serialNo;
    
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    TransportOrderVo *transportOrder = [[TransportOrderVo alloc] init];
    transportOrder.siteCode = siteCode;
    transportOrder.outgoingOrderNum = result;
    postEntityBean.entity = transportOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_mes_transportOrder_scanOutgoingOrder parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        _viewLoading.hidden = YES;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            TransportOrderVo *transportOrder = [TransportOrderVo mj_objectWithKeyValues:returnEntityBean.entity];
            if (transportOrder.transportOrderNum) {
                [self showAlert:[NSString stringWithFormat:@"该单据已存在于%@的%@运输计划下，不能添加到新的运输计划中",transportOrder.userText,transportOrder.transportOrderNum]];
            } else {
                YunShuYuTiJiaoVC *vc = [[YunShuYuTiJiaoVC alloc] init];
                vc.transportOrderVoArray = [[NSMutableArray alloc] init];
                [vc.transportOrderVoArray addObject:transportOrder];
                [self.navigationController pushViewController:vc animated:true];
            }
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

- (void)showAlert:(NSString *)str {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertVC animated:true completion:nil];
}

- (void)setAttributedString:(NSString *)text {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:colorRGB(40, 155, 229) range:NSMakeRange(5, text.length - 9)];
    self.label.attributedText = attributeStr;
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
