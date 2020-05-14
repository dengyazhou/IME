//
//  XuanZeShouHuoDiZhiVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/1/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "XuanZeShouHuoDiZhiVC.h"
#import "VoHeader.h"

#import "XuanZeShouHuoDiZhiCell.h"
#import "ShouHuoDiZhiVC.h"

#import "VoHeader.h"


@interface XuanZeShouHuoDiZhiVC () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayEnterpriseAddressBean;
    NSInteger _isDefault;
    
    UIView *_viewLoading;
    
    UIView *_viewNoContent;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;



@end

@implementation XuanZeShouHuoDiZhiVC

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
    [self.tableView registerNib:[UINib nibWithNibName:@"XuanZeShouHuoDiZhiCell" bundle:nil] forCellReuseIdentifier:@"xuanZeShouHuoDiZhiCell"];
    
    //下面的两个方法写一个就好，带来的效果一样
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.estimatedRowHeight = 90.5;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    
    _viewNoContent = [UIView addView:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) imageNamed:@"icon_no_address" title:@"暂无收货地址"];
    [self.view addSubview:_viewNoContent];
    _viewNoContent.hidden = YES;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayEnterpriseAddressBean.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XuanZeShouHuoDiZhiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xuanZeShouHuoDiZhiCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.viewLineLeading.constant = 46;
    if (indexPath.row == _arrayEnterpriseAddressBean.count-1) {
        cell.viewLineLeading.constant = 0;
    }
    
    EnterpriseAddressBean *enterpriseAddressBean = _arrayEnterpriseAddressBean[indexPath.row];
    
    if (_isDefault == indexPath.row) {
        cell.imageView1.image = [UIImage imageNamed:@"icon_defaultaddress"];//选中
    } else {
        cell.imageView1.image = [UIImage imageNamed:@"icon_unchecked"];
    }
    
    cell.label0.text = enterpriseAddressBean.name;
    cell.label1.text = enterpriseAddressBean.phone.length>0?enterpriseAddressBean.phone:enterpriseAddressBean.tel;
    NSString *string2 = [NSString stringWithFormat:@"%@ %@",enterpriseAddressBean.zoneStr,enterpriseAddressBean.address];
    cell.label2.text = string2;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _isDefault = indexPath.row;
    [tableView reloadData];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (_arrayEnterpriseAddressBean.count > 0) {
        EnterpriseAddressBean *enterpriseAddressBean = _arrayEnterpriseAddressBean[_isDefault];
        self.backBlock(enterpriseAddressBean);
    } else {
        EnterpriseAddressBean *enterpriseAddressBean = [[EnterpriseAddressBean alloc] init];
        self.backBlock(enterpriseAddressBean);
    }
    
}

- (IBAction)buttonGuanLi:(id)sender {
    ShouHuoDiZhiVC *shouHuoDiZhiVC = [[ShouHuoDiZhiVC alloc] init];
    [self.navigationController pushViewController:shouHuoDiZhiVC animated:YES];
}

- (void)initRequest {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    EnterpriseAddressBean *enterpriseAddressBean = [[EnterpriseAddressBean alloc] init];
    enterpriseAddressBean.enterpriseId = loginModel.enterpriseId;
    
    postEntityBean.entity = enterpriseAddressBean.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
//    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_enterpriseAddress_getEnterpriseAddressInfo parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = YES;
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            _arrayEnterpriseAddressBean = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *arrayEnterpriseAddressBean = returnListBean.list;
            if (arrayEnterpriseAddressBean.count != 0) {
                for (NSInteger i = 0; i < arrayEnterpriseAddressBean.count; i++) {
                    EnterpriseAddressBean *obj = [EnterpriseAddressBean mj_objectWithKeyValues:arrayEnterpriseAddressBean[i]];
                    if (self.enterpriseAddressBean) {//已经选择过地址
                        if ([self.enterpriseAddressBean.addressId isEqualToString:obj.addressId]) {
                            _isDefault = i;
                        }
                    } else {//没选择过地址
                        if ([obj.isDefault integerValue] == 1) {
                            _isDefault = i;
                        }
                    }
                    
                    [_arrayEnterpriseAddressBean addObject:obj];
                }
                
                NSLog(@"%ld",_isDefault);
                
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
    
    if (_arrayEnterpriseAddressBean.count > 0) {
        EnterpriseAddressBean *enterpriseAddressBean = _arrayEnterpriseAddressBean[_isDefault];
        self.backBlock(enterpriseAddressBean);
    } else {
        EnterpriseAddressBean *enterpriseAddressBean = [[EnterpriseAddressBean alloc] init];
        self.backBlock(enterpriseAddressBean);
    }
}

- (void)backEnterpriseAddressBean:(void (^)(EnterpriseAddressBean *))block {
    self.backBlock = block;
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
