//
//  EFBFaPanViewController1.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/2/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "EFBFaPanViewController2.h"
#import "UIView+AddViewNoNetAndNoContent.h"

#import "Masonry.h"

#import "EFBFaPanCell200.h"
#import "EFBFaPanCell201.h"

#import "XuanZeShouHuoDiZhiVC.h"

#import "ToolTransition.h"
#import "IMETabBarViewController.h"
#import "RefreshManager.h"

#import "GlobalSettingManager.h"


@interface EFBFaPanViewController2 () <UITableViewDelegate,UITableViewDataSource> {
    
    UIView *_viewLoading;

    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (nonatomic,strong) EnterpriseAddressBean *enterpriseAddressBean;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation EFBFaPanViewController2

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EFBFaPanCell200" bundle:nil] forCellReuseIdentifier:@"eFBFaPanCell200"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EFBFaPanCell201" bundle:nil] forCellReuseIdentifier:@"eFBFaPanCell201"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 132;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 30;
    } else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 30)];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] init];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(view.mas_centerY);
        }];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = colorRGB(153, 153, 153);
        label.text = @"步骤三：选择地址";
        return view;
    } else {
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.inquiryOrder.address.length > 0) {//选择过地址 //用self.inquiryOrder.address判断是否选择过地址
            EFBFaPanCell200 *cell = [tableView dequeueReusableCellWithIdentifier:@"eFBFaPanCell200" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.label0.text = self.inquiryOrder.name;
            cell.label1.text = self.inquiryOrder.phone;
            NSString *string2 = [NSString stringWithFormat:@"%@ %@",self.inquiryOrder.zoneStr,self.inquiryOrder.address];
            cell.label2.text = string2;
            
            return cell;
        } else {
            EFBFaPanCell201 *cell = [tableView dequeueReusableCellWithIdentifier:@"eFBFaPanCell201" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.textField.tintColor = [UIColor clearColor];
            cell.textField.inputView = [UIView new];
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
            cell.textField.rightView = imageView;
            cell.textField.rightViewMode = UITextFieldViewModeAlways;
            cell.textField.placeholder = @"请选择，必填项";
            
            cell.buttonTextField.tag = indexPath.row;
            [cell.buttonTextField addTarget:self action:@selector(buttonTextFieldClickXuanZeShouHuoDiZhi:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self buttonTextFieldClickXuanZeShouHuoDiZhi:nil];
}

#pragma mark 发布询盘
- (IBAction)buttonFaBuXunPan:(UIButton *)sender {

    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:3]]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
        return;
    }

    
    for (InquiryOrderItem *inquiryOrderItem in self.inquiryOrder.inquiryOrderItems) {
        if (inquiryOrderItem.sec_batchDeliverItem == nil || inquiryOrderItem.sec_batchDeliverItem.count == 0) {
            inquiryOrderItem.batchDeliverNum = [NSNumber numberWithInteger:1];
            NSMutableArray *arrayDeliverItem = [NSMutableArray arrayWithCapacity:0];
            BatchDeliverItem *bdItem = [[BatchDeliverItem alloc] init];
            bdItem.deliverTm = self.inquiryOrder.expectRcvTm;
            bdItem.num = [inquiryOrderItem.num1 stringValue];
            [arrayDeliverItem addObject:bdItem];
            inquiryOrderItem.sec_batchDeliverItem = arrayDeliverItem;
        }
        inquiryOrderItem.isVisiblePrice = self.inquiryOrder.isVisiblePrice;//目标价是否可见
    }

    
    if (self.inquiryOrder.address == nil) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择收货地址"];
        return;
    }
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = loginModel.memberId;
    self.inquiryOrder.manufacturerId =  loginModel.manufacturerId;
    postEntityBean.entity = self.inquiryOrder.mj_keyValues;
    
    JwtMember *jwtMember = [[JwtMember alloc] init];
    jwtMember.memberId = loginModel.memberId;
    jwtMember.manufacturerId = loginModel.manufacturerId;
    postEntityBean.jwtMember = jwtMember;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    NSLog(@"%@",[dic mj_JSONString]);

    
    _viewLoading.hidden = NO;
    
    [HttpMamager postRequestWithURLString:DYZ_inquiry_add parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = YES;
        ReturnMsgBean *returnMsgBean = responseObjectModel;
    
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"发盘成功"];
        } else {
            if ([returnMsgBean.status isEqualToString:@"PROHIBIT"]) {
                
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您尚未开通采购商，请拨打客服热线4008210402！"];
                
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"发盘失败"];
            }
        }
        
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isMemberOfClass:[IMETabBarViewController class]]) {
                UITabBarController *tab = (UITabBarController *)vc;
                [self.navigationController popToViewController:vc animated:YES];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshECInquiryFaPan" object:nil];
       
                break;
            }
        }
        
    } fail:^(NSError *error) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"发盘fail"];
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

#pragma mark 选择收货地址
- (void)buttonTextFieldClickXuanZeShouHuoDiZhi:(UIButton *)sender {
    XuanZeShouHuoDiZhiVC *xuanZeShouHuoDiZhiVC = [[XuanZeShouHuoDiZhiVC alloc] init];
    
    if (self.inquiryOrder.address) {
        xuanZeShouHuoDiZhiVC.enterpriseAddressBean = self.enterpriseAddressBean;
    }
    
    [xuanZeShouHuoDiZhiVC backEnterpriseAddressBean:^(EnterpriseAddressBean *enterpriseAddressBean) {
//        NSLog(@"%@",enterpriseAddressBean.address);
        self.enterpriseAddressBean = enterpriseAddressBean;
        
        self.inquiryOrder.address = enterpriseAddressBean.address;
        self.inquiryOrder.zipcode = enterpriseAddressBean.zipcode;
        self.inquiryOrder.zoneId1 = [DatabaseTool t_ZoneSelectZoneWithZone_id:[NSNumber numberWithInteger:[enterpriseAddressBean.zoneId1 integerValue]]];
        self.inquiryOrder.zoneId2 = [DatabaseTool t_ZoneSelectZoneWithZone_id:[NSNumber numberWithInteger:[enterpriseAddressBean.zoneId2 integerValue]]];;
        self.inquiryOrder.zoneId3 = [DatabaseTool t_ZoneSelectZoneWithZone_id:[NSNumber numberWithInteger:[enterpriseAddressBean.zoneId3 integerValue]]];;
        self.inquiryOrder.zoneStr = enterpriseAddressBean.zoneStr;
        self.inquiryOrder.phone = enterpriseAddressBean.phone;
        self.inquiryOrder.telZip = enterpriseAddressBean.telZip;
        self.inquiryOrder.tel = enterpriseAddressBean.tel;
        self.inquiryOrder.extension  = enterpriseAddressBean.extension;
        self.inquiryOrder.name= enterpriseAddressBean.name;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
    [self.navigationController pushViewController:xuanZeShouHuoDiZhiVC animated:YES];
}


#pragma mark 智造家人工推荐合适的供应商(免费)~匿名采购
- (void)switchAction:(UISwitch *)sender {
    if (sender.tag == 1) {
    //智造家人工推荐合适的供应商(免费)
        BOOL isButtonOn = [sender isOn];
        if (isButtonOn) {
            self.inquiryOrder.allowTracking = [NSNumber numberWithInteger:1];
        } else {
            self.inquiryOrder.allowTracking = [NSNumber numberWithInteger:0];
        }
    } else if (sender.tag == 2) {
    //匿名采购
        BOOL isButtonOn = [sender isOn];
        if (isButtonOn) {
            self.inquiryOrder.isPrivate = [NSNumber numberWithInteger:1];
        } else {
            self.inquiryOrder.isPrivate = [NSNumber numberWithInteger:0];
        }
    }
}

- (IBAction)back:(id)sender {
    self.buttonBackBlock(self.inquiryOrder);
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
