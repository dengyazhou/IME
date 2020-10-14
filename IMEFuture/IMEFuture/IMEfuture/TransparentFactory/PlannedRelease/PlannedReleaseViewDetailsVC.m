//
//  PlannedReleaseViewDetailsVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/3.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "PlannedReleaseViewDetailsVC.h"
#import "VoHeader.h"
#import <ReactiveObjC.h>

@interface PlannedReleaseViewDetailsVC () {
    UIView *_viewLoading;
}


@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBack;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (weak, nonatomic) IBOutlet UILabel *label01;
@property (weak, nonatomic) IBOutlet UILabel *label02;
@property (weak, nonatomic) IBOutlet UILabel *label03;
@property (weak, nonatomic) IBOutlet UILabel *label04;
@property (weak, nonatomic) IBOutlet UILabel *label05;
@property (weak, nonatomic) IBOutlet UILabel *label06;
@property (weak, nonatomic) IBOutlet UILabel *label07;
@property (weak, nonatomic) IBOutlet UILabel *label08;
@property (weak, nonatomic) IBOutlet UILabel *label09;
@property (weak, nonatomic) IBOutlet UILabel *label99;


@property (nonatomic, strong) ProductionOrderVo *productionOrderVo;


@end

@implementation PlannedReleaseViewDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    //rac
    @weakify(self);
    [[self.buttonLeftBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isMemberOfClass:NSClassFromString(@"PlannedReleaseViewController")]) {
                [vc setValue:[NSNumber numberWithBool:NO] forKey:@"refreshing"];
                break;
            }
        }
        [self.navigationController popViewControllerAnimated:true];
    }];
    
    [self request_productionOrderConfirm_getProductionOrderList];
}

- (void)reloadData {
    ProductionOrderVo *model = self.productionOrderVo;
    self.label01.text = model.productionOrderNum;
    self.label02.text = model.projectNum;
    self.label03.text = model.projectName;
    self.label04.text = model.materialCode;
    self.label05.text = model.materialText;
    self.label06.text = model.materialSpec;
    self.label07.text = model.orderQuantity.stringValue;
    self.label08.text = model.plannedQuantity.stringValue;
    self.label09.text = [NSNumber numberWithDouble:(model.plannedQuantity.doubleValue - model.releasedQuantity.doubleValue)].stringValue;
    self.label99.text = [[FunctionDYZ dyz] strDateFormat:model.requirementDate withEnterDateFormat:@"yyyy-MM-dd HH:mm:ss" withGoDateFormat:@"yyyy-MM-dd"];
}

- (void)request_productionOrderConfirm_getProductionOrderList {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    ProductionOrderVo *productionOrderVo = [[ProductionOrderVo alloc] init];
    productionOrderVo.siteCode = siteCode;
    productionOrderVo.productionOrderNum = self.productionOrderNum;
    
    mesPostEntityBean.entity = productionOrderVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_productionOrderConfirm_getProductionOrderList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            NSMutableArray *dataArray = returnListBean.list;
            for (NSInteger i=0; i<dataArray.count; i++) {
                self.productionOrderVo = [ProductionOrderVo mj_objectWithKeyValues:dataArray[i]];
                break;
            }
            [self reloadData];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
        self->_viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
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
