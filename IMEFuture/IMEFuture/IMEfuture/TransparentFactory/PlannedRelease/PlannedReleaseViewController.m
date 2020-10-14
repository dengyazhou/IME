//
//  PlannedReleaseViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "PlannedReleaseViewController.h"
#import "VoHeader.h"
#import "PlannedReleaseCell.h"
#import "PlannedReleaseViewDetailsVC.h"
#import "ReleaseViewController.h"



#import <ReactiveObjC.h>

@interface PlannedReleaseViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate> {
    UIView *_viewLoading;
    
    
    NSInteger _aPage;
    
    NSString *_tempText;
    NSString *_tempStartDate;
    NSString *_tempEndDate;
    NSInteger _tempButtonTag;//默认值为99
    
    NSMutableArray *_arrayButtonTime;//存放时间的button
    
}

@property (nonatomic, copy) NSArray *arrayAllWorkCenter;
@property (nonatomic, strong) NSMutableArray *arrayProductionOrderVo;
@property (nonatomic, assign) NSInteger selectCount;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBack;
@property (weak, nonatomic) IBOutlet UIButton *buttonRightSearch;

@property (weak, nonatomic) IBOutlet UIView *viewSearch;
@property (weak, nonatomic) IBOutlet UIView *viewSearchContent;

@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonThree;
@property (weak, nonatomic) IBOutlet UIButton *buttonFour;
@property (weak, nonatomic) IBOutlet UIButton *buttonReset;
@property (weak, nonatomic) IBOutlet UIButton *buttonEnsure;

@property (weak, nonatomic) IBOutlet UIButton *buttonTransmitToLowerLevels;//下达
@property (weak, nonatomic) IBOutlet UIButton *buttonPutIntoProductionInCommission;//投产

@property (nonatomic, assign) BOOL refreshing;//默认值 NO; 控制是否刷新页面

@end

@implementation PlannedReleaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.refreshing) {
        self.refreshing = NO;
        [self.collectionView.mj_header beginRefreshing];
        self.selectCount = 0;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    self.collectionView.collectionViewLayout = flowLayout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PlannedReleaseCell" bundle:nil] forCellWithReuseIdentifier:@"plannedReleaseCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    

    
    _arrayButtonTime = [[NSMutableArray alloc] initWithObjects:self.buttonOne,self.buttonTwo,self.buttonThree,self.buttonFour, nil];


    _tempText = @"";
    _tempStartDate = [NSNull null];
    _tempEndDate = [NSNull null];
    _tempButtonTag = 99;
    [self request_productionOrderConfirm_getProductionOrderList];
    
    
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
    
    self.refreshing = YES;
    //确定
    [[self.buttonEnsure rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self->_tempText = self.textFieldSearch.text;
        
        if (self->_tempButtonTag == 0) {
            self->_tempEndDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:0 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            self->_tempStartDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:1 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else if (self->_tempButtonTag == 1) {
            self->_tempEndDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:0 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            self->_tempStartDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:3 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else if (self->_tempButtonTag == 2) {
            self->_tempEndDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:0 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            self->_tempStartDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:7 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else if (self->_tempButtonTag == 3) {
            self->_tempEndDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:0 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            self->_tempStartDate = [[FunctionDYZ dyz] strBeforeTheCurrentTime:30 withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else {// 99
            self->_tempEndDate = [NSNull null];
            self->_tempStartDate = [NSNull null];
        }
        
        self.viewSearch.hidden = true;
        [self.collectionView.mj_header beginRefreshing];
    }];
    
    //下达
    [[self.buttonTransmitToLowerLevels rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
       
        
        ProductionOrderVo *productionOrderVo;
        for (ProductionOrderVo *value in self.arrayProductionOrderVo) {
            if (value.isSelect.integerValue == 1) {
                productionOrderVo = value;
                break;
            }
        }
        [self request_productionOrderConfirm_decomposeProductionOrder_With:productionOrderVo.productionOrderNum];
        
    }];
    
    //投产
    [[self.buttonPutIntoProductionInCommission rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self showAlertProductionDispatch];
    }];
    
    [RACObserve(self, selectCount) subscribeNext:^(NSNumber  * x) {//监听selectCount的数量
        UIColor *colorTransmitToLowerLevels;
        UIColor *colorPutIntoProductionInCommission;
        BOOL enabledTransmitToLowerLevels;
        BOOL enabledPutIntoProductionInCommission;
        if (x.integerValue == 0) {
            colorTransmitToLowerLevels = colorRGB(197, 197, 197);
            colorPutIntoProductionInCommission = colorRGB(197, 197, 197);
            enabledTransmitToLowerLevels = NO;
            enabledPutIntoProductionInCommission = NO;
        } else if (x.integerValue == 1) {
            colorTransmitToLowerLevels = colorRGB(40, 156, 229);
            colorPutIntoProductionInCommission = colorRGB(197, 197, 197);
            enabledTransmitToLowerLevels = YES;
            enabledPutIntoProductionInCommission = NO;
        } else {
            colorTransmitToLowerLevels = colorRGB(197, 197, 197);
            colorPutIntoProductionInCommission = colorRGB(40, 156, 229);
            enabledTransmitToLowerLevels = NO;
            enabledPutIntoProductionInCommission = YES;
        }
        self.buttonTransmitToLowerLevels.backgroundColor = colorTransmitToLowerLevels;
        self.buttonPutIntoProductionInCommission.backgroundColor = colorPutIntoProductionInCommission;
        self.buttonTransmitToLowerLevels.enabled = enabledTransmitToLowerLevels;
        self.buttonPutIntoProductionInCommission.enabled = enabledPutIntoProductionInCommission;
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
    if ([touch.view isDescendantOfView:self.viewSearchContent]) {
        return NO;
    }
    return YES;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kMainW, 121);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayProductionOrderVo.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlannedReleaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"plannedReleaseCell" forIndexPath:indexPath];
        
    ProductionOrderVo *productionOrderVo = self.arrayProductionOrderVo[indexPath.row];
    
    cell.label0.text = productionOrderVo.projectNum;
    cell.label1.text = productionOrderVo.materialCode;
    cell.label2.text = productionOrderVo.plannedQuantity.stringValue;
    cell.label3.text = productionOrderVo.supplierText;
    cell.label4.text = productionOrderVo.projectName;
    cell.label5.text = productionOrderVo.materialText;
    
//    double remainingQuantity = productionOrderVo.plannedQuantity.doubleValue - productionOrderVo.releasedQuantity.doubleValue;
//    cell.label6.text = [NSString stringWithFormat:@"%.0f",remainingQuantity];
    cell.label6.text = [NSNumber numberWithDouble:productionOrderVo.plannedQuantity.doubleValue - productionOrderVo.releasedQuantity.doubleValue].stringValue;
    
    cell.label7.text = [[FunctionDYZ dyz] strDateFormat:productionOrderVo.requirementDate withEnterDateFormat:@"yyyy-MM-dd HH:mm:ss" withGoDateFormat:@"yyyy-MM-dd"];
    
    if (productionOrderVo.isSelect.integerValue == 0) {
        cell.viewBg.layer.borderWidth = 0;
        cell.viewBg.layer.shadowRadius = 0;
        
        cell.imageView01.image = [UIImage imageNamed:@"unselection"];
    } else {
        cell.viewBg.layer.borderWidth = 0.5;
        cell.viewBg.layer.borderColor = colorRGBA(40, 155, 229, 0.5).CGColor;
        cell.viewBg.layer.shadowColor = colorRGB(65, 178, 235).CGColor;//shadowColor阴影颜色
        cell.viewBg.layer.shadowOffset = CGSizeMake(0,0);
        cell.viewBg.layer.shadowRadius = 3;
        cell.viewBg.layer.shadowOpacity = 0.4;//阴影透明度，默认0

        cell.imageView01.image = [UIImage imageNamed:@"selection"];
    }

    [cell.buttonViewDetails addTarget:self action:@selector(buttonViewDetails:) forControlEvents:UIControlEventTouchUpInside];
    cell.buttonViewDetails.tag = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductionOrderVo *model = self.arrayProductionOrderVo[indexPath.row];
    model.isSelect = model.isSelect.integerValue==0?[NSNumber numberWithInteger:1]:[NSNumber numberWithInteger:0];
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    NSInteger count = 0;
    for (ProductionOrderVo *model in self.arrayProductionOrderVo) {
        if (model.isSelect.integerValue == 1) {
            count++;
        }
    }
    self.selectCount = count;
}


- (void)buttonViewDetails:(UIButton *)sender {
    ProductionOrderVo *model = self.arrayProductionOrderVo[sender.tag];
    
    PlannedReleaseViewDetailsVC *vc = [[PlannedReleaseViewDetailsVC alloc] init];
    vc.productionOrderNum = model.productionOrderNum;
    [self.navigationController pushViewController:vc animated:true];
}


- (void)showAlertProductionDispatch {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"投产系统将使用默认工作中心及工艺路线，是否确认？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self request_productionOrderConfirm_batchDecomposeProductionOrder];
    }];
    [alertController addAction:action0];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 投产
- (void)request_productionOrderConfirm_batchDecomposeProductionOrder {
    _viewLoading.hidden = NO;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (ProductionOrderVo *value in self.arrayProductionOrderVo) {
        if (value.isSelect.integerValue == 1) {
            ProductionOrderVo *model = [[ProductionOrderVo  alloc] init];
            model.siteCode = value.siteCode;
            model.productionOrderNum = value.productionOrderNum;
            model.createUser = tpfUser.userCode;
            model.createUserName = tpfUser.userText;
            [array addObject:model];
        }
    }
    
    mesPostEntityBean.entity = array.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_productionOrderConfirm_batchDecomposeProductionOrder parameters:dic success:^(id responseObjectModel) {
        self->_viewLoading.hidden = YES;
        ReturnMsgBean *returnMsgBean = responseObjectModel;

        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
            [self.collectionView.mj_header beginRefreshing];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
        }
    } fail:^(NSError *error) {
       self->_viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}


- (void)request_productionOrderConfirm_getProductionOrderList {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
 
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        NSString *siteCode = tpfUser.siteCode;
        
        MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
        pagerBean.page = [NSNumber numberWithInteger:[@1 integerValue]];
        
        mesPostEntityBean.pager = pagerBean;
        
        ProductionOrderVo *productionOrderVo = [[ProductionOrderVo alloc] init];
        productionOrderVo.siteCode = siteCode;
        
        productionOrderVo.seb_createDateTime = self->_tempStartDate;
        productionOrderVo.see_createDateTime = self->_tempEndDate;
        productionOrderVo.parameterCodeAndText = self->_tempText;//没有值就是空字符串
        
        mesPostEntityBean.entity = productionOrderVo.mj_keyValues;
        NSDictionary *dic = mesPostEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_productionOrderConfirm_getProductionOrderList parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *returnListBean = responseObjectModel;
     
            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                self.arrayProductionOrderVo = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *dataArray = returnListBean.list;
                for (NSDictionary *dic in dataArray) {
                    ProductionOrderVo *model  = [ProductionOrderVo  mj_objectWithKeyValues:dic];
                    [self.arrayProductionOrderVo addObject:model];
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

        ProductionOrderVo *productionOrderVo = [[ProductionOrderVo alloc] init];
        productionOrderVo.siteCode = siteCode;

        productionOrderVo.seb_createDateTime = self->_tempStartDate;
        productionOrderVo.see_createDateTime = self->_tempEndDate;
        productionOrderVo.parameterCodeAndText = self->_tempText;//没有值就是空字符串

        
        mesPostEntityBean.entity = productionOrderVo.mj_keyValues;
        NSDictionary *dic = mesPostEntityBean.mj_keyValues;

        [HttpMamager postRequestWithURLString:DYZ_productionOrderConfirm_getProductionOrderList parameters:dic success:^(id responseObjectModel) {
           ReturnListBean *returnListBean = responseObjectModel;

           if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
               NSMutableArray *dataArray = returnListBean.list;
               for (NSDictionary *dic in dataArray) {
                   ProductionOrderVo *model  = [ProductionOrderVo  mj_objectWithKeyValues:dic];
                   [self.arrayProductionOrderVo addObject:model];
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


- (void)request_productionOrderConfirm_decomposeProductionOrder_With:(NSString *)productionOrderNum {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    ProductionOrderVo *productionOrderVo = [[ProductionOrderVo alloc] init];
    productionOrderVo.siteCode = siteCode;
    productionOrderVo.productionOrderNum = productionOrderNum;
    
    mesPostEntityBean.entity = productionOrderVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_productionOrderConfirm_decomposeProductionOrder parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            ReleaseViewController *vc = [[ReleaseViewController alloc] init];
            vc.productionOrderNum = productionOrderNum;
            [self.navigationController pushViewController:vc animated:true];
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
