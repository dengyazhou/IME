//
//  MouldGiveOutViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "MouldGiveOutViewController.h"
#import "VoHeader.h"
#import "MouldGiveOutHeader.h"
#import "MouldGiveInDetailCell.h"
#import "MouldGiveOutDetailCell01.h"
#import "MouldGiveOutDetailCell02.h"

#import "MouldProductionDetailViewController.h"

#import <ReactiveObjC.h>

@interface MouldGiveOutViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UIView *_viewLoading;
}

@property (nonatomic, strong) NSMutableArray *arrayModelSequenceVo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBack;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *buttonGiveOut;
@end

@implementation MouldGiveOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.heightNavBar.constant = Height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MouldGiveOutDetailCell01" bundle:nil] forCellReuseIdentifier:@"mouldGiveOutDetailCell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MouldGiveOutDetailCell02" bundle:nil] forCellReuseIdentifier:@"mouldGiveOutDetailCell02"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MouldGiveOutHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"mouldGiveOutHeader"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0.1;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 0.1;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.sectionFooterHeight = 5;
    
    
    
    @weakify(self);
    [[self.buttonLeftBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:true];
    }];
    
    //发放
    [[self.buttonGiveOut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self request_modelSequence_updateModelSequenceStatus];
    }];
    
    [self request_modelSequence_getModelSequenceByMouldCode];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.arrayModelSequenceVo.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MouldGiveOutDetailCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mouldGiveOutDetailCell01" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.label0.text = self.materialCode;
        cell.label1.text = self.materialText;
        cell.label2.text = self.plannedQuantity.stringValue;
        cell.label3.text = [[FunctionDYZ dyz] strDateFormat:self.requirementDate withEnterDateFormat:@"yyyy-MM-dd HH:mm:ss" withGoDateFormat:@"yyyy-MM-dd"];
        cell.label4.text = self.mouldCode;
        if (self.status.integerValue == 2) {
            cell.label5.text = @"投产";
        } else if (self.status.integerValue == 3) {
            cell.label5.text = @"报工";
        }
        cell.label6.text = self.plannedstartDateTime;
        cell.label7.text = [[FunctionDYZ dyz] strDateFormat:self.placeOrderDateTime withEnterDateFormat:@"yyyy-MM-dd HH:mm:ss" withGoDateFormat:@"yyyy-MM-dd"];
        cell.label8.text = self.modelCount;
        cell.label9.text = self.availableModelCount;
        cell.label10.text = self.useModelCount;
        return cell;
        
    } else if (indexPath.section == 1) {
        MouldGiveOutDetailCell02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mouldGiveOutDetailCell02" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row%2 == 0) {
            cell.viewBg.backgroundColor = [UIColor whiteColor];
        } else {
            cell.viewBg.backgroundColor = colorRGB(210, 210, 210);
        }
        
        
        ModelSequenceVo  *model  = self.arrayModelSequenceVo[indexPath.row];
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSUnderlineColorAttributeName : colorRGB(0, 54, 255)};
        NSMutableAttributedString *label0Str = [[NSMutableAttributedString alloc] initWithString:model.sequenceNum attributes:attribtDic];
        cell.label0.attributedText = label0Str;
        
        [cell.buttonLabel0 addTarget:self action:@selector(buttonSequenceNumClickGoToDetail:) forControlEvents:UIControlEventTouchUpInside];
        cell.buttonLabel0.tag = indexPath.row;
        
        cell.label1.text = model.modelCode;
        cell.label2.text = model.confirmCount.stringValue;
        cell.label3.text = model.roughweightSum.stringValue;
    
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
        cell.label4.text = status;
        
        if (model.isSelect.integerValue == 0) {
            cell.imageView0.image = [UIImage imageNamed:@"unselection"];
        } else {
            cell.imageView0.image = [UIImage imageNamed:@"selection"];
        }
        
        return cell;
    } else {
       return nil;
    }
}

- (void)buttonSequenceNumClickGoToDetail:(UIButton *)sender {
    ModelSequenceVo  *model  = self.arrayModelSequenceVo[sender.tag];
    MouldProductionDetailViewController *vc = [[MouldProductionDetailViewController alloc] init];
    vc.modelCode = model.modelCode;
    vc.sequenceNum = model.sequenceNum;
    [self.navigationController pushViewController:vc animated:true];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MouldGiveOutHeader *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"mouldGiveOutHeader"];
    if (section == 0) {
        view.labelTitle.text = @"信息";
    } else if (section == 1) {
        view.labelTitle.text = @"模具序列号";
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        ModelSequenceVo  *model  = self.arrayModelSequenceVo[indexPath.row];
        if (model.status.integerValue == 0) {// 只有库存状态 ， 才能被 勾选
            model.isSelect = model.isSelect.integerValue==0?[NSNumber numberWithInteger:1]:[NSNumber numberWithInteger:0];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

- (void)request_modelSequence_getModelSequenceByMouldCode {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    ModelSequenceVo *modelSequenceVo = [[ModelSequenceVo alloc] init];
    modelSequenceVo.siteCode = siteCode;
    modelSequenceVo.modelCode = self.mouldCode;
        
    mesPostEntityBean.entity = modelSequenceVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_modelSequence_getModelSequenceByMouldCode parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.arrayModelSequenceVo = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *dataArray = returnListBean.list;
            for (NSDictionary *dic in dataArray) {
                ModelSequenceVo  *model  = [ModelSequenceVo  mj_objectWithKeyValues:dic];
//                model.isSelect = [NSNumber numberWithInteger:0];//默认值就是0，所以就不需要 再赋值啦
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

- (void)request_modelSequence_updateModelSequenceStatus {
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    
    for (ModelSequenceVo *model in self.arrayModelSequenceVo) {
        if (model.isSelect.integerValue == 1) {
            model.status = [NSNumber numberWithInteger:1];
            model.productionControlNum = self.productionControlNum;
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
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"发放成功"];
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
