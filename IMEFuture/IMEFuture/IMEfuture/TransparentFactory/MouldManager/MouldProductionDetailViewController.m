//
//  MouldProductionDetailViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "MouldProductionDetailViewController.h"
#import "VoHeader.h"
#import "MouldProductionDetailCell.h"

#import <ReactiveObjC.h>

@interface MouldProductionDetailViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UIView *_viewLoading;
    
    NSInteger _aPage;
}

@property (nonatomic, strong) NSMutableArray *arrayProductionConfirmVo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBack;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MouldProductionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.heightNavBar.constant = Height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MouldProductionDetailCell" bundle:nil] forCellReuseIdentifier:@"mouldProductionDetailCell"];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0.1;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    
    @weakify(self);
    [[self.buttonLeftBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:true];
    }];

    
    [self request_modelSequence_getWorkTimeLogByModel];
    [self.tableView.mj_header beginRefreshing];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrayProductionConfirmVo.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MouldProductionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mouldProductionDetailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row%2 == 0) {
        cell.viewBg.backgroundColor = [UIColor whiteColor];
    } else {
        cell.viewBg.backgroundColor = colorRGB(210, 210, 210);
    }
    
    ProductionConfirmVo *model = self.arrayProductionConfirmVo[indexPath.row];
    cell.label0.text = model.moldmaterial;
    cell.label1.text = model.materialCode;
    cell.label2.text = model.materialText;
    cell.label3.text = [[FunctionDYZ dyz] strDateFormat:model.confirmDateTime withEnterDateFormat:@"yyyy-MM-dd HH:mm:ss" withGoDateFormat:@"yyyy-MM-dd"];
    cell.label4.text = model.workTime;
    cell.label5.text = model.completedQuantity.stringValue;
    return cell;
}


- (void)request_modelSequence_getWorkTimeLogByModel {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        NSString *siteCode = tpfUser.siteCode;

        MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];

        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:[@1 integerValue]];

        mesPostEntityBean.pager = pagerBean;

        ProductionConfirmVo *productionConfirmVo = [[ProductionConfirmVo alloc] init];
        productionConfirmVo.siteCode = siteCode;
        productionConfirmVo.modelCode = self.modelCode;
        productionConfirmVo.sequenceNum = self.sequenceNum;

        mesPostEntityBean.entity = productionConfirmVo.mj_keyValues;
        NSDictionary *dic = mesPostEntityBean.mj_keyValues;

        [HttpMamager postRequestWithURLString:DYZ_modelSequence_getWorkTimeLogByModel parameters:dic success:^(id responseObjectModel) {
           ReturnListBean *returnListBean = responseObjectModel;

           if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
               self.arrayProductionConfirmVo = [[NSMutableArray alloc] initWithCapacity:0];
               NSMutableArray *dataArray = returnListBean.list;
               for (NSDictionary *dic in dataArray) {
                   ProductionConfirmVo  *model  = [ProductionConfirmVo  mj_objectWithKeyValues:dic];
                   [self.arrayProductionConfirmVo addObject:model];
               }
               [self.tableView reloadData];
               [self.tableView.mj_header endRefreshing];
               if (dataArray.count != 0) {
                   if (dataArray.count < [pageSizeDYZ integerValue]) {
                       [self.tableView.mj_footer endRefreshingWithNoMoreData];
                   } else {
                       [self.tableView.mj_footer endRefreshing];
                   }
               } else {
                   [self.tableView.mj_footer endRefreshingWithNoMoreData];
               }
               self->_aPage = 2;
           } else {
               [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
               [self.tableView.mj_header endRefreshing];
           }
        } fail:^(NSError *error) {
           [self.tableView.mj_header endRefreshing];
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        NSString *siteCode = tpfUser.siteCode;

        MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];

        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:self->_aPage];

        mesPostEntityBean.pager = pagerBean;

        ProductionConfirmVo *productionConfirmVo = [[ProductionConfirmVo alloc] init];
         productionConfirmVo.siteCode = siteCode;
        productionConfirmVo.modelCode = self.modelCode;
        productionConfirmVo.sequenceNum = self.sequenceNum;


        mesPostEntityBean.entity = productionConfirmVo.mj_keyValues;
        NSDictionary *dic = mesPostEntityBean.mj_keyValues;

        [HttpMamager postRequestWithURLString:DYZ_modelSequence_getWorkTimeLogByModel parameters:dic success:^(id responseObjectModel) {
          ReturnListBean *returnListBean = responseObjectModel;

          if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
              NSMutableArray *dataArray = returnListBean.list;
              for (NSDictionary *dic in dataArray) {
                  ProductionConfirmVo  *model  = [ProductionConfirmVo  mj_objectWithKeyValues:dic];
                  [self.arrayProductionConfirmVo addObject:model];
              }
              [self.tableView reloadData];

              if (dataArray.count != 0) {
                  [self.tableView.mj_footer endRefreshing];
              } else {
                  [self.tableView.mj_footer endRefreshingWithNoMoreData];
              }
              self->_aPage++;
          } else {
              [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
              [self.tableView.mj_header endRefreshing];
          }
        } fail:^(NSError *error) {
          [self.tableView.mj_header endRefreshing];
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
    
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
