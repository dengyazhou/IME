//
//  ProductionDispatchViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ProductionDispatchViewController.h"
#import "VoHeader.h"
#import "ProductionDispatchCell.h"
#import "ProductionDispatchViewDetailsVC.h"



#import "PadSelectWorkUnitViewController.h"
#import "PadCheckBigImageViewController.h"


#import <ReactiveObjC.h>

@interface ProductionDispatchViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate> {
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

@property (weak, nonatomic) IBOutlet UIButton *buttonPutIntoProductionDispatch;


@property (nonatomic, strong) RACSignal  *loginEnableSignal;





@end

@implementation ProductionDispatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    self.collectionView.collectionViewLayout = flowLayout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductionDispatchCell" bundle:nil] forCellWithReuseIdentifier:@"productionDispatchCell"];
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
        [self request_productionOrderConfirm_getProductionOrderList];
    }];
    
    
    
    //派工
    [[self.buttonPutIntoProductionDispatch rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        [self showAlertProductionDispatch];
    }];
    
    
    self.loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, selectCount)] reduce:^id (NSNumber *x){//x 的类型 必须是 OC类型
        return @(x.integerValue > 0);//返回的类型也必须是OC类型
    }];
    
    [self.loginEnableSignal subscribeNext:^(NSNumber *x) {
        @strongify(self);
        UIColor *color = (x.integerValue == 0) ? colorRGB(197, 197, 197) : colorRGB(40, 156, 229);
        [self.buttonPutIntoProductionDispatch setBackgroundColor:color];
    }];//这个是改变颜色
    
    RAC(self.buttonPutIntoProductionDispatch,enabled) = self.loginEnableSignal;//这个不让点击
    
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
    return self.arrayProductionControlVo.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductionDispatchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"productionDispatchCell" forIndexPath:indexPath];
        
    ProductionControlVo  *model = self.arrayProductionControlVo[indexPath.row];
    
    cell.label0.text = model.projectNum;
    cell.label1.text = model.materialCode;
    cell.label2.text = model.plannedQuantity.stringValue;
    cell.label3.text = model.customerText;
    cell.label4.text = model.projectName;
    cell.label5.text = model.materialText;
    cell.label6.text = [[FunctionDYZ dyz] strDateFormat:model.requirementDate withEnterDateFormat:@"yyyy-MM-dd HH:mm:ss" withGoDateFormat:@"yyyy-MM-dd"];
    
    if (model.isSelect.integerValue == 0) {
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
    ProductionControlVo *model = self.arrayProductionControlVo[indexPath.row];
    model.isSelect = model.isSelect.integerValue==0?[NSNumber numberWithInteger:1]:[NSNumber numberWithInteger:0];
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    
    NSInteger count = 0;
    for (ProductionControlVo *model in self.arrayProductionControlVo) {
        if (model.isSelect.integerValue == 1) {
            count++;
        }
    }
    self.selectCount = count;
}


- (void)buttonViewDetails:(UIButton *)sender {
    ProductionControlVo *model = self.arrayProductionControlVo[sender.tag];
    
    ProductionDispatchViewDetailsVC *vc = [[ProductionDispatchViewDetailsVC alloc] init];
    vc.productionControlVo = model;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)showAlertProductionDispatch {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"是否确认投产所选择订单" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self request_productionControl_placeOrderProductionControl];
    }];
    [alertController addAction:action0];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 派工
- (void)request_productionControl_placeOrderProductionControl {
    _viewLoading.hidden = NO;
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (ProductionControlVo *value in self.arrayProductionControlVo) {
        if (value.isSelect.integerValue == 1) {
            ProductionControlVo *model = [[ProductionControlVo alloc] init];
            model.siteCode = value.siteCode;
            model.productionControlNum = value.productionControlNum;
            [array addObject:model];
        }
    }
    
    mesPostEntityBean.entity = array.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_productionControl_placeOrderProductionControl parameters:dic success:^(id responseObjectModel) {
        self->_viewLoading.hidden = YES;
        ReturnMsgBean *returnMsgBean = responseObjectModel;

        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"派工成功"];
            [self request_productionOrderConfirm_getProductionOrderList];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
        }
    } fail:^(NSError *error) {
       self->_viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)request_productionOrderConfirm_getProductionOrderList {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;

    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];

    ProductionControlVo *productionControlVo = [[ProductionControlVo alloc] init];
    productionControlVo.siteCode = siteCode;

    productionControlVo.startDate = self->_tempStartDate;
    productionControlVo.endDate = self->_tempEndDate;
    productionControlVo.parameterCodeAndText = self->_tempText;//没有值就是空字符串

    mesPostEntityBean.entity = productionControlVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;

    [HttpMamager postRequestWithURLString:DYZ_productionControl_selectProductionControlProductList parameters:dic success:^(id responseObjectModel) {
       ReturnListBean *returnListBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
       if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
           self.arrayProductionControlVo = [[NSMutableArray alloc] initWithCapacity:0];
           NSMutableArray *dataArray = returnListBean.list;
           for (NSDictionary *dic in dataArray) {
               ProductionControlVo *model  = [ProductionControlVo  mj_objectWithKeyValues:dic];
               [self.arrayProductionControlVo addObject:model];
           }
           [self.collectionView reloadData];
       } else {
           [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
       }
    } fail:^(NSError *error) {
        self->_viewLoading.hidden = YES;
       [self.collectionView.mj_header endRefreshing];
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    
    
    //分页
//    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        LoginModel *loginModel = [DatabaseTool getLoginModel];
//        UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
//        NSString *siteCode = tpfUser.siteCode;
//
//        MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
//
//        PagerBean *pagerBean = [[PagerBean alloc] init];
//        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
//        pagerBean.page = [NSNumber numberWithInteger:[@1 integerValue]];
//
//        mesPostEntityBean.pager = pagerBean;
//
//        ProductionControlVo *productionControlVo = [[ProductionControlVo alloc] init];
//        productionControlVo.siteCode = siteCode;
//
//        productionControlVo.startDate = self->_tempStartDate;
//        productionControlVo.endDate = self->_tempEndDate;
//        productionControlVo.parameterCodeAndText = self->_tempText;//没有值就是空字符串
//
//        mesPostEntityBean.entity = productionControlVo.mj_keyValues;
//        NSDictionary *dic = mesPostEntityBean.mj_keyValues;
//
//        [HttpMamager postRequestWithURLString:DYZ_productionControl_selectProductionControlProductList parameters:dic success:^(id responseObjectModel) {
//            ReturnListBean *returnListBean = responseObjectModel;
//
//            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
//                self.arrayProductionControlVo = [[NSMutableArray alloc] initWithCapacity:0];
//                NSMutableArray *dataArray = returnListBean.list;
//                for (NSDictionary *dic in dataArray) {
//                    ProductionControlVo *model  = [ProductionControlVo  mj_objectWithKeyValues:dic];
//                    [self.arrayProductionControlVo addObject:model];
//                }
//                [self.collectionView reloadData];
//                [self.collectionView.mj_header endRefreshing];
//                if (dataArray.count != 0) {
//                    if (dataArray.count < [pageSizeDYZ integerValue]) {
//                        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//                    } else {
//                        [self.collectionView.mj_footer endRefreshing];
//                    }
//                } else {
//                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//                }
//                self->_aPage = 2;
//            } else {
//                [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
//                [self.collectionView.mj_header endRefreshing];
//            }
//        } fail:^(NSError *error) {
//            [self.collectionView.mj_header endRefreshing];
//        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
//    }];
//
//    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        LoginModel *loginModel = [DatabaseTool getLoginModel];
//        UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
//        NSString *siteCode = tpfUser.siteCode;
//
//        MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
//
//        PagerBean *pagerBean = [[PagerBean alloc] init];
//        pagerBean.pageSize = [NSNumber numberWithInteger:[pageSizeDYZ integerValue]];
//        pagerBean.page = [NSNumber numberWithInteger:self->_aPage];
//
//        mesPostEntityBean.pager = pagerBean;
//
//        ProductionControlVo *productionControlVo = [[ProductionControlVo alloc] init];
//        productionControlVo.siteCode = siteCode;
//
//        productionControlVo.startDate = self->_tempStartDate;
//        productionControlVo.endDate = self->_tempEndDate;
//        productionControlVo.parameterCodeAndText = self->_tempText;//没有值就是空字符串
//
//
//        mesPostEntityBean.entity = productionControlVo.mj_keyValues;
//        NSDictionary *dic = mesPostEntityBean.mj_keyValues;
//
//        [HttpMamager postRequestWithURLString:DYZ_productionControl_selectProductionControlProductList parameters:dic success:^(id responseObjectModel) {
//           ReturnListBean *returnListBean = responseObjectModel;
//
//           if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
//               NSMutableArray *dataArray = returnListBean.list;
//               for (NSDictionary *dic in dataArray) {
//                   ProductionControlVo *model  = [ProductionControlVo  mj_objectWithKeyValues:dic];
//                   [self.arrayProductionControlVo addObject:model];
//               }
//               [self.collectionView reloadData];
//
//               if (dataArray.count != 0) {
//                   [self.collectionView.mj_footer endRefreshing];
//               } else {
//                   [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//               }
//               self->_aPage++;
//           } else {
//               [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
//               [self.collectionView.mj_header endRefreshing];
//           }
//        } fail:^(NSError *error) {
//           [self.collectionView.mj_header endRefreshing];
//        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
//    }];
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
