
//
//  ShouPanViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ShouPanViewController.h"
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
#import "ShouPanHeJiaViewController.h"

#import "UIButtonIM.h"
#import "PartDetailsViewController.h"
#import "LingJianXiangQingViewController2.h"
#import "NSArray+Transition.h"
#import "IMETabBarViewController.h"

#import "RefreshManager.h"
#import "GlobalSettingManager.h"

@interface ShouPanViewController () <UITableViewDelegate,UITableViewDataSource,EChaKanXieYiControllerDelegate,UITextViewDelegate> {
    NSMutableArray *_arrayInquiryOrderItemModel;
    NSMutableArray *_quotationOrderItems;
    NSMutableArray *_arrayYesOpen;
    NSInteger _integerButtonLineColor;

    UIView *_viewLoading;
    QuotationOrder *_quotationOrder;
    InquiryOrder *_inquiryOrder;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *buttonBiJiaShouPan;
@property (weak, nonatomic) IBOutlet UIButton *buttonQueRenShouPan;
@property (weak, nonatomic) IBOutlet UIButton *button1QueRenShouPan;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation ShouPanViewController

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
    

    self.viewBG0.hidden = YES;
    self.viewBG1.hidden = YES;
  
    
    
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
    
    
    self.textView.delegate = self;
    [self textViewDidChange:self.textView];
    self.textView.inputAccessoryView = [self addToolbar];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    [self initRequrst];
    

#pragma mark 帮助页 button help4
//    NSDictionary *dicHelp =  [[NSUserDefaults standardUserDefaults] objectForKey:@"hangZhuYeDic"];
//    if ([dicHelp[@"help4"] isEqualToString:@"no"]) {
//        UIButton *buttonHelp = [UIButton buttonWithType:UIButtonTypeCustom];
//        buttonHelp.frame = CGRectMake(0, 0, kMainW, kMainH);
//        [buttonHelp setBackgroundImage:[UIImage imageNamed:@"ime_help_offer_02"] forState:UIControlStateNormal];
//        [buttonHelp addTarget:self action:@selector(buttonHelpClick:) forControlEvents:UIControlEventTouchUpInside];
//        buttonHelp.adjustsImageWhenHighlighted = NO;
//        [[UIApplication sharedApplication].keyWindow addSubview:buttonHelp];
//    }
    
    
}
#pragma mark 帮助页 点击事件
//- (void)buttonHelpClick:(UIButton *)sender{
//    NSDictionary *dicHelp =  [[NSUserDefaults standardUserDefaults] objectForKey:@"hangZhuYeDic"];
//    NSMutableDictionary *muDicHelp = [NSMutableDictionary dictionaryWithDictionary:dicHelp];
//    [muDicHelp setValue:@"yes" forKey:@"help4"];
//    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:muDicHelp
//                                                      ] forKey:@"hangZhuYeDic"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [sender removeFromSuperview];
//}

- (void)initRequrst {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    QuotationOrder *quotationOrder = [[QuotationOrder alloc] init];
    quotationOrder.inquiryOrderId = self.inquiryOrderId;//必传
    quotationOrder.quotationOrderId = self.quotationOrderId;//必传
    quotationOrder.sec_isNeedTempQuo = [NSNumber numberWithInteger:1];//必传
    postEntityBean.entity = quotationOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;    
    [HttpMamager postRequestWithURLString:DYZ_quo_purchase_detail parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
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
            
            _viewLoading.hidden = YES;
            
            if ([_inquiryOrder.isQuotationTemplate integerValue] == 1) {
                self.tableView.hidden = YES;
                [self.tableView1 reloadData];
            } else {
                self.tableView1.hidden = YES;
                [self.tableView reloadData];
            }
            
            self.buttonQueRenShouPan.backgroundColor = colorRGB(255, 132, 0);
            self.button1QueRenShouPan.backgroundColor = colorRGB(255, 132, 0);
      
            self.buttonBiJiaShouPan.hidden = YES;
            self.buttonQueRenShouPan.hidden = YES;
            self.button1QueRenShouPan.hidden = YES;
            if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"] || [_inquiryOrder.inquiryType isEqualToString:@"COM"]) {
                self.buttonBiJiaShouPan.hidden = NO;
                self.buttonQueRenShouPan.hidden = NO;
            }
//            if ([_inquiryOrder.inquiryType isEqualToString:@"COM"]) {
//                self.button1QueRenShouPan.hidden = NO;
//            }
            NSLog(@">>%ld",[_inquiryOrder.isOfflineSign integerValue]);
        } else {
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.textViewText.hidden = YES;
    } else {
        self.textViewText.hidden = NO;
    }
    
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
            if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                view.label0.text = @"****";
            } else {
                view.label0.text  = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:nil;
            }
            
            
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 integerValue]*[quotationOrderItem.price1 doubleValue];
            if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                view.label1.text = @"****";
            } else {
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
            if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                view.label0.text = @"****";
            } else {
                view.label0.text  = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:nil;
            }
            
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 integerValue]*[quotationOrderItem.price1 doubleValue];
            if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                view.label1.text = @"****";
            } else {
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
                    cell.label2.text = @"****";
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
                if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                    cell.zongChaKanlabel2.text = @"****";
                } else {
                    cell.zongChaKanlabel2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:@"0.00";
                }
               
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
                    cell.label2.text = @"****";
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
                    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                        cell.label1.text = @"****";
                    } else {
                        cell.label1.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:@"0.00";
                    }
                    
                    if (_integerButtonLineColor == 0) {
                        cell.label1.textColor = colorRGB(255, 151, 0);
                    } else if (_integerButtonLineColor == 1) {
                       
                    } else if (_integerButtonLineColor == 2) {
                        
                    }
                    
                } else if (indexPath.row == 2+[_inquiryOrder.tempPriceDetailCount integerValue]+1) {
                    cell.label0.text = @"不含税单价";
                    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                        cell.label1.text = @"****";
                    } else {
                        cell.label1.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:@"0.00";
                    }
                    
                    
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
                    if ([_inquiryOrder.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采购商身份进来
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
        if ([_inquiryOrder.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采购商身份进来
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
    if ([_inquiryOrder.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采购商身份进来
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

#pragma mark EChaKanXieYiControllerDelegate
- (void)tongYiXieYiEChaKanXieYiControllerDelegate {

}
- (void)buTongYiXieYiEChaKanXieYiControllerDelegate {

}

#pragma mark button 选择该数量授盘
- (IBAction)xunZeGaiShuLiangShouPan:(UIButton *)sender {
 
    self.viewBG0.hidden = NO;
    self.viewBG1.hidden = NO;
    [self.textView becomeFirstResponder];
    UILabel *label = [self.view viewWithTag:921125];
    label.hidden = YES;

}


- (IBAction)buttonQuXiao:(UIButton *)sender {//取消
    self.viewBG0.hidden = YES;
    self.viewBG1.hidden = YES;
    [self.textView resignFirstResponder];
    UILabel *label = [self.view viewWithTag:921125];
    label.hidden = NO;
}

#pragma mark 授盘
- (IBAction)buttonShouPan:(UIButton *)sender {//授盘
    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:23]]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
        return;
    }
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    QuotationOrder *quotationOrder = [[QuotationOrder alloc] init];
    quotationOrder.sec_isDesignated = [NSNumber numberWithInteger:0];
    quotationOrder.quotationOrderId = _quotationOrder.quotationOrderId;
    quotationOrder.purchaseSubtotalPrice1 = _quotationOrder.subtotalPrice1;
    quotationOrder.purchaseTotalPrice1 = _quotationOrder.subtotalPrice1;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    quotationOrder.sec_tradeOrderTime = [formatter stringFromDate:[NSDate date]];
    
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:0];
    for (QuotationOrderItem *item in _quotationOrder.quotationOrderItems) {
        QuotationOrderItem *itemNew = [[QuotationOrderItem alloc] init];
        itemNew.quotationOrderItemId = item.quotationOrderItemId;
        itemNew.purchaseRemark = @"";
        itemNew.purchaseDeliverTime = item.supplierDeliverTime;
        itemNew.purchasePrice1 = item.price1;
        itemNew.purchaseTempPrice1DetailValue1 = item.supplierTempPrice1DetailValue1;
        itemNew.purchaseTempPrice1DetailValue2 = item.supplierTempPrice1DetailValue2;
        itemNew.purchaseTempPrice1DetailValue3 = item.supplierTempPrice1DetailValue3;
        itemNew.purchaseTempPrice1DetailValue4 = item.supplierTempPrice1DetailValue4;
        itemNew.purchaseTempPrice1DetailValue5 = item.supplierTempPrice1DetailValue5;
        itemNew.purchaseTempPrice1DetailValue6 = item.supplierTempPrice1DetailValue6;
        itemNew.purchaseTempPrice1DetailValue7 = item.supplierTempPrice1DetailValue7;
        itemNew.purchaseTempPrice1DetailValue8 = item.supplierTempPrice1DetailValue8;
        itemNew.purchaseTempPrice1DetailValue9 = item.supplierTempPrice1DetailValue9;
        itemNew.purchaseTempPrice1DetailValue10 = item.supplierTempPrice1DetailValue10;
        itemNew.purchaseTempPrice1DetailValue11 = item.supplierTempPrice1DetailValue11;
        itemNew.purchaseTempPrice1DetailValue12 = item.supplierTempPrice1DetailValue12;
        itemNew.purchaseTempPrice1DetailValue13 = item.supplierTempPrice1DetailValue13;
        itemNew.purchaseTempPrice1DetailValue14 = item.supplierTempPrice1DetailValue14;
        itemNew.purchaseTempPrice1DetailValue15 = item.supplierTempPrice1DetailValue15;
        itemNew.purchaseTempPrice1DetailValue16 = item.supplierTempPrice1DetailValue16;
        itemNew.purchaseTempPrice1DetailValue17 = item.supplierTempPrice1DetailValue17;
        itemNew.purchaseTempPrice1DetailValue18 = item.supplierTempPrice1DetailValue18;
        itemNew.purchaseTempPrice1DetailValue19 = item.supplierTempPrice1DetailValue19;
        [itemArray addObject:itemNew];
    }
    quotationOrder.quotationOrderItems = itemArray;
    
    postEntityBean.entity = quotationOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    

    
    [HttpMamager postRequestWithURLString:DYZ_inquiry_purchase_send parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"授盘成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"授盘失败"];
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
                if ([vc isKindOfClass:[IMETabBarViewController class]]) {
                    IMETabBarViewController *tab = (IMETabBarViewController *)vc;
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
#pragma mark 核价授盘
- (IBAction)buttonCheckConferInquiry:(id)sender {
    ShouPanHeJiaViewController *vc = [[ShouPanHeJiaViewController alloc] init];
    vc.quotationOrderId = _quotationOrder.quotationOrderId;
    vc.inquiryOrderId = _quotationOrder.inquiryOrderId;
    [self.navigationController pushViewController:vc animated:YES];
}


- (UIToolbar *)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 38)];
    toolbar.tintColor = colorRGB(0, 168, 255);
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space,bar];
    return toolbar;
}

- (void)textFieldDone {
    [self.textView resignFirstResponder];
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
