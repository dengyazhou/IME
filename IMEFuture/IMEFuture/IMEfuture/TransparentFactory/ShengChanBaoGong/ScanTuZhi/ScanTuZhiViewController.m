//
//  ScanTuZhiViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ScanTuZhiViewController.h"
#import "VoHeader.h"

#import "SaoYiSaoVC.h"
#import "ScanZuoYeDanYuanViewController.h"
#import "TpfSZViewController.h"

@interface ScanTuZhiViewController () <UITextFieldDelegate> {
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *label;//摄像头对准图纸二维码，点击扫描


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;

@end

@implementation ScanTuZhiViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_BottomBar = Height_BottomBar;
    self.heightNavBar.constant = _height_NavBar;
    self.heightBottomBar.constant = _height_BottomBar;

    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self setAttributedString:@"摄像头对准图纸二维码/工序流转卡，\n点击扫描"];//设置中间字颜色
    
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
    saoYiSaoVC.scanTitle = @"扫描图纸二维码";
    [saoYiSaoVC setResultBlock:^(NSString *result) {
        [self request:result];
    }];
    [self presentViewController:saoYiSaoVC animated:YES completion:nil];
    
}

- (void)request:(NSString *)result {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    ProductionControlVo *productionControlVo = [[ProductionControlVo alloc] init];
    productionControlVo.siteCode = siteCode;
    productionControlVo.productionControlNum = result;
    mesPostEntityBean.entity = productionControlVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_scanRest_chartScan parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        _viewLoading.hidden = YES;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            //扫描成功进入下级界面
            
            //主线程
            ProductionControlVo *scanVo = [ProductionControlVo mj_objectWithKeyValues:returnEntityBean.entity];
            
            [self goScanZuoYeDanYuanViewControllerWithProductionControlNum:result productionOrderNum:scanVo.productionOrderNum requirementDate:scanVo.requirementDate];
        
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;
       
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

- (void)goScanZuoYeDanYuanViewControllerWithProductionControlNum:(NSString *)productionControlNum productionOrderNum:(NSString *)productionOrderNum requirementDate:(NSString *)requirementDate{
    ScanZuoYeDanYuanViewController *scanZuoYeDanYuanViewController = [[ScanZuoYeDanYuanViewController alloc] init];
    scanZuoYeDanYuanViewController.productionControlNum = productionControlNum;
    scanZuoYeDanYuanViewController.productionOrderNum = productionOrderNum;
    scanZuoYeDanYuanViewController.requirementDate = requirementDate;
    [self.navigationController pushViewController:scanZuoYeDanYuanViewController animated:YES];
}

#pragma mark 设置
- (IBAction)buttonSet:(id)sender {
    TpfSZViewController * tpfSZViewController = [[TpfSZViewController alloc] init];
    [self.navigationController pushViewController:tpfSZViewController animated:YES];
}

- (void)setAttributedString:(NSString *)text {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:colorRGB(0, 122, 254) range:NSMakeRange(5, text.length - 9)];
    self.label.attributedText = attributeStr;
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
