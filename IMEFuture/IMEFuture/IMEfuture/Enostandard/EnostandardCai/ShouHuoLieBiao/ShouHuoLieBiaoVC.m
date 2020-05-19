//
//  ShouHuoLieBiaoVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/13.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ShouHuoLieBiaoVC.h"
#import "VoHeader.h"

#import "ShouHuoLieBiaoCell0.h"
#import "ShouHuoLieBiaoCell1.h"
#import "ShouHuoVC.h"
#import "ShouHuoXiangQingVC.h"

@interface ShouHuoLieBiaoVC () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayOrderOperate;
    NSMutableArray *_arrayTradeOrderItems;
    UITableView *_tableView0;
    UITableView *_tableView1;
    UIView *_viewLoading;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UIButton *button0;//tag = 100
@property (weak, nonatomic) IBOutlet UIButton *button1;//tag = 101
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLineLeading;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation ShouHuoLieBiaoVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _viewLoading.hidden = NO;
    [self initRequest];
    [self initRequestTradeOrderDetail];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.button0.tag = 100;
    self.button1.tag = 101;
    [self.button0 setTitleColor:colorCai forState:UIControlStateNormal];
    
    
    self.scrollView.delegate = self;
    self.scrollView.tag = 500;
    self.scrollView.contentSize = CGSizeMake(kMainW*2, 0);
    self.scrollView.pagingEnabled = YES;
    
    _tableView0 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH-_height_NavBar-40-10) style:UITableViewStyleGrouped];
    _tableView0.delegate = self;
    _tableView0.dataSource = self;
    _tableView0.tag = 200;
    _tableView0.backgroundColor = [UIColor clearColor];
    [_tableView0 registerNib:[UINib nibWithNibName:@"ShouHuoLieBiaoCell0" bundle:nil] forCellReuseIdentifier:@"shouHuoLieBiaoCell0"];
    _tableView0.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView0.tableFooterView = [UIView new];
    [self.scrollView addSubview:_tableView0];
    
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(kMainW, 0, kMainW, kMainH-_height_NavBar-40-10) style:UITableViewStyleGrouped];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.tag = 201;
    _tableView1.backgroundColor = [UIColor clearColor];
    [_tableView1 registerNib:[UINib nibWithNibName:@"ShouHuoLieBiaoCell1" bundle:nil] forCellReuseIdentifier:@"shouHuoLieBiaoCell1"];
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView1.tableFooterView = [UIView new];
    [self.scrollView addSubview:_tableView1];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    }
    return 10.f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 200) {
        return _arrayOrderOperate.count;
    } else if (tableView.tag == 201) {
        return _arrayTradeOrderItems.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 200) {
        return 159;
    } else if (tableView.tag == 201) {
        return 120;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 200) {
        ShouHuoLieBiaoCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoLieBiaoCell0" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageViewBuFa.hidden = YES;
        
        cell.button0.hidden = YES;
        cell.button1.hidden = YES;
        cell.button2.hidden = YES;
        
        OrderOperate *orderOperate = _arrayOrderOperate[indexPath.section];
        
        if ([orderOperate.orderOperateType isEqualToString:@"SR"]) {
            cell.imageViewBuFa.hidden = NO;
        }
        
        cell.label0.text = [NSString stringWithFormat:@"发货时间：%@",orderOperate.deliveryTime];
        cell.label1.text = [NSString stringWithFormat:@"发货单号：%@",orderOperate.operateCode];
        
        cell.label21.text = @"入库数量";
        cell.label210.text = [NSString stringWithFormat:@"%ld",[orderOperate.receiveQuantity integerValue]];
        cell.label22.text = @"退货数量";
        cell.label220.text = [NSString stringWithFormat:@"%ld",[orderOperate.deRefundQuantity integerValue]];
        
        if ([orderOperate.isReceived integerValue] == 1) {
            cell.label2.text = @"已收货";
            cell.imageView1.image = [UIImage imageNamed:@"time_deliver_goods_yes"];
            cell.button1.hidden = NO;//查看详情
        }
        if ([orderOperate.isReceived integerValue] == 0) {
            cell.label2.text = @"待收货";
            cell.imageView1.image = [UIImage imageNamed:@"time_deliver_goods_not"];
            if ([orderOperate.receiveQuantity integerValue] > 0) {
                cell.button0.hidden = NO;//去收货
                cell.button1.hidden = NO;//查看详情
            }
            if ([orderOperate.receiveQuantity integerValue] == 0) {
                cell.button0.hidden = NO;//去收货
            }
            if ([orderOperate.receiveQuantity integerValue] > 0) {
                if ([orderOperate.isReceived integerValue] != 1) {
                    cell.button2.hidden = NO;//结束收货
                }
            }
            if ([orderOperate.receiveQuantity integerValue] == 0) {
                cell.button2.hidden = NO;//结束收货
            }
        }
        
        cell.button0.tag = indexPath.section;
        [cell.button0 addTarget:self action:@selector(buttonClickChakanXiangQingOrQuShouHuo:) forControlEvents:UIControlEventTouchUpInside];
        cell.button1.tag = indexPath.section;
        [cell.button1 addTarget:self action:@selector(buttonClickChakanXiangQingOrQuShouHuo:) forControlEvents:UIControlEventTouchUpInside];
        cell.button2.tag = indexPath.section;
        [cell.button2 addTarget:self action:@selector(buttonClickChakanXiangQingOrQuShouHuo:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    } else if (tableView.tag == 201) {
        ShouHuoLieBiaoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoLieBiaoCell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TradeOrderItem *tradeOrderItem = _arrayTradeOrderItems[indexPath.section];
        
        cell.imageView1.image = [UIImage imageNamed:@"list1_not"];
        cell.label0.text = tradeOrderItem.partName;
        cell.label1.text = [NSString stringWithFormat:@"零件号/图号：%@",tradeOrderItem.partNumber];
        cell.label2.text = @"采购数量";
        cell.label21.text = @"累计发货数量";
        cell.label3.text = [NSString stringWithFormat:@"%@",tradeOrderItem.num];
        cell.label31.text = [NSString stringWithFormat:@"%@",tradeOrderItem.deliverNums];
        
        return cell;
    } else {
        return nil;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 500) {
        int x = scrollView.contentOffset.x;
        if (x < kMainW) {
            [self.button0 setTitleColor:colorCai forState:UIControlStateNormal];
            self.labelLineLeading.constant = 0;
            [self.button1 setTitleColor:colorRGB(102, 102, 102) forState:UIControlStateNormal];
        } else {
            [self.button0 setTitleColor:colorRGB(102, 102, 102) forState:UIControlStateNormal];
            self.labelLineLeading.constant = kMainW/2;
            [self.button1 setTitleColor:colorCai forState:UIControlStateNormal];
        }
    }
}

//结束收货Or查看详情Or去收货
- (void)buttonClickChakanXiangQingOrQuShouHuo:(UIButton *)sender {
    OrderOperate *orderOperate = _arrayOrderOperate[sender.tag];
    if ([sender.currentTitle isEqualToString:@"结束收货"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否结束收货？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self requestEndReceive:orderOperate];
        }];
        [alertController addAction:action];
        [alertController addAction:action1];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    if ([sender.currentTitle isEqualToString:@"查看详情"]) {
        ShouHuoXiangQingVC *shouHuoXiangQingVC = [[ShouHuoXiangQingVC alloc] init];
        shouHuoXiangQingVC.tradeOrderId = orderOperate.tradeOrderId;
        shouHuoXiangQingVC.orderOperateId = orderOperate.orderOperateId;
        [self.navigationController pushViewController:shouHuoXiangQingVC animated:YES];
    }
    if ([sender.currentTitle isEqualToString:@"去收货"]) {
        ShouHuoVC *shouHuoVC = [[ShouHuoVC alloc] init];
        shouHuoVC.orderOperateId = orderOperate.orderOperateId;
        [self.navigationController pushViewController:shouHuoVC animated:YES];
    }
}

- (IBAction)buttonClick01:(UIButton *)sender {
    if (sender.tag == 100) {
        [self.button0 setTitleColor:colorCai forState:UIControlStateNormal];
        self.labelLineLeading.constant = 0;
        [self.button1 setTitleColor:colorRGB(102, 102, 102) forState:UIControlStateNormal];
    }
    if (sender.tag == 101) {
        [self.button0 setTitleColor:colorRGB(102, 102, 102) forState:UIControlStateNormal];
        self.labelLineLeading.constant = kMainW/2;
        [self.button1 setTitleColor:colorCai forState:UIControlStateNormal];
    }
    [self.scrollView setContentOffset:CGPointMake((sender.tag-100)*kMainW, 0)];
}

//结束收货
- (void)requestEndReceive:(OrderOperate *)orderOperate1 {
    _viewLoading.hidden = NO;
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.orderOperateId = orderOperate1.orderOperateId;
    orderOperate.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    orderOperate.manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_endReceive parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            [self initRequest];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.tradeOrderId = self.tradeOrderId;
    orderOperate.sei_orderOperateType = [NSMutableArray arrayWithObjects:@"S",@"SR", nil];
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_deliverList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _arrayOrderOperate = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *arrayOrderOperate = model.list;
            for (NSDictionary *dic in arrayOrderOperate) {
                OrderOperate *obj = [OrderOperate mj_objectWithKeyValues:dic];
                NSLog(@">>%@<<",obj.needSend);
                [_arrayOrderOperate addObject:obj];
            }
            _viewLoading.hidden = YES;
            [_tableView0 reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

//订单详情
- (void)initRequestTradeOrderDetail {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    TradeOrder *tradeOrder = [[TradeOrder alloc] init];
    tradeOrder.orderId = self.tradeOrderId;
    postEntityBean.entity = tradeOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    //    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_tradeOrder_getTradeOrderDetail parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            TradeOrder *tradeOrder= [TradeOrder mj_objectWithKeyValues:returnEntityBean.entity];
            _arrayTradeOrderItems = tradeOrder.tradeOrderItems;
        }
    
        [_tableView1 reloadData];
        
    } fail:^(NSError *error) {

    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
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
