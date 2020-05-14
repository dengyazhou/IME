//
//  YunShuDetailVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/8.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "YunShuDetailVC.h"
#import "VoHeader.h"
#import "YunShuCell.h"
#import "YunShuShouHuoVC.h"
#import "YunShuVC.h"
#import "YunShuHeader.h"

@interface YunShuDetailVC () <UITableViewDelegate,UITableViewDataSource> {
    UIView *_viewLoading;
    NSTimer *_time;
}

@property (nonatomic,strong) NSMutableArray <NSMutableArray *> * list;

//@property (nonatomic,strong) NSMutableArray <TransportOrderVo *> *transportOrderVoArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation YunShuDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"YunShuCell" bundle:nil] forCellReuseIdentifier:@"yunShuCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YunShuHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"yunShuHeader"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedSectionHeaderHeight = 0.1;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW-34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
//    _viewLoading.hidden = YES;
    
    _time = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
        [self.tableView reloadData];
    }];
    
    [self initRequest];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list[section].count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YunShuHeader *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"yunShuHeader"];
    
    NSMutableArray <TransportOrderVo *>*sectionArray = self.list[section];
    TransportOrderVo *transportOrder = sectionArray.firstObject.transportOrderVoList.firstObject;
    
    view.label0.text = [NSString stringWithFormat:@"运输计划号：%@",transportOrder.transportOrderNum];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YunShuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yunShuCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSMutableArray <TransportOrderVo *>*sectionArray = self.list[indexPath.section];
    TransportOrderVo *transportOrder = sectionArray[indexPath.row].transportOrderVoList.firstObject;
    
    cell.label01.text = transportOrder.supplierText;
    cell.label02.text = transportOrder.address;
    
    cell.label11.text = [NSString stringWithFormat:@"%lu",sectionArray[indexPath.row].transportOrderVoList.count];
    
    
    cell.label13.hidden = true;
    cell.button13.hidden = true;
    
    //运输单状态 0创建 1运输中 2已到达 3已签收
    if (transportOrder.status.intValue == 0) {
        cell.button13.hidden = false;
        [cell.button13 setTitle:@"开始" forState:UIControlStateNormal];
        cell.button13.backgroundColor = colorRGB(40, 155, 229);
        
        cell.label12.textColor = colorRGB(40, 155, 229);
        cell.label12.text = [self stringGetSecond:0];
        
        
    } else if (transportOrder.status.intValue == 1) {
        cell.button13.hidden = false;
        [cell.button13 setTitle:@"送达" forState:UIControlStateNormal];
        cell.button13.backgroundColor = colorRGB(255, 153, 0);
        
        cell.label12.textColor = colorRGB(255, 153, 0);
    
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *stringDate = [formatter dateFromString:transportOrder.transportStartDatetime];
        
        NSDate *nowDate = [NSDate date];
        NSTimeInterval time = [nowDate timeIntervalSinceDate:stringDate];
        NSUInteger second = (NSUInteger)time;
        
        cell.label12.text = [self stringGetSecond:second];
    } else if (transportOrder.status.intValue == 2) {
        cell.button13.hidden = false;
        [cell.button13 setTitle:@"收货" forState:UIControlStateNormal];
        cell.button13.backgroundColor = colorRGB(127, 185, 45);
        
        cell.label12.textColor = colorRGB(127, 185, 45);
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *stringDate = [formatter dateFromString:transportOrder.transportStartDatetime];

        NSDate *nowDate = [formatter dateFromString:transportOrder.arrivedDatetime];
        NSTimeInterval time = [nowDate timeIntervalSinceDate:stringDate];
        NSUInteger second = (NSUInteger)time;
        
        cell.label12.text = [self stringGetSecond:second];
        
    } else if (transportOrder.status.intValue == 3) {
        cell.label13.hidden = false;
        cell.label13.text = @"完成";
        
        cell.label12.textColor = colorRGB(102, 102, 102);
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *stringDate = [formatter dateFromString:transportOrder.transportStartDatetime];
        
        NSDate *nowDate = [formatter dateFromString:transportOrder.arrivedDatetime];
        NSTimeInterval time = [nowDate timeIntervalSinceDate:stringDate];
        NSUInteger second = (NSUInteger)time;
        
        cell.label12.text = [self stringGetSecond:second];
    }
    
    

    [cell.button13 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.button13.superview.tag = indexPath.section;
    cell.button13.tag = indexPath.row;
    
    return cell;
}

- (NSString *)stringGetSecond:(NSUInteger)second {
    NSUInteger hours = second/60/60;
    NSUInteger minute = second/60%60;
    NSUInteger sec = second%60;
    NSString *strTime = [NSString stringWithFormat:@"%.2lu:%.2lu:%.2lu",(unsigned long)hours,(unsigned long)minute,(unsigned long)sec];
    return strTime;
}


- (void)buttonClick:(UIButton *)sender {
    NSMutableArray <TransportOrderVo *>*sectionArray = self.list[sender.superview.tag];
    
    if ([sender.currentTitle isEqualToString:@"开始"]) {
        BOOL canStart = YES;
        for (TransportOrderVo *vo in sectionArray) {
            TransportOrderVo *temp = vo.transportOrderVoList.firstObject;
            if (temp.status.intValue == 1 || temp.status.intValue == 2) {
                canStart = NO;
                break;
            }
        }
        if (canStart) {
            [self requestTransportOrderStart:sectionArray[sender.tag]];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"同时只能有一条记录备操作"];
        }
    } else if ([sender.currentTitle isEqualToString:@"送达"]) {
        [self requestTransportOrderArrived:sectionArray[sender.tag]];

    } else if ([sender.currentTitle isEqualToString:@"收货"]) {
        [self requestTransportOrderDelivery:sectionArray[sender.tag]];
    }
}

#pragma mark 运输单开始接口
- (void)requestTransportOrderStart:(TransportOrderVo *)transportOrder {
    _viewLoading.hidden = false;
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    for (TransportOrderVo *vo in transportOrder.transportOrderVoList) {
        TransportOrderVo *tempVO = [[TransportOrderVo alloc] init];
        tempVO.siteCode = vo.siteCode;
        tempVO.transportOrderNum = vo.transportOrderNum;
        tempVO.outgoingOrderNum = vo.outgoingOrderNum;
        tempVO.transportUser = userInfo.userCode;
        tempVO.modifyUser = userInfo.userCode;
        [tempArray addObject:tempVO];
    }
    postEntityBean.entity = tempArray;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_mes_transportOrder_transportOrderStart parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            
            for (TransportOrderVo *vo in transportOrder.transportOrderVoList) {
                vo.status = [NSNumber numberWithInt:1];
                
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *stringDate = [formatter stringFromDate:[NSDate date]];
                
                vo.transportStartDatetime = stringDate;
            }
            [self.tableView reloadData];
            
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

#pragma mark 运输单送达接口
- (void)requestTransportOrderArrived:(TransportOrderVo *)transportOrder {
    _viewLoading.hidden = false;
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    for (TransportOrderVo *vo in transportOrder.transportOrderVoList) {
        TransportOrderVo *tempVO = [[TransportOrderVo alloc] init];
        tempVO.siteCode = vo.siteCode;
        tempVO.transportOrderNum = vo.transportOrderNum;
        tempVO.outgoingOrderNum = vo.outgoingOrderNum;
        tempVO.modifyUser = userInfo.userCode;
        [tempArray addObject:tempVO];
    }
    postEntityBean.entity = tempArray;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_mes_transportOrder_transportOrderArrived parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            for (TransportOrderVo *vo in transportOrder.transportOrderVoList) {
                vo.status = [NSNumber numberWithInt:2];
                
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *stringDate = [formatter stringFromDate:[NSDate date]];
                
                vo.arrivedDatetime = stringDate;
            }
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

#pragma mark 运输单关闭接口
- (void)requestTransportOrderClose:(TransportOrderVo *)transportOrder {
    _viewLoading.hidden = false;
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    for (TransportOrderVo *vo in transportOrder.transportOrderVoList) {
        TransportOrderVo *tempVO = [[TransportOrderVo alloc] init];
        tempVO.siteCode = vo.siteCode;
        tempVO.transportOrderNum = vo.transportOrderNum;
        tempVO.outgoingOrderNum = vo.outgoingOrderNum;
        tempVO.modifyUser = userInfo.userCode;
        [tempArray addObject:tempVO];
    }
    postEntityBean.entity = tempArray;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_mes_transportOrder_transportOrderClose parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            for (TransportOrderVo *vo in transportOrder.transportOrderVoList) {
                vo.status = [NSNumber numberWithInt:0];
            }
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

#pragma mark 运输单删除接口
- (void)requestTransportOrderDelete:(TransportOrderVo *)transportOrder with:(NSIndexPath *)indexPath{
    _viewLoading.hidden = false;
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    postEntityBean.entity = transportOrder.transportOrderVoList;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_mes_transportOrder_transportOrderDetailDelete parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            
            NSMutableArray <TransportOrderVo *>*sectionArray = self.list[indexPath.section];
            [sectionArray removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView reloadData];//加上这一句解决了滑动删除 不和谐的问题，去掉这一句也OK
            
            if (self.list.count == 0) {
                [self back:nil];
            }
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

#pragma mark 运输单收货开始接口
- (void)requestTransportOrderDelivery:(TransportOrderVo *)transportOrder {
    _viewLoading.hidden = false;
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    for (TransportOrderVo *vo in transportOrder.transportOrderVoList) {
        TransportOrderVo *tempVO = [[TransportOrderVo alloc] init];
        tempVO.siteCode = vo.siteCode;
        tempVO.transportOrderNum = vo.transportOrderNum;
        tempVO.outgoingOrderNum = vo.outgoingOrderNum;
        tempVO.deliveryUser = userInfo.userCode;
        tempVO.modifyUser = userInfo.userCode;
        [tempArray addObject:tempVO];
    }
    postEntityBean.entity = tempArray;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_mes_transportOrder_transportOrderDelivery parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            
            YunShuShouHuoVC *vc = [[YunShuShouHuoVC alloc] init];
            vc.transportOrder = transportOrder;
            [vc setTransportOrderDeliveryCallBack:^{
                for (TransportOrderVo *vo in transportOrder.transportOrderVoList) {
                    vo.status = [NSNumber numberWithInt:3];
                }
                [self.tableView reloadData];
            }];
            [self.navigationController pushViewController:vc animated:true];
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray <TransportOrderVo *>*sectionArray = self.list[indexPath.section];
    TransportOrderVo *transportOrder = sectionArray[indexPath.row].transportOrderVoList.firstObject;
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self requestTransportOrderDelete:transportOrder with:indexPath];
        
    }];
    deleteAction.backgroundColor = colorRGB(249, 52, 52);
    
    UITableViewRowAction *closeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"关闭" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self requestTransportOrderClose:transportOrder];
    }];
    closeAction.backgroundColor = colorRGB(255, 135, 0);
    
    
    if (transportOrder.status.intValue == 0) {
        return @[deleteAction];
    } else if (transportOrder.status.intValue == 1) {
        return @[closeAction];
    } else if (transportOrder.status.intValue == 2) {
        return @[];
    } else if (transportOrder.status.intValue == 3) {
        return @[];
    }
    return @[];
}

- (void)initRequest {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    TransportOrderVo *transportOrder = [[TransportOrderVo alloc] init];
    transportOrder.siteCode = userInfo.siteCode;
    transportOrder.createUser = userInfo.userCode;
    
    postEntityBean.entity = transportOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_mes_transportOrder_getTransportOrderListByUser parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.list = [[NSMutableArray alloc] initWithCapacity:0];
            
            for (NSMutableArray *middleList in returnListBean.list) {
                NSMutableArray *tempList = [[NSMutableArray alloc] initWithCapacity:0];
                
                for (NSDictionary *dic in middleList) {
                    TransportOrderVo *vo = [TransportOrderVo mj_objectWithKeyValues:dic];
                    [tempList addObject:vo];
                }
                
                [self.list addObject:tempList];
            }
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    
}


- (IBAction)scan:(id)sender {
    YunShuVC *vc = [[YunShuVC alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)back:(id)sender {
    
//    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isMemberOfClass:[YunShuVC class]]) {
//            [self.navigationController popToViewController:obj animated:YES];
//            *stop = YES;
//        }
//    }];
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)dealloc {
    [_time invalidate];
    _time = nil;
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
