//
//  MouldGiveInViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "MouldGiveInViewController.h"
#import "VoHeader.h"
#import "MouldGiveOutHeader.h"
#import "MouldGiveInDetailCell.h"
#import "MouldGiveOutDetailCell01.h"
#import "MouldGiveOutDetailCell02.h"

#import "MouldManagerGiveOutSelectCauseView.h"

#import <ReactiveObjC.h>

@interface MouldGiveInViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UIView *_viewLoading;
}

@property (nonatomic, strong) NSMutableArray *arrayModelSequenceVo;
@property (nonatomic, strong) NSMutableArray *arrayModelReturnCauseList;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBack;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *buttonGiveOut;

@property (nonatomic, strong) MouldManagerGiveOutSelectCauseView *mouldManagerGiveOutSelectCauseView;
@end

@implementation MouldGiveInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.heightNavBar.constant = Height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MouldGiveInDetailCell" bundle:nil] forCellReuseIdentifier:@"mouldGiveInDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MouldGiveOutHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"mouldGiveOutHeader"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0.1;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 0.1;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.sectionFooterHeight = 5;
    
    [self request_modelSequence_getProductionModelSequence];
    [self request_modelSequence_getModelReturnCauseList];
    
    
    @weakify(self);
    [[self.buttonLeftBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:true];
    }];
    
    //还回
    [[self.buttonGiveOut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self request_modelSequence_updateModelSequenceStatus];
    }];
    
    
    
    self.mouldManagerGiveOutSelectCauseView = [MouldManagerGiveOutSelectCauseView loadMyView];
    [self.view addSubview:self.mouldManagerGiveOutSelectCauseView];
    self.mouldManagerGiveOutSelectCauseView.hidden = YES;
    
    [self.mouldManagerGiveOutSelectCauseView callBackSelectTableViewIndex:^(NSInteger index, ModelReturnCauseVo * _Nonnull model) {
        ModelSequenceVo *sequenceVo = self.arrayModelSequenceVo[index];
        sequenceVo.causeText = model.causeText;
        sequenceVo.causeCode = model.causeCode;
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayModelSequenceVo.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MouldGiveInDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mouldGiveInDetailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ModelSequenceVo  *model  = self.arrayModelSequenceVo[indexPath.row];
    cell.label0.text = model.sequenceNum;
    
    if (model.isSelect.integerValue == 0) {
        cell.imageView0.image = [UIImage imageNamed:@"unselection"];
    } else {
        cell.imageView0.image = [UIImage imageNamed:@"selection"];
    }
    
    cell.label1.text = model.modelCode;
    if (model.exceptionFlag.integerValue == 0) {
        cell.label2.text = @"正常";
    } else {
        cell.label2.text = @"异常";
    }
    NSString *status;
    if (model.status.integerValue == 0) {
        status = @"库存";
    } else if (model.status.integerValue == 1) {
        status = @"生产";
    } else if (model.status.integerValue == 2) {
        status = @"待处理";
    } else if (model.status.integerValue == 3) {
        status = @"维修中";
    } else if (model.status.integerValue == 4) {
        status = @"报废";
    }
    cell.label3.text = status;
    
    [cell.buttonSelect addTarget:self action:@selector(buttonMouldManagerGiveOutSelectCauseView:) forControlEvents:UIControlEventTouchUpInside];
    cell.buttonSelect.tag = indexPath.row;
    
    cell.textField.text = model.causeText;
    cell.textField.placeholder = @"请选择";
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MouldGiveOutHeader *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"mouldGiveOutHeader"];
    view.labelTitle.text = @"生产现场模具序列号";
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ModelSequenceVo  *model  = self.arrayModelSequenceVo[indexPath.row];
    model.isSelect = model.isSelect.integerValue==0?[NSNumber numberWithInteger:1]:[NSNumber numberWithInteger:0];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)buttonMouldManagerGiveOutSelectCauseView:(UIButton *)sender {
    self.mouldManagerGiveOutSelectCauseView.hidden = NO;
    self.mouldManagerGiveOutSelectCauseView.index = sender.tag;
    
}

- (void)request_modelSequence_getProductionModelSequence {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    ModelSequenceVo *modelSequenceVo = [[ModelSequenceVo alloc] init];
    modelSequenceVo.siteCode = siteCode;
    modelSequenceVo.productionControlNum = self.productionControlNum;
        
    mesPostEntityBean.entity = modelSequenceVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_modelSequence_getProductionModelSequence parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.arrayModelSequenceVo = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *dataArray = returnListBean.list;
            for (NSDictionary *dic in dataArray) {
                ModelSequenceVo  *model  = [ModelSequenceVo  mj_objectWithKeyValues:dic];
                [self.arrayModelSequenceVo addObject:model];
            }
            [self.tableView reloadData];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
       self->_viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}


- (void)request_modelSequence_getModelReturnCauseList {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    ModelReturnCauseVo *modelReturnCauseVo = [[ModelReturnCauseVo alloc] init];
    modelReturnCauseVo.siteCode = siteCode;
        
    mesPostEntityBean.entity = modelReturnCauseVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_modelSequence_getModelReturnCauseList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.arrayModelReturnCauseList = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *dataArray = returnListBean.list;
            for (NSDictionary *dic in dataArray) {
                ModelReturnCauseVo  *model  = [ModelReturnCauseVo  mj_objectWithKeyValues:dic];
                [self.arrayModelReturnCauseList addObject:model];
            }
            [self.mouldManagerGiveOutSelectCauseView loadTableWithArray:self.arrayModelReturnCauseList];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
       self->_viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (void)request_modelSequence_updateModelSequenceStatus {
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    
    for (ModelSequenceVo *model in self.arrayModelSequenceVo) {
        if (model.isSelect.integerValue == 1) {
            model.status = [NSNumber numberWithInteger:0];
            model.createUser = tpfUser.userCode;
            [array addObject:model];
        }
    }
    
    if (array.count == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择模具号"];
        return;
    }
        
    mesPostEntityBean.entity = array.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    _viewLoading.hidden = NO;
    
    [HttpMamager postRequestWithURLString:DYZ_modelSequence_updateModelSequenceStatus parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"还回成功"];
            
            [self.navigationController popViewControllerAnimated:true];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
        }
    } fail:^(NSError *error) {
       self->_viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
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
