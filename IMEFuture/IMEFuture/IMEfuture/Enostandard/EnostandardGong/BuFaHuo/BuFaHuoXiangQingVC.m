//
//  DuoCiFaHuoXiangQingVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BuFaHuoXiangQingVC.h"
#import "VoHeader.h"

#import "FaHuoCell0.h"

#import "FaHuoCell2.h"
#import "FaHuoCell31.h"
#import "FaHuoHeaderView.h"
#import "ShouHuoLieBiaoCell1.h"
#import "FaHuoXiangQingCell.h"


#import "UIButtonIM.h"


@interface BuFaHuoXiangQingVC () <UITableViewDelegate,UITableViewDataSource> {
    OrderOperate *_orderOperate;
    NSMutableArray *_arrayOrderOperateItem;
    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UIButton *buttonIM;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation BuFaHuoXiangQingVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for (UIView *view in self.buttonIM.subviews) {
        if (view.tag == 100) {
            [view removeFromSuperview];
        }
    }
    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"icon_Private_letter_blue.gif" ofType:nil];
    UIButtonIM *button = [[UIButtonIM alloc] initWithFrame:CGRectMake(0, 0, 60, 25) withGIFFile:gifPath withColor:colorRGB(0, 168, 255)];
    [button addTarget:self action:@selector(buttonSiXinGong:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 100;
    [self.buttonIM addSubview:button];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell0" bundle:nil] forCellReuseIdentifier:@"faHuoCell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"faHuoHeaderView"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoXiangQingCell" bundle:nil] forCellReuseIdentifier:@"faHuoXiangQingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell31" bundle:nil] forCellReuseIdentifier:@"faHuoCell31"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoLieBiaoCell1" bundle:nil] forCellReuseIdentifier:@"shouHuoLieBiaoCell1"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    [self initRequest];
    
}

- (void)buttonSiXinGong:(UIButton *)sender {
    _viewLoading.hidden = NO;
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    Member *meber = [[Member alloc] init];
    meber.memberId =  _orderOperate.tradeOrder.purchaseMemberId;
    postEntityBean.entity = meber.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_user_getMemberInfo parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            Member *member = [Member mj_objectWithKeyValues:returnEntityBean.entity];
           
        }
        _viewLoading.hidden = YES;
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1+_arrayOrderOperateItem.count+2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 83;
    } else if (indexPath.section < 1+_arrayOrderOperateItem.count) {
        return 120;
    } else if (indexPath.section == 1+_arrayOrderOperateItem.count) {
        return 257;
    } else if (indexPath.section == 1+_arrayOrderOperateItem.count+1) {
        return 89;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    } else if (section == 1) {
        return 31;
    } else if (section == 1+_arrayOrderOperateItem.count) {
        return 31;
    } else if (section == 1+_arrayOrderOperateItem.count+1) {
        return 31;
    } else {
        return 10;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        FaHuoHeaderView *faHuoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"faHuoHeaderView"];
        faHuoHeaderView.label1.hidden = YES;
        faHuoHeaderView.label0.text = @"零件信息";
        return faHuoHeaderView;
    } else if (section == 1+_arrayOrderOperateItem.count) {
        FaHuoHeaderView *faHuoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"faHuoHeaderView"];
        faHuoHeaderView.label1.hidden = YES;
        faHuoHeaderView.label0.text = @"发货信息";
        return faHuoHeaderView;
    } else if (section == 1+_arrayOrderOperateItem.count+1) {
        FaHuoHeaderView *faHuoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"faHuoHeaderView"];
        faHuoHeaderView.label1.hidden = YES;
        faHuoHeaderView.label0.text = @"物流信息";
        return faHuoHeaderView;
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FaHuoCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = _orderOperate.tradeOrder.name;
        cell.label1.text = _orderOperate.tradeOrder.phone;
        cell.label2.text = [NSString stringWithFormat:@"%@%@",_orderOperate.tradeOrder.zoneStr,_orderOperate.tradeOrder.address];
        return cell;
    } else if (indexPath.section < 1+_arrayOrderOperateItem.count) {
        ShouHuoLieBiaoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoLieBiaoCell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        OrderOperateItem *orderOperateItem = _arrayOrderOperateItem[indexPath.section-1];
        cell.imageView1.image = [UIImage imageNamed:@"list_supplier"];
        cell.label2.text = @"采购数量";
        cell.label21.text = @"本次发货数量";
        cell.label0.text = orderOperateItem.tradeOrderItem.partName;
        cell.label1.text = [NSString stringWithFormat:@"零件号/图号：%@",orderOperateItem.tradeOrderItem.partNumber];
        cell.label3.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.purchaseNum integerValue]];
        cell.label31.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.operateNum integerValue]];
        return cell;
    } else if (indexPath.section == 1+_arrayOrderOperateItem.count) {
        FaHuoXiangQingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoXiangQingCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.label0.text = _orderOperate.deliveryTime;
        cell.label1.text = _orderOperate.operateCode;
        cell.label2.text = _orderOperate.insideOrderCode;
        cell.label3.text = _orderOperate.deliverNumber.length>0?_orderOperate.deliverNumber:@"暂无";
        cell.textView.text = _orderOperate.remark.length>0?_orderOperate.remark:@"暂无";
        cell.textView.editable = NO;
        return cell;
    } else if (indexPath.section == 1+_arrayOrderOperateItem.count+1) {
        FaHuoCell31 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell31" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = [NSString LogisticsEnum:_orderOperate.logisticsCompanyKey];
        cell.label1.text = _orderOperate.logisticsNo.length>0?_orderOperate.logisticsNo:@"暂无";
        return cell;
    } else {
        return nil;
    }
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
            
            _arrayOrderOperateItem = [[NSMutableArray alloc] initWithCapacity:0];
            for (OrderOperateItem *item in _orderOperate.orderOperateItems) {
                
                [_arrayOrderOperateItem addObject:item];
//                if ([item.reissueQuantity integerValue] > 0) {
//                    
//                }
            }
            
            _viewLoading.hidden = YES;
            [self.tableView reloadData];
        }
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
