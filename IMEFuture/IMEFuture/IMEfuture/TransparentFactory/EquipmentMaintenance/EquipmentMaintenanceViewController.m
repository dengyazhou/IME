//
//  EquipmentMaintenanceViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "EquipmentMaintenanceViewController.h"
#import "VoHeader.h"

#import "SaoYiSaoVC.h"
#import "ZuoYeDanYuanViewController.h"

#import "EMaintenanceCell0.h"
#import "EMaintenanceCell1.h"
#import "EMaintenanceHeader.h"

#import <ReactiveObjC.h>



@interface EquipmentMaintenanceViewController () <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource> {
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    
    UIView *_viewLoading;
}


@property (weak, nonatomic) IBOutlet UIView *viewZhong0;
@property (weak, nonatomic) IBOutlet UIView *viewZhong1;

@property (weak, nonatomic) IBOutlet UIView *viewBottom0;
@property (weak, nonatomic) IBOutlet UIView *viewBottom1;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;//摄像头对准图纸二维码，点击扫描

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar1;

@property (weak, nonatomic) IBOutlet UIButton *buttonCommint;


@property (nonatomic, strong) NSMutableArray *dataArrayEquipmentMaintenancePlanMonthVo;

@end

@implementation EquipmentMaintenanceViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _height_NavBar = Height_NavBar;
    _height_BottomBar = Height_BottomBar;
    self.heightNavBar.constant = _height_NavBar;
    self.heightBottomBar.constant = _height_BottomBar;
    self.heightBottomBar1.constant = _height_BottomBar;
    
//    self.viewZhong0.hidden = YES;
//    self.viewBottom0.hidden = YES;
    
    self.viewZhong1.hidden = YES;
    self.viewBottom1.hidden = YES;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"EMaintenanceCell0" bundle:nil] forCellReuseIdentifier:@"eMaintenanceCell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EMaintenanceCell1" bundle:nil] forCellReuseIdentifier:@"eMaintenanceCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EMaintenanceHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"eMaintenanceHeader"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedSectionHeaderHeight = 0.1;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.sectionFooterHeight = 0;
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    
    [self setAttributedString:@"摄像头对准设备二维码，\n点击扫描"];//设置中间字颜色
    

    
    self.textField.delegate = self;
    
    
    @weakify(self);
    [[self.buttonCommint rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSLog(@"dyz:提交");
        [self commitEquipmentMaintenance];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.dataArrayEquipmentMaintenancePlanMonthVo.count;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else if (section == 1) {
        EMaintenanceHeader *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"eMaintenanceHeader"];
        
        return view;
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        EMaintenanceCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"eMaintenanceCell0" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.dataArrayEquipmentMaintenancePlanMonthVo.count > 0) {
            EquipmentMaintenancePlanMonthVo *model = self.dataArrayEquipmentMaintenancePlanMonthVo[indexPath.row];
            cell.label0.text = [NSString stringWithFormat:@"设备编码:%@",model.equipmentCode]; //设备编码
            cell.label1.text = [NSString stringWithFormat:@"设备名称:%@",model.equipmentText]; //设备名称
            cell.label2.text = [NSString stringWithFormat:@"保养年份:%d",model.planYear.intValue]; //保养年份
            cell.label3.text = [NSString stringWithFormat:@"保养月份:%d",model.month.intValue]; //保养月份
        } else {
            cell.label0.text = [NSString stringWithFormat:@"设备编码:"]; //设备编码
            cell.label1.text = [NSString stringWithFormat:@"设备名称:"]; //设备名称
            cell.label2.text = [NSString stringWithFormat:@"保养年份:"]; //保养年份
            cell.label3.text = [NSString stringWithFormat:@"保养月份:"]; //保养月份
        }
        return cell;
    } else if (indexPath.section == 1) {
        EMaintenanceCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"eMaintenanceCell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        EquipmentMaintenancePlanMonthVo *model = self.dataArrayEquipmentMaintenancePlanMonthVo[indexPath.row];
        cell.label0.text = model.maintainProjectText;
        
        if (model.finishStatus.integerValue == 0) {//没完成
            cell.label1.text = @"未保养";
            if (model.isSelect.integerValue == 1) {
                cell.imageView0.image = [UIImage imageNamed:@"selection"];
            } else {
                cell.imageView0.image = [UIImage imageNamed:@"unselection"];
            }
        } else {//完成了
            cell.label1.text = @"已保养";
            cell.imageView0.image = [UIImage imageNamed:@"selection"];
            
        }
        
        return cell;
    } else {
        return nil;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        EquipmentMaintenancePlanMonthVo  *model  = self.dataArrayEquipmentMaintenancePlanMonthVo[indexPath.row];
        if (model.finishStatus.integerValue == 0) {
            model.isSelect = model.isSelect.integerValue==0?[NSNumber numberWithInteger:1]:[NSNumber numberWithInteger:0];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self request:textField.text];
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}

#pragma mark 扫描
- (IBAction)buttonScan:(id)sender {
    NSLog(@"%s",__FUNCTION__);
    SaoYiSaoVC *saoYiSaoVC = [[SaoYiSaoVC alloc] init];
    saoYiSaoVC.scanTitle = @"扫描设备二维码";
    [saoYiSaoVC setResultBlock:^(NSString *result) {
        
        NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
         [self request:dic[@"equipmentCode"]];
    }];
    [self presentViewController:saoYiSaoVC animated:YES completion:nil];
}

- (void)request:(NSString *)result {
    NSLog(@"dyz:%@",result);
    _viewLoading.hidden = NO;

    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo * userInfoVo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString * siteCode = userInfoVo.siteCode;

    MesPostEntityBean * mesPostEntityBean = [[MesPostEntityBean alloc] init];
    EquipmentMaintenancePlanMonthVo * model = [[EquipmentMaintenancePlanMonthVo alloc] init];
    model.siteCode = siteCode;
    model.equipmentCode = result;
    mesPostEntityBean.entity = model.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_equipmentMaintenance_selectEquipmentMaintenancePlanMonthList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;

        self->_viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            NSMutableArray *array = [EquipmentMaintenancePlanMonthVo mj_objectArrayWithKeyValuesArray:returnListBean.list];
            
            if (array.count == 0) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"该设备本月没有保养计划！"];
                return;
            }
            
            self.dataArrayEquipmentMaintenancePlanMonthVo = array;
            [self.tableView reloadData];
            
            self.viewZhong0.hidden = YES;
            self.viewBottom0.hidden = YES;
            self.viewZhong1.hidden = NO;
            self.viewBottom1.hidden = NO;

        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"该设备本月没有保养计划！"];
        }
    } fail:^(NSError *error) {
       self->_viewLoading.hidden = YES;

    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (void)commitEquipmentMaintenance {
//    PersonnelVo *personnelVo = [PersonnelVo mj_objectWithKeyValues:returnListBean.list];


    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;

    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (EquipmentMaintenancePlanMonthVo *item in self.dataArrayEquipmentMaintenancePlanMonthVo) {
        if (item.isSelect.integerValue == 1) {
            EquipmentMaintenanceLogVo *vo = [[EquipmentMaintenanceLogVo alloc] init];
            vo.siteCode = siteCode;
            vo.equipmentMaintenancePlanMonthId = item.idDYZ;
            vo.confirmUser = self.personnelCode;
            [array addObject:vo];
        }
    }
    
    if (array.count == 0) {
        return;
    }
    
    _viewLoading.hidden = NO;

    mesPostEntityBean.entity = array.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;

    [HttpMamager postRequestWithURLString:DYZ_equipmentMaintenance_commitEquipmentMaintenance parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            
//            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"提交成功！"];
            [self.navigationController popViewControllerAnimated:true];
            
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
        self->_viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}


- (void)setAttributedString:(NSString *)text {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:colorRGB(0, 122, 254) range:NSMakeRange(5, text.length - 9)];
    self.label.attributedText = attributeStr;
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

- (IBAction)buttonCommint:(id)sender {
}
@end
