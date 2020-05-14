//
//  ShouHuoDiZhiVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/1/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ShouHuoDiZhiVC.h"
#import "VoHeader.h"

#import "ShouHuoDiZhiCell.h"
#import "XinZengShouHuoDiZhiVC.h"


@interface ShouHuoDiZhiVC () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayEnterpriseAddressBean;
    NSInteger _isDefault;
    
    UIView *_viewLoading;
    
    UIView *_viewNoContent;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *arrayData;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation ShouHuoDiZhiVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _viewLoading.hidden = NO;
    [self initRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoDiZhiCell" bundle:nil] forCellReuseIdentifier:@"shouHuoDiZhiCell"];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.tableView.estimatedRowHeight = 132;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    
    _viewNoContent = [UIView addView:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-50) imageNamed:@"icon_no_address" title:@"暂无收货地址"];
    [self.view addSubview:_viewNoContent];
    _viewNoContent.hidden = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrayEnterpriseAddressBean.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShouHuoDiZhiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoDiZhiCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    EnterpriseAddressBean *enterpriseAddressBean = _arrayEnterpriseAddressBean[indexPath.section];
    
    if (_isDefault == indexPath.section) {
        [cell.button0 setImage:[UIImage imageNamed:@"icon_defaultaddress"] forState:UIControlStateNormal];
    } else {
        [cell.button0 setImage:[UIImage imageNamed:@"icon_unchecked"] forState:UIControlStateNormal];
    }
    
    cell.label0.text = enterpriseAddressBean.name;
//    cell.label1.text = enterpriseAddressBean.phone;
    cell.label1.text = enterpriseAddressBean.phone.length>0?enterpriseAddressBean.phone:enterpriseAddressBean.tel;
    NSString *string2 = [NSString stringWithFormat:@"%@ %@",enterpriseAddressBean.zoneStr,enterpriseAddressBean.address];
    cell.label2.text = string2;
    
    [cell.button0 addTarget:self action:@selector(button0MoRenDiZhi:) forControlEvents:UIControlEventTouchUpInside];
    cell.button0.tag = indexPath.section;
    
    [cell.button1 addTarget:self action:@selector(button1BianJi:) forControlEvents:UIControlEventTouchUpInside];
    cell.button1.tag = indexPath.section;
    
    [cell.button2 addTarget:self action:@selector(button2ShanChu:) forControlEvents:UIControlEventTouchUpInside];
    cell.button2.tag = indexPath.section;
    
    return cell;
}

#pragma mark 默认地址
- (void)button0MoRenDiZhi:(UIButton *)sender {
    if (sender.tag == _isDefault) {
        return;
    }
    
    _viewLoading.hidden = NO;
    EnterpriseAddressBean *enterpriseAddressBean0 = _arrayEnterpriseAddressBean[sender.tag];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    EnterpriseAddressBean *enterpriseAddressBean = [[EnterpriseAddressBean alloc] init];
    enterpriseAddressBean.enterpriseId = loginModel.enterpriseId;
    enterpriseAddressBean.addressId = enterpriseAddressBean0.addressId;
    enterpriseAddressBean.isDefault = [NSNumber numberWithInteger:1];
    enterpriseAddressBean.address = enterpriseAddressBean0.address;
    enterpriseAddressBean.zipcode = enterpriseAddressBean0.zipcode;
    enterpriseAddressBean.zoneId1 = enterpriseAddressBean0.zoneId1;
    enterpriseAddressBean.zoneId2 = enterpriseAddressBean0.zoneId2;
    enterpriseAddressBean.zoneId3 = enterpriseAddressBean0.zoneId3;
    enterpriseAddressBean.zoneStr = enterpriseAddressBean0.zoneStr;
    enterpriseAddressBean.phone = enterpriseAddressBean0.phone;
    enterpriseAddressBean.telZip = enterpriseAddressBean0.telZip;
    enterpriseAddressBean.tel = enterpriseAddressBean0.tel;
    enterpriseAddressBean.extension = enterpriseAddressBean0.extension;
    enterpriseAddressBean.name = enterpriseAddressBean0.name;
    
    postEntityBean.entity = enterpriseAddressBean.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
//    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_enterpriseAddress_updateEnterpriseAddress parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = YES;
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            enterpriseAddressBean0.isDefault = [NSNumber numberWithInteger:1];
            _isDefault = sender.tag;
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}
#pragma mark 编辑
- (void)button1BianJi:(UIButton *)sender {
    EnterpriseAddressBean *enterpriseAddressBean0 = _arrayEnterpriseAddressBean[sender.tag];
    XinZengShouHuoDiZhiVC *xinZengShouHuoDiZhiVC = [[XinZengShouHuoDiZhiVC alloc] init];
    xinZengShouHuoDiZhiVC.isEdit = 1;
    xinZengShouHuoDiZhiVC.enterpriseAddressBean = enterpriseAddressBean0;
    [self.navigationController pushViewController:xinZengShouHuoDiZhiVC animated:YES];
}
#pragma mark 删除
- (void)button2ShanChu:(UIButton *)sender {
//    NSLog(@"%ld",sender.tag);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认删除该收货地址吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _viewLoading.hidden = NO;
        EnterpriseAddressBean *enterpriseAddressBean0 = _arrayEnterpriseAddressBean[sender.tag];
        
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        EnterpriseAddressBean *enterpriseAddressBean = [[EnterpriseAddressBean alloc] init];
        enterpriseAddressBean.addressId = enterpriseAddressBean0.addressId;
        
        postEntityBean.entity = enterpriseAddressBean.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_enterpriseAddress_deleteEnterpriseAddress parameters:dic success:^(id responseObjectModel) {
            _viewLoading.hidden = YES;
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [_arrayEnterpriseAddressBean removeObjectAtIndex:sender.tag];
                [self.tableView reloadData];
                if (_arrayEnterpriseAddressBean.count != 0) {
                    _viewNoContent.hidden = YES;
                } else {
                    _viewNoContent.hidden = NO;
                }
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
        
    }];
    [alertController addAction:action0];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];
    

}
#pragma mark 新增地址
- (IBAction)buttonXinZengDiZhi:(UIButton *)sender {
    EnterpriseAddressBean *enterpriseAddressBean0 = [[EnterpriseAddressBean alloc] init];
    XinZengShouHuoDiZhiVC *xinZengShouHuoDiZhiVC = [[XinZengShouHuoDiZhiVC alloc] init];
    xinZengShouHuoDiZhiVC.isEdit = 0;
    xinZengShouHuoDiZhiVC.enterpriseAddressBean = enterpriseAddressBean0;
    [self.navigationController pushViewController:xinZengShouHuoDiZhiVC animated:YES];
}

- (void)initRequest {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    EnterpriseAddressBean *enterpriseAddressBean = [[EnterpriseAddressBean alloc] init];
    enterpriseAddressBean.enterpriseId = loginModel.enterpriseId;
    
    postEntityBean.entity = enterpriseAddressBean.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_enterpriseAddress_getEnterpriseAddressInfo parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = YES;
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            _arrayEnterpriseAddressBean = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *arrayEnterpriseAddressBean = returnListBean.list;
            if (arrayEnterpriseAddressBean.count != 0) {
                for (NSInteger i = 0; i < arrayEnterpriseAddressBean.count; i++) {
                    EnterpriseAddressBean *obj = [EnterpriseAddressBean mj_objectWithKeyValues:arrayEnterpriseAddressBean[i]];
                    if ([obj.isDefault integerValue] == 1) {
                        _isDefault = i;
                    }
                    [_arrayEnterpriseAddressBean addObject:obj];
                }
                [self.tableView reloadData];
                _viewNoContent.hidden = YES;
            } else {
                _viewNoContent.hidden = NO;
            }
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
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
