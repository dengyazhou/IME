//
//  ShouHuoXiangQingVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/22.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ShouHuoXiangQingVC.h"
#import "VoHeader.h"

#import "ShouHuoHuiZongVC.h"
#import "ShouHuoXiangQingCell.h"
#import "ShouHuoXiangQingCell1.h"
#import "ShouHuoXiangQingHeader.h"
#import "ShouHuoXiangQingFooter.h"
#import "ShouHuoXiangQingChaKanXiangQingVC.h"

@interface ShouHuoXiangQingVC () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    UICollectionView *_collectionView;
    NSMutableArray *_arrayArray;//大数组
    OrderOperate *_orderOperate;
    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation ShouHuoXiangQingVC

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
    [_collectionView registerNib:[UINib nibWithNibName:@"ShouHuoXiangQingCell" bundle:nil] forCellWithReuseIdentifier:@"shouHuoXiangQingCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"ShouHuoXiangQingCell1" bundle:nil] forCellWithReuseIdentifier:@"shouHuoXiangQingCell1"];
    [_collectionView registerNib:[UINib nibWithNibName:@"ShouHuoXiangQingHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"shouHuoXiangQingHeader"];
    [_collectionView registerNib:[UINib nibWithNibName:@"ShouHuoXiangQingFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"shouHuoXiangQingFooter"];
    [self.view addSubview:_collectionView];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section < _arrayArray.count) {
        return CGSizeMake(kMainW-30, 49);
    }
    return CGSizeMake(0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section < _arrayArray.count) {
        return CGSizeMake(kMainW-30, 42);
    }
    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < _arrayArray.count) {
        return CGSizeMake(kMainW-30, 88);
    } else if (indexPath.section < _arrayArray.count+1) {
        return CGSizeMake(kMainW-30, 276+10);
    } else {
        return CGSizeMake(0, 0);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _arrayArray.count+1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section < _arrayArray.count) {
        NSMutableArray *array = _arrayArray[section];
        OrderOperate *orderOperate = array[0];
        return orderOperate.orderOperateItems.count;
    } else {
        return 1;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _arrayArray.count) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            ShouHuoXiangQingHeader * shouHuoXiangQingHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"shouHuoXiangQingHeader" forIndexPath:indexPath];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kMainW-30, 39) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6,6)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path = maskPath.CGPath;
            shouHuoXiangQingHeader.viewBG.layer.mask = maskLayer;
            
            NSMutableArray *array = _arrayArray[indexPath.section];
            OrderOperate *orderOperate = array[0];
            shouHuoXiangQingHeader.label0.text = [NSString stringWithFormat:@"收货时间：%@",orderOperate.inspectTime];
            
            
            return shouHuoXiangQingHeader;
            return nil;
        }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            ShouHuoXiangQingFooter* shouHuoXiangQingFooter = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"shouHuoXiangQingFooter" forIndexPath:indexPath];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kMainW-30, 42) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(6,6)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path = maskPath.CGPath;
            shouHuoXiangQingFooter.viewBG.layer.mask = maskLayer;
            
            NSMutableArray *array = _arrayArray[indexPath.section];
            OrderOperate *orderOperate = array[0];
            shouHuoXiangQingFooter.label0.text = [NSString stringWithFormat:@"收货单号：%@",orderOperate.operateCode];
            
            [shouHuoXiangQingFooter.buttonBuFaHuo setTitle:@"查看详情" forState:UIControlStateNormal];
            [shouHuoXiangQingFooter.buttonBuFaHuo setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
            shouHuoXiangQingFooter.buttonBuFaHuo.layer.borderColor = colorRGB(221, 221, 221).CGColor;
            shouHuoXiangQingFooter.buttonBuFaHuo.tag = indexPath.section;
            [shouHuoXiangQingFooter.buttonBuFaHuo addTarget:self action:@selector(buttonClickChaKanXiangQing:) forControlEvents:UIControlEventTouchUpInside];
            
            return shouHuoXiangQingFooter;
        }else{
            return nil;
        }
    } else {
        return nil;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _arrayArray.count) {
        ShouHuoXiangQingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shouHuoXiangQingCell" forIndexPath:indexPath];
        cell.viewBG.layer.cornerRadius = 6;
        cell.viewBG.layer.borderWidth = 0.5;
        cell.viewBG.layer.borderColor = colorLine.CGColor;
        cell.imageView1.image = [UIImage imageNamed:@"list1_not"];
        
        NSMutableArray *array = _arrayArray[indexPath.section];
        OrderOperate *orderOperate = array[0];
        OrderOperateItem *orderOperateItem = orderOperate.orderOperateItems[indexPath.row];
        cell.label0.text = orderOperateItem.tradeOrderItem.partName;
        cell.label1.text = [NSString stringWithFormat:@"零件号／图号：%@",orderOperateItem.tradeOrderItem.partNumber];
        
        return cell;
    } else {
        ShouHuoXiangQingCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shouHuoXiangQingCell1" forIndexPath:indexPath];
        cell.viewBG.layer.cornerRadius = 6;
        cell.viewBG.layer.masksToBounds = YES;
        
        cell.label0.text = _orderOperate.deliveryTime;
        cell.label1.text = _orderOperate.insideOrderCode;
        cell.label2.text = _orderOperate.operateCode;
        cell.label3.text = _orderOperate.deliverNumber.length>0?_orderOperate.deliverNumber:@"暂无";
        cell.label4.text = _orderOperate.logisticsCompany;
        cell.label5.text = _orderOperate.logisticsNo.length>0?_orderOperate.logisticsNo:@"暂无";
        cell.label6.text = _orderOperate.tradeOrder.supplierEnterpriseName;
        cell.label11.text = [NSString stringWithFormat:@"备注：%@",_orderOperate.remark.length>0?_orderOperate.remark:@"暂无"];
        return cell;
    }
}

//查看详情
- (void)buttonClickChaKanXiangQing:(UIButton *)sender {
    NSLog(@"%s",__FUNCTION__);
    NSLog(@">>%ld<<",sender.tag);
    ShouHuoXiangQingChaKanXiangQingVC *shouHuoXiangQingChaKanXiangQingVC = [[ShouHuoXiangQingChaKanXiangQingVC alloc] init];
    shouHuoXiangQingChaKanXiangQingVC.tradeOrderId = self.tradeOrderId;
    shouHuoXiangQingChaKanXiangQingVC.orderOperateId = self.orderOperateId;
    shouHuoXiangQingChaKanXiangQingVC.arrayData = _arrayArray[sender.tag];
    [self.navigationController pushViewController:shouHuoXiangQingChaKanXiangQingVC animated:YES];
}

- (IBAction)buttonClickShouhuoHuiZong:(UIButton *)sender {
    ShouHuoHuiZongVC *shouHuoHuiZongVC = [[ShouHuoHuiZongVC alloc] init];
    shouHuoHuiZongVC.orderOperateId = self.orderOperateId;
    [self.navigationController pushViewController:shouHuoHuiZongVC animated:YES];
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = loginModel.memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.tradeOrderId = self.tradeOrderId;
    orderOperate.orderOperateId = self.orderOperateId;
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_receiveDetailList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
//            _arrayOrderOperate = [[NSMutableArray alloc] initWithCapacity:0];
            _arrayArray = [[NSMutableArray alloc] initWithCapacity:0];
//            NSInteger i = 0;
            NSInteger a = 0;
            NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
            
            for (NSInteger i = 0; i < returnListBean.list.count; i++) {
                NSDictionary *dic = returnListBean.list[i];
                OrderOperate *orderOperate = [OrderOperate mj_objectWithKeyValues:dic];
                if ([orderOperate.orderOperateType isEqualToString:@"S"]||[orderOperate.orderOperateType isEqualToString:@"SR"]) {
                    _orderOperate = orderOperate;
                    [returnListBean.list removeObjectAtIndex:i];
                }
            }
            
            for (NSInteger i = 0; i < returnListBean.list.count; i++) {
                NSDictionary *dic = returnListBean.list[i];
                OrderOperate *orderOperate = [OrderOperate mj_objectWithKeyValues:dic];
                if (i == 0) {
                    a = [orderOperate.receiveIndex integerValue];
                }
                if (a == [orderOperate.receiveIndex integerValue]) {
                    [array addObject:orderOperate];
                } else {
                    [_arrayArray addObject:array];
                    array = [[NSMutableArray alloc] initWithCapacity:0];
                    [array addObject:orderOperate];
                }
                a = [orderOperate.receiveIndex integerValue];
                
                if (i == returnListBean.list.count-1) {
                    [_arrayArray addObject:array];
                }
                
                NSLog(@">>>>%@",orderOperate.orderOperateType);
                NSLog(@">>>%ld",[orderOperate.receiveIndex integerValue]);
            }
            NSLog(@"%@",_arrayArray);
            
            _viewLoading.hidden = YES;
            [_collectionView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (IBAction)back:(UIButton *)sender {
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
