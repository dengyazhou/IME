//
//  ChaKanJiaoHuoShiVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ChaKanJiaoHuoShiVC.h"
#import "VoHeader.h"

#import "ChaKanJiaoHuoShiCVCell.h"


@interface ChaKanJiaoHuoShiVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    UICollectionView *_collectionView;
    NSMutableArray *_arrayOrderOperate;
    UIView *_viewLoading;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation ChaKanJiaoHuoShiVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _viewLoading.hidden = NO;
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
    [_collectionView registerNib:[UINib nibWithNibName:@"ChaKanJiaoHuoShiCVCell" bundle:nil] forCellWithReuseIdentifier:@"chaKanJiaoHuoShiCVCell"];
    [self.view addSubview:_collectionView];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    
    [self initRequest];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 0, 0, 0);//分别为上、左、下、右
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kMainW-30, 107);
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrayOrderOperate.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChaKanJiaoHuoShiCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"chaKanJiaoHuoShiCVCell" forIndexPath:indexPath];
    cell.viewBG.layer.cornerRadius = 6;
    OrderOperate *orderOperate = _arrayOrderOperate[indexPath.row];
    
    if ([orderOperate.isNotShipped integerValue] == 1) {
        cell.label1.text = @"待发货";
        cell.imageView1.image = [UIImage imageNamed:@"list1_not"];
    }
    if ([orderOperate.isNotShipped integerValue] == 0) {
        cell.label1.text = @"已发货";
        cell.imageView1.image = [UIImage imageNamed:@"list1_yes"];
    }
    
    OrderOperateItem *orderOperateItem = orderOperate.orderOperateItems[0];
    cell.label0.text = orderOperateItem.tradeOrderItem.partName;
    cell.label2.text = [NSString stringWithFormat:@"要求到货时间：%@",[[orderOperate.deadlineTime componentsSeparatedByString:@" "] firstObject]];
    
    cell.label3.text = [NSString stringWithFormat:@"要求到货数量：%ld%@",[orderOperateItem.preNum integerValue],[NSString QuantityUnit:orderOperateItem.tradeOrderItem.quantityUnit]];

    return cell;
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = loginModel.memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.tradeOrderId = self.tradeOrderId;
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_preOrderList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _arrayOrderOperate = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *arrayOrderOperate = model.list;
            for (NSDictionary *dic in arrayOrderOperate) {
                OrderOperate *obj = [OrderOperate mj_objectWithKeyValues:dic];
                [_arrayOrderOperate addObject:obj];
            }
            [_collectionView reloadData];
            _viewLoading.hidden = YES;
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
