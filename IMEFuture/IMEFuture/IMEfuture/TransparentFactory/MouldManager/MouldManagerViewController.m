//
//  MouldManagerViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "MouldManagerViewController.h"
#import "VoHeader.h"
#import "MouldGiveOutCell.h"
#import "MouldGiveInCell.h"
#import "MouldGiveOutHeader.h"
#import "MouldGiveOutViewController.h"


#import "PadSelectWorkUnitViewController.h"

#import "PadCheckBigImageViewController.h"


#import <ReactiveObjC.h>

@interface MouldManagerViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate> {
    UIView *_viewLoading;
    
}

@property (nonatomic, copy) NSArray *arrayAllWorkCenter;
@property (nonatomic, strong) NSMutableArray *arrayProductionControlVo;
@property (nonatomic, strong) NSMutableArray *arrayTotalProductionControlVo;
@property (nonatomic, strong) NSMutableArray *arrayModelSequenceVo;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBack;

@property (weak, nonatomic) IBOutlet UIButton *buttonLeftGiveOut;//模具发放
@property (weak, nonatomic) IBOutlet UIButton *buttonRightGiveBack;//模具还回
@property (weak, nonatomic) IBOutlet UIView *buttonLeftBottomLine;
@property (weak, nonatomic) IBOutlet UIView *buttonRightBottomLine;

@property (weak, nonatomic) IBOutlet UIButton *buttonGiveIn;


@property (nonatomic, assign) NSInteger indexWorkCenterVo;




@end

@implementation MouldManagerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self request_modelSequence_getProductionModelSequence];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    self.scrollView.scrollEnabled = NO;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    self.collectionView.collectionViewLayout = flowLayout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MouldGiveOutCell" bundle:nil] forCellWithReuseIdentifier:@"mouldGiveOutCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MouldGiveInCell" bundle:nil] forCellReuseIdentifier:@"mouldGiveInCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MouldGiveOutHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"mouldGiveOutHeader"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0.1;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 0.1;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.sectionFooterHeight = 0.1;
    
    [self request_productionControl_getProductionControl];
    
    
    //rac
    @weakify(self);
    
    [[self.buttonLeftBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:true];
    }];
 

    //模具发放
    [[self.buttonLeftGiveOut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.buttonLeftBottomLine.backgroundColor = colorRGB(72, 184, 252);
        self.buttonRightBottomLine.backgroundColor = colorRGB(255, 255, 255);
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:true];
    }];
    
    //模具还回
    [[self.buttonRightGiveBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.buttonLeftBottomLine.backgroundColor = colorRGB(255, 255, 255);
        self.buttonRightBottomLine.backgroundColor = colorRGB(72, 184, 252);
        [self.scrollView setContentOffset:CGPointMake(kMainW, 0) animated:true];
    }];
    
    [[self.textFieldSearch.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
        if (x.length == 0) {
            self.arrayProductionControlVo = [[NSMutableArray alloc] initWithArray:self.arrayTotalProductionControlVo copyItems:YES];
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
            self.arrayProductionControlVo = [[NSMutableArray alloc] initWithArray:self.arrayTotalProductionControlVo copyItems:YES];
            for (ProductionControlVo *model in self.arrayProductionControlVo) {
                if ([model.materialCode containsString:x]) {
                    [array addObject:model];
                }
            }
            self.arrayProductionControlVo = array;
        }
        [self.collectionView reloadData];
        
    }];
    
    self.textFieldSearch.inputAccessoryView = [self addToolbar];
    
    //还回
    [[self.buttonGiveIn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self request_modelSequence_updateModelSequenceStatus];
    }];
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kMainW, 94);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayProductionControlVo.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MouldGiveOutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mouldGiveOutCell" forIndexPath:indexPath];
    
    cell.label0.text = @"项目想好想没想啊千万啊个";
    
//    if (indexPath.row == 2) {
//        cell.viewBg.layer.borderWidth = 0.5;
//        cell.viewBg.layer.borderColor = colorRGBA(40, 155, 229, 0.5).CGColor;
//        cell.viewBg.layer.shadowColor = colorRGB(65, 178, 235).CGColor;//shadowColor阴影颜色
//        cell.viewBg.layer.shadowOffset = CGSizeMake(0,0);
//        cell.viewBg.layer.shadowRadius = 3;
//        cell.viewBg.layer.shadowOpacity = 0.4;//阴影透明度，默认0
//
//    } else {
//        cell.viewBg.layer.borderWidth = 0;
//        cell.viewBg.layer.shadowRadius = 0;
//    }
    
    ProductionControlVo *productionControlVo = self.arrayProductionControlVo[indexPath.row];
    cell.label0.text = productionControlVo.materialCode;
    cell.label1.text = productionControlVo.materialText;
    cell.label2.text = productionControlVo.plannedQuantity.stringValue;
    cell.label3.text = [[FunctionDYZ dyz] strDateFormat:productionControlVo.requirementDate withEnterDateFormat:@"yyyy-MM-dd HH:mm:ss" withGoDateFormat:@"yyyy-MM-dd"];
    cell.label4.text = productionControlVo.mouldCode;
    if (productionControlVo.status.integerValue == 2) {
        cell.label5.text = @"投产";
    } else if (productionControlVo.status.integerValue == 3) {
        cell.label5.text = @"报工";
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductionControlVo *productionControlVo = self.arrayProductionControlVo[indexPath.row];
    
    MouldGiveOutViewController *vc = [[MouldGiveOutViewController alloc] init];
    vc.materialCode = productionControlVo.materialCode;
    vc.materialText = productionControlVo.materialText;
    vc.plannedQuantity = productionControlVo.plannedQuantity;
    vc.requirementDate = productionControlVo.requirementDate;
    vc.mouldCode = productionControlVo.mouldCode;
    vc.status = productionControlVo.status;
    vc.productionControlNum = productionControlVo.productionControlNum;
    [self.navigationController pushViewController:vc animated:true];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayModelSequenceVo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MouldGiveInCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mouldGiveInCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ModelSequenceVo  *model  = self.arrayModelSequenceVo[indexPath.row];
    cell.label0.text = model.sequenceNum;

    if (model.isSelect.integerValue == 0) {
        cell.imageView0.image = [UIImage imageNamed:@"unselection"];
    } else {
        cell.imageView0.image = [UIImage imageNamed:@"selection"];
    }
    
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

- (void)request_productionControl_getProductionControl {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    ProductionControlVo *productionControlVo = [[ProductionControlVo alloc] init];
    productionControlVo.siteCode = siteCode;
        
    mesPostEntityBean.entity = productionControlVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_productionControl_getProductionControl parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.arrayTotalProductionControlVo = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *dataArray = returnListBean.list;
            for (NSDictionary *dic in dataArray) {
                ProductionControlVo  *model  = [ProductionControlVo  mj_objectWithKeyValues:dic];
                [self.arrayTotalProductionControlVo addObject:model];
            }
            self.arrayProductionControlVo = [[NSMutableArray alloc] initWithArray:self.arrayTotalProductionControlVo copyItems:YES];
            [self.collectionView reloadData];
           
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
       self->_viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (void)request_modelSequence_getProductionModelSequence {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    ModelSequenceVo *modelSequenceVo = [[ModelSequenceVo alloc] init];
    modelSequenceVo.siteCode = siteCode;
        
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

- (void)request_modelSequence_updateModelSequenceStatus {
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    for (ModelSequenceVo *model in self.arrayModelSequenceVo) {
        if (model.isSelect.integerValue == 1) {
            model.status = [NSNumber numberWithInteger:0];
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
