//
//  YanHuoDetailViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "YanHuoDetailViewController.h"
#import "VoHeader.h"
#import "YanHuoDetailCell0900.h"
#import "YanHuoDetailCell090000.h"
#import "YanHuoDetailCell090001.h"
#import "YanHuoDetailCell090002.h"
#import "ShouHuooDetailCell0901.h"
#import "FaHuoCell0901.h"
#import "YanHuoDetailCell0903.h"
#import "CiPingChuLiModel.h"
#import "UIViewCiPingChuLiFangShi.h"
#import "PartDetailsView.h"
#import "CheckDefectivePhoneViewController.h"

@interface YanHuoDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) NSInteger index;

@end

@implementation YanHuoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoDetailCell0900" bundle:nil] forCellReuseIdentifier:@"yanHuoDetailCell0900"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoDetailCell090000" bundle:nil] forCellReuseIdentifier:@"yanHuoDetailCell090000"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoDetailCell090001" bundle:nil] forCellReuseIdentifier:@"yanHuoDetailCell090001"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoDetailCell090002" bundle:nil] forCellReuseIdentifier:@"yanHuoDetailCell090002"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuooDetailCell0901" bundle:nil] forCellReuseIdentifier:@"shouHuooDetailCell0901"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell0901" bundle:nil] forCellReuseIdentifier:@"faHuoCell0901"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoDetailCell0903" bundle:nil] forCellReuseIdentifier:@"yanHuoDetailCell0903"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return self.inspectOrderVo.inspectOrderItems.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (self.index == 0) {
            YanHuoDetailCell0900 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoDetailCell0900" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.inspectOrderVo;
            return cell;
        } else if (self.index == 1) {
            if ([self.inspectOrderVo.deliveryMethods isEqualToString:@"SUPPLIER"]) {
                YanHuoDetailCell090000 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoDetailCell090000" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.inspectOrderVo;
                return cell;
            } else if ([self.inspectOrderVo.deliveryMethods isEqualToString:@"LOGISTICS"]) {
                YanHuoDetailCell090001 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoDetailCell090001" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.inspectOrderVo;
                return cell;
            } else if ([self.inspectOrderVo.deliveryMethods isEqualToString:@"SELF"]) {
                YanHuoDetailCell090002 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoDetailCell090002" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.inspectOrderVo;
                return cell;
            }
        }
    } else if (indexPath.section == 1) {
        ShouHuooDetailCell0901 * cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuooDetailCell0901" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setButtonUpOrDownCallBack:^(UIButton * _Nonnull sender) {
            self.index = self.index==0?1:0;
            [sender setTitle:self.index==0?@"展开更多":@"收起" forState:UIControlStateNormal];
            [sender setImage:[UIImage imageNamed:self.index==0?@"Down":@"up1"] forState:UIControlStateNormal];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }];
        return cell;
    } else if (indexPath.section == 2) {
        FaHuoCell0901 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0901" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 3) {
        YanHuoDetailCell0903 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoDetailCell0903" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        InspectOrderItemVo *inspectOrderItemVo = self.inspectOrderVo.inspectOrderItems[indexPath.row];
        cell.model = inspectOrderItemVo;
        DeliverOrderItemBean *model1;
        for (DeliverOrderItemBean *model11 in self.inspectOrderVo.deliverOrder.items) {
            if ([inspectOrderItemVo.deliverOrderItemId isEqualToString:model11.deliverOrderItemId]) {
                model1 = model11;
            }
        }
//        DeliverOrderItemBean *mode1 = self.inspectOrderVo.deliverOrder.items[indexPath.row];
        cell.labelPartName.text = [NSString stringWithFormat:@"%ld、零件号/规格：%@",indexPath.row+1,model1.partNumber!=nil?model1.partNumber:@""];
        [cell setButtonPartDetailCallBack:^{
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PartDetailsView" owner:self options:nil];
            PartDetailsView *partDetailsView = [nib objectAtIndex:0];
            partDetailsView.frame = CGRectMake(0, 0, kMainW, kMainH);
            [self.view addSubview:partDetailsView];
            [partDetailsView initDataIsDeliverOrderItemBean:self.inspectOrderVo.deliverOrder.items[indexPath.row]];
        }];
        [cell setButtonDefectiveOperateCallBack:^{
            NSMutableArray *arrayCiPingChuLiModel = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSInteger i=0; i<5; i++) {
                if ([inspectOrderItemVo valueForKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]]) {
                    CiPingChuLiModel *model1 = [[CiPingChuLiModel alloc] init];
                    model1.defectiveOperateType = [inspectOrderItemVo valueForKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]];
                    model1.reissueNum = [inspectOrderItemVo valueForKey:[NSString stringWithFormat:@"reissueNum%ld",i+1]];
                    model1.unType = [inspectOrderItemVo valueForKey:[NSString stringWithFormat:@"unType%ld",i+1]];
                    model1.unReason = [inspectOrderItemVo valueForKey:[NSString stringWithFormat:@"unReason%ld",i+1]];
                    [arrayCiPingChuLiModel addObject:model1];
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
            [viewCPCLFS initTableView:arrayCiPingChuLiModel defectiveQuantity:inspectOrderItemVo.defectiveQuantity];
        }];
        [cell setButtonPartPhoneCallBack:^{
            CheckDefectivePhoneViewController *vc = [[CheckDefectivePhoneViewController alloc] init];
            vc.filePath = inspectOrderItemVo.filePath;
            vc.fileRealName = inspectOrderItemVo.fileRealName;
            vc.bucketName = inspectOrderItemVo.bucketName;
            vc.fileName = inspectOrderItemVo.fileName;
            
            [self.navigationController pushViewController:vc animated:true];
        }];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
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
