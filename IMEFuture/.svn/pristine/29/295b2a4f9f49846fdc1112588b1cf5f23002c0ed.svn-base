//
//  FaHuoLieBiaoVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "FaHuoLieBiaoVC.h"
#import "VoHeader.h"

#import "FaHuoLieBiaoCell.h"

#import "DuoCiFaHuoXiangQingVC.h"
#import "YiCiFaHuoXiangQingVC.h"
#import "BuFaHuoXiangQingVC.h"

@interface FaHuoLieBiaoVC () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayOrderOperate;
    UIView *_viewLoading;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation FaHuoLieBiaoVC

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
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoLieBiaoCell" bundle:nil] forCellReuseIdentifier:@"faHuoLieBiaoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayOrderOperate.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 185;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FaHuoLieBiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoLieBiaoCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.viewLine0.hidden = NO;
    cell.viewLine1.hidden = NO;
    
    OrderOperate *orderOperate = _arrayOrderOperate[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.viewLine0.hidden = YES;
    }
    if (indexPath.row == _arrayOrderOperate.count-1) {
        cell.viewLine1.hidden = YES;
    }
    NSArray *first = [[[orderOperate.deliveryTime componentsSeparatedByString:@" "] firstObject] componentsSeparatedByString:@"-"];
    NSString *string1 = [NSString stringWithFormat:@"%@-%@",first[1],first[2]];
    NSArray *second = [[[orderOperate.deliveryTime componentsSeparatedByString:@" "] lastObject] componentsSeparatedByString:@":"];
    NSString *string2 = [NSString stringWithFormat:@"%@:%@",second[0],second[1]];
    cell.label0.text = string1;
    cell.label1.text = string2;
    
    cell.imageView1.image = [orderOperate.orderOperateType isEqualToString:@"SR"]?[UIImage imageNamed:@"icon_repair"]:[UIImage imageNamed:@"icon_shipping_list"];
    
    cell.label3.text = [orderOperate.isReceived integerValue] == 1?@"采购商已收货":@"采购商待收货";
    cell.label40.text = [NSString stringWithFormat:@"发货单号：%@",orderOperate.operateCode];
    cell.label41.text = [NSString stringWithFormat:@"送货单号：%@",orderOperate.deliverNumber.length>0?orderOperate.deliverNumber:@"暂无"];
    cell.label42.text = [NSString stringWithFormat:@"运单号：%@",orderOperate.logisticsNo.length>0?orderOperate.logisticsNo:@"暂无"];
    
    cell.buttonChaKanXiangQing.tag = indexPath.row;
    [cell.buttonChaKanXiangQing addTarget:self action:@selector(buttonClickChaKanXiangQing:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)buttonClickChaKanXiangQing:(UIButton *)sender {
    OrderOperate *orderOperate = _arrayOrderOperate[sender.tag];
    //详情分三种 补发货、多次发货、一次发货
    NSLog(@"isPre:%ld orderOperateType:%@",[orderOperate.tradeOrder.isPre integerValue],orderOperate.orderOperateType);
    if ([orderOperate.orderOperateType isEqualToString:@"SR"]) {//补发货
        BuFaHuoXiangQingVC *buFaHuoXQVC = [[BuFaHuoXiangQingVC alloc] init];
        buFaHuoXQVC.orderOperateId = orderOperate.orderOperateId;
        [self.navigationController pushViewController:buFaHuoXQVC animated:YES];
    } else {
        if ([orderOperate.tradeOrder.isPre integerValue] == 0) {//一次发货
            YiCiFaHuoXiangQingVC *yiCiFaHuoXQVC = [[YiCiFaHuoXiangQingVC alloc] init];
            yiCiFaHuoXQVC.orderOperateId = orderOperate.orderOperateId;
            [self.navigationController pushViewController:yiCiFaHuoXQVC animated:YES];
        }
        if ([orderOperate.tradeOrder.isPre integerValue] == 1) {//多次发货
            DuoCiFaHuoXiangQingVC *duoCiFaHuoXQVC = [[DuoCiFaHuoXiangQingVC alloc] init];
            duoCiFaHuoXQVC.orderOperateId = orderOperate.orderOperateId;
            [self.navigationController pushViewController:duoCiFaHuoXQVC animated:YES];
        }
    }
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = loginModel.memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.tradeOrderId = self.tradeOrderId;
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_deliverList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _arrayOrderOperate = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *arrayOrderOperate = model.list;
            for (NSDictionary *dic in arrayOrderOperate) {
                OrderOperate *obj = [OrderOperate mj_objectWithKeyValues:dic];
                [_arrayOrderOperate addObject:obj];
            }
            _viewLoading.hidden = YES;
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (IBAction)back:(UIButton *)sender {
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
