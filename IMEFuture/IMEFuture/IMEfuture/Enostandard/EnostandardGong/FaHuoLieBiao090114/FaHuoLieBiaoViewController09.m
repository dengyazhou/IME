//
//  FaHuoLieBiaoViewController09.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "FaHuoLieBiaoViewController09.h"
#import "VoHeader.h"

#import "FaHuoLieBiaoCell09.h"

#import "FaHuoViewController09.h"



@interface FaHuoLieBiaoViewController09 () <UITableViewDelegate,UITableViewDataSource> {
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *buttonCreatDispatchBill;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation FaHuoLieBiaoViewController09

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoLieBiaoCell09" bundle:nil] forCellReuseIdentifier:@"faHuoLieBiaoCell09"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.buttonCreatDispatchBill.backgroundColor = colorRGB(180, 180, 180);
    self.buttonCreatDispatchBill.enabled = false;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar)];
    [self.view addSubview:_viewLoading];
    
    [self initRequest];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FaHuoLieBiaoCell09 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoLieBiaoCell09" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PurchaseOrderResBean *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PurchaseOrderResBean *model = self.dataArray[indexPath.row];
    if (model.waitDeliverNum.integerValue == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"待发货数量为0"];
        return;
    }
    if (model.selectDYZ.integerValue == 0) {
        model.selectDYZ = [NSNumber numberWithInteger:1];
    } else if (model.selectDYZ.integerValue == 1) {
        model.selectDYZ = [NSNumber numberWithBool:0];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    
    [self changebuttonColor];
}

- (void)changebuttonColor {
    BOOL flag = false;
    for (PurchaseOrderResBean *model in self.dataArray) {
        if (model.selectDYZ.integerValue == 1) {
            flag = true;
        }
    }
    if (flag) {
        self.buttonCreatDispatchBill.backgroundColor = colorGong;
        self.buttonCreatDispatchBill.enabled = true;
    } else {
        self.buttonCreatDispatchBill.backgroundColor = colorRGB(180, 180, 180);
        self.buttonCreatDispatchBill.enabled = false;
    }
}

- (IBAction)buttonCreatDispatchBill:(UIButton *)sender {
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (PurchaseOrderResBean *model in self.dataArray) {
        if (model.selectDYZ.integerValue == 1) {
            [dataArray addObject:model];
        }
    }
    FaHuoViewController09 *vc = [[FaHuoViewController09 alloc] init];
    vc.dataArray = dataArray;//
    vc.isOpenErp = self.isOpenErp;
    [self.navigationController pushViewController:vc animated:true];
}


- (void)initRequest{
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    PurchaseOrderReqBean *purchaseOrderReqBean = [PurchaseOrderReqBean new];
    purchaseOrderReqBean.orderCode = self.insideOrderCode;
    postEntityBean.entity = purchaseOrderReqBean.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_purchaseOrder_purchaseOrderList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *arrayInquiryOrder = model.list;
            for (NSDictionary *dic in arrayInquiryOrder) {
                PurchaseOrderResBean *obj = [PurchaseOrderResBean mj_objectWithKeyValues:dic];
                obj.selectDYZ = [NSNumber numberWithInteger:0];
                
                [self.dataArray addObject:obj];
            }
            [self.tableView reloadData];
            _viewLoading.hidden = YES;
        } else {
       
        }
    } fail:^(NSError *error) {

    } isKindOfModel:NSClassFromString(@"ReturnListBean")];

}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
