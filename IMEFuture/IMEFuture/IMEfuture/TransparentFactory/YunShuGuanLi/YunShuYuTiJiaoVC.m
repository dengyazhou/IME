//
//  YunShuYuTiJiaoVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/8.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "YunShuYuTiJiaoVC.h"
#import "VoHeader.h"
#import "saoYiSaoVC.h"
#import "YunShuCell.h"
#import "YunShuDetailVC.h"

@interface YunShuYuTiJiaoVC () <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource> {
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation YunShuYuTiJiaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"YunShuCell" bundle:nil] forCellReuseIdentifier:@"yunShuCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW-34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    self.labelCount.text = [NSString stringWithFormat:@"已扫描%@张送货单",@1];
    
    self.textField.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.transportOrderVoArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YunShuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yunShuCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    TransportOrderVo *transportOrder = self.transportOrderVoArray[indexPath.section];
    
    cell.label01.text = transportOrder.supplierText;
    cell.label02.text = transportOrder.address;
    
    cell.label11.text = @"1";
    cell.label12.text = @"00:00:00";
    
    cell.button13.hidden = true;
    cell.label13.text = @"创建";
    
    return cell;
}

//1、不需要canEditRowAtIndexPath方法，只有下面的方法就可以
//2、如果需要有的Cell不能左滑，可以设置return返回空数组，设置return nil 没用
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self.transportOrderVoArray removeObjectAtIndex:indexPath.section];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        [tableView reloadData];//加上这一句解决了滑动删除 不和谐的问题，去掉这一句也OK
        
        self.labelCount.text = [NSString stringWithFormat:@"已扫描%lu张送货单",(unsigned long)self.transportOrderVoArray.count];
        
    }];
    deleteAction.backgroundColor = colorRGB(249, 52, 52);

    return @[deleteAction];
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

#pragma mark 批量提交
- (IBAction)buttonPiLianTiJiao:(id)sender {
    _viewLoading.hidden = NO;
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (TransportOrderVo *vo in self.transportOrderVoArray) {
        TransportOrderVo *transportOrder = [[TransportOrderVo alloc] init];
        transportOrder.siteCode = vo.siteCode;
        transportOrder.outgoingOrderNum = vo.outgoingOrderNum;
        transportOrder.createUser = userInfo.userCode;
        transportOrder.modifyUser = userInfo.userCode;
        [tempArray addObject:transportOrder];
    }
    postEntityBean.entity = tempArray;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_mes_transportOrder_createTransportOrder parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = YES;
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            TransportOrderVo *transportOrder = [TransportOrderVo mj_objectWithKeyValues:returnEntityBean.entity];
            
            // 回到YunShuDetailVC
            [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isMemberOfClass:[YunShuDetailVC class]]) {
                    [self.navigationController popToViewController:obj animated:YES];
                    [(YunShuDetailVC *)obj initRequest];
                    *stop = YES;
                }
            }];
        }
        
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

- (void)request:(NSString *)result {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
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
                BOOL flag = NO;
                for (TransportOrderVo *vo in self.transportOrderVoArray) {
                    if ([vo.outgoingOrderNum isEqualToString:result]) {
                        flag = YES;
                        break;
                    }
                }
                if (!flag) {
                    [self.transportOrderVoArray addObject:transportOrder];
                }
                
                [self.tableView reloadData];
                self.labelCount.text = [NSString stringWithFormat:@"已扫描%lu张送货单",(unsigned long)self.transportOrderVoArray.count];
            }
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    
}

- (void)showAlert:(NSString *)str {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertVC animated:true completion:nil];
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
