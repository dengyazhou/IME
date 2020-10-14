//
//  EMScanYGMViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "EMScanYGMViewController.h"
#import "VoHeader.h"

#import "SaoYiSaoVC.h"

#import "ScanTuZhiViewController.h"
#import "EquipmentMaintenanceViewController.h"


@interface EMScanYGMViewController () <UITextFieldDelegate> {
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *label;//摄像头对准图纸二维码，点击扫描

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;

@end

@implementation EMScanYGMViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    LoginModel *loginModel = [DatabaseTool getLoginModel];
//    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
//    NSString *siteCode = tpfUser.siteCode;
//
//    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"Array_PersonnelVo_%@.data",siteCode]];
//    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    if (!array) {
//
//    } else if (array.count == 0) {
//
//    } else if (array.count == 1) {
//        PersonnelVo *personnelVo = array[0];
//        [self request:personnelVo.personnelCode];
//    } else {
//
//    }
//}

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
    
    
    [self setAttributedString:@"摄像头对准员工二维码，\n点击扫描"];//设置中间字颜色
    

    
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
    NSLog(@"%s",__FUNCTION__);
    SaoYiSaoVC *saoYiSaoVC = [[SaoYiSaoVC alloc] init];
    saoYiSaoVC.scanTitle = @"扫描员工二维码";
    [saoYiSaoVC setResultBlock:^(NSString *result) {
        
        NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
         [self request:dic[@"personnelCode"]];
    }];
    [self presentViewController:saoYiSaoVC animated:YES completion:nil];
}

- (void)request:(NSString *)result {
    NSLog(@"dyz:%@",result);
    _viewLoading.hidden = false;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo * userInfoVo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString * siteCode = userInfoVo.siteCode;
    
    MesPostEntityBean * mesPostEntityBean = [[MesPostEntityBean alloc] init];
    PersonnelVo * model = [[PersonnelVo alloc] init];
    model.siteCode = siteCode;
    model.personnelCode = result;
    mesPostEntityBean.entity = model.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_scan_personnelScan parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;

        self->_viewLoading.hidden = YES;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            
            self.textField.text = nil;
            
            EquipmentMaintenanceViewController *vc = [[EquipmentMaintenanceViewController alloc] init];
            vc.personnelCode = result;
            [self.navigationController pushViewController:vc animated:true];
          
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
       self->_viewLoading.hidden = YES;

    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
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
