//
//  ZuoYeDanYuanViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/7.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ZuoYeDanYuanViewController.h"
#import "VoHeader.h"

#import "TpfMaiViewController.h"
#import "ZuoYeDanYuanCell.h"
#import "TpfBaoGongReasonView.h"
#import "ZuoYeDanYuanTiJiaoViewController.h"
#import "ToolTransition.h"
#import "ScanTuZhiViewController.h"
#import "ZuoYeDanYuanLieBiaoViewController.h"
#import "GlobalSettingManager.h"

@interface ZuoYeDanYuanViewController () <UITableViewDelegate,UITableViewDataSource> {
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    NSArray *_arrayR;
    NSArray *_arrayL;
    
    long _secondsCountUp;
    NSArray *_dataArray;//暂停原因
    
    UIView *_viewLoading;
    
    NSString *_resourceDuo;
}

@property (nonatomic,strong) WorkTimeLogVo *workTimeLogVo;//记录上一次返回的workTimeLogVo

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property(nonatomic,strong) NSTimer * countDownTimer;

@property (weak, nonatomic) IBOutlet UIButton *buttonKaiShi;
@property (weak, nonatomic) IBOutlet UIButton *buttonQuXiao;
@property (weak, nonatomic) IBOutlet UIButton *buttonWanGong;
@property (weak, nonatomic) IBOutlet UIButton *buttonZanTing;
@property (weak, nonatomic) IBOutlet UIButton *buttonJiXu;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;
@end

@implementation ZuoYeDanYuanViewController

- (void)didBecomeActive:(NSNotification *)info {
    
    [self request];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    [_countDownTimer setFireDate:[NSDate distantFuture]];
    
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (_countDownTimer != nil) {
        [_countDownTimer invalidate];
        _timeLabel = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    _secondsCountUp = 0;

    _height_NavBar = Height_NavBar;
    _height_BottomBar = Height_BottomBar;
    self.heightNavBar.constant = _height_NavBar;
    self.heightBottomBar.constant = _height_BottomBar;

    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    _arrayR = @[@"生产订单",@"生产单元"];
    _arrayL = @[self.productionOrderNum,self.workUnitText];


    [self.tableView registerNib:[UINib nibWithNibName:@"ZuoYeDanYuanCell" bundle:nil] forCellReuseIdentifier:@"zuoYeDanYuanCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.bounces = NO;

    [self request];
 
}

-(void)countDownAction{
    _secondsCountUp += 1000;
    

    NSString *str_hour = [NSString stringWithFormat:@"%02ld",_secondsCountUp/1000/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_secondsCountUp/1000%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",_secondsCountUp/1000%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    self.timeLabel.text = format_time;

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayR.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZuoYeDanYuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zuoYeDanYuanCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.viewTopLine.hidden = YES;
    cell.viewBottomLine.hidden = YES;
    cell.viewBottomLine15.hidden = YES;
    if (indexPath.row == 0) {
        cell.viewTopLine.hidden = NO;
        cell.viewBottomLine15.hidden = NO;
    } else if (indexPath.row == _arrayR.count-1) {
        cell.viewBottomLine.hidden = NO;
    } else {
        cell.viewBottomLine15.hidden = NO;
    }
    
    cell.label0.text = _arrayR[indexPath.row];
    cell.label1.text = _arrayL[indexPath.row];
    
    return cell;
}

#pragma mark 开始
- (IBAction)buttonKaiShi:(id)sender {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    WorkTimeLogVo *workTimeLogVo = [[WorkTimeLogVo alloc] init];
    workTimeLogVo.siteCode = siteCode;
    workTimeLogVo.startDateTime = [ToolTransition stringFromDate:[NSDate date]];
    workTimeLogVo.productionControlNum = self.productionControlNum;
    workTimeLogVo.workUnitCode = self.workUnitCode;
    workTimeLogVo.operationCode = self.operationCode;
    workTimeLogVo.imeiCode = @"355797079515229";
    workTimeLogVo.confirmUser = self.confirmUser;
    workTimeLogVo.processOperationId = self.processOperationId;
    workTimeLogVo.status = [NSNumber numberWithInt:1];
    workTimeLogVo.workTime = [NSNumber numberWithLong:0];
    workTimeLogVo.workRecordType = self.workRecordType;
    
    NSArray *array = [NSArray arrayWithObjects:workTimeLogVo.mj_keyValues, nil];
    mesPostEntityBean.entity = array.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_workRest_workLog parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        _viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            WorkTimeLogVo *model = [WorkTimeLogVo mj_objectWithKeyValues:returnListBean.list[0]];
            
            self.workTimeLogVo = model;
            
            [self initButtonAndRequest:model];
        
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;
       
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

#pragma mark 取消
- (IBAction)buttonQuXiao:(id)sender {
    [self buttonGoHome:nil];
}

#pragma mark 完工
- (IBAction)buttonWanGong:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否确认完工？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _viewLoading.hidden = NO;
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        NSString *siteCode = tpfUser.siteCode;
        
        MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
        WorkTimeLogVo *workTimeLogVo = [[WorkTimeLogVo alloc] init];
        workTimeLogVo.siteCode = siteCode;
        workTimeLogVo.logId = self.workTimeLogVo.logId;
        workTimeLogVo.startDateTime = self.workTimeLogVo.startDateTime;
        workTimeLogVo.actualendDateTime = [ToolTransition stringFromDate:[NSDate date]];;
        workTimeLogVo.productionControlNum = self.productionControlNum;
        workTimeLogVo.workUnitCode = self.workUnitCode;
        workTimeLogVo.operationCode = self.operationCode;
        workTimeLogVo.confirmUser = self.confirmUser;
        workTimeLogVo.workTime = [NSNumber numberWithLong:_secondsCountUp];
        workTimeLogVo.processOperationId = self.processOperationId;
        workTimeLogVo.status = [NSNumber numberWithInt:4];
        
        NSArray *array = [NSArray arrayWithObjects:workTimeLogVo.mj_keyValues, nil];
        mesPostEntityBean.entity = array.mj_keyValues;
        NSDictionary *dic = mesPostEntityBean.mj_keyValues;
        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_workRest_workLog parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *returnListBean = responseObjectModel;
            _viewLoading.hidden = YES;
            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                
                WorkTimeLogVo *model = [WorkTimeLogVo mj_objectWithKeyValues:returnListBean.list[0]];
                self.workTimeLogVo = model;
                [self initButtonAndRequest:model];
                
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
            }
        } fail:^(NSError *error) {
            _viewLoading.hidden = YES;
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action0];
    [alertController addAction:action1];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 暂停
- (IBAction)buttonZanTing:(id)sender {
    TpfBaoGongReasonView *view = [[TpfBaoGongReasonView alloc] initWithFrame:self.view.frame withData:_dataArray];
    [view blockConfirm:^(id model) {
        ShutDownCauseVo *shutDownCauseVo = model;
        NSLog(@"%@",shutDownCauseVo.shutDownCauseText);
        
        _viewLoading.hidden = NO;
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        NSString *siteCode = tpfUser.siteCode;
        
        MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
        WorkTimeLogVo *workTimeLogVo = [[WorkTimeLogVo alloc] init];
        workTimeLogVo.siteCode = siteCode;
        workTimeLogVo.logId = self.workTimeLogVo.logId;
        workTimeLogVo.startDateTime = self.workTimeLogVo.startDateTime;
        workTimeLogVo.actualendDateTime = [ToolTransition stringFromDate:[NSDate date]];
        workTimeLogVo.productionControlNum = self.productionControlNum;
        workTimeLogVo.workUnitCode = self.workUnitCode;
        workTimeLogVo.operationCode = self.operationCode;
        workTimeLogVo.confirmUser = self.confirmUser;
        workTimeLogVo.workTime = [NSNumber numberWithLong:_secondsCountUp];
        workTimeLogVo.processOperationId = self.processOperationId;
        workTimeLogVo.shutDownCauseCode = shutDownCauseVo.shutDownCauseCode;
        workTimeLogVo.status = [NSNumber numberWithInt:2];
        
        NSArray *array = [NSArray arrayWithObjects:workTimeLogVo.mj_keyValues, nil];
        mesPostEntityBean.entity = array.mj_keyValues;
        NSDictionary *dic = mesPostEntityBean.mj_keyValues;
        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_workRest_workLog parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *returnListBean = responseObjectModel;
            _viewLoading.hidden = YES;
            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                WorkTimeLogVo *model = [WorkTimeLogVo mj_objectWithKeyValues:returnListBean.list[0]];
                self.workTimeLogVo = model;
                [self initButtonAndRequest:model];
                
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
                
            }
        } fail:^(NSError *error) {
            _viewLoading.hidden = YES;
       
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
        
        
    }];
    [self.view addSubview:view];
    
}

#pragma mark 继续
- (IBAction)buttonJiXu:(id)sender {
    _viewLoading.hidden = NO;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    WorkTimeLogVo *workTimeLogVo = [[WorkTimeLogVo alloc] init];
    workTimeLogVo.siteCode = siteCode;
    workTimeLogVo.logId = self.workTimeLogVo.logId;
    workTimeLogVo.productionControlNum = self.productionControlNum;
    workTimeLogVo.processOperationId = self.processOperationId;
    workTimeLogVo.workUnitCode = self.workUnitCode;
    workTimeLogVo.operationCode = self.operationCode;
    workTimeLogVo.confirmUser = self.confirmUser;
    workTimeLogVo.actualendDateTime = [ToolTransition stringFromDate:[NSDate date]];
    workTimeLogVo.imeiCode = self.workTimeLogVo.imeiCode;
    
    NSArray *array = [NSArray arrayWithObjects:workTimeLogVo.mj_keyValues, nil];
    mesPostEntityBean.entity = array.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_workRest_continueWork parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        _viewLoading.hidden = YES;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            self.buttonKaiShi.hidden = YES;
            self.buttonWanGong.hidden = YES;
            self.buttonQuXiao.hidden = YES;
            self.buttonZanTing.hidden = YES;
            self.buttonJiXu.hidden = YES;
            
            self.buttonWanGong.hidden = NO;
            self.buttonZanTing.hidden = NO;
            [_countDownTimer setFireDate:[NSDate distantPast]];//跑
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;

    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    
}

- (void)request{
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    WorkTimeLogVo *workTimeLogVo = [[WorkTimeLogVo alloc] init];
    workTimeLogVo.siteCode = siteCode;
    workTimeLogVo.productionControlNum = self.productionControlNum;
    workTimeLogVo.processOperationId = self.processOperationId;
    workTimeLogVo.workUnitCode = self.workUnitCode;
    workTimeLogVo.confirmUser = self.confirmUser;
    workTimeLogVo.workTimeLogType = [NSNumber numberWithInteger:1];
    mesPostEntityBean.entity = workTimeLogVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_workRest_getWorkTime parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            WorkTimeLogVo *model = [WorkTimeLogVo mj_objectWithKeyValues:returnEntityBean.entity];
            self.workTimeLogVo = model;
            
            
            
            self.materialCode = model.materialCode;
            self.materialText = model.materialText;
            self.projectNum = model.projectNum;
            self.materialspec = model.materialspec;
            self.plannedQuantity = model.plannedQuantity;
            self.completedQuantity = model.completedQuantity;
            
            int planTime = (int)[self.planTime doubleValue];
            int planTime1 = ([self.planTime doubleValue] - planTime)*60;
            int surplusTime = (int)[self.surplusTime doubleValue];
            int surplusTime1 = ([self.surplusTime doubleValue] - surplusTime)*60;
            
            
            if ([GlobalSettingManager shareGlobalSettingManager].showPlanHour) {//显示计划工时
                self->_arrayR = @[@"生产订单",@"生产单元",@"操作员",@"本道工序",@"项目编号",@"物料名称",@"物料编号",@"物料描述",@"物料规格",@"工序计划数/完成数",@"计划工时",@"剩余工时",@"客户交期"];
                self->_arrayL = @[self.productionOrderNum,self.workUnitText,self.personnelName,self.operationText!=nil?self.operationText:@"",self.projectNum!=nil?self.projectNum:@"",self.materialText!=nil?self.materialText:@"",self.materialCode!=nil?self.materialCode:@"",self.materialText!=nil?self.materialText:@"",self.materialspec!=nil?self.materialspec:@"",[NSString stringWithFormat:@"%@/%@",self.plannedQuantity,self.completedQuantity],[NSString stringWithFormat:@"%d小时%d分",planTime,planTime1],[NSString stringWithFormat:@"%d小时%d分",surplusTime,surplusTime1],self.requirementDate];
            } else {//不显示计划工时
                self->_arrayR = @[@"生产订单",@"生产单元",@"操作员",@"本道工序",@"项目编号",@"物料名称",@"物料编号",@"物料描述",@"物料规格",@"工序计划数/完成数",@"剩余工时",@"客户交期"];
                self->_arrayL = @[self.productionOrderNum,self.workUnitText,self.personnelName,self.operationText!=nil?self.operationText:@"",self.projectNum!=nil?self.projectNum:@"",self.materialText!=nil?self.materialText:@"",self.materialCode!=nil?self.materialCode:@"",self.materialText!=nil?self.materialText:@"",self.materialspec!=nil?self.materialspec:@"",[NSString stringWithFormat:@"%@/%@",self.plannedQuantity,self.completedQuantity],[NSString stringWithFormat:@"%d小时%d分",surplusTime,surplusTime1],self.requirementDate];
            }
            
            
            
            [self.tableView reloadData];
            
            [self request1WithOperationCode:model.operationCode];
            [self initButtonAndRequest:model];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
       
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}
- (void)initButtonAndRequest:(WorkTimeLogVo *)model {
    self.buttonKaiShi.hidden = YES;
    self.buttonWanGong.hidden = YES;
    self.buttonQuXiao.hidden = YES;
    self.buttonZanTing.hidden = YES;
    self.buttonJiXu.hidden = YES;
//    报工记录状态-1：开始，2：暂停，3：继续，4：完成，5：报工
    if ([model.status intValue] == 0 || [model.status intValue] == 5) {
        self.buttonKaiShi.hidden = NO;
        self.buttonQuXiao.hidden = NO;
        _secondsCountUp = 0;
        [_countDownTimer setFireDate:[NSDate distantFuture]];//停
    } else if ([model.status intValue] == 1) {
        self.buttonWanGong.hidden = NO;
        self.buttonZanTing.hidden = NO;
        _secondsCountUp = ([[NSDate date] timeIntervalSinceDate:[ToolTransition dateFromString:model.startDateTime]])*1000;
        [_countDownTimer setFireDate:[NSDate distantPast]];//跑
    } else if ([model.status intValue] == 2) {
        self.buttonWanGong.hidden = NO;
        self.buttonJiXu.hidden = NO;
        _secondsCountUp = [model.workTime longValue];
        [_countDownTimer setFireDate:[NSDate distantFuture]];//停
    } else if ([model.status intValue] == 3) {
        self.buttonWanGong.hidden = NO;
        self.buttonZanTing.hidden = NO;
        _secondsCountUp = ([[NSDate date] timeIntervalSinceDate:[ToolTransition dateFromString:model.actualendDateTime]])*1000 + [model.workTime longValue];
        [_countDownTimer setFireDate:[NSDate distantPast]];//跑
    } else if ([model.status intValue] == 4) {
        NSLog(@"提交");
        _secondsCountUp = 0;
        [_countDownTimer setFireDate:[NSDate distantFuture]];//停
        ZuoYeDanYuanTiJiaoViewController *zuoYeDanYuanTiJiaoViewController = [[ZuoYeDanYuanTiJiaoViewController alloc] init];
        zuoYeDanYuanTiJiaoViewController.productionControlNum = self.productionControlNum;
        zuoYeDanYuanTiJiaoViewController.processOperationId = self.processOperationId;
        zuoYeDanYuanTiJiaoViewController.confirmFlag = self.confirmFlag;
        zuoYeDanYuanTiJiaoViewController.workUnitText = self.workUnitText;
        zuoYeDanYuanTiJiaoViewController.operationText = self.operationText;
        zuoYeDanYuanTiJiaoViewController.operationTextNext = self.operationTextNext;
        zuoYeDanYuanTiJiaoViewController.planTime = self.planTime;
        
        zuoYeDanYuanTiJiaoViewController.workTime = self.workTimeLogVo.workTime;
        zuoYeDanYuanTiJiaoViewController.unfinishedQuantity = self.workTimeLogVo.unfinishedQuantity;
        zuoYeDanYuanTiJiaoViewController.operationCode = self.workTimeLogVo.operationCode;
        zuoYeDanYuanTiJiaoViewController.workUnitCode = self.workTimeLogVo.workUnitCode;
        zuoYeDanYuanTiJiaoViewController.confirmUser = self.workTimeLogVo.confirmUser;
        zuoYeDanYuanTiJiaoViewController.status = self.workTimeLogVo.status;
        zuoYeDanYuanTiJiaoViewController.actualendDateTime = self.workTimeLogVo.actualendDateTime;
        zuoYeDanYuanTiJiaoViewController.logId = self.workTimeLogVo.logId;
        
        zuoYeDanYuanTiJiaoViewController.productionOrderNum = self.productionOrderNum;
        zuoYeDanYuanTiJiaoViewController.requirementDate = self.requirementDate;
        zuoYeDanYuanTiJiaoViewController.personnelName = self.personnelName;
        
        
        if (!self.workTimeLogVo.completionMode) {//兼容上一版本，下一版本去掉，2020年3月31号
            self.workTimeLogVo.completionMode = [NSNumber numberWithInteger:1];
        }
        zuoYeDanYuanTiJiaoViewController.completionMode = self.workTimeLogVo.completionMode;
        [self.navigationController pushViewController:zuoYeDanYuanTiJiaoViewController animated:YES];
    }
    
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",_secondsCountUp/1000/3600];//时
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_secondsCountUp/1000%3600)/60];//分
    NSString *str_second = [NSString stringWithFormat:@"%02ld",_secondsCountUp/1000%60];//秒
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    self.timeLabel.text = format_time;

}

- (void)request1WithOperationCode:(NSString *)operationCode{
    
    _viewLoading.hidden = NO;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    ShutDownCauseVo *shutDownCauseVo = [[ShutDownCauseVo alloc] init];
    shutDownCauseVo.siteCode = siteCode;
    shutDownCauseVo.operationCode = operationCode;
    mesPostEntityBean.entity = shutDownCauseVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_workRest_shutDownCauseList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        _viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in returnListBean.list) {
                ShutDownCauseVo *shutDownCauseVo = [ShutDownCauseVo mj_objectWithKeyValues:dic];
                [dataArray addObject:shutDownCauseVo];
            }
            _dataArray = [NSArray arrayWithArray:dataArray];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;

    } isKindOfModel:NSClassFromString(@"ReturnListBean")];

}


- (IBAction)buttonGoHome:(id)sender {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[TpfMaiViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
            break;
        }
    }
}

- (IBAction)back:(id)sender {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    NSString *personnelCode = [DatabaseTool t_TpfPWTableGetPersonnelCodeWithSiteCode:siteCode];
    NSString *workUnitCode = [DatabaseTool t_TpfPWTableGetWorkUnitCodeWithSiteCode:siteCode];
    
    if ((![personnelCode isEqualToString:@"(null)"]) && (![workUnitCode isEqualToString:@"(null)"])) {
        //有 personnelCode，有 workUnitCode
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isMemberOfClass:[ScanTuZhiViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
                return;
            }
        }
    } else if ((![personnelCode isEqualToString:@"(null)"]) && ([workUnitCode isEqualToString:@"(null)"])) {
        //有 personnelCode，无 workUnitCode
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isMemberOfClass:[ZuoYeDanYuanLieBiaoViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
                return;
            }
        }
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isMemberOfClass:[ScanTuZhiViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
                return;
            }
        }
    } else if (([personnelCode isEqualToString:@"(null)"]) && (![workUnitCode isEqualToString:@"(null)"])) {
        //无 personnelCode，有 workUnitCode
        [self.navigationController popViewControllerAnimated:YES];
        return;
    } else if (([personnelCode isEqualToString:@"(null)"]) && ([workUnitCode isEqualToString:@"(null)"])) {
        //无 personnelCode，无 workUnitCode
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    //再制工单
    [self.navigationController popViewControllerAnimated:true];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
