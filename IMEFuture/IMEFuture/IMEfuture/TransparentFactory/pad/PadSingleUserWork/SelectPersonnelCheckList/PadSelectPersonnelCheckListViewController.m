//
//  PadSelectPersonnelCheckListViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "PadSelectPersonnelCheckListViewController.h"
#import "VoHeader.h"

#import "PadSelectWorkUnitCollectionReusableView.h"
#import "PadSelectWorkUnitCollectionViewCell.h"


#import <ReactiveObjC.h>

#import "IMEFuture-swift.h"

@interface PadSelectPersonnelCheckListViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    UIView *_viewLoading;
}


@property (nonatomic, strong) NSMutableArray *arrayPersonnelTypeVo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBack;

@property (weak, nonatomic) IBOutlet UIButton *buttonRightNextStep;

@end

@implementation PadSelectPersonnelCheckListViewController

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
    [[self.buttonLeftBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:true];
    }];
    
    [[self.buttonRightNextStep rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        PersonnelTypeVo *model = nil;
        PersonnelVo *person = nil;
        for (PersonnelTypeVo *personnelTypeVo in self.arrayPersonnelTypeVo) {
            BOOL flag = NO;
            for (PersonnelVo *personnelVo in personnelTypeVo.personnelVoList) {
                if (personnelVo.isSelect == YES) {
                    flag = YES;
                    person = personnelVo;
                    break;
                }
            }
            if (flag == YES) {
                model = personnelTypeVo;
            }
        }
        if (model == 0) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择审核人员"];
            return;
        } else {
            [self.navigationController popViewControllerAnimated:YES];
            self.passwordAuthentificationBlockTemp(person.personnelCode, person.needPassword.integerValue);
        }
    }];
    
    [self requestGetPersonnelListByOperation];
}

- (void)passwordAuthentificationCallBack:(void(^)(NSString * str,NSInteger needPassword))passwordAuthentificationBlock {
    self.passwordAuthentificationBlockTemp = passwordAuthentificationBlock;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.arrayPersonnelTypeVo.count;
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kMainW, 40);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    PersonnelTypeVo *personnelTypeVo = self.arrayPersonnelTypeVo[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        PadSelectWorkUnitCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"padSelectWorkUnitCollectionReusableView" forIndexPath:indexPath];
        
        header.label0.text = personnelTypeVo.personnelTypeText;
        
        return header;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonnelTypeVo *personnelTypeVo = self.arrayPersonnelTypeVo[indexPath.section];
    
    PersonnelVo *personnelVo = personnelTypeVo.personnelVoList[indexPath.row];
    
    CGFloat width = [personnelVo.personnelName boundingRectWithSize:CGSizeMake(1000, 16) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width;
    
    return CGSizeMake(width, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    PersonnelTypeVo *personnelTypeVo = self.arrayPersonnelTypeVo[section];
    return personnelTypeVo.personnelVoList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PadSelectWorkUnitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"padSelectWorkUnitCollectionViewCell" forIndexPath:indexPath];
        
    PersonnelTypeVo *personnelTypeVo = self.arrayPersonnelTypeVo[indexPath.section];
    
    PersonnelVo *personnelVo = personnelTypeVo.personnelVoList[indexPath.row];
    
    
    if (personnelVo.isSelect) {//选中状态
        cell.label0.backgroundColor = colorRGB(106, 191, 67);
        cell.label0.textColor = colorRGB(255, 255, 255);
    } else {
        cell.label0.backgroundColor = colorRGB(241, 241, 241);
        cell.label0.textColor = colorRGB(51, 51, 51);
    }
    
    cell.label0.text = personnelVo.personnelName;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (PersonnelTypeVo *personnelTypeVo in self.arrayPersonnelTypeVo) {
        for (PersonnelVo *personnelVo in personnelTypeVo.personnelVoList) {
            personnelVo.isSelect = NO;
        }
    }
    
    PersonnelTypeVo *personnelTypeVo = self.arrayPersonnelTypeVo[indexPath.section];
    PersonnelVo *personnelVo = personnelTypeVo.personnelVoList[indexPath.row];
    personnelVo.isSelect = YES;
    [collectionView reloadData];
}

#pragma mark 获取审核人接口
- (void)requestGetPersonnelListByOperation {
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    ProductionOperationVo *productionOperationVo = [[ProductionOperationVo alloc] init];
    productionOperationVo.siteCode = siteCode;
    mesPostEntityBean.entity = productionOperationVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_personnel_getPersonnelCheckList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        self->_viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.arrayPersonnelTypeVo = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in returnListBean.list) {
                PersonnelTypeVo  *personnelTypeVo  = [PersonnelTypeVo  mj_objectWithKeyValues:dic];
                [self.arrayPersonnelTypeVo addObject:personnelTypeVo];
            }
            [self.collectionView reloadData];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
        self->_viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
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
