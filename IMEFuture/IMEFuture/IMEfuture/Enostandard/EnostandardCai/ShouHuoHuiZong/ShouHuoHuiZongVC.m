//
//  ShouHuoHuiZongVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/22.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ShouHuoHuiZongVC.h"
#import "VoHeader.h"

#import "ShouHuoLieBiaoCell1.h"

@interface ShouHuoHuiZongVC () <UITableViewDelegate,UITableViewDataSource> {
    OrderOperate *_orderOperate;
    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation ShouHuoHuiZongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoLieBiaoCell1" bundle:nil] forCellReuseIdentifier:@"shouHuoLieBiaoCell1"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    [self initRequest];
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
    return _orderOperate.orderOperateItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShouHuoLieBiaoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoLieBiaoCell1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[indexPath.section];
    
    cell.imageView1.image = [UIImage imageNamed:@"list1_not"];
    cell.label0.text = orderOperateItem.tradeOrderItem.partName;
    cell.label1.text = [NSString stringWithFormat:@"零件号/图号：%@",orderOperateItem.tradeOrderItem.partNumber];
    cell.label2.text = @"采购数量";
    cell.label21.text = @"入库数量";
    cell.label3.text = [NSString stringWithFormat:@"%@",orderOperateItem.tradeOrderItem.num];
    cell.label31.text = [NSString stringWithFormat:@"%@",orderOperateItem.receiveQuantity];
    
    return cell;
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.orderOperateId = self.orderOperateId;
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_deliverDetail parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _orderOperate = [OrderOperate mj_objectWithKeyValues:model.entity];
            _viewLoading.hidden = YES;
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
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
