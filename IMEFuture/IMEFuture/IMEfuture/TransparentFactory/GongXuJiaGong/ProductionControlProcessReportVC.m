//
//  ProductionControlProcessReportVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ProductionControlProcessReportVC.h"
#import "VoHeader.h"

#import "SaoYiSaoVC.h"
#import "ScanZuoYeDanYuanViewController.h"

#import "ProcessDetailCellTableViewCell.h"
#import "ProductionControlProcessDetailVC.h"

@interface ProductionControlProcessReportVC () <UITableViewDelegate,UITableViewDataSource> {
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    
    UIView *_viewLoading;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray <ProcessOperationDetailVo *> *list;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;


@end

@implementation ProductionControlProcessReportVC

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
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProcessDetailCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"processDetailCellTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0.1;
    self.tableView.rowHeight = UITableViewAutomaticDimension;


    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    ProcessOperationDetailVo *processOperationDetailVo = [[ProcessOperationDetailVo alloc] init];
    processOperationDetailVo.siteCode = siteCode;
    processOperationDetailVo.productionControlNum = self.productionControlNum;
    mesPostEntityBean.entity = processOperationDetailVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_rs_mes_productionControlProcessReport_processDetailsList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        
        _viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.list = [ProcessOperationDetailVo mj_objectArrayWithKeyValuesArray:returnListBean.list];
            [self.tableView reloadData];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProcessDetailCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"processDetailCellTableViewCell" forIndexPath:indexPath];
    ProcessOperationDetailVo *model = self.list[indexPath.row];
    cell.label0.text = model.operationText;
    cell.label1.text = [NSString stringWithFormat:@"%@/%@",model.plannedQuantity,model.completedQuantity];;
    cell.label2.text = [NSString stringWithFormat:@"%@/%@/%@",model.plannedHours,model.actualHours,model.timeVariance];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProcessOperationDetailVo *model = self.list[indexPath.row];
    ProductionControlProcessDetailVC *vc = [[ProductionControlProcessDetailVC alloc] init];
    vc.productionControlNum = model.productionControlNum;
    vc.processOperationId = model.processOperationId;
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSMutableArray *)list {
    if (!_list) {
        _list = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _list;
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
