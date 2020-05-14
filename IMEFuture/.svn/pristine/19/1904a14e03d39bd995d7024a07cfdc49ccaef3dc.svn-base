//
//  YanHuoLieBiaoVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/23.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "YanHuoLieBiaoVC.h"
#import "VoHeader.h"


#import "YanHuoLieBiaoCell.h"
#import "YanHuoVC.h"
#import "YanHuoXiangQingVC.h"



@interface YanHuoLieBiaoVC () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayOrderOperate;
    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation YanHuoLieBiaoVC

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
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoLieBiaoCell" bundle:nil] forCellReuseIdentifier:@"yanHuoLieBiaoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrayOrderOperate.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 205;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YanHuoLieBiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoLieBiaoCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.label1.hidden = YES;
    OrderOperate *orderOperate = _arrayOrderOperate[indexPath.section];
    
    if ([orderOperate.isInspect integerValue] == 0) {
        cell.button.layer.borderColor = colorCai.CGColor;
        [cell.button setTitleColor:colorCai forState:UIControlStateNormal];
        [cell.button setTitle:@"验货" forState:UIControlStateNormal];
    }
    if ([orderOperate.isInspect integerValue] == 1) {
        cell.button.layer.borderColor = colorRGB(221, 221, 221).CGColor;
        [cell.button setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
        [cell.button setTitle:@"查看详情" forState:UIControlStateNormal];
    }
    
    cell.label0.text = [NSString stringWithFormat:@"收货单号：%@",orderOperate.receiveCode];
    if ([orderOperate.isInspect integerValue] == 1) {
        cell.label1.hidden = NO;
        if ([orderOperate.inspecStatus integerValue] == 0) {
            cell.label1.text = @"验货通过";
        }
        if ([orderOperate.inspecStatus integerValue] == 1) {
            cell.label1.text = @"验货未通过";
        }
    }
    
    cell.label2.text = [NSString stringWithFormat:@"验货时间：%@",orderOperate.receviceInspecTime.length>0?orderOperate.receviceInspecTime:@""];
    cell.label3.text = [orderOperate.inspecQuantity integerValue] > 0?[NSString stringWithFormat:@"验货数量：%ld",[orderOperate.inspecQuantity integerValue]]:@"验货数量：";
    cell.label4.text = [NSString stringWithFormat:@"发货单号：%@",orderOperate.deliverCode];
    cell.label5.text = [NSString stringWithFormat:@"发货时间：%@",orderOperate.deliveryTime];
    cell.button.tag = indexPath.section;
    [cell.button addTarget:self action:@selector(buttonClickYanHuoOrChaKanXiangQing:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)buttonClickYanHuoOrChaKanXiangQing:(UIButton *)sender {
    OrderOperate *orderOperate = _arrayOrderOperate[sender.tag];
    if ([sender.currentTitle isEqualToString:@"验货"]) {
        YanHuoVC *yanHuoVC = [[YanHuoVC alloc] init];
        yanHuoVC.orderOperateId = orderOperate.orderOperateId;
        [self.navigationController pushViewController:yanHuoVC animated:YES];
    }
    if ([sender.currentTitle isEqualToString:@"查看详情"]) {
        YanHuoXiangQingVC *yanHuoXiangQingVC = [[YanHuoXiangQingVC alloc] init];
        yanHuoXiangQingVC.orderOperateId = orderOperate.orderOperateId;
        [self.navigationController pushViewController:yanHuoXiangQingVC animated:YES];
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
    
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_receiveList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            _arrayOrderOperate = [[NSMutableArray alloc] initWithCapacity:0];
            
            for (NSInteger i = 0; i < returnListBean.list.count; i++) {
                NSDictionary *dic = returnListBean.list[i];
                OrderOperate *orderOperate = [OrderOperate mj_objectWithKeyValues:dic];
                [_arrayOrderOperate addObject:orderOperate];
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
