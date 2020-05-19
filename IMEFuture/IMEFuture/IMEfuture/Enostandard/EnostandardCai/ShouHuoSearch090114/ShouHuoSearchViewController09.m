//
//  ShouHuoSearchViewController09.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ShouHuoSearchViewController09.h"
#import "VoHeader.h"
#import "SaoYiSaoVCWhite.h"
#import "ShouHuoViewController09.h"
#import "ShouHuoDetailViewController09.h"

@interface ShouHuoSearchViewController09 () <UITextFieldDelegate>{
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *viewBGNoreceive;


@end

@implementation ShouHuoSearchViewController09

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.textField.inputAccessoryView = [self addToolbar];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = true;
    
    self.viewBGNoreceive.hidden = true;
    
}

- (IBAction)textFieldEditingDidBeginDDD:(UITextField *)sender {
    self.viewBGNoreceive.hidden= true;
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
            if (inspectOrderVo.receiveOrder == nil) {//收货
                ShouHuoViewController09 *vc = [ShouHuoViewController09 new];
                vc.deliverOrderDetailBean = inspectOrderVo.deliverOrder;
                [self.navigationController pushViewController:vc animated:true];
            } else {//收货详情
                ShouHuoDetailViewController09 *vc = [[ShouHuoDetailViewController09 alloc] init];
                inspectOrderVo.receiveOrder.deliverOrder = inspectOrderVo.deliverOrder;
                vc.receiveBean = inspectOrderVo.receiveOrder;
                NSLog(@"%@",vc.receiveBean);
                [self.navigationController pushViewController:vc animated:true];

            }
            _viewLoading.hidden = YES;
        } else {
//            [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
            _viewLoading.hidden = YES;
            self.viewBGNoreceive.hidden = false;
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

- (IBAction)buttonScan:(id)sender {
    SaoYiSaoVCWhite *vc = [[SaoYiSaoVCWhite alloc] init];
    vc.scanTitle = @"扫描收货单号";
    [vc setResultBlock:^(NSString *result) {
        [self requestDeliverCode:result];
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

//- (UIToolbar *)addToolbar {
//    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 38)];
//    toolbar.tintColor = colorRGB(0, 168, 255);
//    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
//    toolbar.items = @[space,bar];
//    return toolbar;
//}
//
//- (void)textFieldDone {
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
//}

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
