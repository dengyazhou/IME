//
//  EShengChangJingduXiangXiViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/9/19.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "EShengChangJingduXiangXiViewController.h"
#import "VoHeader.h"

#import "ShengChangJinDuCXiangQingCell1.h"
#import "ShengChangJinDuCXiangQingCell2.h"


@interface EShengChangJingduXiangXiViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayYesOpen;
    
    UIView *_viewNoContent;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (nonatomic,strong) TpfOrderBean *tpfOrderBean;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelProcessPercent;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation EShengChangJingduXiangXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ShengChangJinDuCXiangQingCell1" bundle:nil] forCellReuseIdentifier:@"shengChangJinDuCXiangQingCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShengChangJinDuCXiangQingCell2" bundle:nil] forCellReuseIdentifier:@"shengChangJinDuCXiangQingCell2"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ESCJDXXTableViewHeaderView" owner:self options:nil];
    UIView *tmpCustomView = [nib objectAtIndex:0];
    tmpCustomView.frame = CGRectMake(0, 0, kMainW, 34);
    tmpCustomView.backgroundColor = colorRGB(234, 234, 234);
    UIView *tmpView = [[UIView alloc] init];
    tmpView.frame = CGRectMake(0, 0, kMainW, 34);
    [tmpView addSubview:tmpCustomView];
    self.tableView.tableHeaderView = tmpView;
    
    self.tableView.hidden = YES;
    
    if (!_viewNoContent) {
        _viewNoContent = [self viewNoContent];
        [self.view addSubview:_viewNoContent];
    }
    _viewNoContent.hidden = YES;
    
    [self initRequestProductionOrderInfo];
}

- (void)initRequestProductionOrderInfo {
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    
    TradeOrder *tradeOrder = [[TradeOrder alloc] init];
    tradeOrder.orderId = self.orderId;
//    tradeOrder.orderId = @"8a9876f56b0842a5016b0854256d006b";
    postEntityBean.entity = tradeOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    NSString *jsonStr = postEntityBean.mj_JSONString;
    NSLog(@"%@",jsonStr);
    
    NSString *strUrl;
    if ([self.isDefaultPurchase isEqualToString:DefaultPurchase]) {
        strUrl = DYZ_tradeOrder_purchase_productionOrderInfo;
    } else if ([self.isDefaultPurchase isEqualToString:DefaultSupplier]) {
        strUrl = DYZ_tradeOrder_supplier_productionOrderInfo;
    }
    
    [HttpMamager postRequestWithURLString:strUrl parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
      
            self.tpfOrderBean = [TpfOrderBean mj_objectWithKeyValues:returnEntityBean.entity];
            
            self.labelProcessPercent.text = [NSString stringWithFormat:@"%@%@",[self.tpfOrderBean.processPercent stringValue],@"%"];
            _arrayYesOpen = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i < self.tpfOrderBean.infos.count; i++) {
                [_arrayYesOpen addObject:@"yes"];
            }
            
            self.tableView.hidden = NO;
            [self.tableView reloadData];
            if (self.tpfOrderBean.infos.count > 0) {
                self.labelProcessPercent.hidden = NO;
                _viewNoContent.hidden = YES;
                self.tableView.scrollEnabled = YES;
            } else {
                self.labelProcessPercent.hidden = YES;
                _viewNoContent.hidden = NO;
                self.tableView.scrollEnabled = NO;
            }
            
        } else{
            self.labelProcessPercent.hidden = YES;
            self.tableView.hidden = NO;
            _viewNoContent.hidden = false;
            self.tableView.scrollEnabled = NO;
        }
        
    } fail:^(NSError *error) {
        self.labelProcessPercent.hidden = YES;
        self.tableView.hidden = NO;
        if (!_viewNoContent) {
            _viewNoContent = [self viewNoContent];
            [self.view addSubview:_viewNoContent];
        }
        self.tableView.scrollEnabled = NO;
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    TpfOrderInfoBean *tpfOrderInfoBean = self.tpfOrderBean.infos[section];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ESCJDXXTableViewSectionView" owner:self options:nil];
    UIView *tmpCustomView = [nib objectAtIndex:0];
    tmpCustomView.frame = CGRectMake(0, 0, kMainW, 56);
    UILabel *label1 = [tmpCustomView viewWithTag:1];
    label1.text = tpfOrderInfoBean.materialNumber;
#pragma mark 改
    UILabel *label2 = [tmpCustomView viewWithTag:2];
    label2.text = @"--";
    
    UILabel *label3 = [tmpCustomView viewWithTag:3];
    label3.text = tpfOrderInfoBean.plannedQuantity;
#pragma mark 改
    UILabel *label4 = [tmpCustomView viewWithTag:4];
    label4.text = [tpfOrderInfoBean.releasedQuantity stringValue];
    
    UILabel *label5 = [tmpCustomView viewWithTag:5];
    label5.text = tpfOrderInfoBean.completedQuantity;
    
    
    
//    UIButton *button = [tmpCustomView viewWithTag:999];
//    button.tag = section;
//    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonBG = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBG.frame = CGRectMake(0, 0, kMainW, 56);
    buttonBG.tag = section;
    [buttonBG addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tmpCustomView addSubview:buttonBG];
    buttonBG.backgroundColor = [UIColor clearColor];
    return tmpCustomView;
}


- (void)buttonClick:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    NSString *string = _arrayYesOpen[sender.tag];
    if ([string isEqualToString:@"yes"]) {
        [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"no"];
    }
    if ([string isEqualToString:@"no"]) {
        [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"yes"];
    }
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tpfOrderBean.infos.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    TpfOrderInfoBean *tpfOrderInfoBean = self.tpfOrderBean.infos[section];

    NSString *string = _arrayYesOpen[section];

    NSLog(@"%@",string);
    
    if ([string isEqualToString:@"no"]) {
        return 0;
    } else {
        return 1+tpfOrderInfoBean.confirmInfos.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 33;
    } else {
        return 49;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ShengChangJinDuCXiangQingCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"shengChangJinDuCXiangQingCell1" forIndexPath:indexPath];
        [self line:cell.contentView withX:8 withY:32.5];
        return cell;
    } else {
        ShengChangJinDuCXiangQingCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"shengChangJinDuCXiangQingCell2" forIndexPath:indexPath];
        [self line:cell.contentView withX:8 withY:48.5];
        TpfOrderInfoBean *tpfOrderInfoBean = self.tpfOrderBean.infos[indexPath.section];
        TpfConfirmInfo *tpfConfirmInfo = tpfOrderInfoBean.confirmInfos[indexPath.row-1];
        cell.productionControlNum.text = tpfConfirmInfo.productionControlNum;
        cell.plannedQuantity.text = tpfConfirmInfo.plannedQuantity;
        cell.completedQuantity.text = tpfConfirmInfo.completedQuantity;
        return cell;
    }
}
- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)line:(UIView *)view withX:(CGFloat)x withY:(CGFloat)y{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, kMainW-2*x, 0.5)];
    label.backgroundColor = colorLine;
    [view addSubview:label];
}

- (UIView *)viewNoContent {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _height_NavBar+33, kMainW, kMainH - (_height_NavBar+33)-250)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, kMainW, 21);
    label.center = CGPointMake(view.center.x, view.center.y-100);
    label.text = @"无内容";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = colorRGB(32, 32, 32);
    [view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.bounds = CGRectMake(0, 0, kMainW, 21);
    label1.center = CGPointMake(kMainW/2, CGRectGetMaxY(label.frame)+CGRectGetHeight(label1.frame)/2.0);
    label1.text = @"暂无安排生产";
    label1.font = [UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = colorRGB(117, 117, 117);
    [view addSubview:label1];
    
    return view;
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
