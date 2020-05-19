//
//  YanHuoXiangQingVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/23.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "YanHuoXiangQingVC.h"
#import "VoHeader.h"

#import "YanHuoXiangQingCell.h"
#import "YanHuoXiangQingCell1.h"
#import "FaHuoHeaderView.h"

#import "CiPingChuLiModel.h"
#import "UIViewCiPingChuLiFangShi.h"
#import "PartDetailsDingDanViewController.h"

@interface YanHuoXiangQingVC () <UITableViewDelegate,UITableViewDataSource> {
    OrderOperate *_orderOperate;
    UIView *_viewLoading;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation YanHuoXiangQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoXiangQingCell" bundle:nil] forCellReuseIdentifier:@"yanHuoXiangQingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoXiangQingCell1" bundle:nil] forCellReuseIdentifier:@"yanHuoXiangQingCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"faHuoHeaderView"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    [self initRequest];

}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == _orderOperate.orderOperateItems.count) {
        return 31;
    }
    return 10.f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == _orderOperate.orderOperateItems.count) {
        FaHuoHeaderView *faHuoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"faHuoHeaderView"];
        faHuoHeaderView.label1.hidden = YES;
        faHuoHeaderView.label0.text = @"订单信息";
        return faHuoHeaderView;
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _orderOperate.orderOperateItems.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _orderOperate.orderOperateItems.count) {
        return 274;
    } else if (indexPath.section < _orderOperate.orderOperateItems.count+1) {
        return 196;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _orderOperate.orderOperateItems.count) {
        YanHuoXiangQingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoXiangQingCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.buttonChaKanCiPingFangShi.hidden = YES;
        cell.label31.hidden = YES;
        OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[indexPath.section];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"hhmmss";
        NSString *stringDate = [formatter stringFromDate:date];
        stringDate = [stringDate substringToIndex:5];
        if ([orderOperateItem.tradeOrderItem.isMatchDrawingCloud integerValue] == 0) {
            if (orderOperateItem.tradeOrderItem.thumbnailUrl.length > 0) {
                [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:orderOperateItem.tradeOrderItem.thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
            } else {
                cell.imageView1.image = [UIImage imageNamed:@"img_nopicture"];
            }
        } else {
            NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@&t=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_orderOperate.tradeOrder.purchaseEnterpriseId,orderOperateItem.tradeOrderItem.partNumber,orderOperateItem.tradeOrderItem.picVersion,stringDate] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
        }
        
        cell.label0.text = [NSString stringWithFormat:@"%ld、%@",indexPath.section+1,orderOperateItem.tradeOrderItem.partName];
        
        cell.label1.text = orderOperateItem.tradeOrderItem.materialName2.length>0?orderOperateItem.tradeOrderItem.materialName2:@"--";
        NSArray *arrayTags = [orderOperateItem.tradeOrderItem.tags componentsSeparatedByString:@"."];
        NSMutableArray *arrayTags1 = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSString *string in arrayTags) {
            if (![string isEqualToString:@""]) {
                [arrayTags1 addObject:string];
            }
        }
        NSString *stringTag;
        for (int i = 0; i < arrayTags1.count; i++) {
            if (i == 0) {
                stringTag = arrayTags1[i];
            } else {
                stringTag = [NSString stringWithFormat:@"%@、%@",stringTag,arrayTags1[i]];
            }
        }
        cell.label2.text = [NSString stringWithFormat:@"%@",stringTag.length != 0?stringTag:@"详见图纸"];
        
        if ([NSString SizeUnit:orderOperateItem.tradeOrderItem.sizeUnit]) {
            cell.label3.text = [NSString stringWithFormat:@"长 %.2f * 宽 %.2f * 高 %.2f %@",[orderOperateItem.tradeOrderItem.length doubleValue],[orderOperateItem.tradeOrderItem.width doubleValue],[orderOperateItem.tradeOrderItem.height doubleValue],[NSString SizeUnit:orderOperateItem.tradeOrderItem.sizeUnit]];
        } else {
            cell.label3.text = @"--";
        }
        cell.label4.text = [NSString stringWithFormat:@"%ld%@",[orderOperateItem.tradeOrderItem.num integerValue],[NSString QuantityUnit:orderOperateItem.tradeOrderItem.quantityUnit].length>0?[NSString QuantityUnit:orderOperateItem.tradeOrderItem.quantityUnit]:@""];
        cell.buttonLingJianXiangQing.tag = indexPath.section;
        [cell.buttonLingJianXiangQing addTarget:self action:@selector(buttonDeatailClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.label20.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.canInspectNum integerValue]];
//        cell.label21.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.qualityQuantity integerValue]+[orderOperateItem.defectiveQuantity integerValue]];
        cell.label21.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.operateNum integerValue]];
        cell.label22.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.qualityQuantity integerValue]];
        cell.label23.text = [NSString stringWithFormat:@"%ld",[orderOperateItem.defectiveQuantity integerValue]];
        
        if ([_orderOperate.isInspect integerValue] == 1) {
            if ([orderOperateItem.defectiveQuantity integerValue] > 0) {
                cell.buttonChaKanCiPingFangShi.hidden = NO;
                cell.label30.text = @"不合格";
            } else {
                cell.label30.text = @"合格";
                if ([orderOperateItem.isMianjian integerValue] == 1) {
                    cell.label31.hidden = NO;
                }
            }
        }
        cell.buttonChaKanCiPingFangShi.tag = indexPath.section;
        [cell.buttonChaKanCiPingFangShi addTarget:self action:@selector(buttonClickChaKanCiPingFangShi:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else if (indexPath.section < _orderOperate.orderOperateItems.count+1) {
        YanHuoXiangQingCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoXiangQingCell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.label0.text = _orderOperate.receviceTime;
        cell.label1.text = _orderOperate.receiveCode.length>0?_orderOperate.receiveCode:@"暂无";
        cell.label2.text = _orderOperate.tradeOrder.insideOrderCode;
        cell.label3.text = _orderOperate.deliverCode.length>0?_orderOperate.deliverCode:@"暂无";
        cell.label4.text = _orderOperate.deliverNumber.length>0?_orderOperate.deliverNumber:@"暂无";
        cell.label5.text = _orderOperate.logisticsCompany.length>0?_orderOperate.logisticsCompany:@"暂无";
        cell.label6.text = _orderOperate.logisticsNo.length>0?_orderOperate.logisticsNo:@"暂无";
        cell.label7.text = _orderOperate.tradeOrder.supplierEnterpriseName;
        return cell;
    }
    return nil;
}

//查看处理方式
- (void)buttonClickChaKanCiPingFangShi:(UIButton *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    
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

- (void)buttonDeatailClick:(UIButton *)sender {
    OrderOperateItem *orderOperateItem = _orderOperate.orderOperateItems[sender.tag];
    
    PartDetailsDingDanViewController *ljxqVC = [[PartDetailsDingDanViewController alloc] init];
    ljxqVC.tradeOrderItem = orderOperateItem.tradeOrderItem;
//    ljxqVC.factoryProductInfo = _factoryProductInfo;
    ljxqVC.enterpriseId = _orderOperate.tradeOrder.purchaseEnterpriseId;
    ljxqVC.inquiryType = _orderOperate.tradeOrder.inquiryType;
    ljxqVC.sourceCaiOrGong = @"gong";
    [self.navigationController pushViewController:ljxqVC animated:YES];
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    
    OrderOperate *orderOperate = [[OrderOperate alloc] init];
    orderOperate.orderOperateId = self.orderOperateId;
    postEntityBean.entity = orderOperate.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_i_orderOperate_reissueOperate parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _orderOperate = [OrderOperate mj_objectWithKeyValues:model.entity];
            
            _viewLoading.hidden = YES;
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
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
