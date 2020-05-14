//
//  ShenHeShouPanDingJiaViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ShenHeShouPanDingJiaViewController.h"
#import "VoHeader.h"

#import "BaoJiaDingJiaCell.h"
#import "BaoJiaDingJiaCell1.h"

#import "MXBaoJiaCell01.h"
#import "BaoJiaHeaderView01.h"
#import "MXBaoJiaCell02.h"
#import "YiJiaEGChaKanShouPanCell00.h"
#import "MXBaoJiaCell05.h"
#import "MXBaoJiaCell111.h"
#import "MingXiQueRenBaoJia02.h"


#import "Masonry.h"


#import "QiYeXinXiXiangQingViewController.h"
#import "XunPanXiangQingViewController.h"

#import "CommentUtils.h"
#import "EGOrderViewController.h"

#import "ECInquiryViewController.h"



#import "UIButtonIM.h"

#import "NSArray+Transition.h"

#import "LingJianXiangQingViewController2.h"
#import "PartDetailsViewController.h"
#import "UIViewXuanZeYuanYing.h"
#import "RefreshManager.h"

@interface ShenHeShouPanDingJiaViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayInquiryOrderItemModel;
    NSMutableArray *_quotationOrderItems;
    NSMutableArray *_arrayYesOpen;
    
    NSInteger _integerButtonLineColor;
    QuotationOrder *_quotationOrderHttp;
    
    InquiryOrder *_inquiryOrderHttp;
    
    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (weak, nonatomic) IBOutlet UIButton *buttonBuTongGuoL;//不通过L   小
@property (weak, nonatomic) IBOutlet UIButton *buttonTongGuoR;//通过R      小
@property (weak, nonatomic) IBOutlet UIButton *buttonBuTongGuo;//不通过    大
@property (weak, nonatomic) IBOutlet UIButton *buttonTongGuo;//通过       大

@end

@implementation ShenHeShouPanDingJiaViewController

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
    
   

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell01" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell02" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell02"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaoJiaHeaderView01" bundle:nil] forHeaderFooterViewReuseIdentifier:@"baoJiaHeaderView01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell05" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell05"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaEGChaKanShouPanCell00" bundle:nil] forCellReuseIdentifier:@"yiJiaEGChaKanShouPanCell00"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia02" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia02"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.hidden = YES;
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    
//    self.buttonBuTongGuoL.hidden = YES;
//    self.buttonTongGuoR.hidden = YES;
    self.buttonBuTongGuo.hidden = YES;
    self.buttonTongGuo.hidden = YES;

    
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
    inquiryOrder.inquiryOrderId = self.inquiryOrder.inquiryOrderId;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    QuotationOrder *quotationOrder = [[QuotationOrder alloc] init];
    quotationOrder.manufacturerId = loginModel.manufacturerId;
    inquiryOrder.manufacturerId = loginModel.manufacturerId;
    
    inquiryOrder.quotationOrder = quotationOrder;
    
    PurchaseProject *purchaseProject = [[PurchaseProject alloc] init];
    
    inquiryOrder.project = purchaseProject;
    
    postEntityBean.entity = inquiryOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_inquiry_detail parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        _viewLoading.hidden = YES;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _inquiryOrderHttp = [InquiryOrder mj_objectWithKeyValues:model.entity];
            
            _arrayInquiryOrderItemModel = _inquiryOrderHttp.inquiryOrderItems;
            
            _quotationOrderItems = [[NSMutableArray alloc] init];
            _arrayYesOpen = [[NSMutableArray alloc] initWithCapacity:0];
            for (InquiryOrderItem *item in _arrayInquiryOrderItemModel) {
                QuotationOrderItem *quotationOrderItem = [[QuotationOrderItem alloc] init];
                
                [_quotationOrderItems addObject:quotationOrderItem];
                [_arrayYesOpen addObject:@"no"];
            }
            
            [self.tableView reloadData];
            self.tableView.hidden = NO;
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    
    
    
    
//    _quotationOrderHttp = quotationOrderItem.quotationOrder;
    

    _integerButtonLineColor = [_quotationOrderHttp.dealIndex integerValue]-1;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
//        return 1+1+2+1;
        return 1;
    } else if (section == 2) {
        return 0;
    } else if (section < 1+1+1+_quotationOrderItems.count) {
        NSString *string = _arrayYesOpen[section-3];
        if ([string isEqualToString:@"no"]) {
            return 0;
        } else {
//            return 1;
            return 1+2;
        }
    } else if (section == 1+1+1+_quotationOrderItems.count) {
        return 1;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 68;
    } else if (indexPath.section == 1) {
        return 40;
    } else if (indexPath.section == 2) {
        return 0;
    } else if (indexPath.section < 1+1+1+_quotationOrderItems.count) {
        if (indexPath.row == 0) {
            return 265;
        } else if (indexPath.section <= 1+_quotationOrderItems.count+2) {
            return 40;
        } else {
            return 0;
        }
    } else if (indexPath.section == 1+1+1+_quotationOrderItems.count) {
        return 56;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1+1+1+_quotationOrderItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
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
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
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
        labelTitle1.text = _inquiryOrderHttp.title;
        labelTitle1.textAlignment = NSTextAlignmentRight;
        [view addSubview:labelTitle1];
        
        return view;
    } else if (section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
        view.backgroundColor = colorRGB(241, 241, 241);
        
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
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UIColor *color;
        if ([_quotationOrderHttp.manufacturerId isEqualToString:loginModel.manufacturerId]) {
            color = colorGong;//蓝色
        } else {
            color = colorCai;
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
        view.label00.textColor = color;
        view.label0.textColor = color;
        view.label0.text  = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:nil;
        
        double totalPrice = 0;
        totalPrice = [quotationOrderItem.num1 integerValue]*[quotationOrderItem.price1 doubleValue];
        view.label1.text = [NSString stringWithFormat:@"%.2f",totalPrice];
        
        view.label2.text  = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
        view.label2DanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
        
        
        view.label0Wei.text = @"待审核";
        view.label0Wei.textColor = color;
        view.label1Wei.text = [NSString stringWithFormat:@"%@",model.num1];
        view.label1WeiDanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
        
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        UIImageView *imageViewH = [[UIImageView alloc] init];
        [cell.contentView addSubview:imageViewH];
        [imageViewH mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).with.offset(10);
            make.top.equalTo(cell.contentView.mas_top).with.offset(10);
            make.width.mas_equalTo(48);
            make.height.mas_equalTo(48);
        }];
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.textColor = colorRGB(32, 32, 32);
        [cell.contentView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageViewH.mas_right).with.offset(10);
            make.top.equalTo(imageViewH.mas_top).with.offset(5);
            make.right.equalTo(cell.mas_right).with.offset(-83-5);
        }];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.textColor = colorRGB(117, 117, 117);
        label2.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageViewH.mas_right).with.offset(10);
            make.top.equalTo(label1.mas_bottom).with.offset(3);
        }];
        
        
        [imageViewH sd_setImageWithURL:[NSURL URLWithString:_inquiryOrderHttp.inquiryOrderEnterprises[0].enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
        
        label2.text = [NSString stringWithFormat:@"%@ %@",_inquiryOrderHttp.inquiryOrderEnterprises[0].enterpriseInfo.province?_inquiryOrderHttp.inquiryOrderEnterprises[0].enterpriseInfo.province:@"",_inquiryOrderHttp.inquiryOrderEnterprises[0].enterpriseInfo.city?_inquiryOrderHttp.inquiryOrderEnterprises[0].enterpriseInfo.city:@""];
        label1.text = _inquiryOrderHttp.inquiryOrderEnterprises[0].enterpriseInfo.enterpriseName;
        
  
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//            MXBaoJiaCell02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell02" forIndexPath:indexPath];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            LoginModel *loginModel = [DatabaseTool getLoginModel];
//            UIColor *color;
//            if ([_quotationOrderHttp.manufacturerId isEqualToString:loginModel.manufacturerId]) {
//                color = colorGong;//蓝色
//            } else {
//                color = colorCai;
//            }
//            cell.viewRight.backgroundColor = [color colorWithAlphaComponent:0.05];
//            cell.labelRight.text = @"授盘价";
//            return cell;
//        } else if (indexPath.row < 1+1+2) {
//            YiJiaEGChaKanShouPanCell00 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaEGChaKanShouPanCell00" forIndexPath:indexPath];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            if (indexPath.row == 1) {
//
//                cell.label0.text = [NSString stringWithFormat:@"小计\n(共%ld种零件)",_quotationOrderItems.count];;
//                cell.label1.text = [NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.subtotalPrice1 doubleValue]];
//            } else if (indexPath.row < 1+1+1) {
//                cell.label0.text = @"杂费";
//                cell.label1.text = [NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.cost1 doubleValue]];
//            } else {
//                cell.label0.text = @"运费";
//                cell.label1.text = [NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.shipPrice1 doubleValue]];
//            }
//            return cell;
//        } else if (indexPath.row == 1+1+2) {
//            MXBaoJiaCell05 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell05" forIndexPath:indexPath];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            LoginModel *loginModel = [DatabaseTool getLoginModel];
//            UIColor *color;
//            if ([_quotationOrderHttp.manufacturerId isEqualToString:loginModel.manufacturerId]) {
//                color = colorGong;//蓝色
//            } else {
//                color = colorCai;
//            }
//            cell.viewLeft.backgroundColor = [color colorWithAlphaComponent:0.05];
//            NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrderHttp.supplierTaxRate doubleValue]*100];
//            cell.labelLeft.text = [NSString stringWithFormat:@"总计\n(含税价%@%@)",stringTaxRate,@"%"];
//            cell.labelRight.text = [NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.totalPrice1 doubleValue]];
//            return cell;
//        } else {
//            return nil;
//        }
        if (indexPath.row == 0) {
            MXBaoJiaCell111 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell111" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrderHttp.supplierTaxRate doubleValue]*100];
//            cell.label0.text = [NSString stringWithFormat:@"总计(含税价%@%@)",stringTaxRate,@"%"];
            cell.label0.text = @"未税总计";
            cell.label2.text = _quotationOrderHttp.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.totalPrice1 doubleValue]]:@"0.00";
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
            
            cell.viewZanBuBaoJia.hidden = YES;
            cell.buttonZanBuBaoJia.hidden = YES;
            cell.viewZongjia.hidden = YES;
            
            
            cell.viewZongChaKan.hidden = YES;
            cell.viewZongChaKan.hidden = NO;
            
            
            InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 3];
            QuotationOrderItem *quotationOrderItem =  _quotationOrderItems[indexPath.section - 3];
            
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
                
                NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_inquiryOrderHttp.member.enterpriseInfo.enterpriseId,inquiryOrderItem.partNumber,inquiryOrderItem.picVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
            }
            
            NSString *batchDeliverItem = [[inquiryOrderItem.deliveryTime componentsSeparatedByString:@" "] firstObject];
            cell.labelDaoHuoTime.text = [NSString stringWithFormat:@"交货日期:%@",batchDeliverItem];
            
            cell.buttonClose.tag = indexPath.section - 3;
            [cell.buttonClose addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.buttonClose1.tag = indexPath.section - 3;
            [cell.buttonClose1 addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.buttonImage.tag = indexPath.section - 3;
            [cell.buttonImage addTarget:self action:@selector(buttonImageClick:) forControlEvents:UIControlEventTouchUpInside];
            
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            UIColor *color;
            if ([_quotationOrderHttp.manufacturerId isEqualToString:loginModel.manufacturerId]) {
                color = colorRGB(0, 168, 255);//蓝色
            } else {
                color = colorRGB(255, 132, 0);
            }
            
            cell.buttonDetail.tag = indexPath.section - 3;
            [cell.buttonDetail setTitleColor:color forState:UIControlStateNormal];
            [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.zongChaKanlabel0.text = @"授盘价:";
            cell.zongChaKanlabel1.textColor = color;
            cell.zongChaKanlabel2.textColor = color;
            cell.zongChaKanlabel2.text = inquiryOrderItem.price1?[NSString stringWithFormat:@"%.2f",[inquiryOrderItem.price1 doubleValue]]:@"0.00";
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
            if (view.tag == 19921126) {
                [view removeFromSuperview];
            }
        }
        CGFloat h;
        if (_quotationOrderHttp.remark) {
            CGSize size = [_quotationOrderHttp.remark boundingRectWithSize:CGSizeMake(kMainW-20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
            h = size.height + 15;
        } else {
            h = 30;
        }
        UILabel *labelBeiZhuContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kMainW-20, h)];
        labelBeiZhuContent.tag = 19921126;
        labelBeiZhuContent.font = [UIFont systemFontOfSize:15];
        labelBeiZhuContent.numberOfLines = 0;
        if (_quotationOrderHttp.remark.length > 0) {
            labelBeiZhuContent.text = _quotationOrderHttp.remark;
        } else {
            labelBeiZhuContent.text = @"暂无备注";
        }
        labelBeiZhuContent.textColor = colorRGB(117, 117, 117);
        [cell.contentView addSubview:labelBeiZhuContent];
        
        return cell;
    } else {
        return nil;
    }
}

- (void)buttonOpenClick:(UIButton *)sender {
    [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"yes"];
    [_tableView reloadData];
}

- (void)buttonCloseClick:(UIButton *)sender {
    [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"no"];
    [_tableView reloadData];
}

- (void)buttonImageClick:(UIButton *)sender {
    InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
    NSLog(@">>>%ld<",inquiryOrderItem.inquiryOrderItemFiles.count);
    
    if (inquiryOrderItem.inquiryOrderItemFiles.count == 1) {
        LingJianXiangQingViewController2 *lingJianXiangQingViewController2 = [[LingJianXiangQingViewController2 alloc] init];
        lingJianXiangQingViewController2.isMatchDrawingCloud = inquiryOrderItem.isMatchDrawingCloud;
        lingJianXiangQingViewController2.inquiryOrderItemFile = inquiryOrderItem.inquiryOrderItemFiles[0];
        [self.navigationController pushViewController:lingJianXiangQingViewController2 animated:YES];
    } else if ([inquiryOrderItem.isMatchDrawingCloud integerValue] == 1) {
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        PurchaseProjectInfo *purchaseProjectInfo = [[PurchaseProjectInfo alloc] init];
        purchaseProjectInfo.sec_enterpriseId = _inquiryOrderHttp.member.enterpriseInfo.enterpriseId;
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
                    if ([_inquiryOrderHttp.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采购商身份进来
                        sourceCaiOrGong = @"cai";
                    } else {
                        sourceCaiOrGong = @"gong";
                    }
                    PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
                    //                    partDetailsViewController.indexNum = 1;
                    partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
                    partDetailsViewController.enterpriseId = _inquiryOrderHttp.member.enterpriseInfo.enterpriseId;
                    partDetailsViewController.inquiryType = _inquiryOrderHttp.inquiryType;
                    partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
                    [self.navigationController pushViewController:partDetailsViewController animated:YES];
                }
            }
        } fail:^(NSError *error) {
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    } else {
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        NSString *sourceCaiOrGong;
        if ([_inquiryOrderHttp.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采购商身份进来
            sourceCaiOrGong = @"cai";
        } else {
            sourceCaiOrGong = @"gong";
        }
        PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
        //        partDetailsViewController.indexNum = 1;
        partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
        partDetailsViewController.enterpriseId = _inquiryOrderHttp.member.enterpriseInfo.enterpriseId;
        partDetailsViewController.inquiryType = _inquiryOrderHttp.inquiryType;
        partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
        [self.navigationController pushViewController:partDetailsViewController animated:YES];
    }
}

- (void)buttonDetailClick:(UIButton *)sender {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    NSString *sourceCaiOrGong;
    if ([_inquiryOrderHttp.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采购商身份进来
        sourceCaiOrGong = @"cai";
    } else {
        sourceCaiOrGong = @"gong";
    }
    PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
    partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
    partDetailsViewController.enterpriseId = _inquiryOrderHttp.member.enterpriseInfo.enterpriseId;
    partDetailsViewController.inquiryType = _inquiryOrderHttp.inquiryType;
    partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
    
    [self.navigationController pushViewController:partDetailsViewController animated:YES];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        QiYeXinXiXiangQingViewController *qyxxxqVC = [[QiYeXinXiXiangQingViewController alloc] init];
        qyxxxqVC.enterpriseInfo = _inquiryOrderHttp.inquiryOrderEnterprises[0].enterpriseInfo;
        qyxxxqVC.isPrivate = _inquiryOrderHttp.isPrivate;
        qyxxxqVC.ucenterId = _inquiryOrderHttp.member.ucenterId;//
        qyxxxqVC.passiveId = _inquiryOrderHttp.member.manufacturerId;//
        qyxxxqVC.quotationOrderStatus = _quotationOrderHttp.status;//
        qyxxxqVC.caiOrGong = @"gong";
        [self.navigationController pushViewController:qyxxxqVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
    inquiryOrder.inquiryOrderId = _inquiryOrderHttp.inquiryOrderId;
    inquiryOrder.manufacturerId = loginModel.manufacturerId;
    inquiryOrder.confirmStatus = [NSNumber numberWithInteger:0];
    inquiryOrder.confirmId = loginModel.memberId;
    inquiryOrder.confirmName = loginModel.accountName;
    inquiryOrder.confirmMsg = string;
    
    postEntityBean.memberId = loginModel.memberId;
    
    postEntityBean.entity = inquiryOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_inquiry_confirm_refuse parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"不通过成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"不通过失败"];
        }
        
        BOOL isBreak = false;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isMemberOfClass:[XunPanXiangQingViewController class]]) {
                isBreak = true;
                
                [self.navigationController popToViewController:vc animated:YES];
                
                [RefreshManager shareRefreshManager].eCInquiryVC = @"通知ECInquiryViewController刷新啦";
                break;
                
            }
        }
        
        if (!isBreak) {
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[UITabBarController class]]) {
                    UITabBarController *tab = (UITabBarController *)vc;
                    if ([tab.viewControllers[0] isMemberOfClass:[ECInquiryViewController class]]) {
                        tab.selectedIndex = 0;
                        [self.navigationController popToViewController:vc animated:YES];
                        
                        [RefreshManager shareRefreshManager].eCInquiryVC = @"通知ECInquiryViewController刷新啦";
                        break;
                    }
                }
            }
        }
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
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
    inquiryOrder.inquiryOrderId = _inquiryOrderHttp.inquiryOrderId;
    inquiryOrder.manufacturerId = loginModel.manufacturerId;
    inquiryOrder.confirmStatus = [NSNumber numberWithInteger:1];
    inquiryOrder.confirmId = loginModel.memberId;
    inquiryOrder.confirmName = loginModel.accountName;
    
    postEntityBean.memberId = loginModel.memberId;
    
    postEntityBean.entity = inquiryOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_inquiry_confirm_consent parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"审核授盘成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"审核授盘失败"];
        }
        
        BOOL isBreak = false;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isMemberOfClass:[XunPanXiangQingViewController class]]) {
                isBreak = true;
                
                [self.navigationController popToViewController:vc animated:YES];
                
                [RefreshManager shareRefreshManager].eCInquiryVC = @"通知ECInquiryViewController刷新啦";
                break;
                
            }
        }
        
        if (!isBreak) {
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[UITabBarController class]]) {
                    UITabBarController *tab = (UITabBarController *)vc;
                    if ([tab.viewControllers[0] isMemberOfClass:[ECInquiryViewController class]]) {
                        tab.selectedIndex = 0;
                        [self.navigationController popToViewController:vc animated:YES];
                        
                        [RefreshManager shareRefreshManager].eCInquiryVC = @"通知ECInquiryViewController刷新啦";
                        break;
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}


- (void)buttonNum:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    _integerButtonLineColor = sender.tag-100;
    [self.tableView reloadData];
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
