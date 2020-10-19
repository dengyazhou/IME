//
//  ScanYuanGongMaViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ScanYuanGongMaViewController.h"
#import "VoHeader.h"

#import "SaoYiSaoVC.h"
#import "TpfMaiViewController.h"
#import "ZuoYeDanYuanViewController.h"
#import "ScanTuZhiViewController.h"

#import "IMEFuture-swift.h"

@interface ScanYuanGongMaViewController () <UITextFieldDelegate> {
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *label;//摄像头对准图纸二维码，点击扫描


@property (weak, nonatomic) IBOutlet UILabel *labelOrderNum;
@property (weak, nonatomic) IBOutlet UILabel *labelworkUnitText;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;

@end

@implementation ScanYuanGongMaViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"Array_PersonnelVo_%@.data",siteCode]];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!array) {
        
    } else if (array.count == 0) {
        
    } else if (array.count == 1) {
        PersonnelVo *personnelVo = array[0];
        [self request:personnelVo.personnelCode];
    } else {
        
    }
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
    
    
    [self setAttributedString:@"摄像头对准员工二维码，\n点击扫描"];//设置中间字颜色
    
    self.labelOrderNum.text = [NSString stringWithFormat:@"生产订单：%@",self.productionOrderNum];
    self.labelworkUnitText.text = [NSString stringWithFormat:@"生产单元：%@",self.workUnitScanVo.workUnitText];
    
    
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
    _viewLoading.hidden = NO;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo * userInfoVo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString * siteCode = userInfoVo.siteCode;
    
    MesPostEntityBean * mesPostEntityBean = [[MesPostEntityBean alloc] init];
    PersonnelVo * personnelVo = [[PersonnelVo alloc] init];
    personnelVo.siteCode = siteCode;
    personnelVo.personnelCode = result;
    personnelVo.productionControlNum = self.workUnitScanVo.productionControlNum;
    personnelVo.operationCode = self.workUnitScanVo.operationCode;
    mesPostEntityBean.entity = personnelVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_scan_personnelScanByProductionControlNum parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        
        _viewLoading.hidden = YES;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            PersonnelVo *personnelVo = [PersonnelVo mj_objectWithKeyValues:returnEntityBean.entity];
            
            ReportWorkProductionOrderConfirmVo *model = [[ReportWorkProductionOrderConfirmVo alloc] init];
            model.productionControlNum = self.workUnitScanVo.productionControlNum;
            model.operationCode = self.workUnitScanVo.operationCode;
            model.workUnitCode = self.workUnitScanVo.workUnitCode;
            model.processOperationId = self.workUnitScanVo.processOperationId;
            model.confirmUser = personnelVo.personnelCode;
            
            [self validateWorkRecordType:model personnelVo:personnelVo];
            
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;
       
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

#pragma mark 请选择报工记录类型
- (void)validateWorkRecordType:(ReportWorkProductionOrderConfirmVo *)model personnelVo:(PersonnelVo *)personnelVo{
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    ReportWorkProductionOrderConfirmVo *reportWorkProductionOrderConfirmVo = [[ReportWorkProductionOrderConfirmVo alloc] init];
    reportWorkProductionOrderConfirmVo.siteCode = siteCode;
    reportWorkProductionOrderConfirmVo.productionControlNum = model.productionControlNum;
    reportWorkProductionOrderConfirmVo.operationCode = model.operationCode;
    reportWorkProductionOrderConfirmVo.workUnitCode = model.workUnitCode;
    reportWorkProductionOrderConfirmVo.processOperationId = model.processOperationId;
    reportWorkProductionOrderConfirmVo.confirmUser = model.confirmUser;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    [array addObject:reportWorkProductionOrderConfirmVo];
    mesPostEntityBean.entity = array.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_mes_productionOrderConfirm_validateWorkRecordType parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        _viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            if (returnListBean.list.count > 0) {
                ReportWorkProductionOrderConfirmVo *temp = [ReportWorkProductionOrderConfirmVo mj_objectWithKeyValues:returnListBean.list[0]];
                if (temp.chooseWorkRecordTypeFlag.integerValue == 1) {//弹款 选择
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择报工记录类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"正常生产" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self gointoZuoYeDanYuanViewController:personnelVo workRecordType:[NSNumber numberWithInteger:0]];
                    }];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"返工返修" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self gointoZuoYeDanYuanViewController:personnelVo workRecordType:[NSNumber numberWithInteger:1]];
                    }];
                    [alertController addAction:action];
                    [alertController addAction:action1];
                    
                    if ([alertController respondsToSelector:@selector(popoverPresentationController)]) {
                        alertController.popoverPresentationController.sourceView = self.view;//必须加
                        alertController.popoverPresentationController.sourceRect = CGRectMake(0, kMainH, kMainW, kMainH);//可选
                    }
                    [self presentViewController:alertController animated:true completion:nil];
                } else {
                    [self gointoZuoYeDanYuanViewController:personnelVo workRecordType:[NSNumber numberWithInteger:0]];
                }
            }
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (void)gointoZuoYeDanYuanViewController:(PersonnelVo *)personnelVo workRecordType:(NSNumber *)workRecordType{
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    WorkTimeLogVo *workTimeLogVo = [[WorkTimeLogVo alloc] init];
    workTimeLogVo.siteCode = siteCode;
    workTimeLogVo.productionControlNum = self.workUnitScanVo.productionControlNum;;
    workTimeLogVo.processOperationId = self.workUnitScanVo.processOperationId;
    workTimeLogVo.workUnitCode = self.workUnitScanVo.workUnitCode;
    workTimeLogVo.confirmUser = personnelVo.personnelCode;
    workTimeLogVo.workTimeLogType = [NSNumber numberWithInteger:1];
    mesPostEntityBean.entity = workTimeLogVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_workLog_getWorkTime parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
//            WorkTimeLogVo *model = [WorkTimeLogVo mj_objectWithKeyValues:returnEntityBean.entity];
            
            
            ZuoYeDanYuanViewController *zuoYeDanYuanViewController = [[ZuoYeDanYuanViewController alloc] init];
            zuoYeDanYuanViewController.planTime = self.workUnitScanVo.planTime;
            zuoYeDanYuanViewController.surplusTime = self.workUnitScanVo.surplusTime;
            zuoYeDanYuanViewController.workUnitText = self.workUnitScanVo.workUnitText;
            zuoYeDanYuanViewController.operationText = self.workUnitScanVo.operationText;
            zuoYeDanYuanViewController.operationTextNext = self.workUnitScanVo.operationTextNext;
            zuoYeDanYuanViewController.productionControlNum = self.workUnitScanVo.productionControlNum;
            zuoYeDanYuanViewController.workUnitCode = self.workUnitScanVo.workUnitCode;
            zuoYeDanYuanViewController.operationCode = self.workUnitScanVo.operationCode;
            zuoYeDanYuanViewController.processOperationId = self.workUnitScanVo.processOperationId;
            zuoYeDanYuanViewController.confirmFlag = self.workUnitScanVo.confirmFlag;
            zuoYeDanYuanViewController.confirmUser = personnelVo.personnelCode;
            zuoYeDanYuanViewController.productionOrderNum = self.productionOrderNum;
            zuoYeDanYuanViewController.requirementDate = self.requirementDate;
            zuoYeDanYuanViewController.personnelName = personnelVo.personnelName;
            zuoYeDanYuanViewController.workRecordType = workRecordType;
            
            [self.navigationController pushViewController:zuoYeDanYuanViewController animated:YES];
         
        } else if ([returnEntityBean.status isEqualToString:@"ERROR"] && returnEntityBean.returnCode.integerValue == -4) {
            ZuoYeViewController *vc = [[ZuoYeViewController alloc] init];
            vc.batchWorkNum = returnEntityBean.returnMsg;
            [self.navigationController pushViewController:vc animated:true];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}


#pragma mark 回到首页
- (IBAction)buttonGoHome:(id)sender {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[TpfMaiViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
            break;
        }
    }
}

- (void)setAttributedString:(NSString *)text {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:colorRGB(0, 122, 254) range:NSMakeRange(5, text.length - 9)];
    self.label.attributedText = attributeStr;
}

- (IBAction)back:(id)sender {
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    NSString *personnelCode = [DatabaseTool t_TpfPWTableGetPersonnelCodeWithSiteCode:siteCode];
    NSString *workUnitCode = [DatabaseTool t_TpfPWTableGetWorkUnitCodeWithSiteCode:siteCode];
    
    if (![workUnitCode isEqualToString:@"(null)"]) {
        //有 workUnitCode
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isMemberOfClass:[ScanTuZhiViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
                break;
            }
        }
    } else {
        //无 workUnitCode
        [self.navigationController popViewControllerAnimated:YES];
    }
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
