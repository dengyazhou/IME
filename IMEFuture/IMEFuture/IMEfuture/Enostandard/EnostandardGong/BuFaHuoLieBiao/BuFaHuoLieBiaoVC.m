//
//  BuFaHuoLieBiaoVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BuFaHuoLieBiaoVC.h"

#import "VoHeader.h"

#import "BuFaHuoLieBiaoCVCell.h"
#import "BuFaHuoLieBiaoHeader.h"
#import "BuFaHuoLieBiaoFooter.h"
#import "BuFaHuoLieBiaoFooter1.h"
#import "UIViewChaKanCiPingLaiYuan.h"
#import "UIViewCiPingChuLiFangShi.h"
#import "BuFaHuoVC.h"

#import "CiPingChuLiModel.h"

@interface BuFaHuoLieBiaoVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    UICollectionView *_collectionView;
    NSMutableArray *_arrayOrderOperate;
    NSMutableArray *_arrayOrderOperateItem;
    UIView *_viewLoading;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation BuFaHuoLieBiaoVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _viewLoading.hidden = NO;
    
    [self initRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"BuFaHuoLieBiaoCVCell" bundle:nil] forCellWithReuseIdentifier:@"buFaHuoLieBiaoCVCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"BuFaHuoLieBiaoHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"buFaHuoLieBiaoHeader"];
    [_collectionView registerNib:[UINib nibWithNibName:@"BuFaHuoLieBiaoFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"buFaHuoLieBiaoFooter"];
    [_collectionView registerNib:[UINib nibWithNibName:@"BuFaHuoLieBiaoFooter1" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"buFaHuoLieBiaoFooter1"];
    [self.view addSubview:_collectionView];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kMainW-30, 49);//宽好像没用
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    OrderOperate *orderOperate = _arrayOrderOperate[section];
    if ([orderOperate.needSend integerValue] == 1) {//补发货
        return CGSizeMake(kMainW-30, 42);
    }
    if ([orderOperate.needSend integerValue] == 2) {//已发货
        return CGSizeMake(kMainW-30, 10);
    }
    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kMainW-30, 88);
}

//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

////两个cell之间的间距（同一行的cell的间距）
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 0;
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _arrayOrderOperate.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray *arrayOrderOperateItem = _arrayOrderOperateItem[section];
    return arrayOrderOperateItem.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BuFaHuoLieBiaoHeader * buFaHuoLieBiaoHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"buFaHuoLieBiaoHeader" forIndexPath:indexPath];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kMainW-30, 39) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6,6)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = maskPath.CGPath;
        buFaHuoLieBiaoHeader.viewBG.layer.mask = maskLayer;
        OrderOperate *orderOperate = _arrayOrderOperate[indexPath.section];
        if ([orderOperate.needSend integerValue] == 1) {//补发货
            buFaHuoLieBiaoHeader.label0.text = @"待发货";
        }
        if ([orderOperate.needSend integerValue] == 2) {//已发货
            buFaHuoLieBiaoHeader.label0.text = @"已发货";
        }
        buFaHuoLieBiaoHeader.button.tag = indexPath.section;
        [buFaHuoLieBiaoHeader.button addTarget:self action:@selector(buttonClickChaKanCiPingLaiYuan:) forControlEvents:UIControlEventTouchUpInside];
        
        return buFaHuoLieBiaoHeader;
        return nil;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        OrderOperate *orderOperate = _arrayOrderOperate[indexPath.section];
        if ([orderOperate.needSend integerValue] == 1) {//补发货
            BuFaHuoLieBiaoFooter1* buFaHuoLieBiaoFooter1 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"buFaHuoLieBiaoFooter1" forIndexPath:indexPath];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kMainW-30, 42) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(6,6)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path = maskPath.CGPath;
            buFaHuoLieBiaoFooter1.viewBG.layer.mask = maskLayer;
            
            [buFaHuoLieBiaoFooter1.buttonBuFaHuo setTitle:@"补发货" forState:UIControlStateNormal];
            [buFaHuoLieBiaoFooter1.buttonBuFaHuo setTitleColor:colorGong forState:UIControlStateNormal];
            buFaHuoLieBiaoFooter1.buttonBuFaHuo.layer.borderColor = colorGong.CGColor;
            buFaHuoLieBiaoFooter1.buttonBuFaHuo.tag = indexPath.section;
            [buFaHuoLieBiaoFooter1.buttonBuFaHuo addTarget:self action:@selector(buttonClickBuFaHuo:) forControlEvents:UIControlEventTouchUpInside];
            
            return buFaHuoLieBiaoFooter1;
        }
        if ([orderOperate.needSend integerValue] == 2) {//已发货
            BuFaHuoLieBiaoFooter* buFaHuoLieBiaoFooter = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"buFaHuoLieBiaoFooter" forIndexPath:indexPath];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kMainW-30, 10) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(6,6)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path = maskPath.CGPath;
            buFaHuoLieBiaoFooter.viewBG.layer.mask = maskLayer;
            
            return buFaHuoLieBiaoFooter;

        }
        return nil;
    }else{
        return nil;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BuFaHuoLieBiaoCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"buFaHuoLieBiaoCVCell" forIndexPath:indexPath];
    cell.viewBG.layer.cornerRadius = 6;
    cell.viewBG.layer.borderWidth = 0.5;
    cell.viewBG.layer.borderColor = colorLine.CGColor;
    
    OrderOperate *orderOperate = _arrayOrderOperate[indexPath.section];
    NSMutableArray *arrayOrderOperateItem = _arrayOrderOperateItem[indexPath.section];
    OrderOperateItem *orderOperateItem = arrayOrderOperateItem[indexPath.row];
    if ([orderOperate.needSend integerValue] == 1) {//补发货
        cell.imageView1.image = [UIImage imageNamed:@"list_supplier"];
    }
    if ([orderOperate.needSend integerValue] == 2) {//已发货
        cell.imageView1.image = [UIImage imageNamed:@"list1_yes"];
    }
    
    cell.label0.text = orderOperateItem.tradeOrderItem.partName;
    cell.label1.text = [NSString stringWithFormat:@"补发货数量：%ld%@",[orderOperateItem.reissueQuantity integerValue],[NSString QuantityUnit:orderOperateItem.tradeOrderItem.quantityUnit]];
    
    cell.buttonView.tag = indexPath.section;
    cell.buttonChaKanCiPingChuLiFangShi.tag = indexPath.row;
    [cell.buttonChaKanCiPingChuLiFangShi addTarget:self action:@selector(buttonClickChaKanCiPingChuLiFangShi:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

//查看次品来源
- (void)buttonClickChaKanCiPingLaiYuan:(UIButton *)sender {
    OrderOperate *orderOperate = _arrayOrderOperate[sender.tag];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewChaKanCiPingLaiYuan" owner:self options:nil];
    UIViewChaKanCiPingLaiYuan *viewCKCPLY = [nib objectAtIndex:0];
    viewCKCPLY.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewCKCPLY];
    viewCKCPLY.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    viewCKCPLY.viewBG.backgroundColor = [UIColor whiteColor];
    
    viewCKCPLY.label0.text = [NSString stringWithFormat:@"发货单号：%@",orderOperate.deliverCode];
    viewCKCPLY.label1.text = [NSString stringWithFormat:@"送货单号：%@",orderOperate.deliverNumber.length>0?orderOperate.deliverNumber:@"暂无"];
    viewCKCPLY.label2.text = [NSString stringWithFormat:@"补发货单生成时间：%@",[[orderOperate.createTime componentsSeparatedByString:@" "] firstObject]];
}
//查看次品处理方式
- (void)buttonClickChaKanCiPingChuLiFangShi:(UIButton *)sender {
    UIView *buttonView = [sender superview];
    NSMutableArray *arrayOrderOperateItem = _arrayOrderOperateItem[buttonView.tag];
    OrderOperateItem *orderOperateItem = arrayOrderOperateItem[sender.tag];
    
    NSMutableArray *arrayCiPingChuLiModel = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i=0; i<5; i++) {
        if ([orderOperateItem valueForKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]]) {
            CiPingChuLiModel *model = [[CiPingChuLiModel alloc] init];
            model.defectiveOperateType = [orderOperateItem valueForKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]];
            model.reissueNum = [orderOperateItem valueForKey:[NSString stringWithFormat:@"reissueNum%ld",i+1]];
            model.isNeedSend = [orderOperateItem valueForKey:[NSString stringWithFormat:@"isNeedSend%ld",i+1]];
            model.unReason = [orderOperateItem valueForKey:[NSString stringWithFormat:@"unReason%ld",i+1]];
            [arrayCiPingChuLiModel addObject:model];
        } else {
            break;
        }
    }
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewCiPingChuLiFangShi" owner:self options:nil];
    UIViewCiPingChuLiFangShi *viewCPCLFS = [nib objectAtIndex:0];
    viewCPCLFS.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewCPCLFS];
    viewCPCLFS.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    viewCPCLFS.viewBG.backgroundColor = [UIColor whiteColor];
    
    viewCPCLFS.tabelViewBG.layer.borderColor = colorRGB(221, 221, 221).CGColor;
    viewCPCLFS.tabelViewBG.clipsToBounds = YES;
    [viewCPCLFS initTableView:arrayCiPingChuLiModel defectiveQuantity:orderOperateItem.defectiveQuantity];
}

//补发货
- (void)buttonClickBuFaHuo:(UIButton *)sender {
    OrderOperate *orderOperate = _arrayOrderOperate[sender.tag];
    NSLog(@">>>%ld<<",sender.tag);
    
    BuFaHuoVC *buFaHuoVC = [[BuFaHuoVC alloc] init];
    buFaHuoVC.orderOperateId =  orderOperate.orderOperateId;
    [self.navigationController pushViewController:buFaHuoVC animated:YES];
    
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.tradeOrderId = self.tradeOrderId;
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_inspectList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _arrayOrderOperate = [[NSMutableArray alloc] initWithCapacity:0];
            _arrayOrderOperateItem = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *arrayOrderOperate = model.list;
            for (NSDictionary *dic in arrayOrderOperate) {
                OrderOperate *obj = [OrderOperate mj_objectWithKeyValues:dic];
                [_arrayOrderOperate addObject:obj];
                NSMutableArray *arrayItem = [[NSMutableArray alloc] initWithCapacity:0];
                for (OrderOperateItem *item in obj.orderOperateItems) {
                    if ([item.reissueQuantity integerValue] > 0) {
                        [arrayItem addObject:item];
                    }
                }
                [_arrayOrderOperateItem addObject:arrayItem];
            }
            
            _viewLoading.hidden = YES;
            [_collectionView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
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

@end
