//
//  PadSelectWorkUnitViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "PadSelectWorkUnitViewController.h"
#import "VoHeader.h"

#import "PadSelectWorkUnitCollectionReusableView.h"
#import "PadSelectWorkUnitCollectionViewCell.h"


#import <ReactiveObjC.h>

#import "PadSelectPersonnelListByOperationViewController.h"

@interface PadSelectWorkUnitViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate> {
    UIView *_viewLoading;
}

@property (nonatomic, strong) NSMutableArray *arrayProductionOperationVoSource;
@property (nonatomic, strong) NSMutableArray *arrayProductionOperationVoCopy;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBack;
@property (weak, nonatomic) IBOutlet UIButton *buttonRightSearch;

@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBackHome;
@property (weak, nonatomic) IBOutlet UIButton *buttonRightNextStep;

@property (weak, nonatomic) IBOutlet UIView *viewSearch;
@property (weak, nonatomic) IBOutlet UIView *viewSearchContent;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;
@property (weak, nonatomic) IBOutlet UIButton *buttonReset;
@property (weak, nonatomic) IBOutlet UIButton *buttonEnsure;

@end

@implementation PadSelectWorkUnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PadSelectWorkUnitCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"padSelectWorkUnitCollectionViewCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PadSelectWorkUnitCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"padSelectWorkUnitCollectionReusableView"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
        
    
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
        self.textFieldSearch.text = nil;
        self.arrayProductionOperationVoCopy = [[NSMutableArray alloc] initWithArray:self.arrayProductionOperationVoSource copyItems:YES];
        [self.collectionView reloadData];
        self.viewSearch.hidden = YES;
    }];
    //确定
    [[self.buttonEnsure rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSMutableArray *arrayTempProductionOperationVo = [[NSMutableArray alloc] initWithCapacity:0];
        self.arrayProductionOperationVoCopy = [[NSMutableArray alloc] initWithArray:self.arrayProductionOperationVoSource copyItems:YES];
        for (ProductionOperationVo *productionOperationVo in self.arrayProductionOperationVoCopy) {
            BOOL flag = NO;
            NSMutableArray *arrayTempWorkUnitVo = [[NSMutableArray alloc] initWithCapacity:0];
            for (WorkUnitVo *workUnitVo in productionOperationVo.workUnitVoList) {
                if ([workUnitVo.workUnitText containsString:self.textFieldSearch.text]) {
                    flag = YES;
                    [arrayTempWorkUnitVo addObject:workUnitVo];
                }
            }
            if (flag == YES) {
                productionOperationVo.workUnitVoList = arrayTempWorkUnitVo;
                [arrayTempProductionOperationVo addObject:productionOperationVo];
            }
        }
        self.arrayProductionOperationVoCopy = arrayTempProductionOperationVo;
        [self.collectionView reloadData];
        self.viewSearch.hidden = YES;
    }];
    
    
    
    [[self.buttonLeftBackHome rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:true];
    }];
    
    [[self.buttonRightNextStep rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        ProductionOperationVo *model = nil;
        WorkUnitVo *unit = nil;
        for (ProductionOperationVo *productionOperationVo in self.arrayProductionOperationVoCopy) {
            BOOL flag = NO;
            for (WorkUnitVo *workUnitVo in productionOperationVo.workUnitVoList) {
                if (workUnitVo.isSelect == YES) {
                    flag = YES;
                    unit = workUnitVo;
                    break;
                }
            }
            if (flag == YES) {
                model = productionOperationVo;
                break;
            }
        }
        if (model == nil) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择作业单元"];
            return;
        } else {
            PadSelectPersonnelListByOperationViewController *vc = [[PadSelectPersonnelListByOperationViewController alloc] init];
            vc.productionControlNum = self.productionControlNum;
            vc.processOperationId = model.processOperationId;
            vc.operationCode = model.operationCode;
            vc.workUnitCode = unit.workUnitCode;
            [self.navigationController pushViewController:vc animated:true];
        }
    }];
    
    [self requestGetWorkUnitList];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.viewSearchContent]) {
        return NO;
    }
    return YES;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.arrayProductionOperationVoCopy.count;
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kMainW, 40);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ProductionOperationVo *productionOperationVo = self.arrayProductionOperationVoCopy[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        PadSelectWorkUnitCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"padSelectWorkUnitCollectionReusableView" forIndexPath:indexPath];
        
        header.label0.text = productionOperationVo.operationText;
        
        return header;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductionOperationVo *productionOperationVo = self.arrayProductionOperationVoCopy[indexPath.section];
    
    WorkUnitVo *workUnitVo = productionOperationVo.workUnitVoList[indexPath.row];
    
    CGFloat width = [workUnitVo.workUnitText boundingRectWithSize:CGSizeMake(1000, 16) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width;
    
    return CGSizeMake(width, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ProductionOperationVo *productionOperationVo = self.arrayProductionOperationVoCopy[section];
    return productionOperationVo.workUnitVoList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PadSelectWorkUnitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"padSelectWorkUnitCollectionViewCell" forIndexPath:indexPath];
        
    ProductionOperationVo *productionOperationVo = self.arrayProductionOperationVoCopy[indexPath.section];
    
    WorkUnitVo *workUnitVo = productionOperationVo.workUnitVoList[indexPath.row];
    
    
    if (workUnitVo.isSelect) {//选中状态
        cell.label0.backgroundColor = colorRGB(106, 191, 67);
        cell.label0.textColor = colorRGB(255, 255, 255);
    } else {
        cell.label0.backgroundColor = colorRGB(241, 241, 241);
        cell.label0.textColor = colorRGB(51, 51, 51);
    }
    
    cell.label0.text = workUnitVo.workUnitText;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (ProductionOperationVo *productionOperationVo in self.arrayProductionOperationVoCopy) {
        for (WorkUnitVo *workUnitVo in productionOperationVo.workUnitVoList) {
            workUnitVo.isSelect = NO;
        }
    }
    ProductionOperationVo *productionOperationVo = self.arrayProductionOperationVoCopy[indexPath.section];
    WorkUnitVo *workUnitVo = productionOperationVo.workUnitVoList[indexPath.row];
    workUnitVo.isSelect = YES;
    [collectionView reloadData];
}

#pragma mark 获取生产工序及作业单元接口
- (void)requestGetWorkUnitList {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    ProductionOperationVo *productionOperationVo = [[ProductionOperationVo alloc] init];
    productionOperationVo.siteCode = siteCode;
    productionOperationVo.productionControlNum = self.productionControlNum;
    mesPostEntityBean.entity = productionOperationVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_productionControl_getWorkUnitList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.arrayProductionOperationVoSource = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in returnListBean.list) {
                ProductionOperationVo  *productionOperationVoSource  = [ProductionOperationVo  mj_objectWithKeyValues:dic];
                [self.arrayProductionOperationVoSource addObject:productionOperationVoSource];
            }
            self.arrayProductionOperationVoCopy = [[NSMutableArray alloc] initWithArray:self.arrayProductionOperationVoSource copyItems:YES];
            [self.collectionView reloadData];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
        self->_viewLoading.hidden = YES;
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
