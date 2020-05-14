//
//  TemporaryTaskVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "TemporaryTaskVC.h"

#import "VoHeader.h"

#import "CompleteConfirmationVC.h"
#import "TemporaryTaskSuspendView.h"

#import "TemporaryTaskTypeCell.h"
#import "CompleteConfirmationCipherConfirmationView.h"

@interface TemporaryTaskVC ()<UITableViewDelegate,UITableViewDataSource> {
    UIView *_viewLoading;
    TemporaryTaskSuspendView *_temporaryTaskSuspendView;
    NSInteger _index;
    long _secondsCountUp;
}

@property (nonatomic,strong) NSMutableArray <TemporaryTaskTypeVo *> *temporaryTaskTypeVoList;
@property (nonatomic,strong) TemporaryTaskVo *temporaryTaskVo;
@property(nonatomic,strong) NSTimer * countDownTimer;


@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelTask;
@property (weak, nonatomic) IBOutlet UITableView *tableViewTaskType;

@property (weak, nonatomic) IBOutlet UIButton *buttonTask;
@property (weak, nonatomic) IBOutlet UILabel *labelTaskExplain;

@property (weak, nonatomic) IBOutlet UITextField *textFieldPlanWorkTime;

@property (weak, nonatomic) IBOutlet UITextView *textViewTaskExplain;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

//@property (weak, nonatomic) IBOutlet UIButton *buttonStart;
//@property (weak, nonatomic) IBOutlet UIButton *buttonSuspend;//暂停
//@property (weak, nonatomic) IBOutlet UIButton *buttonContinue;//继续
//@property (weak, nonatomic) IBOutlet UIButton *buttonFinish;

@property (weak, nonatomic) IBOutlet UIButton *buttonCreateSelf;//员工创建
@property (weak, nonatomic) IBOutlet UIButton *buttonStartSelf;//员工开始
@property (weak, nonatomic) IBOutlet UIButton *buttonCloseSelf;//员工关闭
@property (weak, nonatomic) IBOutlet UIButton *buttonSuspendSelf;//员工暂停
@property (weak, nonatomic) IBOutlet UIButton *buttonFinishSelf;//员工完成
@property (weak, nonatomic) IBOutlet UIButton *buttonContinueSelf;//员工继续


@property (weak, nonatomic) IBOutlet UIButton *buttonCloseLeader;//组长关闭
@property (weak, nonatomic) IBOutlet UIButton *buttonFinishLeader;//组长完成

@end

@implementation TemporaryTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.heightNavBar.constant = Height_NavBar;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    _index = 0;
    _secondsCountUp = 0;
    
    self.tableViewTaskType.hidden = YES;
    
    self.buttonCreateSelf.hidden = true;
    self.buttonStartSelf.hidden = true;
    self.buttonCloseSelf.hidden = true;
    self.buttonSuspendSelf.hidden = true;
    self.buttonFinishSelf.hidden = true;
    self.buttonContinueSelf.hidden = true;
    self.buttonCloseLeader.hidden = true;
    self.buttonFinishLeader.hidden = true;
    
    
    self.tableViewTaskType.delegate = self;
    self.tableViewTaskType.dataSource = self;
    [self.tableViewTaskType registerNib:[UINib nibWithNibName:@"TemporaryTaskTypeCell" bundle:nil] forCellReuseIdentifier:@"temporaryTaskTypeCell"];
    self.tableViewTaskType.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViewTaskType.layer.borderWidth = 1;
    self.tableViewTaskType.layer.borderColor = colorRGB(221, 221, 221).CGColor;
    
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW-34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    // placeholder
    UILabel *label = [UILabel new];
    label.font = self.textViewTaskExplain.font;
    label.text = @"请输入任务说明";
    label.numberOfLines = 0;
    label.textColor = [UIColor lightGrayColor];
    [label sizeToFit];
    [self.textViewTaskExplain addSubview:label];
    
    // kvc
    [self.textViewTaskExplain setValue:label forKey:@"_placeholderLabel"];
    self.textViewTaskExplain.inputAccessoryView = [self addToolbar];
    
    self.textFieldPlanWorkTime.inputAccessoryView = [self addToolbar];
    
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    [_countDownTimer setFireDate:[NSDate distantFuture]];
    
    [self initRequestGetTemporaryTaskTypeList];
    
    [self initRequestGetTemporaryTaskWithId:self.idDYZ];
    
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    if (parent == nil) {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
    }
}

-(void)countDownAction{
    _secondsCountUp += 1000;
    [self showLabelTime];
}

- (void)showLabelTime {
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",_secondsCountUp/1000/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_secondsCountUp/1000%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",_secondsCountUp/1000%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    self.timeLabel.text = format_time;
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        _temporaryTaskSuspendView.center = self.view.center;
    } else {
        _temporaryTaskSuspendView.center = CGPointMake(_temporaryTaskSuspendView.center.x,  _temporaryTaskSuspendView.center.y-rect.size.height/2);
    }
}

- (IBAction)buttonSelectTask:(id)sender {
    if (self.temporaryTaskTypeVoList.count == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请维护临时任务类型"];
        return;
    }
    self.tableViewTaskType.hidden = false;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.temporaryTaskTypeVoList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TemporaryTaskTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"temporaryTaskTypeCell" forIndexPath:indexPath];
    TemporaryTaskTypeVo *temporaryTaskTypeVo = self.temporaryTaskTypeVoList[indexPath.row];
    cell.label0.text = temporaryTaskTypeVo.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TemporaryTaskTypeVo *temporaryTaskTypeVo = self.temporaryTaskTypeVoList[indexPath.row];
    if (temporaryTaskTypeVo.taskSpecificationRequiredFlag.integerValue == 1) {
        self.labelTaskExplain.text = @"任务说明(必填)";
        NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] initWithString:self.labelTaskExplain.text];
        [abs addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(self.labelTaskExplain.text.length-3, 2)];
        self.labelTaskExplain.attributedText = abs;
    } else {
        self.labelTaskExplain.text = @"任务说明";
    }
    
    self.labelTask.text = temporaryTaskTypeVo.name;
    self.textFieldPlanWorkTime.text = temporaryTaskTypeVo.planWorkTime.stringValue;
    _index = indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    tableView.hidden = true;
}


//员工创建
- (IBAction)buttonCreateSelfClick:(UIButton *)sender {
    if (self.temporaryTaskTypeVoList.count == 0) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请维护临时任务类型"];
            return;
        }
        
        TemporaryTaskTypeVo *temporaryTaskTypeVo = self.temporaryTaskTypeVoList[_index];
        if (temporaryTaskTypeVo.taskSpecificationRequiredFlag.integerValue == 1) {
            if (self.textViewTaskExplain.text.length > 0) {
                
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"任务说明必填"];
                return;
            }
        } else {

        }
        
        
        _viewLoading.hidden = false;
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        
        MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
        TemporaryTaskVo *temporaryTaskVo = [[TemporaryTaskVo alloc] init];
        
        temporaryTaskVo.temporaryTaskTypeId = temporaryTaskTypeVo.idDYZ;
        temporaryTaskVo.siteCode = userInfo.siteCode;
        temporaryTaskVo.createUser = userInfo.userCode;
        temporaryTaskVo.modifyUser = userInfo.userCode;
        temporaryTaskVo.taskSpecification = self.textViewTaskExplain.text;
        temporaryTaskVo.saveOrStart = [NSNumber numberWithInteger:0];
        postEntityBean.entity = temporaryTaskVo.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        [HttpMamager postRequestWithURLString:DYZ_mes_temporaryTask_temporaryTaskStart parameters:dic success:^(id responseObjectModel) {
            _viewLoading.hidden = true;
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"创建成功"];
                [self.navigationController popViewControllerAnimated:true];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
            }
        } fail:^(NSError *error) {
            _viewLoading.hidden = true;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

//员工开始
- (IBAction)buttonStartSelfClick:(UIButton *)sender {
    if (self.temporaryTaskTypeVoList.count == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请维护临时任务类型"];
        return;
    }
        
    TemporaryTaskTypeVo *temporaryTaskTypeVo = self.temporaryTaskTypeVoList[_index];
    if (temporaryTaskTypeVo.taskSpecificationRequiredFlag.integerValue == 1) {
    //       self.labelTaskExplain.text = @"任务说明(必填)";
        if (self.textViewTaskExplain.text.length > 0) {
                
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"任务说明必填"];
            return;
        }
            
    } else {
//        self.labelTaskExplain.text = @"任务说明";
    }
        
        
    _viewLoading.hidden = false;
        
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    TemporaryTaskVo *temporaryTaskVo = [[TemporaryTaskVo alloc] init];
    if (self.idDYZ) {
        temporaryTaskVo.idDYZ = [NSNumber numberWithLong:self.idDYZ.longValue];
    }
    
        
        temporaryTaskVo.temporaryTaskTypeId = temporaryTaskTypeVo.idDYZ;
        temporaryTaskVo.siteCode = userInfo.siteCode;
        temporaryTaskVo.createUser = userInfo.userCode;
        temporaryTaskVo.modifyUser = userInfo.userCode;
        temporaryTaskVo.taskSpecification = self.textViewTaskExplain.text;
        temporaryTaskVo.saveOrStart = [NSNumber numberWithInteger:1];
        postEntityBean.entity = temporaryTaskVo.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        [HttpMamager postRequestWithURLString:DYZ_mes_temporaryTask_temporaryTaskStart parameters:dic success:^(id responseObjectModel) {
            _viewLoading.hidden = true;
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [self initRequestGetTemporaryTaskWithId:[NSNumber numberWithLongLong:returnMsgBean.returnMsg.longLongValue]];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
            }
        } fail:^(NSError *error) {
            _viewLoading.hidden = true;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}



//员工关闭
- (IBAction)buttonCloseSelfClick:(UIButton *)sender {
    [self closeSelfClick];
}

- (void)closeSelfClick {
    _viewLoading.hidden = false;
           
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
           
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    TemporaryTaskVo *temporaryTaskVo = [[TemporaryTaskVo alloc] init];
           
    temporaryTaskVo.idDYZ = self.temporaryTaskVo.idDYZ;
    temporaryTaskVo.siteCode = userInfo.siteCode;
    temporaryTaskVo.modifyUser = userInfo.userCode;
    postEntityBean.entity = temporaryTaskVo.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_mes_temporaryTask_temporaryTaskClose parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"关闭成功"];
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = true;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

//员工暂停
- (IBAction)buttonSuspendSelfClick:(UIButton *)sender {
    TemporaryTaskSuspendView *view = [TemporaryTaskSuspendView loadXibView];
    [view initWithDataWithAffirmButtonClick:^(NSString * _Nonnull msg) {
        _viewLoading.hidden = false;
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        
        MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
        TemporaryTaskShutdownVo *temporaryTaskShutdownVo = [[TemporaryTaskShutdownVo alloc] init];
        temporaryTaskShutdownVo.siteCode = userInfo.siteCode;
        temporaryTaskShutdownVo.temporaryTaskId = self.temporaryTaskVo.idDYZ;
        temporaryTaskShutdownVo.shutdownCause = msg;
        temporaryTaskShutdownVo.createUser = userInfo.userCode;
        temporaryTaskShutdownVo.modifyUser = userInfo.userCode;
        postEntityBean.entity = temporaryTaskShutdownVo.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_mes_temporaryTask_temporaryTaskShutdown parameters:dic success:^(id responseObjectModel) {
            _viewLoading.hidden = true;
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [self initRequestGetTemporaryTaskWithId:self.temporaryTaskVo.idDYZ];
            }
        } fail:^(NSError *error) {
            _viewLoading.hidden = true;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
        
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    }];
    [self.view addSubview:view];
    _temporaryTaskSuspendView = view;
}



//员工完成
- (IBAction)buttonFinishSelfClick:(UIButton *)sender {
    //(需要输密码)
    CompleteConfirmationVC *vc = [[CompleteConfirmationVC alloc] init];
    vc.temporaryTaskVo = self.temporaryTaskVo;
    vc.workTime = [NSNumber numberWithLong:_secondsCountUp/1000/60];
    //获取计划工时
    for (TemporaryTaskTypeVo *temp in self.temporaryTaskTypeVoList) {
        if (temp.idDYZ == self.temporaryTaskVo.temporaryTaskTypeId) {
            vc.name = temp.name;
            vc.planWorkTime = temp.planWorkTime;
            break;
        }
    }
    
    [self.navigationController pushViewController:vc animated:true];
}



//员工继续
- (IBAction)buttonContinueSelfClick:(UIButton *)sender {
    _viewLoading.hidden = false;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    TemporaryTaskVo *temporaryTaskVo = [[TemporaryTaskVo alloc] init];
    temporaryTaskVo.idDYZ = self.temporaryTaskVo.idDYZ;
    temporaryTaskVo.siteCode = userInfo.siteCode;
    temporaryTaskVo.modifyUser = userInfo.userCode;
    postEntityBean.entity = temporaryTaskVo.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_mes_temporaryTask_temporaryTaskContinue parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [self initRequestGetTemporaryTaskWithId:self.temporaryTaskVo.idDYZ];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = true;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}


//组长关闭
- (IBAction)buttonCloseLeaderClick:(UIButton *)sender {
    [self closeSelfClick];
}


//组长完成
- (IBAction)buttonFinishLeaderClick:(UIButton *)sender {
    //(不需要输密码)
    CompleteConfirmationCipherConfirmationView *viewConfirmation = [CompleteConfirmationCipherConfirmationView loadXibView];
    viewConfirmation.needPassword = [NSNumber numberWithInteger:0];
    viewConfirmation.workTime = [NSNumber numberWithLong:_secondsCountUp/1000/60];
    //获取计划工时
    for (TemporaryTaskTypeVo *temp in self.temporaryTaskTypeVoList) {
        if (temp.idDYZ == self.temporaryTaskVo.temporaryTaskTypeId) {
            viewConfirmation.name = temp.name;
            viewConfirmation.planWorkTime = temp.planWorkTime;
            break;
        }
    }
    [viewConfirmation initWithDataWithAffirmWithName:@"" ButtonClick:^ {
        if (viewConfirmation.textFieldjihuagongshi.text.integerValue == 0) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"计划工时要大于0"];
            return;
        }
        
        _viewLoading.hidden = false;
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];

        MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
        TemporaryTaskVo  *temporaryTaskVo  = [[TemporaryTaskVo  alloc] init];
        temporaryTaskVo.idDYZ = self.temporaryTaskVo.idDYZ;
        temporaryTaskVo.siteCode = userInfo.siteCode;
        temporaryTaskVo.createUser = userInfo.userCode;
        temporaryTaskVo.modifyUser = userInfo.userCode;
        temporaryTaskVo.planWorkTime = [NSNumber numberWithInteger:viewConfirmation.textFieldjihuagongshi.text.integerValue];
        postEntityBean.entity = temporaryTaskVo.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;

        [HttpMamager postRequestWithURLString:DYZ_mes_temporaryTask_temporaryTaskCommit parameters:dic success:^(id responseObjectModel) {
            _viewLoading.hidden = true;
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [viewConfirmation removeFromSuperview];

                [self.navigationController popViewControllerAnimated:true];
            } else {

                [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];

            }
        } fail:^(NSError *error) {
            _viewLoading.hidden = true;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];        
    }];
    [self.view addSubview:viewConfirmation];
    
}


- (void)initRequestGetTemporaryTaskTypeList {
    _viewLoading.hidden = false;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    TemporaryTaskTypeVo *temporaryTaskTypeVo = [[TemporaryTaskTypeVo alloc] init];
    temporaryTaskTypeVo.siteCode = userInfo.siteCode;
    postEntityBean.entity = temporaryTaskTypeVo.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_mes_temporaryTask_getTemporaryTaskTypeList parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.temporaryTaskTypeVoList = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dicTemp in returnListBean.list) {
                TemporaryTaskTypeVo *vo = [TemporaryTaskTypeVo mj_objectWithKeyValues:dicTemp];
                if (vo.lockFlag.integerValue == 0) {
                    [self.temporaryTaskTypeVoList addObject:vo];
                }
            }
            [self.tableViewTaskType reloadData];
            if (self.labelTask.text.length > 0) {
                
            } else {
                if (self.temporaryTaskTypeVoList.count > 0) {
                    TemporaryTaskTypeVo *vo = self.temporaryTaskTypeVoList[_index];
                    self.labelTask.text = vo.name;
                    self.textFieldPlanWorkTime.text = vo.planWorkTime.stringValue;
                    if (vo.taskSpecificationRequiredFlag.integerValue == 1) {
            
                        self.labelTaskExplain.text = @"任务说明(必填)";
                        NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] initWithString:self.labelTaskExplain.text];
                        [abs addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(self.labelTaskExplain.text.length-3, 2)];
                        self.labelTaskExplain.attributedText = abs;
                        
                    } else {
                        self.labelTaskExplain.text = @"任务说明";
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = true;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (void)initRequestGetTemporaryTaskWithId:(NSNumber *)DYZid{
    _viewLoading.hidden = false;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    TemporaryTaskVo *temporaryTaskVo = [[TemporaryTaskVo alloc] init];
    
    temporaryTaskVo.idDYZ = DYZid;
    
    postEntityBean.entity = temporaryTaskVo.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_mes_temporaryTask_getTemporaryTask parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        if (responseObjectModel == nil) { //返回为 (null)。没传idDYZ的时候返回，null，意为创建；
            TemporaryTaskVo *temporaryTaskVo = [[TemporaryTaskVo alloc] init];
            temporaryTaskVo.status = [NSNumber numberWithInteger:8];//自己给它一个状态8，对应按钮为【创建】和【开始】
            temporaryTaskVo.createUser = userInfo.userCode;
            temporaryTaskVo.createUserText = userInfo.userText;
            [self loadViewDYZwith:temporaryTaskVo];
        } else {
            ReturnEntityBean *returnEntityBean = responseObjectModel;
            if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
                TemporaryTaskVo *temporaryTaskVo = [TemporaryTaskVo mj_objectWithKeyValues:returnEntityBean.entity];
                self.temporaryTaskVo = temporaryTaskVo;
                if (temporaryTaskVo.status.integerValue == 2) {//返回后，再次进入，让时间显示
                    _secondsCountUp = temporaryTaskVo.workTime.longValue;
                    [self showLabelTime];
                }
                [self loadViewDYZwith:temporaryTaskVo];
            }
        }
        
        
    } fail:^(NSError *error) {
        _viewLoading.hidden = true;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

- (void)loadViewDYZwith:(TemporaryTaskVo *)temporaryTaskVo {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    

    
    self.buttonCreateSelf.hidden = true;
    self.buttonStartSelf.hidden = true;
    self.buttonCloseSelf.hidden = true;
    self.buttonSuspendSelf.hidden = true;
    self.buttonFinishSelf.hidden = true;
    self.buttonContinueSelf.hidden = true;
    self.buttonCloseLeader.hidden = true;
    self.buttonFinishLeader.hidden = true;
    
    
    //临时任务状态 0 创建 1 进行中 2 暂停 3 完成 4 关闭             8（自己添加的，对应的按钮是【创建】【开始】）
    
    if (self.leaderFlag == 1 && ![temporaryTaskVo.createUser isEqualToString:userInfo.userCode]) {
        //组长进来、且不是自己的任务
        if (temporaryTaskVo.status.integerValue == 8) {
               // 未创建的不会出现，因为在列表页面，不会出现未创建的状态
           } else if (temporaryTaskVo.status.integerValue == 0) {
               // 关闭
               self.buttonCloseLeader.hidden = false;
               _secondsCountUp = 0;
               [_countDownTimer setFireDate:[NSDate distantFuture]];//停
           } else if (temporaryTaskVo.status.integerValue == 1) {
               // 完成 (不需要输密码)
               self.buttonFinishLeader.hidden = false;
               _secondsCountUp = ([[NSDate date] timeIntervalSinceDate:[ToolTransition dateFromString:temporaryTaskVo.startDateTime]])*1000+temporaryTaskVo.workTime.longValue;
               [_countDownTimer setFireDate:[NSDate distantPast]];//跑
           } else if (temporaryTaskVo.status.integerValue == 2) {
               // 完成 (不需要输密码)
               self.buttonFinishLeader.hidden = false;
               _secondsCountUp = temporaryTaskVo.workTime.longValue;
               [_countDownTimer setFireDate:[NSDate distantFuture]];//停
           } else if (temporaryTaskVo.status.integerValue == 3) {
               //完成的不会出现，因为在列表页面，不会出现未创建的状态
           } else if (temporaryTaskVo.status.integerValue == 4) {
               //关闭的不会出现，因为在列表页面，不会出现未创建的状态
           }
    } else {
        //自己进来（包括组长进来，是自己的任务）
        if (temporaryTaskVo.status.integerValue == 8) {
            // 创建、开始
            self.buttonCreateSelf.hidden = false;
            self.buttonStartSelf.hidden = false;
            _secondsCountUp = 0;
            [_countDownTimer setFireDate:[NSDate distantFuture]];//停
        } else if (temporaryTaskVo.status.integerValue == 0) {
            // 关闭、开始
            self.buttonCloseSelf.hidden = false;
            self.buttonStartSelf.hidden = false;
            _secondsCountUp = 0;
            [_countDownTimer setFireDate:[NSDate distantFuture]];//停
        } else if (temporaryTaskVo.status.integerValue == 1) {
            // 暂停、完成 (需要输密码)
            self.buttonSuspendSelf.hidden = false;
            self.buttonFinishSelf.hidden = false;
            _secondsCountUp = ([[NSDate date] timeIntervalSinceDate:[ToolTransition dateFromString:temporaryTaskVo.startDateTime]])*1000+temporaryTaskVo.workTime.longValue;
            [_countDownTimer setFireDate:[NSDate distantPast]];//跑
        } else if (temporaryTaskVo.status.integerValue == 2) {
            // 继续、完成 (需要输密码)
            self.buttonContinueSelf.hidden = false;
            self.buttonFinishSelf.hidden = false;
            _secondsCountUp = temporaryTaskVo.workTime.longValue;
            [_countDownTimer setFireDate:[NSDate distantFuture]];//停
        } else if (temporaryTaskVo.status.integerValue == 3) {
            //完成的不会出现，因为在列表页面，不会出现未创建的状态
        } else if (temporaryTaskVo.status.integerValue == 4) {
            //关闭的不会出现，因为在列表页面，不会出现未创建的状态
        }
    }

    self.buttonTask.enabled = false;
    self.textFieldPlanWorkTime.enabled = false;
    self.textViewTaskExplain.editable = false;
    if (temporaryTaskVo.status.integerValue == 8) {
        self.buttonTask.enabled = true;
        self.textFieldPlanWorkTime.enabled = true;
        self.textViewTaskExplain.editable = true;
    } else {
        self.labelTask.text = temporaryTaskVo.name;
        self.textFieldPlanWorkTime.text = temporaryTaskVo.planWorkTime.stringValue;
        self.textViewTaskExplain.inputAccessoryView = nil;
    }
    self.labelName.text = temporaryTaskVo.createUserText;
    self.textViewTaskExplain.text = temporaryTaskVo.taskSpecification;
}

- (UIToolbar *)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 38)];
    toolbar.tintColor = colorRGB(0, 168, 255);
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space,bar];
    return toolbar;
}

- (void)textFieldDone {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
