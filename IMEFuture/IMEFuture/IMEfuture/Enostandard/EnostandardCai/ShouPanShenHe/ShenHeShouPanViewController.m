
//
//  ShenHeShouPanViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ShenHeShouPanViewController.h"
#import "VoHeader.h"

#import "MingXiQueRenBaoJia01.h"
#import "MingXiQueRenBaoJia010.h"
#import "MingXiQueRenBaoJia02.h"
#import "MingXiQueRenBaoJia03.h"
#import "MXBaoJiaCell01.h"
#import "BaoJiaHeaderView01.h"
#import "MXBaoJiaCell111.h"

#import "Masonry.h"


#import "QiYeXinXiXiangQingViewController.h"
#import "EChaKanXieYiController.h"
#import "XunPanXiangQingViewController.h"
#import "ECInquiryViewController.h"

#import "UIButtonIM.h"

#import "PartDetailsViewController.h"
#import "LingJianXiangQingViewController2.h"
#import "NSArray+Transition.h"
#import "UIViewXuanZeYuanYing.h"

#import "RefreshManager.h"
#import "GlobalSettingManager.h"

@interface ShenHeShouPanViewController () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate> {
    NSMutableArray *_arrayInquiryOrderItemModel;
    NSMutableArray *_quotationOrderItems;
    NSMutableArray *_arrayYesOpen;
    NSInteger _integerButtonLineColor;
    BOOL _haveDuiGou;
    UIView *_viewLoading;
    QuotationOrder *_quotationOrder;
    InquiryOrder *_inquiryOrder;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (weak, nonatomic) IBOutlet UIButton *buttonBuTongGuoL;//不通过L   小
@property (weak, nonatomic) IBOutlet UIButton *buttonTongGuoR;//通过R      小
@property (weak, nonatomic) IBOutlet UIButton *buttonBuTongGuo;//不通过    大
@property (weak, nonatomic) IBOutlet UIButton *buttonTongGuo;//通过       大


@end

@implementation ShenHeShouPanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    
    _haveDuiGou = YES;
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BaoJiaCell31" bundle:nil] forCellReuseIdentifier:@"cell31"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia01" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia010" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia010"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia02" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia02"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia03" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia03"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell01" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaoJiaHeaderView01" bundle:nil] forHeaderFooterViewReuseIdentifier:@"baoJiaHeaderView01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tag = 88;
    
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    [self.tableView1 registerNib:[UINib nibWithNibName:@"BaoJiaCell31" bundle:nil] forCellReuseIdentifier:@"cell31"];
    [self.tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia01" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia010" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia010"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia02" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia02"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia03" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia03"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell01" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"BaoJiaHeaderView01" bundle:nil] forHeaderFooterViewReuseIdentifier:@"baoJiaHeaderView01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView1.tableFooterView = [UIView new];
    self.tableView1.tag = 89;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    
//    self.buttonBuTongGuoL.hidden = YES;
//    self.buttonTongGuoR.hidden = YES;
    self.buttonBuTongGuo.hidden = YES;
    self.buttonTongGuo.hidden = YES;
    
    [self initRequrst];

}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
//            return 1+1+2+1;
            return 1;
        } else if (section == 2) {
            return 0;
        } else if (section < 1+1+1+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[section - 3];
                if (quotationOrderItem.isSkip.integerValue == 0) {//暂不报价
                    return 3;
                } else {//启动报价
                    return 1;
                }
            }
        } else if (section == 1+1+1+_quotationOrderItems.count) {
            return 1;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
//            return 1+1+[_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue]+1;
            return 1;
        } else if (section == 2) {
            return 0;
        } else if (section < 1+1+1+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[section - 3];
                if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"] && [quotationOrderItem.isSkip integerValue] == 1) {
                    return 1;
                } else {
                    return 1+1+[_inquiryOrder.tempPriceDetailCount integerValue]+2+2;
                }
            }
        } else if (section == 1+1+1+_quotationOrderItems.count) {
            return 1;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 88) {
        if (indexPath.section == 0) {
            return 68;
        } else if (indexPath.section == 1) {
            return 40;
        } else if (indexPath.section == 2) {
            return 0;
        } else if (indexPath.section < 1+1+1+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
                    return 265;
                } else {
                    return 235;
                }
            } else if (indexPath.row == 1) {
                return 50;
            } else {
                return 40;
            }
        } else if (indexPath.section == 1+1+1+_quotationOrderItems.count) {
            if (_quotationOrder.remark) {
                CGSize size = [_quotationOrder.remark boundingRectWithSize:CGSizeMake(kMainW-20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                return size.height + 56 + 5 - 15;
            } else {
                return 56;
            }
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (indexPath.section == 0) {
            return 68;
        } else if (indexPath.section == 1) {
            return 40;
        } else if (indexPath.section == 2) {
            return 0;
        } else if (indexPath.section < 1+1+1+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
                    if ([quotationOrderItem.isSkip integerValue] == 1) {
                        return 265;
                    } else {
                        return 221;
                    }
                } else {
                    return 198;
                }
            } else if (indexPath.row == 1) {
                return 50;
            } else {
                return 40;
            }
        } else if (indexPath.section == 1+1+1+_quotationOrderItems.count) {
            if (_quotationOrder.remark) {
                CGSize size = [_quotationOrder.remark boundingRectWithSize:CGSizeMake(kMainW-20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                return size.height + 56 + 5 - 15;
            } else {
                return 56;
            }
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 88) {
        return 1+1+1+_quotationOrderItems.count+1;
    } else if (tableView.tag == 89) {
        return 1+1+1+_quotationOrderItems.count+1;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 0.1;
        } else if (section == 1) {
            return 32;
        } else if (section == 2) {
            return 32;
        } else if (section < 1+1+1+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == 1+1+1+_quotationOrderItems.count) {
            return 32;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 0.1;
        } else if (section == 1) {
            return 32;
        } else if (section == 2) {
            return 32;
        } else if (section < 1+1+1+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == 1+1+1+_quotationOrderItems.count) {
            return 32;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 0.1;
        } else if (section == 1) {
            return 0.1;
        } else if (section == 2) {
            return 0.1;
        } else if (section < 1+1+1+_quotationOrderItems.count) {
            if (section == 1+1+_quotationOrderItems.count) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == 1+1+1+_quotationOrderItems.count) {
            return 0.1;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 0.1;
        } else if (section == 1) {
            return 0.1;
        } else if (section == 2) {
            return 0.1;
        } else if (section < 1+1+1+_quotationOrderItems.count) {
            if (section == 1+1+_quotationOrderItems.count) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == 1+1+1+_quotationOrderItems.count) {
            return 0.1;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return nil;
        } else if (section == 1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件总计";
            [view addSubview:labelDiYiBaoJia];
            
            UILabel *labelTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(15+50+10, 0, kMainW-30-50-10, 32)];
            labelTitle1.font = [UIFont systemFontOfSize:12];
            labelTitle1.textColor = colorText153;
            labelTitle1.text = _inquiryOrder.title;
            labelTitle1.textAlignment = NSTextAlignmentRight;
            [view addSubview:labelTitle1];
            
            [self line:view withY:31.5 withTag:0];
            return view;
        } else if (section == 2) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 74, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件报价";
            [view addSubview:labelDiYiBaoJia];
            return view;
        } else if (section < 1+1+1+_quotationOrderItems.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewYiBaoJia.hidden = YES;
            view.viewWeiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            
            InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 3];
            QuotationOrderItem *quotationOrderItem = _quotationOrderItems[section - 3];
            
            if ([quotationOrderItem.isSkip integerValue] == 1) {
                view.viewZanBuBaoJia.hidden = NO;
            } else {
                if ([quotationOrderItem.price1 doubleValue]>0) {
                    view.viewYiBaoJia.hidden = NO;
                } else {
                    view.viewWeiBaoJia.hidden = NO;
                }
            }
            
            NSString *partNumber_specifications;
            if (model.partNumber.length>0&&model.specifications.length>0) {
                partNumber_specifications = [NSString stringWithFormat:@"%@/%@",model.partNumber,model.specifications];
            } else if (model.partNumber.length>0&&model.specifications.length==0) {
                partNumber_specifications = model.partNumber;
            } else if (model.partNumber.length==0&&model.specifications.length>0) {
                partNumber_specifications = model.specifications;
            } else {
                partNumber_specifications = @"--";
            }
            view.labelName.text = [NSString stringWithFormat:@"%ld、%@",section-3+1,partNumber_specifications];
            view.label00.textColor = colorRGB(255, 151, 0);
            view.label0.textColor = colorRGB(255, 151, 0);
            
            
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 integerValue]*[quotationOrderItem.price1 doubleValue];
            
            if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                view.label0.text = @"****";
                view.label1.text = @"****";
            } else {
                view.label0.text  = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:nil;
                view.label1.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            }
            
            
            
            view.label2.text  = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label2DanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            
            view.label0Wei.text = @"未报价";
            view.label0Wei.textColor = colorRGB(255, 151, 0);
            view.label1Wei.text = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label1WeiDanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            view.labelZanBuBaoJia.textColor = colorRGB(255, 151, 0);
            view.labelZanBuYuanYin.text = [NSString stringWithFormat:@"原因:%@",quotationOrderItem.skipRemark];
            
            view.labelZongjia.text = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.labelZongjiaDanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            view.buttonOpen.tag = section-3;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-3;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            return view;
        } else if (section == 1+1+1+_quotationOrderItems.count) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"备注";
            [view addSubview:labelDiYiBaoJia];
            
            [self line:view withY:31.5 withTag:0];
            return view;
        } else {
            return nil;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return nil;
        } else if (section == 1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件总计";
            [view addSubview:labelDiYiBaoJia];
            
            UILabel *labelTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(15+50+10, 0, kMainW-30-50-10, 32)];
            labelTitle1.font = [UIFont systemFontOfSize:12];
            labelTitle1.textColor = colorText153;
            labelTitle1.text = _inquiryOrder.title;
            labelTitle1.textAlignment = NSTextAlignmentRight;
            [view addSubview:labelTitle1];
            
            [self line:view withY:31.5 withTag:0];
            return view;
        } else if (section == 2) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 74, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件报价明细";
            [view addSubview:labelDiYiBaoJia];
            
            return view;
        } else if (section < 1+1+1+_quotationOrderItems.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewYiBaoJia.hidden = YES;
            view.viewWeiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            
            InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 3];
            QuotationOrderItem *quotationOrderItem = _quotationOrderItems[section - 3];
            
            if ([quotationOrderItem.isSkip integerValue] == 1) {
                view.viewZanBuBaoJia.hidden = NO;
            } else {
                if ([quotationOrderItem.price1 doubleValue]>0) {
                    view.viewYiBaoJia.hidden = NO;
                } else {
                    view.viewWeiBaoJia.hidden = NO;
                }
            }
            
            NSString *partNumber_specifications;
            if (model.partNumber.length>0&&model.specifications.length>0) {
                partNumber_specifications = [NSString stringWithFormat:@"%@/%@",model.partNumber,model.specifications];
            } else if (model.partNumber.length>0&&model.specifications.length==0) {
                partNumber_specifications = model.partNumber;
            } else if (model.partNumber.length==0&&model.specifications.length>0) {
                partNumber_specifications = model.specifications;
            } else {
                partNumber_specifications = @"--";
            }
            view.labelName.text = [NSString stringWithFormat:@"%ld、%@",section-3+1,partNumber_specifications];
            view.label00.textColor = colorRGB(255, 151, 0);
            view.label0.textColor = colorRGB(255, 151, 0);
            
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 integerValue]*[quotationOrderItem.price1 doubleValue];
            if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                view.label0.text = @"****";
                view.label1.text = @"****";
            } else {
                view.label0.text  = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:nil;
                view.label1.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            }
            
            view.label2.text  = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label2DanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            
            view.label0Wei.text = @"未报价";
            view.label0Wei.textColor = colorRGB(255, 151, 0);
            view.label1Wei.text = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label1WeiDanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            view.labelZanBuBaoJia.textColor = colorRGB(255, 151, 0);
            view.labelZanBuYuanYin.text = [NSString stringWithFormat:@"原因:%@",quotationOrderItem.skipRemark];
            
            view.buttonOpen.tag = section-3;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-3;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            return view;
        } else if (section == 1+1+1+_quotationOrderItems.count) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"备注";
            [view addSubview:labelDiYiBaoJia];
            
            [self line:view withY:31.5 withTag:0];
            return view;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 88) {
        if (indexPath.section == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            UIImageView *imageViewH = [[UIImageView alloc] init];
            [cell.contentView addSubview:imageViewH];
            [imageViewH sd_setImageWithURL:[NSURL URLWithString:_quotationOrder.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
            [imageViewH mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(10);
                make.top.equalTo(cell.contentView.mas_top).with.offset(10);
                make.width.mas_equalTo(48);
                make.height.mas_equalTo(48);
            }];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = _quotationOrder.member.enterpriseInfo.enterpriseName;
            label1.textColor = colorRGB(32, 32, 32);
            [cell.contentView addSubview:label1];
            
            if ([_quotationOrder.member.enterpriseInfo.hasTrFactory integerValue] == 0) {
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imageViewH.mas_right).with.offset(10);
                    make.top.equalTo(imageViewH.mas_top).with.offset(5);
                    make.right.equalTo(cell.mas_right).with.offset(-83-5);
                }];
            }
            
            if ([_quotationOrder.member.enterpriseInfo.hasTrFactory integerValue] == 1) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_factory"]];
                [cell.contentView addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imageViewH.mas_right).with.offset(10);
                    make.top.equalTo(imageViewH.mas_top).with.offset(5);
                    make.width.mas_equalTo(17);
                    make.height.mas_equalTo(17);
                }];
                
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imageViewH.mas_right).with.offset(37);
                    make.top.equalTo(imageViewH.mas_top).with.offset(5);
                    make.right.equalTo(cell.mas_right).with.offset(-83-5);
                }];
            }
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.text = [NSString stringWithFormat:@"%@ %@",_quotationOrder.member.enterpriseInfo.province?_quotationOrder.member.enterpriseInfo.province:@"",_quotationOrder.member.enterpriseInfo.city?_quotationOrder.member.enterpriseInfo.city:@""];
            label2.textColor = colorRGB(117, 117, 117);
            label2.font = [UIFont systemFontOfSize:12];
            [cell.contentView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageViewH.mas_right).with.offset(10);
                make.top.equalTo(label1.mas_bottom).with.offset(3);
            }];
            
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else if (indexPath.section == 1) {

            if (indexPath.row == 0) {
                MXBaoJiaCell111 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell111" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrder.supplierTaxRate doubleValue]*100];

                cell.label0.text = @"未税总计";
                if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                    cell.label2.text = @"****";//未税核算价
                } else {
                    cell.label2.text = _quotationOrder.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.totalPrice1 doubleValue]]:@"0.00";
                }
                cell.label1.textColor = colorCai;
                cell.label2.textColor = colorCai;
                
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section < 1+1+1+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.imageTopConstraint.constant = 8;
                cell.viewDaoHuoTime.hidden = YES;
                cell.viewZanBuBaoJia.hidden = YES;
                cell.buttonZanBuBaoJia.hidden = YES;
                cell.viewZongjia.hidden = YES;
                cell.viewZongChaKan.hidden = YES;
                
                InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 3];
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                
                if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
                    if ([quotationOrderItem.isSkip integerValue] == 1) {
                        cell.imageTopConstraint.constant = 38;
                        cell.viewDaoHuoTime.hidden = NO;
                        cell.viewZanBuBaoJia.hidden = NO;
                    } else {
                        cell.imageTopConstraint.constant = 38;
                        cell.viewDaoHuoTime.hidden = NO;
                        cell.viewZongChaKan.hidden = NO;
                    }
                } else {
                    cell.viewZongChaKan.hidden = NO;
                }
                
                NSString *partNumber_specifications;
                if (inquiryOrderItem.partNumber.length>0&&inquiryOrderItem.specifications.length>0) {
                    partNumber_specifications = [NSString stringWithFormat:@"%@/%@",inquiryOrderItem.partNumber,inquiryOrderItem.specifications];
                } else if (inquiryOrderItem.partNumber.length>0&&inquiryOrderItem.specifications.length==0) {
                    partNumber_specifications = inquiryOrderItem.partNumber;
                } else if (inquiryOrderItem.partNumber.length==0&&inquiryOrderItem.specifications.length>0) {
                    partNumber_specifications = inquiryOrderItem.specifications;
                } else {
                    partNumber_specifications = @"--";
                }
                cell.dyzPartNumber.text = [NSString stringWithFormat:@"%ld、%@",indexPath.section-3+1,partNumber_specifications];
                cell.materialName.text = inquiryOrderItem.materialName2.length>0?inquiryOrderItem.materialName2:@"--";
                
                cell.dyzPartName.text = inquiryOrderItem.partName.length>0?inquiryOrderItem.partName:@"--";
                
                if ([NSString SizeUnit:inquiryOrderItem.sizeUnit]) {
                    cell.sizeLWHUnit.text = [NSString stringWithFormat:@"长 %.2f * 宽 %.2f * 高 %.2f %@",[inquiryOrderItem.length doubleValue],[inquiryOrderItem.width doubleValue],[inquiryOrderItem.height doubleValue],[NSString SizeUnit:inquiryOrderItem.sizeUnit]];
                } else {
                    cell.sizeLWHUnit.text = @"--";
                }
                
                cell.num123.text = [NSString stringWithFormat:@"%@%@",inquiryOrderItem.num1,[NSString QuantityUnit:inquiryOrderItem.quantityUnit].length>0?[NSString QuantityUnit:inquiryOrderItem.quantityUnit]:@""];
                
                if ([inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:inquiryOrderItem.sec_thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                } else {
                    
                    NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_inquiryOrder.member.enterpriseInfo.enterpriseId,inquiryOrderItem.partNumber,inquiryOrderItem.picVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                }

                
                NSString *batchDeliverItem = [[inquiryOrderItem.deliveryTime componentsSeparatedByString:@" "] firstObject];
                cell.labelDaoHuoTime.text = [NSString stringWithFormat:@"交货日期:%@",batchDeliverItem];
                
                cell.labelZanBuBaoJia.text = [NSString stringWithFormat:@"暂不报价原因:%@",quotationOrderItem.skipRemark];
                
                cell.buttonClose.tag = indexPath.section - 3;
                [cell.buttonClose addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonClose1.tag = indexPath.section - 3;
                [cell.buttonClose1 addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonImage.tag = indexPath.section - 3;
                [cell.buttonImage addTarget:self action:@selector(buttonImageClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonDetail.tag = indexPath.section - 3;
                [cell.buttonDetail setTitleColor:colorRGB(255, 151, 0) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.zongChaKanlabel1.textColor = colorCai;
                cell.zongChaKanlabel2.textColor = colorCai;
                cell.zongChaKanlabel2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:@"0.00";
                return cell;
            } else if (indexPath.row == 1) {
                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                cell.label0.text = @"回复交期";
                if (quotationOrderItem.supplierDeliverTime) {
                    cell.label1.text = [[quotationOrderItem.supplierDeliverTime componentsSeparatedByString:@" "] firstObject];
                } else {
                    cell.label1.text = @"--";
                }
                return cell;
            } else if (indexPath.row == 2) {
                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                cell.label0.text = @"零件备注";
                cell.label1.text = quotationOrderItem.supplierRemark.length>0?quotationOrderItem.supplierRemark:@"--";
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 1+1+1+_quotationOrderItems.count) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 19921126||view.tag == 19921127) {
                    [view removeFromSuperview];
                }
            }
            CGFloat h;
            CGFloat y;
            if (_quotationOrder.remark) {
                CGSize size = [_quotationOrder.remark boundingRectWithSize:CGSizeMake(kMainW-20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                h = size.height + 15;
                y = size.height + 56 + 5 - 15;
            } else {
                h = 30;
                y = 56;
            }
            UILabel *labelBeiZhuContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kMainW-20, h)];
            labelBeiZhuContent.tag = 19921126;
            labelBeiZhuContent.font = [UIFont systemFontOfSize:15];
            labelBeiZhuContent.numberOfLines = 0;
            if (_quotationOrder.remark.length > 0) {
                labelBeiZhuContent.text = _quotationOrder.remark;
            } else {
                labelBeiZhuContent.text = @"暂无备注";
            }
            labelBeiZhuContent.textColor = colorRGB(117, 117, 117);
            
            [cell.contentView addSubview:labelBeiZhuContent];
            
//            UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, y-0.5, kMainW, 0.5)];
//            viewline.tag = 19921127;
//            viewline.backgroundColor = colorLine;
//            [cell.contentView addSubview:viewline];
            
            
            return cell;
        } else {
            return nil;
        }
    } else if (tableView.tag == 89) {
        if (indexPath.section == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            UIImageView *imageViewH = [[UIImageView alloc] init];
            [cell.contentView addSubview:imageViewH];
            [imageViewH sd_setImageWithURL:[NSURL URLWithString:_quotationOrder.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
            [imageViewH mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(10);
                make.top.equalTo(cell.contentView.mas_top).with.offset(10);
                make.width.mas_equalTo(48);
                make.height.mas_equalTo(48);
            }];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = _quotationOrder.member.enterpriseInfo.enterpriseName;
            label1.textColor = colorRGB(32, 32, 32);
            [cell.contentView addSubview:label1];
            
            if ([_quotationOrder.member.enterpriseInfo.hasTrFactory integerValue] == 0) {
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imageViewH.mas_right).with.offset(10);
                    make.top.equalTo(imageViewH.mas_top).with.offset(5);
                    make.right.equalTo(cell.mas_right).with.offset(-83-5);
                }];
            }
            
            if ([_quotationOrder.member.enterpriseInfo.hasTrFactory integerValue] == 1) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_factory"]];
                [cell.contentView addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imageViewH.mas_right).with.offset(10);
                    make.top.equalTo(imageViewH.mas_top).with.offset(5);
                    make.width.mas_equalTo(17);
                    make.height.mas_equalTo(17);
                }];
                
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imageViewH.mas_right).with.offset(37);
                    make.top.equalTo(imageViewH.mas_top).with.offset(5);
                    make.right.equalTo(cell.mas_right).with.offset(-83-5);
                }];
            }
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.text = [NSString stringWithFormat:@"%@ %@",_quotationOrder.member.enterpriseInfo.province?_quotationOrder.member.enterpriseInfo.province:@"",_quotationOrder.member.enterpriseInfo.city?_quotationOrder.member.enterpriseInfo.city:@""];
            label2.textColor = colorRGB(117, 117, 117);
            label2.font = [UIFont systemFontOfSize:12];
            [cell.contentView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageViewH.mas_right).with.offset(10);
                make.top.equalTo(label1.mas_bottom).with.offset(3);
            }];
            
           
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else if (indexPath.section == 1) {

            if (indexPath.row == 0) {
                MXBaoJiaCell111 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell111" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrder.supplierTaxRate doubleValue]*100];
                cell.label0.text = @"未税总计";
                if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                    cell.label2.text = @"****";//未税核算价
                } else {
                    cell.label2.text = _quotationOrder.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.totalPrice1 doubleValue]]:@"0.00";
                }
                cell.label1.textColor = colorCai;
                cell.label2.textColor = colorCai;
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section < 1+1+1+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.imageTopConstraint.constant = 8;
                cell.viewDaoHuoTime.hidden = YES;
                cell.viewZanBuBaoJia.hidden = YES;
                cell.buttonZanBuBaoJia.hidden = YES;
                cell.viewZongjia.hidden = YES;
                cell.viewZongChaKan.hidden = YES;
                
                InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 3];
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                
                if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
                    if ([quotationOrderItem.isSkip integerValue] == 1) {
                        cell.imageTopConstraint.constant = 38;
                        cell.viewDaoHuoTime.hidden = NO;
                        cell.viewZanBuBaoJia.hidden = NO;
                    } else {
                        cell.imageTopConstraint.constant = 38;
                        cell.viewDaoHuoTime.hidden = NO;
                    }
                } else {

                }
                
                NSString *partNumber_specifications;
                if (inquiryOrderItem.partNumber.length>0&&inquiryOrderItem.specifications.length>0) {
                    partNumber_specifications = [NSString stringWithFormat:@"%@/%@",inquiryOrderItem.partNumber,inquiryOrderItem.specifications];
                } else if (inquiryOrderItem.partNumber.length>0&&inquiryOrderItem.specifications.length==0) {
                    partNumber_specifications = inquiryOrderItem.partNumber;
                } else if (inquiryOrderItem.partNumber.length==0&&inquiryOrderItem.specifications.length>0) {
                    partNumber_specifications = inquiryOrderItem.specifications;
                } else {
                    partNumber_specifications = @"--";
                }
                cell.dyzPartNumber.text = [NSString stringWithFormat:@"%ld、%@",indexPath.section-3+1,partNumber_specifications];
                cell.materialName.text = inquiryOrderItem.materialName2.length>0?inquiryOrderItem.materialName2:@"--";
                
                cell.dyzPartName.text = inquiryOrderItem.partName.length>0?inquiryOrderItem.partName:@"--";
                
                if ([NSString SizeUnit:inquiryOrderItem.sizeUnit]) {
                    cell.sizeLWHUnit.text = [NSString stringWithFormat:@"长 %.2f * 宽 %.2f * 高 %.2f %@",[inquiryOrderItem.length doubleValue],[inquiryOrderItem.width doubleValue],[inquiryOrderItem.height doubleValue],[NSString SizeUnit:inquiryOrderItem.sizeUnit]];
                } else {
                    cell.sizeLWHUnit.text = @"--";
                }
                
                cell.num123.text = [NSString stringWithFormat:@"%@%@",inquiryOrderItem.num1,[NSString QuantityUnit:inquiryOrderItem.quantityUnit].length>0?[NSString QuantityUnit:inquiryOrderItem.quantityUnit]:@""];
                
                if ([inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:inquiryOrderItem.sec_thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                } else {
                    
                    NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_inquiryOrder.member.enterpriseInfo.enterpriseId,inquiryOrderItem.partNumber,inquiryOrderItem.picVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                }
                
                NSString *batchDeliverItem = [[inquiryOrderItem.deliveryTime componentsSeparatedByString:@" "] firstObject];
                cell.labelDaoHuoTime.text = [NSString stringWithFormat:@"交货日期:%@",batchDeliverItem];
                
                cell.labelZanBuBaoJia.text = [NSString stringWithFormat:@"暂不报价原因:%@",quotationOrderItem.skipRemark];
                
                cell.buttonClose.tag = indexPath.section - 3;
                [cell.buttonClose addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonClose1.tag = indexPath.section - 3;
                [cell.buttonClose1 addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonImage.tag = indexPath.section - 3;
                [cell.buttonImage addTarget:self action:@selector(buttonImageClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonDetail.tag = indexPath.section - 3;
                [cell.buttonDetail setTitleColor:colorRGB(255, 151, 0) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            } else if (indexPath.row == 1) {
                MingXiQueRenBaoJia010 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia010" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.view1.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
    
                
                InquiryOrderItem *model = _arrayInquiryOrderItemModel[indexPath.section - 3];
                
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                cell.label1.text  = quotationOrderItem.num1?[NSString QuantityUnit:model.quantityUnit].length != 0?[NSString stringWithFormat:@"%@(%@)",quotationOrderItem.num1,[NSString QuantityUnit:model.quantityUnit]]:[NSString stringWithFormat:@"%@",quotationOrderItem.num1]:@"--";
        
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]) {
                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.label0.text = [_inquiryOrder valueForKey:[NSString stringWithFormat:@"tempPriceDetailName%ld",indexPath.row-1]];
                
                
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                
                NSNumber *supplierTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%ld",indexPath.row-1]];
                
                cell.label1.text = supplierTempPrice1DetailValue?[NSString stringWithFormat:@"%.2f",[supplierTempPrice1DetailValue doubleValue]]:@"0.00";
                
                for (UIView *view1 in cell.contentView.subviews) {
                    if ([view1 viewWithTag:1]) {
                        [view1 removeFromSuperview];
                    }
                    if ([view1 viewWithTag:2]) {
                        [view1 removeFromSuperview];
                    }
                }
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]+2) {
                MingXiQueRenBaoJia03 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia03" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.view0.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                cell.label1.textColor = colorRGB(51, 51, 51);
            
                
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                if (indexPath.row == 2+[_inquiryOrder.tempPriceDetailCount integerValue]) {
                    cell.label0.text = @"含税单价";
                    cell.label1.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:@"0.00";
                    
                    if (_integerButtonLineColor == 0) {
                        cell.label1.textColor = colorRGB(255, 151, 0);
                    } else if (_integerButtonLineColor == 1) {
                       
                    } else if (_integerButtonLineColor == 2) {
                        
                    }
                    
                } else if (indexPath.row == 2+[_inquiryOrder.tempPriceDetailCount integerValue]+1) {
                    cell.label0.text = @"不含税单价";
                    cell.label1.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:@"0.00";
                    
                }
                
                for (UIView *view1 in cell.contentView.subviews) {
                    if ([view1 viewWithTag:1]) {
                        [view1 removeFromSuperview];
                    }
                    if ([view1 viewWithTag:2]) {
                        [view1 removeFromSuperview];
                    }
                    if ([view1 viewWithTag:3]) {
                        [view1 removeFromSuperview];
                    }
                }
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]+2+1) {
                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                cell.label0.text = @"回复交期";
                if (quotationOrderItem.supplierDeliverTime) {
                    cell.label1.text = [[quotationOrderItem.supplierDeliverTime componentsSeparatedByString:@" "] firstObject];
                } else {
                    cell.label1.text = @"--";
                }
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]+2+2) {
                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                cell.label0.text = @"零件备注";
                cell.label1.text = quotationOrderItem.supplierRemark.length>0?quotationOrderItem.supplierRemark:@"--";
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 1+1+1+_quotationOrderItems.count) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 19921126||view.tag == 19921127) {
                    [view removeFromSuperview];
                }
            }
            CGFloat h;
            CGFloat y;
            if (_quotationOrder.remark) {
                CGSize size = [_quotationOrder.remark boundingRectWithSize:CGSizeMake(kMainW-20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                h = size.height + 15;
                y = size.height + 56 + 5 - 15;
            } else {
                h = 30;
                y = 56;
            }
            UILabel *labelBeiZhuContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kMainW-20, h)];
            labelBeiZhuContent.tag = 19921126;
            labelBeiZhuContent.font = [UIFont systemFontOfSize:15];
            labelBeiZhuContent.numberOfLines = 0;
            if (_quotationOrder.remark.length > 0) {
                labelBeiZhuContent.text = _quotationOrder.remark;
            } else {
                labelBeiZhuContent.text = @"暂无备注";
            }
            labelBeiZhuContent.textColor = colorRGB(117, 117, 117);
            
            
            
            [cell.contentView addSubview:labelBeiZhuContent];
            
            
//            UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, y-0.5, kMainW, 0.5)];
//            viewline.tag = 19921127;
//            viewline.backgroundColor = colorLine;
//            [cell.contentView addSubview:viewline];
            
            return cell;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QiYeXinXiXiangQingViewController *qyxxxqVC = [[QiYeXinXiXiangQingViewController alloc] init];
        qyxxxqVC.enterpriseInfo = _quotationOrder.member.enterpriseInfo;
        qyxxxqVC.passiveId = _quotationOrder.member.manufacturerId;
        qyxxxqVC.ucenterId = _quotationOrder.member.ucenterId;
        qyxxxqVC.caiOrGong = @"cai";
        [self.navigationController pushViewController:qyxxxqVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)buttonOpenClick:(UIButton *)sender {
//    for (int i = 0; i<_arrayYesOpen.count; i++) {
//        if (i==sender.tag) {
//            [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"yes"];
//        } else {
//            [_arrayYesOpen replaceObjectAtIndex:i withObject:@"no"];
//        }
//    }
    
    [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"yes"];
    [_tableView reloadData];
    [_tableView1 reloadData];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sender.tag+3];
//    [_tableView1 scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
}

- (void)buttonCloseClick:(UIButton *)sender {
    NSLog(@"%s %ld",__FUNCTION__,sender.tag);
    [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"no"];
    [_tableView reloadData];
    [_tableView1 reloadData];
}

- (void)buttonImageClick:(UIButton *)sender {
    InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
    if (inquiryOrderItem.inquiryOrderItemFiles.count == 1) {
        LingJianXiangQingViewController2 *lingJianXiangQingViewController2 = [[LingJianXiangQingViewController2 alloc] init];
        lingJianXiangQingViewController2.isMatchDrawingCloud = inquiryOrderItem.isMatchDrawingCloud;
        lingJianXiangQingViewController2.inquiryOrderItemFile = inquiryOrderItem.inquiryOrderItemFiles[0];
        [self.navigationController pushViewController:lingJianXiangQingViewController2 animated:YES];
    } else if ([inquiryOrderItem.isMatchDrawingCloud integerValue] == 1) {
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        PurchaseProjectInfo *purchaseProjectInfo = [[PurchaseProjectInfo alloc] init];
        purchaseProjectInfo.sec_enterpriseId = _inquiryOrder.member.enterpriseInfo.enterpriseId;
        purchaseProjectInfo.partNumber = inquiryOrderItem.partNumber;
        purchaseProjectInfo.picVersion = inquiryOrderItem.picVersion;
        postEntityBean.entity = purchaseProjectInfo.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        [HttpMamager postRequestWithURLString:DYZ_purchaseProject_queryDrawingLibrariesInfo parameters:dic success:^(id responseObjectModel) {
            ReturnEntityBean *model = responseObjectModel;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                PurchaseProjectInfo *purchaseProjectInfo = [PurchaseProjectInfo mj_objectWithKeyValues:model.entity];
                AccVersionInter *accVersionInter = purchaseProjectInfo.sec_foundVersion;
                NSMutableArray * arrayAccDrawingInter = [[NSMutableArray alloc] initWithCapacity:0];
                for (AccDrawingInter *acc in accVersionInter.drawings) {
                    if (![acc.previewUrl containsString:@".pdf"]) {
                        [arrayAccDrawingInter addObject:acc];
                    }
                }
                if (arrayAccDrawingInter.count == 1) {
                    LingJianXiangQingViewController2 *lingJianXiangQingViewController2 = [[LingJianXiangQingViewController2 alloc] init];
                    lingJianXiangQingViewController2.isMatchDrawingCloud = [NSNumber numberWithInteger:1];
                    lingJianXiangQingViewController2.accDrawingInter = arrayAccDrawingInter[0];
                    [self.navigationController pushViewController:lingJianXiangQingViewController2 animated:YES];
                } else {
                    LoginModel *loginModel = [DatabaseTool getLoginModel];
                    NSString *sourceCaiOrGong;
                    if ([_inquiryOrder.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
                        sourceCaiOrGong = @"cai";
                    } else {
                        sourceCaiOrGong = @"gong";
                    }
                    PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
//                    partDetailsViewController.indexNum = 1;
                    partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
                    partDetailsViewController.enterpriseId = _inquiryOrder.member.enterpriseInfo.enterpriseId;
                    partDetailsViewController.inquiryType = _inquiryOrder.inquiryType;
                    partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
                    [self.navigationController pushViewController:partDetailsViewController animated:YES];
                }
            }
        } fail:^(NSError *error) {
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    } else {
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        NSString *sourceCaiOrGong;
        if ([_inquiryOrder.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
            sourceCaiOrGong = @"cai";
        } else {
            sourceCaiOrGong = @"gong";
        }
        PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
//        partDetailsViewController.indexNum = 1;
        partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
        partDetailsViewController.enterpriseId = _inquiryOrder.member.enterpriseInfo.enterpriseId;
        partDetailsViewController.inquiryType = _inquiryOrder.inquiryType;
        partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
        [self.navigationController pushViewController:partDetailsViewController animated:YES];
    }
}

- (void)buttonDetailClick:(UIButton *)sender {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    NSString *sourceCaiOrGong;
    if ([_inquiryOrder.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
        sourceCaiOrGong = @"cai";
    } else {
        sourceCaiOrGong = @"gong";
    }
    PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
    partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
    partDetailsViewController.enterpriseId = _inquiryOrder.member.enterpriseInfo.enterpriseId;
    partDetailsViewController.inquiryType = _inquiryOrder.inquiryType;
    partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
    
    [self.navigationController pushViewController:partDetailsViewController animated:YES];
}


#pragma mark button 不通过
- (IBAction)buttonClickBuTongHuo:(UIButton *)sender {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UIViewXuanZeYuanYing" owner:self options:nil];
    UIViewXuanZeYuanYing *viewXZYY = [nib objectAtIndex:0];
    viewXZYY.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewXZYY];
    viewXZYY.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [viewXZYY initPickerViewWithArray:@[@"供应商报价不合理",@"询盘内容需要调整",@"其它原因"] ButtonClick:^(NSString *string) {
        [self butongGuo:string];
    } buttonQuXiao:^{
        
    }];
}

- (void)butongGuo:(NSString *)string {
#pragma mark 采购商审批拒绝接口
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    TradeOrder *tradeOrder = [[TradeOrder alloc] init];
    tradeOrder.orderId = self.orderId;
    tradeOrder.confirmMsg = string;
    postEntityBean.entity = tradeOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_tradeOrder_purchase_purchaseRefuseOrder parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"不通过成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"不通过失败"];
        }
        [self.navigationController popViewControllerAnimated:true];
        [RefreshManager shareRefreshManager].eCInquiryVC = @"通知ECInquiryViewController刷新啦";
        //通知ECOrderViewController 刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshECOrder" object:nil userInfo:nil];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];

}
#pragma mark button 确认授盘
- (IBAction)buttonQueRenShouPan:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认授盘给该供应商？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self tongGuo];
    }];
    [alertController addAction:alertAction];
    [alertController addAction:alertAction1];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)tongGuo {
#pragma mark 采购商审批通过接口
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    TradeOrder *tradeOrder = [[TradeOrder alloc] init];
    tradeOrder.orderId = self.orderId;
    postEntityBean.entity = tradeOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;

    [HttpMamager postRequestWithURLString:DYZ_tradeOrder_purchase_purchaseApprovalOrder parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"审核授盘成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"审核授盘失败"];
        }
        [self.navigationController popViewControllerAnimated:true];
        [RefreshManager shareRefreshManager].eCInquiryVC = @"通知ECInquiryViewController刷新啦";
        //通知ECOrderViewController 刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshECOrder" object:nil userInfo:nil];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)initRequrst {
#pragma mark 查询询盘详细接口
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
    inquiryOrder.inquiryOrderId = self.inquiryOrderId;
    postEntityBean.entity =  inquiryOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_inquiry_purchase_detail parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            InquiryOrder *inquiryOrderHttp = [InquiryOrder mj_objectWithKeyValues:returnEntityBean.entity];
            EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
            postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
            QuotationOrder *quotationOrder = [[QuotationOrder alloc] init];
            quotationOrder.inquiryOrderId = inquiryOrderHttp.inquiryOrderId;//必传
            quotationOrder.quotationOrderId = inquiryOrderHttp.inquiryOrderEnterprises[0].quotationOrderId;//必传
            quotationOrder.sec_isNeedTempQuo = [NSNumber numberWithInteger:1];//必传
            postEntityBean.entity = quotationOrder.mj_keyValues;
            NSDictionary *dic = postEntityBean.mj_keyValues;
            
#pragma mark 采购商查询报价详情
            [HttpMamager postRequestWithURLString:DYZ_quo_purchase_detail parameters:dic success:^(id responseObjectModel) {
                ReturnListBean *returnListBean = responseObjectModel;
                
                _viewLoading.hidden = YES;
                if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                    _quotationOrderItems = [[NSMutableArray alloc] init];
                    _arrayInquiryOrderItemModel = [[NSMutableArray alloc] init];
                    _arrayYesOpen = [[NSMutableArray alloc] initWithCapacity:0];
                    QuotationOrder *quotationOrder =  [QuotationOrder mj_objectWithKeyValues:returnListBean.list[0]];
                    for (QuotationOrderItem *quotationOrderItem in quotationOrder.quotationOrderItems) {
                        [_quotationOrderItems addObject:quotationOrderItem];
                        [_arrayInquiryOrderItemModel addObject:quotationOrderItem.inquiryOrderItem];
                        [_arrayYesOpen addObject:@"no"];
                    }
                    _quotationOrder = quotationOrder;
                    _inquiryOrder = quotationOrder.inquiryOrder;
                    if ([_inquiryOrder.isQuotationTemplate integerValue] == 1) {
                        self.tableView.hidden = YES;
                        [self.tableView1 reloadData];
                    } else {
                        self.tableView1.hidden = YES;
                        [self.tableView reloadData];
                    }
                }
            } fail:^(NSError *error) {
                
            } isKindOfModel:NSClassFromString(@"ReturnListBean")];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

- (void)textFieldDone {
    
}

- (void)line:(UIView *)view withY:(CGFloat)y withTag:(NSInteger)tag{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, kMainW, 0.5)];
    label.tag = tag;
    label.backgroundColor = colorLine;
    [view addSubview:label];
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
