//
//  ZhiJianSearchViewController09.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ZhiJianSearchViewController09.h"
#import "VoHeader.h"
#import "SaoYiSaoVCWhite.h"
#import "YanHuoViewController09.h"
#import "YanHuoDetailViewController.h"


@interface ZhiJianSearchViewController09 () <UITextFieldDelegate>{
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *viewBGNoInspect;

@end

@implementation ZhiJianSearchViewController09

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = true;
    
    self.viewBGNoInspect.hidden = true;
}

- (IBAction)textFieldEditingDidBeginDDD:(UITextField *)sender {
    self.viewBGNoInspect.hidden= true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self requestDeliverCode:textField.text];
    [textField resignFirstResponder];
    textField.text = nil;
    return true;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}


- (IBAction)buttonScan:(id)sender {
    SaoYiSaoVCWhite *vc = [[SaoYiSaoVCWhite alloc] init];
    vc.scanTitle = @"扫描收货单号";
    [vc setResultBlock:^(NSString *result) {
        [self requestDeliverCode:result];
    }];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)requestDeliverCode:(NSString *)deliverCode{
    _viewLoading.hidden = false;
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    DeliverOrderReqBean *deliverOrderReqBean = [DeliverOrderReqBean new];
    deliverOrderReqBean.deliverCode = deliverCode;
    postEntityBean.entity = deliverOrderReqBean.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_inspect_appGetInspectOrder parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            
            InspectOrderVo *inspectOrderVo = [InspectOrderVo mj_objectWithKeyValues:model.entity];
            
            if (inspectOrderVo.inspectOrderId == nil) {
                if (inspectOrderVo.receiveOrder == nil) {
                    NSLog(@"没有质检单");
                    self.viewBGNoInspect.hidden = false;
                } else {
                    InspectOrderVo *model = [InspectOrderVo new];
                    model.supplierEnterpriseName = inspectOrderVo.supplierEnterpriseName;
                    model.receiveCode = inspectOrderVo.deliverOrder.receiveCode;
                    model.receiveTime = inspectOrderVo.receiveOrder.receiveTime;
                    model.deliverCode = inspectOrderVo.deliverOrder.deliverCode;
                    model.deliveryTime = inspectOrderVo.deliverOrder.deliveryTime;
                    model.deliverNumber = inspectOrderVo.deliverOrder.deliverNumber;
                    model.deliveryMethods = inspectOrderVo.deliverOrder.deliveryMethods;
                    model.deliveryContact = inspectOrderVo.deliverOrder.deliveryContact;
                    model.deliveryPhone = inspectOrderVo.deliverOrder.deliveryPhone;
                    model.license = inspectOrderVo.deliverOrder.license;
                    model.logisticsCompanyKey = inspectOrderVo.deliverOrder.logisticsCompanyKey;
                    model.logisticsNo = inspectOrderVo.deliverOrder.logisticsNo;
                    model.selfAddress = inspectOrderVo.deliverOrder.selfAddress;
                    model.remark = inspectOrderVo.deliverOrder.remark;
                    model.deliveryMethodsDesc = inspectOrderVo.deliverOrder.deliveryMethodsDesc;
                    
                    model.deliverOrderId = inspectOrderVo.deliverOrder.deliverOrderId;
                    model.receiveOrderId = inspectOrderVo.receiveOrder.receiveOrderId;
                    model.isOpenErp = inspectOrderVo.receiveOrder.isOpenErp;
                    
//                    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:0];
                    NSMutableArray *inspectOrderItems = [[NSMutableArray alloc] init];
                    
                    for (NSInteger i=0; i<inspectOrderVo.receiveOrder.receiveOrderItems.count; i++) {
                        ReceiveItemBean *receiveItem = inspectOrderVo.receiveOrder.receiveOrderItems[i];
                        InspectOrderItemVo *item = [InspectOrderItemVo new];
                        item.receiveOrderItemId = receiveItem.receiveOrderItemId;
                        item.receiveNum = receiveItem.receiveNum.stringValue;
                        item.deliverOrderItemId =  receiveItem.deliverOrderItemId;
                        item.qualityQuantity = receiveItem.receiveNum;
                        item.defectiveQuantity = [NSNumber numberWithInteger:0];
                        item.isMianjian = [NSNumber numberWithInteger:0];
                        item.isReceiveMianjian = receiveItem.isMianjian;
                        item.canInspectNum = receiveItem.receiveNum;
                        
                        item.defaultQuantity = [NSNumber numberWithInteger:0];
                        item.realQualityQuantity = receiveItem.receiveNum;
                        item.downgradeQuantity = [NSNumber numberWithInteger:0];
                        
                        if (receiveItem.isMianjian.integerValue == 1 || receiveItem.receiveNum.doubleValue == 0) {
                            
                        } else {
                            [inspectOrderItems addObject:item];
//                            [items addObject:inspectOrderVo.deliverOrder.items[i]];
                        }
                    }
                    
                    model.inspectOrderItems = inspectOrderItems;
                    
//                    inspectOrderVo.deliverOrder.items = items;
                    
                    model.deliverOrder = inspectOrderVo.deliverOrder;
                    
                    YanHuoViewController09 *vc = [[YanHuoViewController09 alloc] init];
                    vc.inspectOrderVo = model;
                    
                    //(realQualityQuantity + defaultQuantity + downgradeQuantity) 作为合格数
                    //canInspectNum(可验货数) = （realQualityQuantity + defaultQuantity + downgradeQuantity)合格数 + defectiveQuantity(次品数)
                
                    [self.navigationController pushViewController:vc animated:true];
                }
            } else {
                if ([inspectOrderVo.receiveOrderStatus isEqualToString:@"INSPECTING"]) {//质检中
                    YanHuoViewController09 *vc = [[YanHuoViewController09 alloc] init];
                    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:0];
                    NSMutableArray *inspectOrderItems = [[NSMutableArray alloc] initWithCapacity:0];
                    for (NSInteger i=0; i<inspectOrderVo.inspectOrderItems.count; i++) {
                        InspectOrderItemVo *model0 = inspectOrderVo.inspectOrderItems[i];
                        DeliverOrderItemBean *model1 = inspectOrderVo.deliverOrder.items[i];
                        
                        if (model0.isReceiveMianjian.integerValue == 1 || model0.receiveNum.doubleValue == 0) {
                            
                        } else {
                            [inspectOrderItems addObject:model0];
                            [items addObject:model1];
                        }
                    }
                    inspectOrderVo.inspectOrderItems = inspectOrderItems;
                    inspectOrderVo.deliverOrder.items = items;
                    vc.inspectOrderVo = inspectOrderVo;
                    [self.navigationController pushViewController:vc animated:true];
                } else if ([inspectOrderVo.receiveOrderStatus isEqualToString:@"INSPECTED"]) {//已质检
                    YanHuoDetailViewController *vc = [[YanHuoDetailViewController alloc] init];
                    
                    inspectOrderVo.deliveryContact = inspectOrderVo.deliverOrder.deliveryContact;
                    inspectOrderVo.deliveryPhone = inspectOrderVo.deliverOrder.deliveryPhone;
                    
                    vc.inspectOrderVo = inspectOrderVo;
                    [self.navigationController pushViewController:vc animated:true];
                }
            }
            _viewLoading.hidden = YES;
        } else {
//            [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
            _viewLoading.hidden = YES;
            self.viewBGNoInspect.hidden = false;
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
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
