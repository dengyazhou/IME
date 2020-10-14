//
//  ReleaseViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ReleaseViewController.h"
#import "VoHeader.h"
#import "ReleaseHeader.h"
#import "ReleaseCell.h"

#import <ReactiveObjC.h>

#import "PlannedReleaseViewController.h"

@interface ReleaseViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate> {
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBack;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UIView *datePickerViewBG;


@property (weak, nonatomic) IBOutlet UIButton *buttonConfirmRelease;

@property (nonatomic, strong) ProductionOrderVo *productionOrderVo;

@property (nonatomic, strong) NSMutableArray *arrayData;

@property (nonatomic, strong) NSNumber *isLeftOrRigth;//1: 代表cell上左边 时间点击，2: 代表cell上右边 时间点击


@end

@implementation ReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReleaseHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"releaseHeader"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReleaseCell" bundle:nil] forCellReuseIdentifier:@"releaseCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0.1;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 0.1;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.sectionFooterHeight = 0;
    
    self.datePickerViewBG.backgroundColor = colorRGBA(0, 0, 0, 0.2);
    self.datePickerViewBG.hidden = true;
    
    [self.datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier: @"zh_CN"]];
    [self.datePicker addTarget:self action:@selector(onDatePickerChangedDate:) forControlEvents:UIControlEventValueChanged];
    
    //rac
    @weakify(self);
    
    UITapGestureRecognizer *viewSearchBackgroundTap = [[UITapGestureRecognizer alloc] init];
    viewSearchBackgroundTap.cancelsTouchesInView = NO;
    [self.datePickerViewBG addGestureRecognizer:viewSearchBackgroundTap];
    viewSearchBackgroundTap.delegate = self;
    
    [viewSearchBackgroundTap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        self.datePickerViewBG.hidden = true;
    }];
    
    
    self.arrayData = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    [[self.buttonLeftBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:true];
    }];
    
    //确认下达
    [[self.buttonConfirmRelease rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self request_productionOrderConfirm_saveProductionControl];
    }];
    
    [self request_productionOrderConfirm_decomposeProductionOrder];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.datePickerView]) {
        return NO;
    }
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ProductionOrderVo *model = self.productionOrderVo;
    
    ReleaseHeader *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"releaseHeader"];
    
    view.label01.text = model.productionOrderNum;
    view.label02.text = model.materialCode;
    view.label03.text = model.plannedQuantity.stringValue;
    view.label04.text = model.projectNum;
    view.label05.text = model.materialText;
    view.label06.text = model.releasedQuantity.stringValue;
    
    for (WorkCenterVo *vo in model.workCenterList) {
        if (vo.selectDyz.integerValue == 1) {
            view.labelWorkCenter.text = vo.workCenterText;
            break;
        }
    }
    
    for (MateriaProcessAssignVo *vo in model.materiaProcessAssignList) {
        if (vo.selectDyz.integerValue == 1) {
            view.labelMateriaProcess.text = vo.processText;
            break;
        }
    }
    
    view.workCenterList = model.workCenterList;
    view.materiaProcessAssignList = model.materiaProcessAssignList;
    [view.tableViewWorkCenter reloadData];
    [view.tableViewMateriaProcess reloadData];
    
    [view callBackReloadData:^{
        [tableView reloadData];
    }];
    
    view.textFiledBatchesRelease.inputAccessoryView = [self addToolbar];
    
    [view callBackBatchesReleaseblock:^{//分批下达
        double alreadyReleaseQuantity = 0;
        for (ProductionOrderVo *temp in self.arrayData) {
            alreadyReleaseQuantity = alreadyReleaseQuantity + temp.plannedQuantity.doubleValue;
        }
        
        //剩余数量
        double remainingQuantity = (model.plannedQuantity.doubleValue-model.releasedQuantity.doubleValue-alreadyReleaseQuantity);
        
        if (remainingQuantity <= 0) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"全部数量已下达完成！"];
            return;
        }
        
        if (view.textFiledBatchesRelease.text.length == 0 || view.textFiledBatchesRelease.text.doubleValue > remainingQuantity) {//只添加一条数据
//            NSLog(@"==========111111111+++++++++");
            ProductionOrderVo *item = [[ProductionOrderVo alloc] init];
            
            item.plannedstartDateTime = model.plannedstartDateTime;
            item.plannedendDateTime = model.plannedendDateTime;
            item.plannedQuantity = [NSNumber numberWithDouble:remainingQuantity];
            
            item.workCenterList = [[NSMutableArray alloc] initWithArray:model.workCenterList copyItems:YES];
            item.materiaProcessAssignList = [[NSMutableArray alloc] initWithArray:model.materiaProcessAssignList copyItems:YES];
            
            [self.arrayData addObject:item];
            
        } else {
            //向下取整，个数
            double count = floor(remainingQuantity/view.textFiledBatchesRelease.text.doubleValue);
            
            //多余的数量
            double excessQuantity = remainingQuantity-count*view.textFiledBatchesRelease.text.doubleValue;
            
            for (int i=0; i<count; i++) {
                ProductionOrderVo *item = [[ProductionOrderVo alloc] init];
                
                item.plannedstartDateTime = model.plannedstartDateTime;
                item.plannedendDateTime = model.plannedendDateTime;
                item.plannedQuantity = [NSNumber numberWithDouble:view.textFiledBatchesRelease.text.doubleValue];
                
                item.workCenterList = [[NSMutableArray alloc] initWithArray:model.workCenterList copyItems:YES];
                item.materiaProcessAssignList = [[NSMutableArray alloc] initWithArray:model.materiaProcessAssignList copyItems:YES];
                
                [self.arrayData addObject:item];
            }
            
            if (excessQuantity == 0) {
                
            } else {
                NSString *excessQuantityStr = [NSString stringWithFormat:@"%f",excessQuantity];
                
                ProductionOrderVo *item = [[ProductionOrderVo alloc] init];
                
                item.plannedstartDateTime = model.plannedstartDateTime;
                item.plannedendDateTime = model.plannedendDateTime;
//                item.plannedQuantity = [NSNumber numberWithDouble:excessQuantity];
                item.plannedQuantity = [NSNumber numberWithDouble:excessQuantityStr.doubleValue];
                
                item.workCenterList = [[NSMutableArray alloc] initWithArray:model.workCenterList copyItems:YES];
                item.materiaProcessAssignList = [[NSMutableArray alloc] initWithArray:model.materiaProcessAssignList copyItems:YES];
                
                [self.arrayData addObject:item];
            }
            
//            NSLog(@"==========%lf+++++++++",count);
        }
        
        
        [self.tableView reloadData];
        
        
    }];
    
    return view;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self.arrayData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [tableView reloadData];
    }];
    deleteAction.backgroundColor = colorRGB(249, 52, 52);

    return @[deleteAction];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReleaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"releaseCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ProductionOrderVo *model = self.arrayData[indexPath.row];
    
    for (WorkCenterVo *vo in model.workCenterList) {
        if (vo.selectDyz.integerValue == 1) {
            cell.labelWorkCenter.text = vo.workCenterText;
            break;
        }
    }
    
    for (MateriaProcessAssignVo *vo in model.materiaProcessAssignList) {
        if (vo.selectDyz.integerValue == 1) {
            cell.labelMateriaProcess.text = vo.processText;
            break;
        }
    }
    
    cell.workCenterList = model.workCenterList;
    cell.materiaProcessAssignList = model.materiaProcessAssignList;
    
    [cell callBackReloadData:^{//选择后，直接赋值，不用刷新整个表
        
        for (WorkCenterVo *vo in model.workCenterList) {
            if (vo.selectDyz.integerValue == 1) {
                cell.labelWorkCenter.text = vo.workCenterText;
                break;
            }
        }
        for (MateriaProcessAssignVo *vo in model.materiaProcessAssignList) {
            if (vo.selectDyz.integerValue == 1) {
                cell.labelMateriaProcess.text = vo.processText;
                break;
            }
        }
        
    }];
    
    cell.labelStartDateTime.text = model.plannedstartDateTime;//2020-08-22 00:00:00
    cell.labelEndDateTime.text = model.plannedendDateTime;
    
    
    ProductionOrderVo *modelHeader = self.productionOrderVo;
    NSDate *dateStartHeader =  [[FunctionDYZ dyz] dateWithString:modelHeader.plannedstartDateTime withEnterDateFormat:nil];
    NSDate *dateEndHeader =  [[FunctionDYZ dyz] dateWithString:modelHeader.plannedendDateTime withEnterDateFormat:nil];
    
    
    
    [cell callStartDateTime:^{
        self.datePickerViewBG.hidden = NO;
        
        NSDate *dateStart =  [[FunctionDYZ dyz] dateWithString:model.plannedstartDateTime withEnterDateFormat:nil];
        NSDate *dateEnd =  [[FunctionDYZ dyz] dateWithString:model.plannedendDateTime withEnterDateFormat:nil];
                
    
        [self.datePicker setDate:dateStart animated:YES];
        [self.datePicker setMinimumDate:dateStartHeader];
        [self.datePicker setMaximumDate:dateEnd];
        self.datePicker.tag = indexPath.row;
        
        self.isLeftOrRigth = [NSNumber numberWithInteger:1];
        
    }];
    
    [cell callEndDateTime:^{
        self.datePickerViewBG.hidden = NO;
        
        NSDate *dateStart =  [[FunctionDYZ dyz] dateWithString:model.plannedstartDateTime withEnterDateFormat:nil];
        NSDate *dateEnd =  [[FunctionDYZ dyz] dateWithString:model.plannedendDateTime withEnterDateFormat:nil];
        
        [self.datePicker setDate:dateEnd animated:YES];
        [self.datePicker setMinimumDate:dateStart];
        [self.datePicker setMaximumDate:dateEndHeader];
        self.datePicker.tag = indexPath.row;
        
        self.isLeftOrRigth = [NSNumber numberWithInteger:2];
        
    }];
    
    cell.textFiledPlannedQuantity.text = model.plannedQuantity.stringValue;
    
    [cell callTextFiledPlannedQuantity:^(NSString * _Nonnull str) {
        model.plannedQuantity = [NSNumber numberWithDouble:str.doubleValue];
    }];
    
    cell.textFiledPlannedQuantity.inputAccessoryView = [self addToolbar];
    
    return cell;
}

- (void)onDatePickerChangedDate:(UIDatePicker *)datePicker {
    if (self.isLeftOrRigth.integerValue == 1) {
        ProductionOrderVo *model = self.arrayData[datePicker.tag];
        model.plannedstartDateTime = [[FunctionDYZ dyz] stringWithDate:datePicker.date withEnterDateFormat:nil];
        NSLog(@"start:tag:%ld----%@",datePicker.tag,model.plannedstartDateTime);
    }
    if (self.isLeftOrRigth.integerValue == 2) {
        ProductionOrderVo *model = self.arrayData[datePicker.tag];
        model.plannedendDateTime = [[FunctionDYZ dyz] stringWithDate:datePicker.date withEnterDateFormat:nil];
        NSLog(@"end:tag:%ld----%@",datePicker.tag,model.plannedendDateTime);
    }
    
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:datePicker.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}



- (void)request_productionOrderConfirm_decomposeProductionOrder {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    ProductionOrderVo *productionOrderVo = [[ProductionOrderVo alloc] init];
    productionOrderVo.siteCode = siteCode;
    productionOrderVo.productionOrderNum = self.productionOrderNum;
    
    mesPostEntityBean.entity = productionOrderVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_productionOrderConfirm_decomposeProductionOrder parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            ProductionOrderVo *model = [ProductionOrderVo mj_objectWithKeyValues:returnEntityBean.entity];
            
             BOOL flagWorkCenter = NO;
            for (WorkCenterVo *vo in model.workCenterList) {
                if ([vo.workCenterCode isEqualToString:model.material.workCenterCode]) {
                    vo.selectDyz = [NSNumber numberWithInteger:1];
                    flagWorkCenter = YES;
                }
            }
            if (flagWorkCenter == NO) {
                if (model.workCenterList.count > 0) {
                    WorkCenterVo *vo = model.workCenterList.firstObject;
                    vo.selectDyz = [NSNumber numberWithInteger:1];
                }
            }
            BOOL flagMateria = NO;
            for (MateriaProcessAssignVo *vo in model.materiaProcessAssignList) {
                if ([vo.processCode isEqualToString:model.processCode] && [vo.processRev isEqualToString:model.processRev]) {
                    vo.selectDyz = [NSNumber numberWithInteger:1];
                    flagMateria = YES;
                }
            }
            if (flagMateria == NO) {
                if (model.materiaProcessAssignList.count > 0) {
                    MateriaProcessAssignVo *vo = model.materiaProcessAssignList.firstObject;
                    vo.selectDyz = [NSNumber numberWithInteger:1];
                }
            }
            
            self.productionOrderVo = model;
            [self.tableView reloadData];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
        self->_viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}


- (void)request_productionOrderConfirm_saveProductionControl {
    double alreadyReleaseQuantity = 0;
    for (ProductionOrderVo *temp in self.arrayData) {
        alreadyReleaseQuantity = alreadyReleaseQuantity + temp.plannedQuantity.doubleValue;
    }
    ProductionOrderVo *model = self.productionOrderVo;
    if (alreadyReleaseQuantity > model.plannedQuantity.doubleValue-model.releasedQuantity.doubleValue) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"下达的数量超过订单未下达的数量，请修改！"];
        return;
    }
   
    
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    ProductionOrderVo *productionOrderVo = [[ProductionOrderVo alloc] init];
    productionOrderVo.siteCode = siteCode;
    productionOrderVo.productionOrderNum = self.productionOrderNum;
    productionOrderVo.createUser = tpfUser.userCode;
    productionOrderVo.createUserName = tpfUser.userText;
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (ProductionOrderVo *model in self.arrayData) {
        ProductionControlVo *item = [[ProductionControlVo alloc] init];
        item.plannedQuantity = model.plannedQuantity;
        for (WorkCenterVo *vo in model.workCenterList) {
            if (vo.selectDyz.integerValue == 1) {
                item.workCenterCode = vo.workCenterCode;
                break;
            }
        }
        for (MateriaProcessAssignVo *vo in model.materiaProcessAssignList) {
            if (vo.selectDyz.integerValue == 1) {
                item.processCode = vo.processCode;
                item.processRev = vo.processRev;
                break;
            }
        }
        item.plannedStartDate = model.plannedstartDateTime;
        item.plannedendDateTime = model.plannedendDateTime;
        [array addObject:item];
    }
    productionOrderVo.productionControlVoList = array;
    
    mesPostEntityBean.entity = productionOrderVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_productionOrderConfirm_saveProductionControl parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isMemberOfClass:NSClassFromString(@"PlannedReleaseViewController")]) {
                    [vc setValue:[NSNumber numberWithBool:YES] forKey:@"refreshing"];
                    break;
                }
            }
            
            [self.navigationController popViewControllerAnimated:true];
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
        self->_viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
