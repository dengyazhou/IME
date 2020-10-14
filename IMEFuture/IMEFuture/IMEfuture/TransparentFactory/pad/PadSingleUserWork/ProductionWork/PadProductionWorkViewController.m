//
//  PadProductionWorkViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "PadProductionWorkViewController.h"
#import "VoHeader.h"
#import "PadProductionWorkCollectionViewCell.h"

#import "PadSelectWorkUnitViewController.h"

#import "PadCheckBigImageViewController.h"


#import <ReactiveObjC.h>

@interface PadProductionWorkViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate> {
    UIView *_viewLoading;
    
    
    NSInteger _aPage;
    
    NSString *_tempText;
    NSString *_tempStartDate;
    NSString *_tempEndDate;
    NSInteger _tempButtonTag;//默认值为99
    
    NSMutableArray *_arrayButtonTime;//存放时间的button
    
}

@property (nonatomic, copy) NSArray *arrayAllWorkCenter;
@property (nonatomic, strong) NSMutableArray *arrayProductionControlVo;

@property (weak, nonatomic) IBOutlet UILabel *labelWorkCenter;
@property (weak, nonatomic) IBOutlet UIButton *buttonWorkCenter;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *tableViewBG;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBack;
@property (weak, nonatomic) IBOutlet UIButton *buttonRightSearch;

@property (weak, nonatomic) IBOutlet UIButton *buttonLeftStatue2;
@property (weak, nonatomic) IBOutlet UIButton *buttonRightStatue3;
@property (weak, nonatomic) IBOutlet UIView *buttonLeftBottomLine;
@property (weak, nonatomic) IBOutlet UIView *buttonRightBottomLine;

@property (weak, nonatomic) IBOutlet UIView *viewSearch;
@property (weak, nonatomic) IBOutlet UIView *viewSearchContent;

@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonThree;
@property (weak, nonatomic) IBOutlet UIButton *buttonFour;
@property (weak, nonatomic) IBOutlet UIButton *buttonReset;
@property (weak, nonatomic) IBOutlet UIButton *buttonEnsure;



// status = 2 : 待生产作业单
// status = 3 : 进行中作业单
@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger indexWorkCenterVo;




@end

@implementation PadProductionWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PadProductionWorkCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"padProductionWorkCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = colorRGB(221, 221, 221).CGColor;
    self.tableView.layer.cornerRadius = 3;
    
    
    _arrayButtonTime = [[NSMutableArray alloc] initWithObjects:self.buttonOne,self.buttonTwo,self.buttonThree,self.buttonFour, nil];

    [self requestSelectAllWorkCenter];
    
    self.status = 2;
    _tempText = @"";
    _tempStartDate = [NSNull null];
    _tempEndDate = [NSNull null];
    _tempButtonTag = 99;
    [self requestSelectProductionControlList];
    
    
    //rac
    @weakify(self);
    
    self.viewSearch.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    self.viewSearch.hidden = true;
    
    UITapGestureRecognizer *viewSearchBackgroundTap = [[UITapGestureRecognizer alloc] init];
    viewSearchBackgroundTap.cancelsTouchesInView = NO;
    [self.viewSearch addGestureRecognizer:viewSearchBackgroundTap];
    viewSearchBackgroundTap.delegate = self;
    
    [viewSearchBackgroundTap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        self.viewSearch.hidden = true;
    }];
    
    self.textFieldSearch.inputAccessoryView = [self addToolbar];
    
    
    UITapGestureRecognizer *viewTableViewBackgroundTap = [[UITapGestureRecognizer alloc] init];
    viewTableViewBackgroundTap.cancelsTouchesInView = NO;
    [self.tableViewBG addGestureRecognizer:viewTableViewBackgroundTap];
    viewTableViewBackgroundTap.delegate = self;
    
    [viewTableViewBackgroundTap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        self.tableViewBG.hidden = true;
    }];
    
    [[self.buttonLeftBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:true];
    }];
    
    [[self.buttonRightSearch rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.viewSearch.hidden = NO;
    }];
    
    //重置
    [[self.buttonReset rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self->_tempText = @"";
        self->_tempStartDate = [NSNull null];
        self->_tempEndDate = [NSNull null];
        self->_tempButtonTag = 99;
        self.textFieldSearch.text = nil;
        
        for (UIButton *button in self->_arrayButtonTime) {
            button.backgroundColor = colorRGB(241, 241, 241);
            [button setTitleColor:colorRGB(51, 51, 51) forState:UIControlStateNormal];
        }
    }];
    
    //确定
    [[self.buttonEnsure rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self->_tempText = self.textFieldSearch.text;
        
        if (self->_tempButtonTag == 0) {
            self->_tempEndDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:0 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            self->_tempStartDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:30 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else if (self->_tempButtonTag == 1) {
            self->_tempEndDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:0 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            self->_tempStartDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:90 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else if (self->_tempButtonTag == 2) {
            self->_tempEndDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:0 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            self->_tempStartDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:365 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else if (self->_tempButtonTag == 3) {
            self->_tempEndDate = [NSNull null];
            self->_tempStartDate = [NSNull null];
        } else {// 99
            self->_tempEndDate = [NSNull null];
            self->_tempStartDate = [NSNull null];
        }
        
        self.viewSearch.hidden = true;
        [self.collectionView.mj_header beginRefreshing];
    }];
    
    //选择工作中心
    [[self.buttonWorkCenter rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.tableViewBG.hidden = false;
    }];
    
    //待生产作业单
    [[self.buttonLeftStatue2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.status = 2;
        self.buttonLeftBottomLine.backgroundColor = colorRGB(72, 184, 252);
        self.buttonRightBottomLine.backgroundColor = colorRGB(255, 255, 255);
        [self.collectionView.mj_header beginRefreshing];
    }];
    
    //进行中作业单
    [[self.buttonRightStatue3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.status = 3;
        self.buttonLeftBottomLine.backgroundColor = colorRGB(255, 255, 255);
        self.buttonRightBottomLine.backgroundColor = colorRGB(72, 184, 252);
        [self.collectionView.mj_header beginRefreshing];
    }];
    
}

- (IBAction)buttonClickSelectTime:(UIButton *)sender {
    for (int i=0; i<_arrayButtonTime.count; i++) {
        UIButton *button = _arrayButtonTime[i];
        if (sender.tag == i) {
            sender.backgroundColor = colorRGB(40, 155, 229);
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            button.backgroundColor = colorRGB(241, 241, 241);
            [button setTitleColor:colorRGB(51, 51, 51) forState:UIControlStateNormal];
        }
    }
    _tempButtonTag = sender.tag;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.viewSearchContent] || [touch.view isDescendantOfView:self.tableView]) {
        return NO;
    }
    return YES;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kMainW-30)/2.0, 210);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayProductionControlVo.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PadProductionWorkCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"padProductionWorkCollectionViewCell" forIndexPath:indexPath];
    ProductionControlVo *productionControlVo = self.arrayProductionControlVo[indexPath.row];
    
    if (productionControlVo.drawingPreviewVoList != nil && productionControlVo.drawingPreviewVoList.count > 0) {
        DrawingPreviewVo *drawingPreviewVo = productionControlVo.drawingPreviewVoList[0];
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:drawingPreviewVo.smallPreviewUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
    } else {
        cell.imageView1.image = [UIImage imageNamed:@"img_nopicture"];
    }
    
    cell.imageButton.tag = indexPath.row;
    [cell.imageButton addTarget:self action:@selector(buttonImageClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.label0.text = productionControlVo.projectName;
    cell.label1.text = [NSString stringWithFormat:@"当前工序:%@",productionControlVo.operationText!=nil?productionControlVo.operationText:@""];
    cell.label2.text = [NSString stringWithFormat:@"作业数量:%@",productionControlVo.orderQuantity.stringValue];

    cell.label3.text = [[FunctionDYZ dyz] strDateFormat:productionControlVo.plannedStartDate withEnterDateFormat:@"yyyy-MM-dd HH:mm:ss" withGoDateFormat:@"yy/MM/dd HH:mm"];
    
    
    
    if (productionControlVo.status.integerValue == 2) {
        [cell.button0 setTitle:@"开工" forState:UIControlStateNormal];
        cell.button0.backgroundColor = colorRGB(106, 191, 67);
    } else if (productionControlVo.status.integerValue == 3) {
        [cell.button0 setTitle:@"报工" forState:UIControlStateNormal];
        cell.button0.backgroundColor = colorRGB(40, 155, 229);
    } else if (productionControlVo.status.integerValue == 4) {
        [cell.button0 setTitle:@"已完工" forState:UIControlStateNormal];
        cell.button0.backgroundColor = colorRGB(221, 221, 221);
    } else {
        NSLog(@"--出现不正确的状态---");
    }
    
    
    [cell.button0 addTarget:self action:@selector(buttonnClick0:) forControlEvents:UIControlEventTouchUpInside];
    cell.button0.tag = indexPath.row;
    return cell;
}

- (void)buttonImageClick:(UIButton *)sender {
    ProductionControlVo *productionControlVo = self.arrayProductionControlVo[sender.tag];
    if (productionControlVo.drawingPreviewVoList != nil && productionControlVo.drawingPreviewVoList.count > 0) {
        PadCheckBigImageViewController *vc = [[PadCheckBigImageViewController alloc] init];
        vc.productionControlNum = productionControlVo.productionControlNum;
        
        [self.navigationController pushViewController:vc animated:true];
    }
}

- (void)buttonnClick0:(UIButton *)sender {
    ProductionControlVo *productionControlVo = self.arrayProductionControlVo[sender.tag];
    
    PadSelectWorkUnitViewController *vc = [[PadSelectWorkUnitViewController alloc] init];
    vc.productionControlNum = productionControlVo.productionControlNum;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayAllWorkCenter.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WorkCenterVo *workCenterVo = self.arrayAllWorkCenter[indexPath.row];
    cell.textLabel.text = workCenterVo.workCenterText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tableViewBG.hidden = true;
    self.indexWorkCenterVo = indexPath.row;
    WorkCenterVo *workCenterVo  = self.arrayAllWorkCenter[self.indexWorkCenterVo];
    self.labelWorkCenter.text = workCenterVo.workCenterText;
    [self.collectionView.mj_header beginRefreshing];
}


- (void)requestSelectProductionControlList {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
 
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        NSString *siteCode = tpfUser.siteCode;
        
        MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:[@1 integerValue]];
        
        mesPostEntityBean.pager = pagerBean;
        
        ProductionControlVo *productionControlVo = [[ProductionControlVo alloc] init];
        productionControlVo.siteCode = siteCode;
        
        
        WorkCenterVo *workCenterVo  = self.arrayAllWorkCenter[self.indexWorkCenterVo];
        
        productionControlVo.workCenterCode = workCenterVo.workCenterCode;
        productionControlVo.startDate = self->_tempStartDate;
        productionControlVo.endDate = self->_tempEndDate;
        productionControlVo.status = [NSNumber numberWithInteger:self.status];
        productionControlVo.text = self->_tempText;//没有值就是空字符串
        
        mesPostEntityBean.entity = productionControlVo.mj_keyValues;
        NSDictionary *dic = mesPostEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_productionControl_selectProductionControlList parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *returnListBean = responseObjectModel;
     
            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                self.arrayProductionControlVo = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *dataArray = returnListBean.list;
                for (NSDictionary *dic in dataArray) {
                    ProductionControlVo  *model  = [ProductionControlVo  mj_objectWithKeyValues:dic];
                    [self.arrayProductionControlVo addObject:model];
                }
                [self.collectionView reloadData];
                [self.collectionView.mj_header endRefreshing];
                if (dataArray.count != 0) {
                    if (dataArray.count < [pageSizeDYZ integerValue]) {
                        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [self.collectionView.mj_footer endRefreshing];
                    }
                } else {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
                self->_aPage = 2;
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
                [self.collectionView.mj_header endRefreshing];
            }
        } fail:^(NSError *error) {
            [self.collectionView.mj_header endRefreshing];
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];

    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
           LoginModel *loginModel = [DatabaseTool getLoginModel];
           UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
           NSString *siteCode = tpfUser.siteCode;
           
           MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
           
           PagerBean *pagerBean = [[PagerBean alloc] init];
           pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
           pagerBean.page = [NSNumber numberWithInteger:self->_aPage];
           
           mesPostEntityBean.pager = pagerBean;
           
           ProductionControlVo *productionControlVo = [[ProductionControlVo alloc] init];
           productionControlVo.siteCode = siteCode;
           
           
           WorkCenterVo *workCenterVo = self.arrayAllWorkCenter[self.indexWorkCenterVo];
           
           productionControlVo.workCenterCode = workCenterVo.workCenterCode;
           productionControlVo.startDate = self->_tempStartDate;
        productionControlVo.endDate = self->_tempEndDate;
           productionControlVo.status = [NSNumber numberWithInteger:self.status];
        productionControlVo.text = self->_tempText;
        
           mesPostEntityBean.entity = productionControlVo.mj_keyValues;
           NSDictionary *dic = mesPostEntityBean.mj_keyValues;
           
           [HttpMamager postRequestWithURLString:DYZ_productionControl_selectProductionControlList parameters:dic success:^(id responseObjectModel) {
               ReturnListBean *returnListBean = responseObjectModel;
        
               if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                   NSMutableArray *dataArray = returnListBean.list;
                   for (NSDictionary *dic in dataArray) {
                       ProductionControlVo  *model  = [ProductionControlVo  mj_objectWithKeyValues:dic];
                       [self.arrayProductionControlVo addObject:model];
                   }
                   [self.collectionView reloadData];
            
                   if (dataArray.count != 0) {
                       [self.collectionView.mj_footer endRefreshing];
                   } else {
                       [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                   }
                   self->_aPage++;
               } else {
                   [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
                   [self.collectionView.mj_header endRefreshing];
               }
           } fail:^(NSError *error) {
               [self.collectionView.mj_header endRefreshing];
           } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
}

#pragma mark 获取工作中心列表
- (void)requestSelectAllWorkCenter {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    WorkCenterVo *workCenterVo = [[WorkCenterVo alloc] init];
    workCenterVo.siteCode = siteCode;
    mesPostEntityBean.entity = workCenterVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_workCenter_selectAllWorkCenter parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        _viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in returnListBean.list) {
                WorkCenterVo  *workCenterVo  = [WorkCenterVo  mj_objectWithKeyValues:dic];
                [dataArray addObject:workCenterVo];
            }
            self.arrayAllWorkCenter = [NSArray arrayWithArray:dataArray];
            
            [self.tableView reloadData];
            
            // 暂时写在这里，需要修改哦
            if (self.arrayAllWorkCenter.count > 0) {
                if ((self.arrayAllWorkCenter.count*44)>(kMainH-80-Height_NavBar)) {
                    self.tableViewHeight.constant = (kMainH-80-Height_NavBar);
                } else {
                    self.tableViewHeight.constant = self.arrayAllWorkCenter.count*44;
                }
                
                self.indexWorkCenterVo = 0;
                WorkCenterVo *workCenterVo  = self.arrayAllWorkCenter[self.indexWorkCenterVo];
                self.labelWorkCenter.text = workCenterVo.workCenterText;
                [self.collectionView.mj_header beginRefreshing];
            }
            
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;

    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
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
