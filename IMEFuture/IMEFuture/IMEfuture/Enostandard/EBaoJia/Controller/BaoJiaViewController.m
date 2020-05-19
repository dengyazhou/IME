//
//  BaoJiaViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/13.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaoJiaViewController.h"
#import "VoHeader.h"
#import "EChooseTaxRateView.h"


#import "MXBaoJiaCell01.h"
#import "MXBaoJiaCell011.h"
#import "MXBaoJiaCell02.h"
#import "MXBaoJiaCell03.h"
#import "MXBaoJiaCell04.h"
#import "MXBaoJiaCell05.h"
#import "MXBaoJiaCell11.h"
#import "MXBaoJiaCell12.h"
#import "MXBaoJiaCell13.h"
#import "MXBaoJiaCell06.h"
#import "MXBaoJiaCell07.h"
#import "MXBaoJiaCell111.h"
#import "BaoJiaHeaderView01.h"

#import "BaoJiaViewController4.h"


#import "PartDetailsViewController.h"

#import "EChooseTaxRateView5Kind.h"
#import "LingJianXiangQingViewController2.h"
#import "NSArray+Transition.h"

#import "EChooseSkipRemarkView3Kind.h"

#import "UIViewXuanZeYaoQiuDaoHuoRiQi.h"
#import "RefreshManager.h"
#import "GlobalSettingManager.h"

@interface BaoJiaViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,EChooseTaxRateViewDeegate> {
    NSMutableArray *_arrayYesOpen;
    
    UILabel *_placeHolder;
    NSMutableArray *_arrayInquiryOrderItemModel;
    QuotationOrder *_quotationOrder;
    
    EChooseTaxRateView *_eChooseTaxRateView;
    double _supplierTaxRateTemp;
    
    UIView *_viewLoading;
    
    
    EChooseTaxRateView5Kind *_eChooseTaxRateView5Kind;
    EChooseSkipRemarkView3Kind *_eChooseSkipRemarkView3Kind;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (nonatomic,strong)InquiryOrder *inquiryOrderModel;

@property (nonatomic,strong) UIButton *buttonCheckToConfirm;

@property (weak, nonatomic) IBOutlet UIButton *buttonCheckToConfirm0;
@property (weak, nonatomic) IBOutlet UIButton *buttonCheckToConfirm1;
@property (weak, nonatomic) IBOutlet UIButton *buttonNoQuotation;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation BaoJiaViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([self.inquiryOrderModel.inquiryType isEqualToString:@"COM"]||[self.inquiryOrderModel.inquiryType isEqualToString:@"DIR"]) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"enterpriseNameDic"];
        NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithDictionary:dic];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        NSString *str = [dicM objectForKey:loginModel.enterpriseName];
        if ([str isEqualToString:@""]) {
            MemberResBean * member = [GlobalSettingManager shareGlobalSettingManager].member;
            _quotationOrder.supplierTaxRate = member.enterpriseInfo.supplierTaxRate;
            _supplierTaxRateTemp = [_quotationOrder.supplierTaxRate doubleValue];
            
            if ([_quotationOrder.supplierTaxRate doubleValue] == 0.13) {
                _eChooseTaxRateView = [[EChooseTaxRateView alloc] initWithFrame:self.view.frame withImageName0:@"label_circle_2t" withImageName1:@"label_circle"];
                _eChooseTaxRateView.delegate = self;
                [self.view addSubview:_eChooseTaxRateView];
            }
            if ([_quotationOrder.supplierTaxRate doubleValue] == 0.03) {
                _eChooseTaxRateView = [[EChooseTaxRateView alloc] initWithFrame:self.view.frame withImageName0:@"label_circle" withImageName1:@"label_circle_2t"];
                _eChooseTaxRateView.delegate = self;
                [self.view addSubview:_eChooseTaxRateView];
            }
            
            [dicM setObject:[_quotationOrder.supplierTaxRate stringValue] forKey:loginModel.enterpriseName];
            [[NSUserDefaults standardUserDefaults] setObject:dicM forKey:@"enterpriseNameDic"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } else {
            _quotationOrder.supplierTaxRate = [NSNumber numberWithDouble:[str doubleValue]];
            _supplierTaxRateTemp = [str doubleValue];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.inquiryOrderCodeAndTitle.text = @"询盘报价";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellSection2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell01" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell011" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell011"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell02" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell02"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell03" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell03"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell04" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell04"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell05" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell05"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell11" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell11"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell12" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell12"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell13" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell13"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaoJiaHeaderView01" bundle:nil] forHeaderFooterViewReuseIdentifier:@"baoJiaHeaderView01"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消tableView每个Cell的线
    self.tableView.tag = 88;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [self.tableView addGestureRecognizer:tap];
    
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    [self.tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellSection2"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell01" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell01"];

    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell02" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell02"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell03" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell03"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell04" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell04"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell05" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell05"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell06" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell06"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell07" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell07"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell11" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell11"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell12" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell12"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell13" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell13"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"BaoJiaHeaderView01" bundle:nil] forHeaderFooterViewReuseIdentifier:@"baoJiaHeaderView01"];
    
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;//取消tableView每个Cell的线
    self.tableView1.tag = 89;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [self.tableView1 addGestureRecognizer:tap1];
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    [self initRequestInquirySupplierDetail];
    
    
    
#pragma mark 帮助页 button help2
    NSDictionary *dicHelp =  [[NSUserDefaults standardUserDefaults] objectForKey:@"hangZhuYeDic"];
    if ([dicHelp[@"help2"] isEqualToString:@"no"]) {
        UIButton *buttonHelp = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonHelp.frame = CGRectMake(0, 0, kMainW, kMainH);
        [buttonHelp setBackgroundImage:[UIImage imageNamed:@"ime_help_offer_03"] forState:UIControlStateNormal];
        [buttonHelp addTarget:self action:@selector(buttonHelpClick:) forControlEvents:UIControlEventTouchUpInside];
        buttonHelp.adjustsImageWhenHighlighted = NO;
        [[UIApplication sharedApplication].keyWindow addSubview:buttonHelp];
    }
    
}

#pragma mark EChooseTaxRateViewDeegate
- (void)eChooseTaxRateViewButton:(UIButton *)sender {
    if (sender.tag == 0) {
        _quotationOrder.supplierTaxRate = [NSNumber numberWithDouble:_supplierTaxRateTemp];
        [_eChooseTaxRateView removeFromSuperview];
        _eChooseTaxRateView = nil;
        
        if ([self.inquiryOrderModel.isQuotationTemplate integerValue] == 1) {
            [_tableView1 reloadData];
        } else {
            [_tableView reloadData];
        }
        
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"enterpriseNameDic"];
        NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithDictionary:dic];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        [dicM setObject:[_quotationOrder.supplierTaxRate stringValue] forKey:loginModel.enterpriseName];
        [[NSUserDefaults standardUserDefaults] setObject:dicM forKey:@"enterpriseNameDic"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (sender.tag == 1) {
        _supplierTaxRateTemp = 0.13;
    }
    if (sender.tag == 2) {
        _supplierTaxRateTemp = 0.03;
    }
}

- (void)eChooseTaxRateViewTapSelector {
    [_eChooseTaxRateView removeFromSuperview];
    _eChooseTaxRateView = nil;
}

#pragma mark 帮助页 点击事件
- (void)buttonHelpClick:(UIButton *)sender{
    NSDictionary *dicHelp =  [[NSUserDefaults standardUserDefaults] objectForKey:@"hangZhuYeDic"];
    NSMutableDictionary *muDicHelp = [NSMutableDictionary dictionaryWithDictionary:dicHelp];
    [muDicHelp setValue:@"yes" forKey:@"help2"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:muDicHelp] forKey:@"hangZhuYeDic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [sender removeFromSuperview];
}

- (void)tapSelector:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 65;
        self.tableViewBottom1.constant = 65;
    } else {
        self.tableViewBottom.constant = rect.size.height;
        self.tableViewBottom1.constant = rect.size.height;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 1;
        } else if (section <= self.inquiryOrderModel.inquiryOrderItems.count) {
            NSString *string = _arrayYesOpen[section-1];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
                InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 1];
                QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
                if (quotationOrderItem.isSkip.integerValue == 0) {//暂不报价
                    return 2;
                } else {//启动报价
                    return 1;
                }
            }
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+1) {
//            return 1+2+1;
            return 1;
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+2) {
            if ([self.buttonCheckToConfirm.currentTitle isEqualToString:@"查看并确认报价"]) {
                return 1;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 1;
        } else if (section <= self.inquiryOrderModel.inquiryOrderItems.count) {
            NSString *string = _arrayYesOpen[section-1];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
                InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 1];
                QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
                if ([self.inquiryOrderModel.inquiryType isEqualToString:@"ATG"] && [quotationOrderItem.isSkip integerValue] == 1) {
                    return 1;
                } else {
                    return 1+1+[self.inquiryOrderModel.tempPriceDetailCount integerValue]+2+2;
                }
                
            }
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+1) {
//            return 1+[self.inquiryOrderModel.tempCostDetailCount integerValue]+[self.inquiryOrderModel.tempShipPriceDetailCount integerValue]+1;
            return 1;
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+2) {
            if ([self.buttonCheckToConfirm.currentTitle isEqualToString:@"查看并确认报价"]) {
                return 1;
            } else {
                return 0;
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
        return 1+self.inquiryOrderModel.inquiryOrderItems.count+1+1;;
    } else if (tableView.tag == 89) {
        return 1+self.inquiryOrderModel.inquiryOrderItems.count+1+1;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 88) {
        if (indexPath.section == 0) {
            return 50;
        } else if (indexPath.section <= self.inquiryOrderModel.inquiryOrderItems.count) {
            if (indexPath.row == 0) {
                InquiryOrderItem *model = _arrayInquiryOrderItemModel[indexPath.section - 1];
                QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
                if ([self.inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
                    if (quotationOrderItem.isSkip.integerValue == 0) {//暂不报价
                        return 265-44;
                    } else {//启动报价
                        return 265;
                    }
                } else {
                    if (quotationOrderItem.isSkip.integerValue == 0) {//暂不报价
                        return 235-44;
                    } else {//启动报价
                        return 235;
                    }
                }
            } else {
                return 114;
            }
        } else if (indexPath.section == self.inquiryOrderModel.inquiryOrderItems.count+1) {
            return 44;
        } else if (indexPath.section == self.inquiryOrderModel.inquiryOrderItems.count+2) {
            return 80;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (indexPath.section == 0) {
            return 50;
        } else if (indexPath.section <= self.inquiryOrderModel.inquiryOrderItems.count) {
            if (indexPath.row == 0) {
                InquiryOrderItem *model = _arrayInquiryOrderItemModel[indexPath.section - 1];
                QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
                
                if ([self.inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
                    if ([quotationOrderItem.isSkip integerValue] == 1) {
                        return 265;
                    } else {
                        return 221;
                    }
                } else {
                    return 198;
                }
            } else {
                return 40;
            }
        } else if (indexPath.section == self.inquiryOrderModel.inquiryOrderItems.count+1) {
            return 44;
        } else if (indexPath.section == self.inquiryOrderModel.inquiryOrderItems.count+2) {
            return 80;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 32;
        } else if (section <= self.inquiryOrderModel.inquiryOrderItems.count) {
            NSString *string = _arrayYesOpen[section-1];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+1) {
            return 32;
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+2) {
            if ([self.buttonCheckToConfirm.currentTitle isEqualToString:@"查看并确认报价"]) {
                return 32;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 32;
        } else if (section <= self.inquiryOrderModel.inquiryOrderItems.count) {
            NSString *string = _arrayYesOpen[section-1];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+1) {
            return 32;
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+2) {
            if ([self.buttonCheckToConfirm.currentTitle isEqualToString:@"查看并确认报价"]) {
                return 32;
            } else {
                return 0;
            }
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
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorBG;
            [self line:view withY:0 withTag:0];
            
            UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 74, 32)];
            labelTitle.font = [UIFont systemFontOfSize:12];
            labelTitle.textColor = colorText153;
            labelTitle.text = @"零件报价";
            [view addSubview:labelTitle];
            
            UILabel *labelTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(15+74+10, 0, kMainW-30-74-10, 32)];
            labelTitle1.font = [UIFont systemFontOfSize:12];
            labelTitle1.textColor = colorText153;
            labelTitle1.text = self.inquiryOrderModel.title;
            labelTitle1.textAlignment = NSTextAlignmentRight;
            [view addSubview:labelTitle1];
            
            [self line:view withY:31.5 withTag:0];
            return view;
        } else if (section <= self.inquiryOrderModel.inquiryOrderItems.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewYiBaoJia.hidden = YES;
            view.viewWeiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            
            InquiryOrderItem *model = self.inquiryOrderModel.inquiryOrderItems[section - 1];
            QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
            
            if ([quotationOrderItem.isSkip integerValue] == 1) {
                view.viewZanBuBaoJia.hidden = NO;
            } else {
                view.viewZongJia.hidden = NO;
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
            view.labelName.text = [NSString stringWithFormat:@"%ld、%@",section-1+1,partNumber_specifications];
            view.label00.textColor = colorRGB(0, 168, 255);
            view.label0.textColor = colorRGB(0, 168, 255);
            view.label0.text  = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:nil;
            
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.price1 doubleValue];
            view.label1.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            
            view.label2.text  = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label2DanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            
            view.label0Wei.text = @"未报价";
            view.label0Wei.textColor = colorRGB(0, 168, 255);
            view.label1Wei.text = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label1WeiDanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            view.labelZanBuYuanYin.text = [NSString stringWithFormat:@"原因:%@",quotationOrderItem.skipRemark];
            
            view.labelZongjia.text = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.labelZongjiaDanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            
            view.buttonOpen.tag = section-1;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-1;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *string = _arrayYesOpen[section-1];
            if ([string isEqualToString:@"no"]) {
                view.textFieldZongjia.hidden = NO;
            } else {
                view.textFieldZongjia.hidden = YES;
            }
            
            view.textFieldZongjia.delegate = self;
            view.textFieldZongjia.tag = section - 1;
            view.textFieldZongjia.inputAccessoryView = [self addToolbar];
            [view.textFieldZongjia addTarget:self action:@selector(priceTextField:) forControlEvents:UIControlEventEditingChanged];
            view.textFieldZongjia.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%@",quotationOrderItem.price1]:nil;
            
            return view;
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件总计";
            [view addSubview:labelDiYiBaoJia];
            
            return view;
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+2) {
            if ([self.buttonCheckToConfirm.currentTitle isEqualToString:@"查看并确认报价"]) {
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
    } else if (tableView.tag == 89) {
        if (section == 0) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorBG;
            [self line:view withY:0 withTag:0];
            
            UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 74, 32)];
            labelTitle.font = [UIFont systemFontOfSize:12];
            labelTitle.textColor = colorText153;
            labelTitle.text = @"零件报价明细";
            [view addSubview:labelTitle];
            
            UILabel *labelTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(15+74+10, 0, kMainW-30-74-10, 32)];
            labelTitle1.font = [UIFont systemFontOfSize:12];
            labelTitle1.textColor = colorText153;
            labelTitle1.text = self.inquiryOrderModel.title;
            labelTitle1.textAlignment = NSTextAlignmentRight;
            [view addSubview:labelTitle1];
            
            [self line:view withY:31.5 withTag:0];
            return view;
        } else if (section <= self.inquiryOrderModel.inquiryOrderItems.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewYiBaoJia.hidden = YES;
            view.viewWeiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            
            InquiryOrderItem *model = self.inquiryOrderModel.inquiryOrderItems[section - 1];
            QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
            
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
            view.labelName.text = [NSString stringWithFormat:@"%ld、%@",section-1+1,partNumber_specifications];
            view.label00.textColor = colorRGB(0, 168, 255);
            view.label0.textColor = colorRGB(0, 168, 255);
            view.label0.text  = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:nil;
            
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.price1 doubleValue];
            view.label1.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            
            view.label2.text  = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label2DanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            
            view.label0Wei.text = @"未报价";
            view.label0Wei.textColor = colorRGB(0, 168, 255);
            view.label1Wei.text = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label1WeiDanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            
            view.labelZanBuYuanYin.text = [NSString stringWithFormat:@"原因:%@",quotationOrderItem.skipRemark];
            
            view.buttonOpen.tag = section-1;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-1;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            return view;
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件总计";
            [view addSubview:labelDiYiBaoJia];

            return view;
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+2) {
            if ([self.buttonCheckToConfirm.currentTitle isEqualToString:@"查看并确认报价"]) {
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
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 5;
        } else if (section <= self.inquiryOrderModel.inquiryOrderItems.count) {
            if (section == self.inquiryOrderModel.inquiryOrderItems.count) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+1) {
            return 0.1;
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+2) {
            return 0.1;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 5;
        } else if (section <= self.inquiryOrderModel.inquiryOrderItems.count) {
            if (section == self.inquiryOrderModel.inquiryOrderItems.count) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+1) {
            return 0.1;
        } else if (section == self.inquiryOrderModel.inquiryOrderItems.count+2) {
            return 0.1;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 88) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                for (UIView *view in cell.contentView.subviews) {
                    if (view.tag == 10 || view.tag == 11) {
                        [view removeFromSuperview];
                    }
                }
                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f%@",[_quotationOrder.supplierTaxRate doubleValue]*100,@"%"];//[_quotationOrder.supplierTaxRate doubleValue] == 0.13
                cell.textLabel.text = [NSString stringWithFormat:@"税率(%@)",stringTaxRate];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0, 0, kMainW, 50);
                button.backgroundColor = [UIColor clearColor];
                button.tag = 10;
                [button addTarget:self action:@selector(buttonIndexPath00) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:button];
                
                UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, kMainW, 0.5)];
                viewLine.backgroundColor = colorRGB(221, 221, 221);
                viewLine.tag = 11;
                [cell.contentView addSubview:viewLine];
                
                return cell;
            } else {
                return  nil;
            }
        } else if (indexPath.section <= self.inquiryOrderModel.inquiryOrderItems.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.clipsToBounds = true;
                
                cell.imageTopConstraint.constant = 8;
                cell.viewDaoHuoTime.hidden = YES;
                cell.viewZanBuBaoJia.hidden = YES;
                cell.buttonZanBuBaoJia.hidden = YES;
                cell.viewZongjia.hidden = YES;
                cell.viewZongChaKan.hidden = YES;
                
                InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 1];
                QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:inquiryOrderItem.inquiryOrderItemId];
                if ([self.inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
                    if ([quotationOrderItem.isSkip integerValue] == 1) {
                        cell.imageTopConstraint.constant = 38;
                        cell.viewDaoHuoTime.hidden = NO;
                        cell.viewZanBuBaoJia.hidden = NO;
                        cell.buttonZanBuBaoJia.hidden = NO;
                        [cell.buttonZanBuBaoJia setTitle:@"启动报价" forState:UIControlStateNormal];
                    } else {
                        cell.imageTopConstraint.constant = 38;
                        cell.viewDaoHuoTime.hidden = NO;
                        cell.buttonZanBuBaoJia.hidden = NO;
                        cell.viewZongjia.hidden = NO;
                        [cell.buttonZanBuBaoJia setTitle:@"暂不报价" forState:UIControlStateNormal];
                    }
                } else {
                    cell.viewZongjia.hidden = NO;
                }
                
                if (self.inquiryOrderModel.inquiryOrderItems.count == 1) {
                    cell.buttonZanBuBaoJia.hidden = YES;
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
                
                cell.dyzPartNumber.text = [NSString stringWithFormat:@"%ld、%@",indexPath.section-1+1,partNumber_specifications];
                cell.materialName.text = inquiryOrderItem.materialName2.length>0?inquiryOrderItem.materialName2:@"--";
                
                cell.dyzPartName.text = inquiryOrderItem.partName.length>0?inquiryOrderItem.partName:@"--";
                if ([NSString SizeUnit:inquiryOrderItem.sizeUnit]) {
                    cell.sizeLWHUnit.text = [NSString stringWithFormat:@"长 %.2f * 宽 %.2f * 高 %.2f %@",[inquiryOrderItem.length doubleValue],[inquiryOrderItem.width doubleValue],[inquiryOrderItem.height doubleValue],[NSString SizeUnit:inquiryOrderItem.sizeUnit]];
                } else {
                    cell.sizeLWHUnit.text = @"--";
                }
                
                
                cell.num123.text = [NSString stringWithFormat:@"%@%@",[NSString removeSuffixIsZone:[inquiryOrderItem.num1 doubleValue]],[NSString QuantityUnit:inquiryOrderItem.quantityUnit].length>0?[NSString QuantityUnit:inquiryOrderItem.quantityUnit]:@""];
                
                if (self.inquiryOrderModel.isVisiblePrice.integerValue == 1) {
                    cell.labelTargetPrice.hidden = NO;
                } else {
                    cell.labelTargetPrice.hidden = true;
                }
                cell.labelTargetPrice.text = [NSString stringWithFormat:@"未税核算价:%@",inquiryOrderItem.price1.stringValue];
                
                
                if ([inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:inquiryOrderItem.sec_thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                } else {
                    
                    NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_inquiryOrderModel.member.enterpriseInfo.enterpriseId,inquiryOrderItem.partNumber,inquiryOrderItem.picVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                }
                
                NSString *batchDeliverItem = [[inquiryOrderItem.deliveryTime componentsSeparatedByString:@" "] firstObject];
                
                cell.labelDaoHuoTime.text = [NSString stringWithFormat:@"交货日期:%@",batchDeliverItem];
                
                cell.labelZanBuBaoJia.text = [NSString stringWithFormat:@"暂不报价原因:%@",quotationOrderItem.skipRemark];
                
                cell.buttonClose.tag = indexPath.section - 1;
                [cell.buttonClose addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonClose1.tag = indexPath.section - 1;
                [cell.buttonClose1 addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonImage.tag = indexPath.section - 1;
                [cell.buttonImage addTarget:self action:@selector(buttonImageClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonDetail.tag = indexPath.section - 1;
                [cell.buttonDetail setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonZanBuBaoJia.tag = indexPath.section - 1;
                [cell.buttonZanBuBaoJia addTarget:self action:@selector(buttonZanBuBaoJiaClickZongJia:) forControlEvents:UIControlEventTouchUpInside];
                
//                cell.textFieldZongJia.delegate = self;
//                cell.textFieldZongJia.tag = indexPath.section - 1;
//                cell.textFieldZongJia.inputAccessoryView = [self addToolbar];
//                [cell.textFieldZongJia addTarget:self action:@selector(priceTextField:) forControlEvents:UIControlEventEditingChanged];
//                cell.textFieldZongJia.placeholder = @"请填写零件含税价";
//                cell.textFieldZongJia.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%@",quotationOrderItem.price1]:nil;
//
//                UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
//                rightLabel.text = @"单价(元)";
//                rightLabel.font = [UIFont systemFontOfSize:14];
//                rightLabel.textColor = colorRGB(204, 204, 204);
//                cell.textFieldZongJia.rightView = rightLabel;
//                cell.textFieldZongJia.rightViewMode = UITextFieldViewModeAlways;
                
                return cell;
            } else if (indexPath.row == 1) {//回复交期&零件详情
                MXBaoJiaCell011 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell011" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 1];
                QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:inquiryOrderItem.inquiryOrderItemId];
                
                cell.textFieldPrice.delegate = self;
                cell.textFieldPrice.tag = indexPath.section - 1;
                cell.textFieldPrice.inputAccessoryView = [self addToolbar];
                [cell.textFieldPrice addTarget:self action:@selector(priceTextField:) forControlEvents:UIControlEventEditingChanged];
                cell.textFieldPrice.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%@",quotationOrderItem.price1]:nil;
                
                cell.textFieldResponseDate.tag = indexPath.section - 1;
                cell.textFieldResponseDate.tintColor = [UIColor clearColor];
                cell.textFieldResponseDate.inputView = [UIView new];
                [cell.textFieldResponseDate addTarget:self action:@selector(textFieldSupplierDeliverTime:) forControlEvents:UIControlEventEditingDidBegin];
                if (quotationOrderItem.supplierDeliverTime) {
                    cell.textFieldResponseDate.text = [[quotationOrderItem.supplierDeliverTime componentsSeparatedByString:@" "] firstObject];
                } else {
                    cell.textFieldResponseDate.text = nil;
                }
                
                cell.textFieldPartRemark.tag = indexPath.section - 1;
                cell.textFieldPartRemark.inputAccessoryView = [self addToolbar];
                [cell.textFieldPartRemark addTarget:self action:@selector(textFieldSupplierRemark:) forControlEvents:UIControlEventEditingChanged];
                cell.textFieldPartRemark.text = quotationOrderItem.supplierRemark?quotationOrderItem.supplierRemark:nil;
                
                
                
                return cell;
            } else {
                return nil;
            }
            
        } else if (indexPath.section == self.inquiryOrderModel.inquiryOrderItems.count+1) {
            if (indexPath.row == 0) {
                MXBaoJiaCell111 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell111" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrder.supplierTaxRate doubleValue]*100];
//                cell.label0.text = [NSString stringWithFormat:@"总计(含税价%@%@)",stringTaxRate,@"%"];
                cell.label0.text = @"未税总计";
                cell.label2.text = _quotationOrder.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.totalPrice1 doubleValue]]:@"0.00";
                
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == self.inquiryOrderModel.inquiryOrderItems.count+2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellSection2" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (UIView *view in cell.contentView.subviews) {
                [view removeFromSuperview];
            }
            
            UITextView *oneTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 8, kMainW-20, 55)];
            oneTextView.font = [UIFont systemFontOfSize:14];
            oneTextView.delegate = self;
            [cell.contentView addSubview:oneTextView];
//            oneTextView.layer.cornerRadius = 7;
//            oneTextView.layer.borderWidth = 0.5;
//            oneTextView.layer.borderColor = colorRGB(209, 209, 209).CGColor;
            oneTextView.inputAccessoryView = [self addToolbar];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, oneTextView.frame.size.width, 16)];
            label.text = @"报价外额外需要注明的内容";
            label.textColor = colorRGB(177, 177, 177);
            label.font = [UIFont systemFontOfSize:14];
            label.tag = 19921125;
            [oneTextView addSubview:label];
            
            if (_quotationOrder.remark) {
                oneTextView.text = _quotationOrder.remark;
                label.hidden = YES;
            }
            
            return cell;
        } else {
            return nil;
        }
        return nil;
    } else if (tableView.tag == 89) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                for (UIView *view in cell.contentView.subviews) {
                    if (view.tag == 10 || view.tag == 11) {
                        [view removeFromSuperview];
                    }
                }
                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f%@",[_quotationOrder.supplierTaxRate doubleValue]*100,@"%"];//[_quotationOrder.supplierTaxRate doubleValue] == 0.13
                cell.textLabel.text = [NSString stringWithFormat:@"税率(%@)",stringTaxRate];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0, 0, kMainW, 50);
                button.backgroundColor = [UIColor clearColor];
                button.tag = 10;
                [button addTarget:self action:@selector(buttonIndexPath00) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:button];
                
                UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, kMainW, 0.5)];
                viewLine.backgroundColor = colorRGB(221, 221, 221);
                viewLine.tag = 11;
                [cell.contentView addSubview:viewLine];
                
                return cell;
            } else {
                return  nil;
            }
        } else if (indexPath.section <= self.inquiryOrderModel.inquiryOrderItems.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.imageTopConstraint.constant = 8;
                cell.viewDaoHuoTime.hidden = YES;
                cell.viewZanBuBaoJia.hidden = YES;
                cell.buttonZanBuBaoJia.hidden = YES;
                cell.viewZongjia.hidden = YES;
                cell.viewZongChaKan.hidden = YES;
                
                InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 1];
                QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:inquiryOrderItem.inquiryOrderItemId];
                if ([self.inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
                    if ([quotationOrderItem.isSkip integerValue] == 1) {
//                        return 265;
                        cell.imageTopConstraint.constant = 38;
                        cell.viewDaoHuoTime.hidden = NO;
                        cell.viewZanBuBaoJia.hidden = NO;
                        cell.buttonZanBuBaoJia.hidden = NO;
                        [cell.buttonZanBuBaoJia setTitle:@"启动报价" forState:UIControlStateNormal];
                    } else {
//                        return 221;
                        cell.imageTopConstraint.constant = 38;
                        cell.viewDaoHuoTime.hidden = NO;
                        cell.buttonZanBuBaoJia.hidden = NO;
                        [cell.buttonZanBuBaoJia setTitle:@"暂不报价" forState:UIControlStateNormal];
                    }
                } else {
//                    return 198;
                }
                
                if (self.inquiryOrderModel.inquiryOrderItems.count == 1) {
                    cell.buttonZanBuBaoJia.hidden = YES;
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
                cell.dyzPartNumber.text = [NSString stringWithFormat:@"%ld、%@",indexPath.section-1+1,partNumber_specifications];
                cell.materialName.text = inquiryOrderItem.materialName2.length>0?inquiryOrderItem.materialName2:@"--";
                
                cell.dyzPartName.text = inquiryOrderItem.partName.length>0?inquiryOrderItem.partName:@"--";
                
                if ([NSString SizeUnit:inquiryOrderItem.sizeUnit]) {
                    cell.sizeLWHUnit.text = [NSString stringWithFormat:@"长 %.2f * 宽 %.2f * 高 %.2f %@",[inquiryOrderItem.length doubleValue],[inquiryOrderItem.width doubleValue],[inquiryOrderItem.height doubleValue],[NSString SizeUnit:inquiryOrderItem.sizeUnit]];
                } else {
                    cell.sizeLWHUnit.text = @"--";
                }
                
                cell.num123.text = [NSString stringWithFormat:@"%@%@",[NSString removeSuffixIsZone:[inquiryOrderItem.num1 doubleValue]],[NSString QuantityUnit:inquiryOrderItem.quantityUnit].length>0?[NSString QuantityUnit:inquiryOrderItem.quantityUnit]:@""];
                
                if (self.inquiryOrderModel.isVisiblePrice.integerValue == 1) {
                    cell.labelTargetPrice.hidden = NO;
                } else {
                    cell.labelTargetPrice.hidden = true;
                }
                cell.labelTargetPrice.text = [NSString stringWithFormat:@"未税核算价:%@",inquiryOrderItem.price1.stringValue];
                
                
                
                if ([inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:inquiryOrderItem.sec_thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                } else {
                    
                    NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_inquiryOrderModel.member.enterpriseInfo.enterpriseId,inquiryOrderItem.partNumber,inquiryOrderItem.picVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                }
                
                NSString *batchDeliverItem = [[inquiryOrderItem.deliveryTime componentsSeparatedByString:@" "] firstObject];
                cell.labelDaoHuoTime.text = [NSString stringWithFormat:@"交货日期:%@",batchDeliverItem];
                
                cell.labelZanBuBaoJia.text = [NSString stringWithFormat:@"暂不报价原因:%@",quotationOrderItem.skipRemark];
                
                cell.buttonClose.tag = indexPath.section - 1;
                [cell.buttonClose addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonClose1.tag = indexPath.section - 1;
                [cell.buttonClose1 addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonImage.tag = indexPath.section - 1;
                [cell.buttonImage addTarget:self action:@selector(buttonImageClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonDetail.tag = indexPath.section - 1;
                [cell.buttonDetail setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonZanBuBaoJia.tag = indexPath.section - 1;
                [cell.buttonZanBuBaoJia addTarget:self action:@selector(buttonZanBuBaoJiaClick:) forControlEvents:UIControlEventTouchUpInside];
                
                return cell;
            } else if (indexPath.row == 1) {
                MXBaoJiaCell02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell02" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.viewRight.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
                cell.labelRight.text = @"报价(元)";
                
                return cell;
            } else if (indexPath.row < 2+[self.inquiryOrderModel.tempPriceDetailCount integerValue]) {
                MXBaoJiaCell03 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell03" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.labelTempPriceDetailName.text = [self.inquiryOrderModel valueForKey:[NSString stringWithFormat:@"tempPriceDetailName%ld",indexPath.row-1]];
                
                InquiryOrderItem *model = _arrayInquiryOrderItemModel[indexPath.section - 1];
                QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
                if (quotationOrderItem) {
                    NSNumber *supplierTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%ld",indexPath.row-1]];
                    cell.textField.text = supplierTempPrice1DetailValue?[NSString stringWithFormat:@"%@",supplierTempPrice1DetailValue]:nil;
                }
                
                cell.textFieldSuperView.tag = indexPath.section-1;
                cell.textField.tag = indexPath.row-2;
                [cell.textField addTarget:self action:@selector(addTargetActionTestFieldItem:) forControlEvents:UIControlEventEditingChanged];
                cell.textField.delegate = self;
                
                cell.textField.inputAccessoryView = [self addToolbar];
                
                return cell;
            } else if (indexPath.row < 2+[self.inquiryOrderModel.tempPriceDetailCount integerValue]+1) {
                MXBaoJiaCell04 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell04" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.viewLeft.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
                InquiryOrderItem *model = _arrayInquiryOrderItemModel[indexPath.section - 1];
                QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
                
                cell.labelRight.text = quotationOrderItem.price1?[NSString stringWithFormat:@"¥%.2f",[quotationOrderItem.price1 doubleValue]]:@"¥0.00";
                
                return cell;
            } else if (indexPath.row < 2+[self.inquiryOrderModel.tempPriceDetailCount integerValue]+2) {
                MXBaoJiaCell05 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell05" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.viewLeft.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
                InquiryOrderItem *model = _arrayInquiryOrderItemModel[indexPath.section - 1];
                QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
                
                cell.labelRight.text = quotationOrderItem.price1?[NSString stringWithFormat:@"¥%.2f",[quotationOrderItem.price1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:@"¥0.00";
                
                return cell;
            } else if (indexPath.row < 2+[self.inquiryOrderModel.tempPriceDetailCount integerValue]+3) {//回复交期
                MXBaoJiaCell06 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell06" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                InquiryOrderItem *model = _arrayInquiryOrderItemModel[indexPath.section - 1];
                QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
                cell.labelTempPriceDetailName.text = @"回复交期";
                
                cell.textField.placeholder = @"请选择";
                cell.textField.tag = indexPath.section - 1;
                cell.textField.tintColor = [UIColor clearColor];
                cell.textField.inputView = [UIView new];
                [cell.textField addTarget:self action:@selector(textFieldSupplierDeliverTime:) forControlEvents:UIControlEventEditingDidBegin];
                if (quotationOrderItem.supplierDeliverTime) {
                    cell.textField.text = [[quotationOrderItem.supplierDeliverTime componentsSeparatedByString:@" "] firstObject];
                } else {
                    cell.textField.text = nil;
                }
                
                return cell;
            } else if (indexPath.row < 2+[self.inquiryOrderModel.tempPriceDetailCount integerValue]+4) {//零件备注
                MXBaoJiaCell07 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell07" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                InquiryOrderItem *model = _arrayInquiryOrderItemModel[indexPath.section - 1];
                QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
                cell.labelTempPriceDetailName.text = @"零件备注";
                
                cell.textField.placeholder = @"请输入";
                cell.textField.tag = indexPath.section - 1;
                cell.textField.inputAccessoryView = [self addToolbar];
                [cell.textField addTarget:self action:@selector(textFieldSupplierRemark:) forControlEvents:UIControlEventEditingChanged];
                cell.textField.text = quotationOrderItem.supplierRemark?quotationOrderItem.supplierRemark:nil;
                
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == self.inquiryOrderModel.inquiryOrderItems.count+1) {

            if (indexPath.row == 0) {
                MXBaoJiaCell111 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell111" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrder.supplierTaxRate doubleValue]*100];
//                cell.label0.text = [NSString stringWithFormat:@"总计(含税价%@%@)",stringTaxRate,@"%"];
                cell.label0.text = @"未税总计";
                cell.label2.text = _quotationOrder.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.totalPrice1 doubleValue]]:@"0.00";
                
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == self.inquiryOrderModel.inquiryOrderItems.count+2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellSection2" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (UIView *view in cell.contentView.subviews) {
                [view removeFromSuperview];
            }
            
            UITextView *oneTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 8, kMainW-20, 55)];
            oneTextView.font = [UIFont systemFontOfSize:14];
            oneTextView.delegate = self;
            [cell.contentView addSubview:oneTextView];

            oneTextView.inputAccessoryView = [self addToolbar];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, oneTextView.frame.size.width, 16)];
            label.text = @"报价外额外需要注明的内容";
            label.textColor = colorRGB(177, 177, 177);
            label.font = [UIFont systemFontOfSize:14];
            label.tag = 19921125;
            [oneTextView addSubview:label];
            
            if (_quotationOrder.remark) {
                oneTextView.text = _quotationOrder.remark;
                label.hidden = YES;
            }
            
            return cell;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
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
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

- (void)buttonOpenClick:(UIButton *)sender {
    [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"yes"];
    [self textFieldDone];
    [_tableView reloadData];
    [_tableView1 reloadData];
}

- (void)buttonCloseClick:(UIButton *)sender {
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
        purchaseProjectInfo.sec_enterpriseId = _inquiryOrderModel.member.enterpriseInfo.enterpriseId;
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
                    if ([_inquiryOrderModel.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
                        sourceCaiOrGong = @"cai";
                    } else {
                        sourceCaiOrGong = @"gong";
                    }
                    PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
//                    partDetailsViewController.indexNum = 1;
                    partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
                    partDetailsViewController.enterpriseId = _inquiryOrderModel.member.enterpriseInfo.enterpriseId;
                    partDetailsViewController.inquiryType = _inquiryOrderModel.inquiryType;
                    partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
                    [self.navigationController pushViewController:partDetailsViewController animated:YES];
                }
            }
        } fail:^(NSError *error) {
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    } else {
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        NSString *sourceCaiOrGong;
        if ([_inquiryOrderModel.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
            sourceCaiOrGong = @"cai";
        } else {
            sourceCaiOrGong = @"gong";
        }
        PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
//        partDetailsViewController.indexNum = 1;
        partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
        partDetailsViewController.enterpriseId = _inquiryOrderModel.member.enterpriseInfo.enterpriseId;
        partDetailsViewController.inquiryType = _inquiryOrderModel.inquiryType;
        partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
        [self.navigationController pushViewController:partDetailsViewController animated:YES];
    }
}

- (void)buttonDetailClick:(UIButton *)sender {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    NSString *sourceCaiOrGong;
    if ([_inquiryOrderModel.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
        sourceCaiOrGong = @"cai";
    } else {
        sourceCaiOrGong = @"gong";
    }
    PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
    partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
    partDetailsViewController.enterpriseId = _inquiryOrderModel.member.enterpriseInfo.enterpriseId;
    partDetailsViewController.inquiryType = _inquiryOrderModel.inquiryType;
    partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
    
    [self.navigationController pushViewController:partDetailsViewController animated:YES];
}

- (void)buttonZanBuBaoJiaClickZongJia:(UIButton *)sender {
    InquiryOrderItem *model = _arrayInquiryOrderItemModel[sender.tag];
    QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
    
    if ([sender.currentTitle isEqualToString:@"暂不报价"]) {
        _eChooseSkipRemarkView3Kind = [[EChooseSkipRemarkView3Kind alloc] initWithFrame:self.view.frame defaultSkipRemark:quotationOrderItem.skipRemark buttonConfirmClick:^(NSString *confirmTax) {
            quotationOrderItem.isSkip = [NSNumber numberWithInteger:1];
            quotationOrderItem.skipRemark = confirmTax;
            
            quotationOrderItem.price1 = [NSNumber numberWithDouble:0];
            
            [_tableView reloadData];
            [self calculateTotalPrice];
            
            [sender setTitle:@"启动报价" forState:UIControlStateNormal];
            
            BOOL enterAble = true;
            self.buttonCheckToConfirm.backgroundColor = colorRGB(0, 168, 255);
            self.buttonCheckToConfirm.enabled = YES;
            for (QuotationOrderItem *quotationOrderItem in _quotationOrder.quotationOrderItems) {
                if (!(([quotationOrderItem.price1 doubleValue] > 0) || [quotationOrderItem.isSkip integerValue] == 1)) {
                    enterAble = false;
                    self.buttonCheckToConfirm.backgroundColor = colorRGB(180, 180, 180);
                    self.buttonCheckToConfirm.enabled = NO;
                    break;
                }
            }
            if ([_quotationOrder.totalPrice1 doubleValue] <= 0) {
                self.buttonCheckToConfirm.backgroundColor = colorRGB(180, 180, 180);
                self.buttonCheckToConfirm.enabled = NO;
            }
            
        }];
        [self.view addSubview:_eChooseSkipRemarkView3Kind];
    } else if ([sender.currentTitle isEqualToString:@"启动报价"]) {
        quotationOrderItem.isSkip = [NSNumber numberWithInteger:0];
        quotationOrderItem.skipRemark = nil;
        
        [sender setTitle:@"暂不报价" forState:UIControlStateNormal];
        
        //解决self.button 首先所有的零件都处理过，变亮了，最后有开启报价，没填数据前self.button颜色变成高亮
        BOOL enterAble = true;
        self.buttonCheckToConfirm.backgroundColor = colorRGB(0, 168, 255);
        self.buttonCheckToConfirm.enabled = YES;
        for (QuotationOrderItem *quotationOrderItem in _quotationOrder.quotationOrderItems) {
            if (!(([quotationOrderItem.price1 doubleValue] > 0) || [quotationOrderItem.isSkip integerValue] == 1)) {
                enterAble = false;
                self.buttonCheckToConfirm.backgroundColor = colorRGB(180, 180, 180);
                self.buttonCheckToConfirm.enabled = NO;
                break;
            }
        }
        if ([_quotationOrder.totalPrice1 doubleValue] <= 0) {
            self.buttonCheckToConfirm.backgroundColor = colorRGB(180, 180, 180);
            self.buttonCheckToConfirm.enabled = NO;
        }
        [_tableView reloadData];
    }
}

- (void)buttonZanBuBaoJiaClick:(UIButton *)sender {
    InquiryOrderItem *model = _arrayInquiryOrderItemModel[sender.tag];
    QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
    
    if ([sender.currentTitle isEqualToString:@"暂不报价"]) {
        _eChooseSkipRemarkView3Kind = [[EChooseSkipRemarkView3Kind alloc] initWithFrame:self.view.frame defaultSkipRemark:quotationOrderItem.skipRemark buttonConfirmClick:^(NSString *confirmTax) {
            quotationOrderItem.isSkip = [NSNumber numberWithInteger:1];
            quotationOrderItem.skipRemark = confirmTax;
            for (int i = 0; i < [self.inquiryOrderModel.tempPriceDetailCount integerValue]; i++) {
                [quotationOrderItem setValue:nil forKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%d",i+1]];
            }
            quotationOrderItem.price1 = [NSNumber numberWithDouble:0];
            
            [_tableView1 reloadData];
            [self calculateTotalPriceMingXi];
            
            [sender setTitle:@"启动报价" forState:UIControlStateNormal];
            
            BOOL enterAble = true;
            self.buttonCheckToConfirm.backgroundColor = colorRGB(0, 168, 255);
            self.buttonCheckToConfirm.enabled = YES;
            for (QuotationOrderItem *quotationOrderItem in _quotationOrder.quotationOrderItems) {
                if (!(([quotationOrderItem.price1 doubleValue] > 0) || [quotationOrderItem.isSkip integerValue] == 1)) {
                    enterAble = false;
                    self.buttonCheckToConfirm.backgroundColor = colorRGB(180, 180, 180);
                    self.buttonCheckToConfirm.enabled = NO;
                    break;
                }
            }
            if ([_quotationOrder.totalPrice1 doubleValue] <= 0) {
                self.buttonCheckToConfirm.backgroundColor = colorRGB(180, 180, 180);
                self.buttonCheckToConfirm.enabled = NO;
            }
    
        }];
        [self.view addSubview:_eChooseSkipRemarkView3Kind];
    } else if ([sender.currentTitle isEqualToString:@"启动报价"]) {
        quotationOrderItem.isSkip = [NSNumber numberWithInteger:0];
        quotationOrderItem.skipRemark = nil;
        
        [sender setTitle:@"暂不报价" forState:UIControlStateNormal];
        
        //解决self.button 首先所有的零件都处理过，变亮了，最后有开启报价，没填数据前self.button颜色变成高亮
        BOOL enterAble = true;
        self.buttonCheckToConfirm.backgroundColor = colorRGB(0, 168, 255);
        self.buttonCheckToConfirm.enabled = YES;
        for (QuotationOrderItem *quotationOrderItem in _quotationOrder.quotationOrderItems) {
            if (!(([quotationOrderItem.price1 doubleValue] > 0) || [quotationOrderItem.isSkip integerValue] == 1)) {
                enterAble = false;
                self.buttonCheckToConfirm.backgroundColor = colorRGB(180, 180, 180);
                self.buttonCheckToConfirm.enabled = NO;
                break;
            }
        }
        if ([_quotationOrder.totalPrice1 doubleValue] <= 0) {
            self.buttonCheckToConfirm.backgroundColor = colorRGB(180, 180, 180);
            self.buttonCheckToConfirm.enabled = NO;
        }
        [_tableView1 reloadData];
    }
}

- (void)buttonIndexPath00 {
    
    if ([self.inquiryOrderModel.inquiryType isEqualToString:@"COM"]||[self.inquiryOrderModel.inquiryType isEqualToString:@"DIR"]) {
        if (!_eChooseTaxRateView) {
            if ([_quotationOrder.supplierTaxRate doubleValue] == 0.13) {
                _eChooseTaxRateView = [[EChooseTaxRateView alloc] initWithFrame:self.view.frame withImageName0:@"label_circle_2t" withImageName1:@"label_circle"];
                _eChooseTaxRateView.delegate = self;
                [self.view addSubview:_eChooseTaxRateView];
            }
            if ([_quotationOrder.supplierTaxRate doubleValue] == 0.03) {
                _eChooseTaxRateView = [[EChooseTaxRateView alloc] initWithFrame:self.view.frame withImageName0:@"label_circle" withImageName1:@"label_circle_2t"];
                _eChooseTaxRateView.delegate = self;
                [self.view addSubview:_eChooseTaxRateView];
            }
        }
    }
    
    if ([self.inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
        if (!_eChooseTaxRateView5Kind) {
            NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrder.supplierTaxRate doubleValue]*100];
            _eChooseTaxRateView5Kind = [[EChooseTaxRateView5Kind alloc] initWithFrame:self.view.frame defaultTax:stringTaxRate buttonConfirmClick:^(NSString *confirmTax) {
                double tax = [confirmTax doubleValue]/100.0;
                NSLog(@"-->%@",[NSNumber numberWithDouble:tax]);//56时 有问题 0.5600000000000001
                _quotationOrder.supplierTaxRate = [NSNumber numberWithDouble:tax];
                if ([self.inquiryOrderModel.isQuotationTemplate integerValue] == 1) {
                    [_tableView1 reloadData];
                } else {
                    [_tableView reloadData];
                }
            }];
            [self.view addSubview:_eChooseTaxRateView5Kind];
        } else {
            _eChooseTaxRateView5Kind.hidden = NO;
        }
    }
}

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.tableView setContentOffset:CGPointMake(0, 10000)];
    [_tableView1 setContentOffset:CGPointMake(0, 10000)];
}

- (void)textViewDidChange:(UITextView *)textView {
    UILabel *label = [textView viewWithTag:19921125];
    if (textView.text.length > 0) {
        label.hidden = YES;
    } else {
        label.hidden = NO;
    }
    _quotationOrder.remark = textView.text;
}

- (void)buttonChaKanXiangQing:(UIButton *)sender {
    PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
    partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
    partDetailsViewController.enterpriseId = self.inquiryOrderModel.member.enterpriseInfo.enterpriseId;
    partDetailsViewController.inquiryType = self.inquiryOrderModel.inquiryType;
    partDetailsViewController.sourceCaiOrGong = @"cai";
    [self.navigationController pushViewController:partDetailsViewController animated:YES];
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    BOOL enterAble = true;
    self.buttonCheckToConfirm.backgroundColor = colorRGB(0, 168, 255);
    self.buttonCheckToConfirm.enabled = YES;
    for (QuotationOrderItem *quotationOrderItem in _quotationOrder.quotationOrderItems) {
        if (!(([quotationOrderItem.price1 doubleValue] > 0) || [quotationOrderItem.isSkip integerValue] == 1)) {
            enterAble = false;
            self.buttonCheckToConfirm.backgroundColor = colorRGB(180, 180, 180);
            self.buttonCheckToConfirm.enabled = NO;
            break;
        }
    }
    if ([_quotationOrder.totalPrice1 doubleValue] <= 0) {
        self.buttonCheckToConfirm.backgroundColor = colorRGB(180, 180, 180);
        self.buttonCheckToConfirm.enabled = NO;
    }
}

//键盘只能输入@"-.1234567890"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"-.1234567890"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

#pragma mark 总价询盘 含税单价
- (void)priceTextField:(UITextField *)sender {
    NSString *string = sender.text;
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count == 2) {
        NSString *stringR = [array lastObject];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        }
    }
    InquiryOrderItem *model = _arrayInquiryOrderItemModel[sender.tag];
    QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
    if (quotationOrderItem) {
        quotationOrderItem.price1 = [NSNumber numberWithDouble:[sender.text doubleValue]];
    }
    [self calculateTotalPrice];
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:self.inquiryOrderModel.inquiryOrderItems.count+1]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 总价询盘 回复交期  明细询盘
- (void)textFieldSupplierDeliverTime:(UITextField *)sender {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeYaoQiuDaoHuoRiQi" owner:self options:nil];
    UIViewXuanZeYaoQiuDaoHuoRiQi *viewXZSJ = [nib objectAtIndex:0];
    viewXZSJ.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewXZSJ];
    viewXZSJ.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [viewXZSJ initDataPickerButtonClick:^(NSString *string) {
        NSLog(@"%@",string);
        InquiryOrderItem *model = _arrayInquiryOrderItemModel[sender.tag];
        QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
        if (quotationOrderItem) {
            quotationOrderItem.supplierDeliverTime = string;
            sender.text = [[quotationOrderItem.supplierDeliverTime componentsSeparatedByString:@" "] firstObject];
        }
    } buttonQuXiao:^{
        [sender resignFirstResponder];
    }];
}

#pragma mark 总价询盘 零件备注  明细询盘
- (void)textFieldSupplierRemark:(UITextField *)sender {
    InquiryOrderItem *model = _arrayInquiryOrderItemModel[sender.tag];
    QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
    if (quotationOrderItem) {
        quotationOrderItem.supplierRemark = sender.text;
    }
}



- (void)textField:(UITextField *)sender {
    NSString *string = sender.text;
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count == 2) {
        NSString *stringR = [array lastObject];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        }
    }
    if (sender.tag == 0) {
        _quotationOrder.cost1 = [NSNumber numberWithDouble:[sender.text doubleValue]];
    }
    if (sender.tag == 1) {
        _quotationOrder.shipPrice1 = [NSNumber numberWithDouble:[sender.text doubleValue]];
    }
    [self calculateTotalPrice];
    
}

- (void)addTargetActionTestFieldItem:(UITextField *)sender {
    NSString *string = sender.text;
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count == 2) {
        NSString *stringR = [array lastObject];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        }
    }
    
    UIView *view = sender.superview;
    
    InquiryOrderItem *model = _arrayInquiryOrderItemModel[view.tag];
    QuotationOrderItem *quotationOrderItem = [self getQuotationOrderItemByInquiryOrderItemId:model.inquiryOrderItemId];
    if (quotationOrderItem) {
        [quotationOrderItem setValue:[NSNumber numberWithDouble:[sender.text doubleValue]] forKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%ld",sender.tag+1]];
    }
    
    double price1 = 0;
    for (int i = 0; i < [self.inquiryOrderModel.tempPriceDetailCount integerValue]; i++) {
        NSNumber *supplierTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%d",i+1]];
        price1 = price1 + [supplierTempPrice1DetailValue doubleValue];
    }
    price1 = [[NSString stringWithFormat:@"%.2f",price1] doubleValue];
    quotationOrderItem.price1 = [NSNumber numberWithDouble:price1];
    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2+[self.inquiryOrderModel.tempPriceDetailCount integerValue] inSection:view.tag+1],[NSIndexPath indexPathForRow:2+[self.inquiryOrderModel.tempPriceDetailCount integerValue]+1 inSection:view.tag+1],] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"%ld %ld",view.tag,sender.tag);
    [self calculateTotalPriceMingXi];
    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:self.inquiryOrderModel.inquiryOrderItems.count+1]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)addTargetActionTestFieldItemZongJi:(UITextField *)sender {
    NSString *string = sender.text;
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count == 2) {
        NSString *stringR = [array lastObject];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        }
    }
    NSLog(@"%ld",sender.tag);
    
    if (sender.tag < [self.inquiryOrderModel.tempCostDetailCount integerValue]) {
        [_quotationOrder setValue:[NSNumber numberWithDouble:[sender.text doubleValue]] forKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%ld",sender.tag+1]];
    } else if (sender.tag < [self.inquiryOrderModel.tempCostDetailCount integerValue]+[self.inquiryOrderModel.tempShipPriceDetailCount integerValue]) {
        [_quotationOrder setValue:[NSNumber numberWithDouble:[sender.text doubleValue]] forKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%ld",sender.tag+1-[self.inquiryOrderModel.tempCostDetailCount integerValue]]];
    }
    [self calculateTotalPriceMingXi];
}

- (QuotationOrderItem *)getQuotationOrderItemByInquiryOrderItemId:(NSString *)inquiryOrderItemId {
    QuotationOrderItem *returnQuotationOrderItem = nil;
    for (QuotationOrderItem *quotationOrderItem in _quotationOrder.quotationOrderItems) {
        if ([quotationOrderItem.inquiryOrderItem.inquiryOrderItemId isEqualToString:inquiryOrderItemId]) {
            returnQuotationOrderItem = quotationOrderItem;
            break;
        }
    }
    return returnQuotationOrderItem;
}

- (void)calculateTotalPrice {
    double totalPrice = 0;
    totalPrice = totalPrice + [_quotationOrder.cost1 doubleValue] + [_quotationOrder.shipPrice1 doubleValue];
    double subtotalPrice = 0;
    for (QuotationOrderItem *quotationOrderItem in _quotationOrder.quotationOrderItems) {
        if ([quotationOrderItem.isSkip integerValue] == 0) {
            subtotalPrice = subtotalPrice + [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.price1 doubleValue];
        }
    }
    subtotalPrice = [[NSString stringWithFormat:@"%.2f",subtotalPrice] doubleValue];
    totalPrice = totalPrice + subtotalPrice;
    _quotationOrder.subtotalPrice1 = [NSNumber numberWithDouble:subtotalPrice];
    _quotationOrder.totalPrice1 = [NSNumber numberWithDouble:totalPrice];

//    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1+2 inSection:_inquiryOrderModel.inquiryOrderItems.count+1]] withRowAnimation:UITableViewRowAnimationNone];
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:_inquiryOrderModel.inquiryOrderItems.count+1]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)calculateTotalPriceMingXi {
    double totalPrice = 0;
    
    double costPrice = 0;
    for (int i = 0; i < [self.inquiryOrderModel.tempCostDetailCount integerValue]; i++) {
        NSNumber *supplierTempCost1DetailValue = [_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%d",i+1]];
        costPrice = costPrice+[supplierTempCost1DetailValue doubleValue];
    }
    totalPrice = totalPrice + costPrice;
    _quotationOrder.cost1 = [NSNumber numberWithDouble:costPrice];
    double shipPrice = 0;
    for (int i = 0; i < [self.inquiryOrderModel.tempShipPriceDetailCount integerValue]; i++) {
        NSNumber *supplierTempShipPrice1DetailValue = [_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%d",i+1]];
        shipPrice = shipPrice+[supplierTempShipPrice1DetailValue doubleValue];
    }
    totalPrice = totalPrice + shipPrice;
    _quotationOrder.shipPrice1 = [NSNumber numberWithDouble:shipPrice];
    
    
    double subtotalPrice = 0;
    for (QuotationOrderItem *quotationOrderItem in _quotationOrder.quotationOrderItems) {
        if ([quotationOrderItem.isSkip integerValue] == 0) {
            subtotalPrice = subtotalPrice + [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.price1 doubleValue];
        }
    }
    subtotalPrice = [[NSString stringWithFormat:@"%.2f",subtotalPrice] doubleValue];
    totalPrice = totalPrice + subtotalPrice;
    _quotationOrder.subtotalPrice1 = [NSNumber numberWithDouble:subtotalPrice];
    
    _quotationOrder.totalPrice1 = [NSNumber numberWithDouble:totalPrice];
    
//    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1+[self.inquiryOrderModel.tempCostDetailCount integerValue]+[self.inquiryOrderModel.tempShipPriceDetailCount integerValue] inSection:_inquiryOrderModel.inquiryOrderItems.count+1]] withRowAnimation:UITableViewRowAnimationNone];
    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:_inquiryOrderModel.inquiryOrderItems.count+1]] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark 查看并确认报价.btn
- (IBAction)buttonClick:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"查看并确认报价"]) {
        BaoJiaViewController4 *bjVC4 = [[BaoJiaViewController4 alloc] init];
        bjVC4.inquiryOrderModel = _inquiryOrderModel;
        bjVC4.quotationOrder = _quotationOrder;
        [self.navigationController pushViewController:bjVC4 animated:YES];
    }
}

#pragma mark 整单不报价.btn
- (IBAction)buttonClickNoQuotation:(UIButton *)sender {
    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:83]]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
        return;
    }
    
    if ([self.inquiryOrderModel.inquiryType isEqualToString:@"COM"]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"寻源询盘不支持整单不报价"];
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"整单不报价" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        NSString *closeMsg = alertController.textFields[0].text;

        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        inquiryOrder.inquiryOrderId = self.inquiryOrderModel.inquiryOrderId;
        inquiryOrder.refuseMsg = closeMsg;
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
#pragma mark 供应商拒绝报价接口
        [HttpMamager postRequestWithURLString:DYZ_api_quo_supplier_refuse parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *model = responseObjectModel;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
            }
            [self.navigationController popViewControllerAnimated:true];
            [RefreshManager shareRefreshManager].eGInquiryVC = @"通知EGInquiryViewController刷新啦";
        } fail:^(NSError *error) {

        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];

    }]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入原因";
    }];
    [self presentViewController:alertController animated:true completion:nil];
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

- (void)initRequestInquirySupplierDetail {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
    inquiryOrder.inquiryOrderId = self.inquiryOrderId;
    postEntityBean.entity = inquiryOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_inquiry_supplier_detail parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        _viewLoading.hidden = true;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            
            self.inquiryOrderModel = [InquiryOrder mj_objectWithKeyValues:model.entity];
            
            _quotationOrder = [[QuotationOrder alloc] init];
            _quotationOrder.isTemporary = [NSNumber numberWithInteger:0];

            _arrayInquiryOrderItemModel = self.inquiryOrderModel.inquiryOrderItems;
            
            _arrayYesOpen = [[NSMutableArray alloc] initWithCapacity:0];
            
            NSMutableArray <__kindof QuotationOrderItem *> *quotationOrderItems = [[NSMutableArray alloc] init];
            for (InquiryOrderItem *model in _arrayInquiryOrderItemModel) {
                QuotationOrderItem *quotationOrderItem = [[QuotationOrderItem alloc] init];
                InquiryOrderItem *inquiryOrderItem = [[InquiryOrderItem alloc] init];
                inquiryOrderItem.inquiryOrderItemId = model.inquiryOrderItemId;
                quotationOrderItem.inquiryOrderItem = inquiryOrderItem;
                quotationOrderItem.inquiryOrderItemId = model.inquiryOrderItemId;
                quotationOrderItem.isSkip = [NSNumber numberWithInteger:0];
                quotationOrderItem.num1 = model.num1;
                quotationOrderItem.supplierDeliverTime = model.deliveryTime;
                [quotationOrderItems addObject:quotationOrderItem];
                [_arrayYesOpen addObject:@"no"];
            }
            _quotationOrder.quotationOrderItems = quotationOrderItems;
            
            _quotationOrder.inquiryOrderId = self.inquiryOrderModel.inquiryOrderId;
            
            if ([self.inquiryOrderModel.isQuotationTemplate integerValue] == 1) {
                self.tableView.hidden = YES;
            } else {
                self.tableView1.hidden = YES;
            }
            
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"enterpriseNameDic"];
            NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithDictionary:dic];
            LoginModel *login = [DatabaseTool getLoginModel];
            NSString *str = [dicM objectForKey:login.enterpriseName];
            if ([str isEqualToString:@""]) {
                MemberResBean *member = [GlobalSettingManager shareGlobalSettingManager].member;
                _quotationOrder.supplierTaxRate = member.enterpriseInfo.supplierTaxRate;
                _supplierTaxRateTemp = [_quotationOrder.supplierTaxRate doubleValue];
            } else {
                _quotationOrder.supplierTaxRate = [NSNumber numberWithDouble:[str doubleValue]];
                _supplierTaxRateTemp = [str doubleValue];
            }
            
            self.buttonNoQuotation.hidden = YES;
            self.buttonCheckToConfirm0.hidden = YES;
            self.buttonCheckToConfirm1.hidden = YES;
            
            if ([self.inquiryOrderModel.inquiryType isEqualToString:@"COM"]) {//寻源
                self.buttonCheckToConfirm1.hidden = NO;
                self.buttonCheckToConfirm = self.buttonCheckToConfirm1;
            } else if ([self.inquiryOrderModel.inquiryType isEqualToString:@"ATG"]) {
                self.buttonNoQuotation.hidden = NO;
                self.buttonCheckToConfirm0.hidden = NO;
                self.buttonCheckToConfirm = self.buttonCheckToConfirm0;
            }
            
            self.buttonCheckToConfirm.backgroundColor = colorRGB(180, 180, 180);
            self.buttonCheckToConfirm.enabled = NO;
            
            if (!self.buttonCheckToConfirm.currentTitle) {
                [self.buttonCheckToConfirm setTitle:@"查看并确认报价" forState:UIControlStateNormal];
            }
            
            [self.tableView reloadData];
            [self.tableView1 reloadData];
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
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
