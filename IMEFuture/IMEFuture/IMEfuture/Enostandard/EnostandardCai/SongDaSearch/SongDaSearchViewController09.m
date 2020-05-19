//
//  SongDaSearchViewController09.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "SongDaSearchViewController09.h"
#import "VoHeader.h"
#import "SaoYiSaoVCWhite.h"
#import "YanHuoViewController09.h"
#import "YanHuoDetailViewController.h"


@interface SongDaSearchViewController09 () <UITextFieldDelegate>{
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *viewBGNoInspect;

@end

@implementation SongDaSearchViewController09

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
        [self performSelector:@selector(afterdyz:) withObject:result afterDelay:1];//延迟调用一下，不然UIAlertController出不来
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)afterdyz:(NSString *)str {
    [self requestDeliverCode:str];
}

- (void)requestDeliverCode:(NSString *)deliverCode{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认是否送达?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
            _viewLoading.hidden = false;
            EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
            postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
            DeliverOrderReqBean *deliverOrderReqBean = [DeliverOrderReqBean new];
            deliverOrderReqBean.deliverCode = deliverCode;
            postEntityBean.entity = deliverOrderReqBean.mj_keyValues;
            NSDictionary *dic = postEntityBean.mj_keyValues;
        
            [HttpMamager postRequestWithURLString:DYZ_aip_deliverOrder_purchaseSetSdTime parameters:dic success:^(id responseObjectModel) {
                ReturnEntityBean *model = responseObjectModel;
                if ([model.status isEqualToString:@"SUCCESS"]) {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"送达成功"];
                    _viewLoading.hidden = YES;
                } else {
                    if (model.returnCode.integerValue == -2) {
                        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"该订单不能送达！"];
                    }else {
                        [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
                    }
                    _viewLoading.hidden = YES;
//                    self.viewBGNoInspect.hidden = false;
                }
            } fail:^(NSError *error) {
                
            } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
        
        
        
    }];
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
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
