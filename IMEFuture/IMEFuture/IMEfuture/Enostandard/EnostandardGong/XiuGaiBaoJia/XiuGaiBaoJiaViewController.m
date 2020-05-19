//
//  XiuGaiBaoJiaViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "XiuGaiBaoJiaViewController.h"
#import "VoHeader.h"

#import "MingXiQueRenBaoJia01.h"
#import "MingXiQueRenBaoJia010.h"
#import "MingXiQueRenBaoJia02.h"
#import "MingXiQueRenBaoJia03.h"
#import "MXBaoJiaCell01.h"
#import "XiuGaiBaoJia3Cell00.h"
#import "XiuGaiBaoJia3Cell01.h"
#import "BaoJiaHeaderView01.h"
#import "MXBaoJiaCell06.h"
#import "MXBaoJiaCell07.h"
#import "MXBaoJiaCell011.h"
#import "MXBaoJiaCell111.h"

#import "XunPanXiangQingViewController.h"
#import "PartDetailsViewController.h"

#import "EChooseTaxRateView.h"
#import "EChooseTaxRateView5Kind.h"
#import "EChooseSkipRemarkView3Kind.h"
#import "LingJianXiangQingViewController2.h"
#import "NSArray+Transition.h"

#import "UIViewXuanZeYaoQiuDaoHuoRiQi.h"

@interface XiuGaiBaoJiaViewController () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,EChooseTaxRateViewDeegate> {
    NSMutableArray *_arrayInquiryOrderItemModel;
    NSMutableArray *_arrayQuotationOrderItemModel;
    NSMutableArray *_arrayYesOpen;
    BOOL _haveNum2;
    BOOL _haveNum3;
    QuotationOrder *_quotationOrder;
    InquiryOrder *_inquiryOrder;
    
    UIActivityIndicatorView *_activityIndicatorView;
    
    EChooseTaxRateView *_eChooseTaxRateView;
    double _supplierTaxRateTemp;
    
    
    EChooseTaxRateView5Kind *_eChooseTaxRateView5Kind;
    EChooseSkipRemarkView3Kind *_eChooseSkipRemarkView3Kind;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation XiuGaiBaoJiaViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_activityIndicatorView startAnimating];
    [self initRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.inquiryOrderCodeAndTitle.text = @"修改报价";
    self.buttonBaoJia.backgroundColor = colorRGB(180, 180, 180);
    self.buttonBaoJia.enabled = NO;


    
    if ([self.stringSource isEqualToString:@"WC待审核查看报价"] || [self.stringSource isEqualToString:@"SR成功接盘查看报价"] || [self.stringSource isEqualToString:@"WS等待授盘查看报价"] || [self.stringSource isEqualToString:@"TOCLCC查看报价"] || [self.stringSource isEqualToString:@"SO查看报价"]) {
    }
    if ([self.stringSource isEqualToString:@"重新报价"]) {
        [self.buttonBaoJia setTitle:@"提交报价" forState:UIControlStateNormal];
    }
    if ([self.stringSource isEqualToString:@"修改报价"]||[self.stringSource isEqualToString:@"重新报价1"]) {
        [self.buttonBaoJia setTitle:@"提交报价" forState:UIControlStateNormal];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BaoJiaCell30" bundle:nil] forCellReuseIdentifier:@"cell30"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaoJiaCell31" bundle:nil] forCellReuseIdentifier:@"cell31"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia01" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia010" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia010"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia02" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia02"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia03" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia03"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell01" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XiuGaiBaoJia3Cell00" bundle:nil] forCellReuseIdentifier:@"xiuGaiBaoJia3Cell00"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XiuGaiBaoJia3Cell01" bundle:nil] forCellReuseIdentifier:@"xiuGaiBaoJia3Cell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell011" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell011"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaoJiaHeaderView01" bundle:nil] forHeaderFooterViewReuseIdentifier:@"baoJiaHeaderView01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tag = 88;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [self.tableView addGestureRecognizer:tap];
    
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    [self.tableView1 registerNib:[UINib nibWithNibName:@"BaoJiaCell30" bundle:nil] forCellReuseIdentifier:@"cell30"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"BaoJiaCell31" bundle:nil] forCellReuseIdentifier:@"cell31"];
    [self.tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia01" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia010" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia010"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia02" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia02"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia03" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia03"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell01" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"XiuGaiBaoJia3Cell00" bundle:nil] forCellReuseIdentifier:@"xiuGaiBaoJia3Cell00"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"XiuGaiBaoJia3Cell01" bundle:nil] forCellReuseIdentifier:@"xiuGaiBaoJia3Cell01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"BaoJiaHeaderView01" bundle:nil] forHeaderFooterViewReuseIdentifier:@"baoJiaHeaderView01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell06" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell06"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell07" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell07"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView1.tableFooterView = [UIView new];
    self.tableView1.tag = 89;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [self.tableView1 addGestureRecognizer:tap1];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.backgroundColor = colorRGB(241, 241, 241);
    _activityIndicatorView.color = colorRGB(117, 117, 117);
    _activityIndicatorView.frame = CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar);
    [self.view addSubview:_activityIndicatorView];
    
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    QuotationOrderItem *quotationOrderItem = [[QuotationOrderItem alloc] init];
    quotationOrderItem.q__quotationOrderId = self.quotationOrderId;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    quotationOrderItem.qm__manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    postEntityBean.entity = quotationOrderItem.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_quotation_detail parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            [_activityIndicatorView stopAnimating];
            
            _arrayQuotationOrderItemModel = [[NSMutableArray alloc] init];
            _arrayInquiryOrderItemModel = [[NSMutableArray alloc] init];
            _arrayYesOpen = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in returnListBean.list) {
                QuotationOrderItem *quotationOrderItem = [QuotationOrderItem mj_objectWithKeyValues:dic];
                [_arrayQuotationOrderItemModel addObject:quotationOrderItem];
                [_arrayInquiryOrderItemModel addObject:quotationOrderItem.inquiryOrderItem];
                [_arrayYesOpen addObject:@"no"];
                _quotationOrder = quotationOrderItem.quotationOrder;
                _inquiryOrder = quotationOrderItem.inquiryOrderItem.inquiryOrder;
            }
            
            for (QuotationOrderItem *quotationOrderItem in _arrayQuotationOrderItemModel) {
                if ([quotationOrderItem.num2 integerValue] != 0) {
                    _haveNum2 = YES;
                    break;
                }
            }
            for (QuotationOrderItem *quotationOrderItem in _arrayQuotationOrderItemModel) {
                if ([quotationOrderItem.num3 integerValue] != 0) {
                    _haveNum3 = YES;
                    break;
                }
            }
//            self.inquiryOrderCodeAndTitle.text = [NSString stringWithFormat:@"修改报价/%@",_inquiryOrder.title];
            
            _supplierTaxRateTemp = [_quotationOrder.supplierTaxRate doubleValue];
            
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
        } else if (section == 1) {
//            return 1+1+2+1;
            return 1;
        } else if (section == 2) {
            return 0;
        } else if (section < 1+1+1+_arrayQuotationOrderItemModel.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[section - 3];
                if (quotationOrderItem.isSkip.integerValue == 0) {//暂不报价
                    return 2;
                } else {//启动报价
                    return 1;
                }
            }
        } else if (section == 1+1+1+_arrayQuotationOrderItemModel.count) {
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
        } else if (section < 1+1+1+_arrayQuotationOrderItemModel.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[section - 3];
                if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"] && [quotationOrderItem.isSkip integerValue] == 1) {
                    return 1;
                } else {
                    return 1+1+[_inquiryOrder.tempPriceDetailCount integerValue]+2+2;
                }
            }
        } else if (section == 1+1+1+_arrayQuotationOrderItemModel.count) {
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
            return 50;
        } else if (indexPath.section == 1) {
            return 40;
        } else if (indexPath.section == 2) {
            return 0;
        } else if (indexPath.section < 1+1+1+_arrayQuotationOrderItemModel.count) {
            if (indexPath.row == 0) {
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 3];
                if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
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
        } else if (indexPath.section == 1+1+1+_arrayQuotationOrderItemModel.count) {
            return 100-19;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (indexPath.section == 0) {
            return 50;
        } else if (indexPath.section == 1) {
            return 40;
        } else if (indexPath.section == 2) {
            return 0;
        } else if (indexPath.section < 1+1+1+_arrayQuotationOrderItemModel.count) {
            if (indexPath.row == 0) {
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 3];
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
        } else if (indexPath.section == 1+1+1+_arrayQuotationOrderItemModel.count) {
            return 100-19;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 88) {
        return 1+1+1+_arrayQuotationOrderItemModel.count+1;
    } else if (tableView.tag == 89) {
        return 1+1+1+_arrayQuotationOrderItemModel.count+1;
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
        } else if (section < 1+1+1+_arrayQuotationOrderItemModel.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == 1+1+1+_arrayQuotationOrderItemModel.count) {
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
        } else if (section < 1+1+1+_arrayQuotationOrderItemModel.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == 1+1+1+_arrayQuotationOrderItemModel.count) {
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
        } else if (section < 1+1+1+_arrayQuotationOrderItemModel.count) {
            if (section == 1+1+_arrayQuotationOrderItemModel.count) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == 1+1+1+_arrayQuotationOrderItemModel.count) {
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
        } else if (section < 1+1+1+_arrayQuotationOrderItemModel.count) {
            if (section == 1+1+_arrayQuotationOrderItemModel.count) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == 1+1+1+_arrayQuotationOrderItemModel.count) {
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
        } else if (section < 1+1+1+_arrayQuotationOrderItemModel.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewYiBaoJia.hidden = YES;
            view.viewWeiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            
            InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 3];
            QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[section - 3];
            
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
            view.labelName.text = [NSString stringWithFormat:@"%ld、%@",section-3+1,partNumber_specifications];;
            view.label00.textColor = colorRGB(0, 168, 255);
            view.label0.textColor = colorRGB(0, 168, 255);
            view.label0.text  = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:nil;
            
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 integerValue]*[quotationOrderItem.price1 doubleValue];
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
            
            view.buttonOpen.tag = section-3;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-3;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                view.textFieldZongjia.hidden = NO;
            } else {
                view.textFieldZongjia.hidden = YES;
            }
            
            view.textFieldZongjia.delegate = self;
            view.textFieldZongjia.tag = section-3;
            view.textFieldZongjia.inputAccessoryView = [self addToolbar];
            [view.textFieldZongjia addTarget:self action:@selector(price1TextField:) forControlEvents:UIControlEventEditingChanged];
            if ([quotationOrderItem.price1 integerValue] == 0) {
                view.textFieldZongjia.text = @"0";
            } else {
                view.textFieldZongjia.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%@",quotationOrderItem.price1]:nil;
            }
            return view;
        } else if (section == 1+1+1+_arrayQuotationOrderItemModel.count) {
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
        } else if (section < 1+1+1+_arrayQuotationOrderItemModel.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewYiBaoJia.hidden = YES;
            view.viewWeiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            
            InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 3];
            QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[section - 3];
            
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
            view.label00.textColor = colorRGB(0, 168, 255);
            view.label0.textColor = colorRGB(0, 168, 255);
            view.label0.text  = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:nil;
            
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 integerValue]*[quotationOrderItem.price1 doubleValue];
            view.label1.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            
            view.label2.text  = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label2DanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            
            view.label0Wei.text = @"未报价";
            view.label0Wei.textColor = colorRGB(0, 168, 255);
            view.label1Wei.text = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label1WeiDanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            view.labelZanBuYuanYin.text = [NSString stringWithFormat:@"原因:%@",quotationOrderItem.skipRemark];
            
            view.buttonOpen.tag = section-3;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-3;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            return view;
        } else if (section == 1+1+1+_arrayQuotationOrderItemModel.count) {
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
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 10 || view.tag == 11 || view.tag == 19921125 || view.tag == 19921126) {
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
        } else if (indexPath.section == 1) {
//            if (indexPath.row == 0) {
//                MingXiQueRenBaoJia01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia01" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.view1.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
//
//                return cell;
//            } else if (indexPath.row == 1) {
//                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.label0.text = [NSString stringWithFormat:@"小计\n(共%ld种零件)",_arrayInquiryOrderItemModel.count];
//                cell.label1.text = _quotationOrder.subtotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.subtotalPrice1 doubleValue]]:@"0.00";
//                return cell;
//            } else if (indexPath.row < 1+1+2) {
//                XiuGaiBaoJia3Cell00 *cell = [tableView dequeueReusableCellWithIdentifier:@"xiuGaiBaoJia3Cell00" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                if (indexPath.row < 1+1+1) {
//                    cell.label0.text = @"杂费";
//                    if ([_quotationOrder.cost1 integerValue] == 0) {
//                        cell.textField1.placeholder = @"0";
//                    } else {
//                        cell.textField1.text = _quotationOrder.cost1?[NSString stringWithFormat:@"%@",_quotationOrder.cost1]:nil;
//                    }
//                } else {
//                    cell.label0.text = @"运费";
//                    if ([_quotationOrder.shipPrice1 integerValue] == 0) {
//                        cell.textField1.placeholder = @"0";
//                    } else {
//                        cell.textField1.text = _quotationOrder.shipPrice1?[NSString stringWithFormat:@"%@",_quotationOrder.shipPrice1]:nil;
//                    }
//
//                }
//
//                cell.textField1.tag = indexPath.row - 2;
//                cell.textField1.delegate = self;
//                cell.textField1.inputAccessoryView = [self addToolbar];
//                [cell.textField1 addTarget:self action:@selector(total1cost:) forControlEvents:UIControlEventEditingChanged];
//
//                return cell;
//            } else if (indexPath.row == 1+1+2) {
//                MingXiQueRenBaoJia03 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia03" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.view0.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
//                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrder.supplierTaxRate doubleValue]*100];
//                cell.label0.text = [NSString stringWithFormat:@"总计\n(含税价%@%@)",stringTaxRate,@"%"];
//                cell.label1.text = _quotationOrder.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.totalPrice1 doubleValue]]:@"0.00";
//                return cell;
//            } else {
//                return nil;
//            }
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
        } else if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section < 1+1+1+_arrayQuotationOrderItemModel.count) {
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
                
                InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 3];
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 3];
                
                if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
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
                
                if (_arrayQuotationOrderItemModel.count == 1) {
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
                cell.dyzPartNumber.text = [NSString stringWithFormat:@"%ld、%@",indexPath.section-3+1,partNumber_specifications];
                cell.materialName.text = inquiryOrderItem.materialName2.length>0?inquiryOrderItem.materialName2:@"--";
                
                cell.dyzPartName.text = inquiryOrderItem.partName.length>0?inquiryOrderItem.partName:@"--";
                
                if ([NSString SizeUnit:inquiryOrderItem.sizeUnit]) {
                    cell.sizeLWHUnit.text = [NSString stringWithFormat:@"长 %.2f * 宽 %.2f * 高 %.2f %@",[inquiryOrderItem.length doubleValue],[inquiryOrderItem.width doubleValue],[inquiryOrderItem.height doubleValue],[NSString SizeUnit:inquiryOrderItem.sizeUnit]];
                } else {
                    cell.sizeLWHUnit.text = @"--";
                }
                
                cell.num123.text = [NSString stringWithFormat:@"%@%@",inquiryOrderItem.num1,[NSString QuantityUnit:inquiryOrderItem.quantityUnit].length>0?[NSString QuantityUnit:inquiryOrderItem.quantityUnit]:@""];
                
                cell.labelTargetPrice.hidden = NO;
                if ([inquiryOrderItem.isVisiblePrice integerValue] == 1) {
                    cell.labelTargetPrice.text = [NSString stringWithFormat:@"未税核算价:%@",inquiryOrderItem.price1.stringValue];
                } else {
                    cell.labelTargetPrice.text = @"未税核算价:--";
                }
                
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
                [cell.buttonDetail setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonZanBuBaoJia.tag = indexPath.section - 3;
                [cell.buttonZanBuBaoJia addTarget:self action:@selector(buttonZanBuBaoJiaClickZongJia:) forControlEvents:UIControlEventTouchUpInside];
                
//                cell.textFieldZongJia.delegate = self;
//                cell.textFieldZongJia.tag = indexPath.section - 3;
//                cell.textFieldZongJia.inputAccessoryView = [self addToolbar];
//                [cell.textFieldZongJia addTarget:self action:@selector(price1TextField:) forControlEvents:UIControlEventEditingChanged];
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
                
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 3];
                
                cell.textFieldPrice.delegate = self;
                cell.textFieldPrice.tag = indexPath.section - 3;
                cell.textFieldPrice.inputAccessoryView = [self addToolbar];
                [cell.textFieldPrice addTarget:self action:@selector(price1TextField:) forControlEvents:UIControlEventEditingChanged];
                cell.textFieldPrice.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%@",quotationOrderItem.price1]:nil;
                
                cell.textFieldResponseDate.tag = indexPath.section - 3;
                cell.textFieldResponseDate.tintColor = [UIColor clearColor];
                cell.textFieldResponseDate.inputView = [UIView new];
                [cell.textFieldResponseDate addTarget:self action:@selector(textFieldSupplierDeliverTime:) forControlEvents:UIControlEventEditingDidBegin];
                if (quotationOrderItem.supplierDeliverTime) {
                    cell.textFieldResponseDate.text = [[quotationOrderItem.supplierDeliverTime componentsSeparatedByString:@" "] firstObject];
                } else {
                    cell.textFieldResponseDate.text = nil;
                }
                
                cell.textFieldPartRemark.tag = indexPath.section - 3;
                cell.textFieldPartRemark.inputAccessoryView = [self addToolbar];
                [cell.textFieldPartRemark addTarget:self action:@selector(textFieldSupplierRemark:) forControlEvents:UIControlEventEditingChanged];
                cell.textFieldPartRemark.text = quotationOrderItem.supplierRemark?quotationOrderItem.supplierRemark:nil;
                
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 1+1+1+_arrayQuotationOrderItemModel.count) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 10 || view.tag == 11 || view.tag == 19921125 || view.tag == 19921126) {
                    [view removeFromSuperview];
                }
            }
            
            UITextView *oneTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, kMainW-20, 55)];
            oneTextView.font = [UIFont systemFontOfSize:14];
            oneTextView.delegate = self;
            oneTextView.text = _quotationOrder.remark;
            oneTextView.tag = 19921126;
            [cell.contentView addSubview:oneTextView];
//            oneTextView.layer.cornerRadius = 7;
//            oneTextView.layer.borderWidth = 0.5;
//            oneTextView.layer.borderColor = colorRGB(209, 209, 209).CGColor;
            oneTextView.inputAccessoryView = [self addToolbar];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, oneTextView.frame.size.width, 16)];
            label.text = @"请输入报价备注";
            label.textColor = colorRGB(177, 177, 177);
            label.font = [UIFont systemFontOfSize:14];
            label.tag = 19921125;
            [oneTextView addSubview:label];
            
            if (oneTextView.text.length > 0) {
                label.hidden = YES;
            } else {
                label.hidden = NO;
            }
            
            return cell;
        } else {
            return nil;
        }
    } else if (tableView.tag == 89) {
        if (indexPath.section == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 10 || view.tag == 11 || view.tag == 19921125 || view.tag == 19921126) {
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
        } else if (indexPath.section == 1) {
//            if (indexPath.row == 0) {
//                MingXiQueRenBaoJia01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia01" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.view1.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
//                return cell;
//            } else if (indexPath.row == 1) {
//                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.label0.text = [NSString stringWithFormat:@"小计\n(共%ld种零件)",_arrayInquiryOrderItemModel.count];
//                cell.label1.text = _quotationOrder.subtotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.subtotalPrice1 doubleValue]]:@"0.00";
//
//                return cell;
//            } else if (indexPath.row < 1+1+[_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue]) {
//                XiuGaiBaoJia3Cell00 *cell = [tableView dequeueReusableCellWithIdentifier:@"xiuGaiBaoJia3Cell00" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                if (indexPath.row < 1+1+[_inquiryOrder.tempCostDetailCount integerValue]) {
//                    cell.label0.text = [_inquiryOrder valueForKey:[NSString stringWithFormat:@"tempCostDetailName%ld",indexPath.row-1]];
//                    NSNumber *supplierTempCost1DetailValue = [_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%ld",indexPath.row-1]];
//                    if ([supplierTempCost1DetailValue integerValue] == 0) {
//                        cell.textField1.placeholder = @"0";
//                    } else {
//                        cell.textField1.text = supplierTempCost1DetailValue?[NSString stringWithFormat:@"%@",supplierTempCost1DetailValue]:nil;
//                    }
//                } else {
//                    cell.label0.text = [_inquiryOrder valueForKey:[NSString stringWithFormat:@"tempShipPriceDetailName%ld",indexPath.row-1-[_inquiryOrder.tempCostDetailCount integerValue]]];
//                    NSNumber *supplierTempShipPrice1DetailValue = [_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%ld",indexPath.row-1-[_inquiryOrder.tempCostDetailCount integerValue]]];
//                    if ([supplierTempShipPrice1DetailValue integerValue] == 0) {
//                        cell.textField1.placeholder = @"0";
//                    } else {
//                        cell.textField1.text = supplierTempShipPrice1DetailValue?[NSString stringWithFormat:@"%@",supplierTempShipPrice1DetailValue]:nil;
//                    }
//                }
//
//                cell.textField1.tag = indexPath.row - 2;
//                cell.textField1.delegate = self;
//                cell.textField1.inputAccessoryView = [self addToolbar];
//                [cell.textField1 addTarget:self action:@selector(total1costMingXi:) forControlEvents:UIControlEventEditingChanged];
//
//                return cell;
//            } else if (indexPath.row == 1+1+[_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue]) {
//                MingXiQueRenBaoJia03 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia03" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.view0.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
//                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrder.supplierTaxRate doubleValue]*100];
//                cell.label0.text = [NSString stringWithFormat:@"总计\n(含税价%@%@)",stringTaxRate,@"%"];
//                cell.label1.text = _quotationOrder.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.totalPrice1 doubleValue]]:@"0.00";
//
//
//                return cell;
//            } else {
//                return nil;
//            }
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
        } else if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section < 1+1+1+_arrayQuotationOrderItemModel.count) {
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
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 3];
                
                if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
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
                        [cell.buttonZanBuBaoJia setTitle:@"暂不报价" forState:UIControlStateNormal];
                    }
                } else {

                }
                if (_arrayQuotationOrderItemModel.count == 1) {
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
                cell.dyzPartNumber.text = [NSString stringWithFormat:@"%ld、%@",indexPath.section-3+1,partNumber_specifications];
                cell.materialName.text = inquiryOrderItem.materialName2.length>0?inquiryOrderItem.materialName2:@"--";
                
                cell.dyzPartName.text = inquiryOrderItem.partName.length>0?inquiryOrderItem.partName:@"--";  
                
                if ([NSString SizeUnit:inquiryOrderItem.sizeUnit]) {
                    cell.sizeLWHUnit.text = [NSString stringWithFormat:@"长 %.2f * 宽 %.2f * 高 %.2f %@",[inquiryOrderItem.length doubleValue],[inquiryOrderItem.width doubleValue],[inquiryOrderItem.height doubleValue],[NSString SizeUnit:inquiryOrderItem.sizeUnit]];
                } else {
                    cell.sizeLWHUnit.text = @"--";
                }
                
                cell.num123.text = [NSString stringWithFormat:@"%@%@",inquiryOrderItem.num1,[NSString QuantityUnit:inquiryOrderItem.quantityUnit].length>0?[NSString QuantityUnit:inquiryOrderItem.quantityUnit]:@""];
                
                cell.labelTargetPrice.hidden = NO;
                if ([inquiryOrderItem.isVisiblePrice integerValue] == 1) {
                    cell.labelTargetPrice.text = [NSString stringWithFormat:@"未税核算价:%@",inquiryOrderItem.price1.stringValue];
                } else {
                    cell.labelTargetPrice.text = @"未税核算价:--";
                }
                
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
                [cell.buttonDetail setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonZanBuBaoJia.tag = indexPath.section - 3;
                [cell.buttonZanBuBaoJia addTarget:self action:@selector(buttonZanBuBaoJiaClick:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            } else if (indexPath.row == 1) {
                MingXiQueRenBaoJia010 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia010" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.view1.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
                
                InquiryOrderItem *model = _arrayInquiryOrderItemModel[indexPath.section - 3];
                
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 3];
                cell.label1.text  = quotationOrderItem.num1?[NSString QuantityUnit:model.quantityUnit].length != 0?[NSString stringWithFormat:@"%@(%@)",quotationOrderItem.num1,[NSString QuantityUnit:model.quantityUnit]]:[NSString stringWithFormat:@"%@",quotationOrderItem.num1]:@"--";
    
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]) {
                XiuGaiBaoJia3Cell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"xiuGaiBaoJia3Cell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.label0.text = [_inquiryOrder valueForKey:[NSString stringWithFormat:@"tempPriceDetailName%ld",indexPath.row-1]];
                
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 3];
                
                NSNumber *supplierTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%ld",indexPath.row-1]];
                
                if ([supplierTempPrice1DetailValue integerValue] == 0) {
                    cell.textField1.placeholder = @"0";
                } else {
                    cell.textField1.text = supplierTempPrice1DetailValue?[NSString stringWithFormat:@"%@",supplierTempPrice1DetailValue]:nil;
                }

                cell.textFieldSuperView1.tag = indexPath.section - 3;
                cell.textField1.tag = indexPath.row-2;
                cell.textField1.delegate = self;
                cell.textField1.inputAccessoryView = [self addToolbar];
                [cell.textField1 addTarget:self action:@selector(price1MingXi:) forControlEvents:UIControlEventEditingChanged];
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]+2) {
                MingXiQueRenBaoJia03 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia03" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.view0.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 3];
                if (indexPath.row == 2+[_inquiryOrder.tempPriceDetailCount integerValue]) {
                    cell.label0.text = @"含税单价";
                    cell.label1.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:@"0.00";
                    
                } else if (indexPath.row == 2+[_inquiryOrder.tempPriceDetailCount integerValue]+1) {
                    cell.label0.text = @"不含税单价";
                    cell.label1.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:nil;
                    
                }
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]+3) {//回复交期
                MXBaoJiaCell06 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell06" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 3];
                cell.labelTempPriceDetailName.text = @"回复交期";
                
                cell.textField.placeholder = @"请选择";
                cell.textField.tag = indexPath.section - 3;
                cell.textField.tintColor = [UIColor clearColor];
                cell.textField.inputView = [UIView new];
                [cell.textField addTarget:self action:@selector(textFieldSupplierDeliverTime:) forControlEvents:UIControlEventEditingDidBegin];
                if (quotationOrderItem.supplierDeliverTime) {
                    cell.textField.text = [[quotationOrderItem.supplierDeliverTime componentsSeparatedByString:@" "] firstObject];
                } else {
                    cell.textField.text = nil;
                }
                
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]+4) {//零件备注
                MXBaoJiaCell07 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell07" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 3];
                cell.labelTempPriceDetailName.text = @"零件备注";
                
                cell.textField.placeholder = @"请输入";
                cell.textField.tag = indexPath.section - 3;
                cell.textField.inputAccessoryView = [self addToolbar];
                [cell.textField addTarget:self action:@selector(textFieldSupplierRemark:) forControlEvents:UIControlEventEditingChanged];
                cell.textField.text = quotationOrderItem.supplierRemark?quotationOrderItem.supplierRemark:nil;
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 1+1+1+_arrayQuotationOrderItemModel.count) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 10 || view.tag == 11 || view.tag == 19921125 || view.tag == 19921126) {
                    [view removeFromSuperview];
                }
            }
            
            UITextView *oneTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, kMainW-20, 55)];
            oneTextView.font = [UIFont systemFontOfSize:14];
            oneTextView.delegate = self;
            oneTextView.text = _quotationOrder.remark;
            oneTextView.tag = 19921126;
            [cell.contentView addSubview:oneTextView];
//            oneTextView.layer.cornerRadius = 7;
//            oneTextView.layer.borderWidth = 0.5;
//            oneTextView.layer.borderColor = colorRGB(209, 209, 209).CGColor;
            oneTextView.inputAccessoryView = [self addToolbar];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, oneTextView.frame.size.width, 16)];
            label.text = @"请输入报价备注";
            label.textColor = colorRGB(177, 177, 177);
            label.font = [UIFont systemFontOfSize:14];
            label.tag = 19921125;
            [oneTextView addSubview:label];
            
            if (oneTextView.text.length > 0) {
                label.hidden = YES;
            } else {
                label.hidden = NO;
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
    NSLog(@">>>%ld<",inquiryOrderItem.inquiryOrderItemFiles.count);
    
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

- (void)buttonZanBuBaoJiaClickZongJia:(UIButton *)sender {
    QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[sender.tag];
    if ([sender.currentTitle isEqualToString:@"暂不报价"]) {
        _eChooseSkipRemarkView3Kind = [[EChooseSkipRemarkView3Kind alloc] initWithFrame:self.view.frame defaultSkipRemark:quotationOrderItem.skipRemark buttonConfirmClick:^(NSString *confirmTax) {
            quotationOrderItem.isSkip = [NSNumber numberWithInteger:1];
            quotationOrderItem.skipRemark = confirmTax;
            
            quotationOrderItem.price1 = [NSNumber numberWithDouble:0];
            
            [_tableView reloadData];
            [self calculateTotalPrice1];
            
            [sender setTitle:@"启动报价" forState:UIControlStateNormal];
            
            BOOL enterAble = true;
            self.buttonBaoJia.backgroundColor = colorRGB(0, 168, 255);
            self.buttonBaoJia.enabled = YES;
            for (QuotationOrderItem *quotationOrderItem in _arrayQuotationOrderItemModel) {
                if (!(([quotationOrderItem.price1 doubleValue] > 0) || [quotationOrderItem.isSkip integerValue] == 1)) {
                    enterAble = false;
                    self.buttonBaoJia.backgroundColor = colorRGB(180, 180, 180);
                    self.buttonBaoJia.enabled = NO;
                    break;
                }
            }
            
            if ([_quotationOrder.totalPrice1 doubleValue] <= 0) {
                self.buttonBaoJia.backgroundColor = colorRGB(180, 180, 180);
                self.buttonBaoJia.enabled = NO;
            }
        }];
        [self.view addSubview:_eChooseSkipRemarkView3Kind];
    } else if ([sender.currentTitle isEqualToString:@"启动报价"]) {
        quotationOrderItem.isSkip = [NSNumber numberWithInteger:0];
        quotationOrderItem.skipRemark = nil;
        
        [sender setTitle:@"暂不报价" forState:UIControlStateNormal];
        
        //解决self.button 首先所有的零件都处理过，变亮了，最后有开启报价，没填数据前self.button颜色变成高亮
        BOOL enterAble = true;
        self.buttonBaoJia.backgroundColor = colorRGB(0, 168, 255);
        self.buttonBaoJia.enabled = YES;
        for (QuotationOrderItem *quotationOrderItem in _arrayQuotationOrderItemModel) {
            if (!(([quotationOrderItem.price1 doubleValue] > 0) || [quotationOrderItem.isSkip integerValue] == 1)) {
                enterAble = false;
                self.buttonBaoJia.backgroundColor = colorRGB(180, 180, 180);
                self.buttonBaoJia.enabled = NO;
                break;
            }
        }
        
        if ([_quotationOrder.totalPrice1 doubleValue] <= 0) {
            self.buttonBaoJia.backgroundColor = colorRGB(180, 180, 180);
            self.buttonBaoJia.enabled = NO;
        }
        
        [_tableView reloadData];
    }
}

- (void)buttonZanBuBaoJiaClick:(UIButton *)sender {
    QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[sender.tag];
    if ([sender.currentTitle isEqualToString:@"暂不报价"]) {
        _eChooseSkipRemarkView3Kind = [[EChooseSkipRemarkView3Kind alloc] initWithFrame:self.view.frame defaultSkipRemark:quotationOrderItem.skipRemark buttonConfirmClick:^(NSString *confirmTax) {
            quotationOrderItem.isSkip = [NSNumber numberWithInteger:1];
            quotationOrderItem.skipRemark = confirmTax;
            for (int i = 0; i < [_inquiryOrder.tempPriceDetailCount integerValue]; i++) {
                [quotationOrderItem setValue:nil forKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%d",i+1]];
            }
            quotationOrderItem.price1 = [NSNumber numberWithDouble:0];
            
            [_tableView1 reloadData];
            [self calculateTotalPrice1MingXi];
            
            [sender setTitle:@"启动报价" forState:UIControlStateNormal];
            
            BOOL enterAble = true;
            self.buttonBaoJia.backgroundColor = colorRGB(0, 168, 255);
            self.buttonBaoJia.enabled = YES;
            for (QuotationOrderItem *quotationOrderItem in _arrayQuotationOrderItemModel) {
                if (!(([quotationOrderItem.price1 doubleValue] > 0) || [quotationOrderItem.isSkip integerValue] == 1)) {
                    enterAble = false;
                    self.buttonBaoJia.backgroundColor = colorRGB(180, 180, 180);
                    self.buttonBaoJia.enabled = NO;
                    break;
                }
            }
            
            if ([_quotationOrder.totalPrice1 doubleValue] <= 0) {
                self.buttonBaoJia.backgroundColor = colorRGB(180, 180, 180);
                self.buttonBaoJia.enabled = NO;
            }
        }];
        [self.view addSubview:_eChooseSkipRemarkView3Kind];
    } else if ([sender.currentTitle isEqualToString:@"启动报价"]) {
        quotationOrderItem.isSkip = [NSNumber numberWithInteger:0];
        quotationOrderItem.skipRemark = nil;
        
        [sender setTitle:@"暂不报价" forState:UIControlStateNormal];
        
        //解决self.button 首先所有的零件都处理过，变亮了，最后有开启报价，没填数据前self.button颜色变成高亮
        BOOL enterAble = true;
        self.buttonBaoJia.backgroundColor = colorRGB(0, 168, 255);
        self.buttonBaoJia.enabled = YES;
        for (QuotationOrderItem *quotationOrderItem in _arrayQuotationOrderItemModel) {
            if (!(([quotationOrderItem.price1 doubleValue] > 0) || [quotationOrderItem.isSkip integerValue] == 1)) {
                enterAble = false;
                self.buttonBaoJia.backgroundColor = colorRGB(180, 180, 180);
                self.buttonBaoJia.enabled = NO;
                break;
            }
        }
        
        if ([_quotationOrder.totalPrice1 doubleValue] <= 0) {
            self.buttonBaoJia.backgroundColor = colorRGB(180, 180, 180);
            self.buttonBaoJia.enabled = NO;
        }
        
        [_tableView1 reloadData];
    }
}

- (void)buttonIndexPath00 {
    if ([_inquiryOrder.inquiryType isEqualToString:@"COM"]||[_inquiryOrder.inquiryType isEqualToString:@"DIR"]) {
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
    
    if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
        if (!_eChooseTaxRateView5Kind) {
            NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrder.supplierTaxRate doubleValue]*100];
            _eChooseTaxRateView5Kind = [[EChooseTaxRateView5Kind alloc] initWithFrame:self.view.frame defaultTax:stringTaxRate buttonConfirmClick:^(NSString *confirmTax) {
                double tax = [confirmTax doubleValue]/100.0;
                NSLog(@"-->%@",[NSNumber numberWithDouble:tax]);//56时 有问题 0.5600000000000001
                _quotationOrder.supplierTaxRate = [NSNumber numberWithDouble:tax];
                if ([_inquiryOrder.isQuotationTemplate integerValue] == 1) {
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

#pragma mark EChooseTaxRateViewDeegate
- (void)eChooseTaxRateViewButton:(UIButton *)sender {
    if (sender.tag == 0) {
        _quotationOrder.supplierTaxRate = [NSNumber numberWithDouble:_supplierTaxRateTemp];
        [_eChooseTaxRateView removeFromSuperview];
        _eChooseTaxRateView = nil;
        
        if ([_inquiryOrder.isQuotationTemplate integerValue] == 1) {
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    BOOL enterAble = true;
    self.buttonBaoJia.backgroundColor = colorRGB(0, 168, 255);
    self.buttonBaoJia.enabled = YES;
    for (QuotationOrderItem *quotationOrderItem in _arrayQuotationOrderItemModel) {
        if (!(([quotationOrderItem.price1 doubleValue] > 0) || [quotationOrderItem.isSkip integerValue] == 1)) {
            enterAble = false;
            self.buttonBaoJia.backgroundColor = colorRGB(180, 180, 180);
            self.buttonBaoJia.enabled = NO;
            break;
        }
    }
    if ([_quotationOrder.totalPrice1 doubleValue] <= 0) {
        self.buttonBaoJia.backgroundColor = colorRGB(180, 180, 180);
        self.buttonBaoJia.enabled = NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"-.1234567890"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

- (void)price1TextField:(UITextField *)sender {
    QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[sender.tag];
    NSString *string;
    NSArray *array = [sender.text componentsSeparatedByString:@"¥"];
    string = [array lastObject];
    NSArray *array1 = [string componentsSeparatedByString:@"."];
    if (array1.count == 2) {
        NSString *stringR = [array1 lastObject];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"¥%@.%@",[array1 firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        }
    }
    NSString *string1;
    NSArray *array2 = [sender.text componentsSeparatedByString:@"¥"];
    string1 = [array2 lastObject];
    quotationOrderItem.price1 = [NSNumber numberWithDouble:[string1 doubleValue]];
    [self calculateTotalPrice1];
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
        QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[sender.tag];
        
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
    QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[sender.tag];
    if (quotationOrderItem) {
        quotationOrderItem.supplierRemark = sender.text;
    }
}


- (void)price1MingXi:(UITextField *)sender {
    UIView *view = sender.superview;
//    NSLog(@"price1MingXi %ld %ld",view.tag,sender.tag);
    QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[view.tag];
    if (quotationOrderItem) {
        [quotationOrderItem setValue:[NSNumber numberWithDouble:[sender.text doubleValue]] forKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%ld",sender.tag+1]];
    }
    double price1 = 0;
    for (int i = 0; i < [_inquiryOrder.tempPriceDetailCount integerValue]; i++) {
        NSNumber *supplierTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%d",i+1]];
        price1 = price1 + [supplierTempPrice1DetailValue doubleValue];
    }
    price1 = [[NSString stringWithFormat:@"%.2f",price1] doubleValue];
    quotationOrderItem.price1 = [NSNumber numberWithDouble:price1];
    
    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2+[_inquiryOrder.tempPriceDetailCount integerValue] inSection:view.tag+3],[NSIndexPath indexPathForRow:2+[_inquiryOrder.tempPriceDetailCount integerValue]+1 inSection:view.tag+3]] withRowAnimation:UITableViewRowAnimationNone];
    
    [self calculateTotalPrice1MingXi];
}

- (void)total1cost:(UITextField *)sender {
    
    NSString *string;
    NSArray *array = [sender.text componentsSeparatedByString:@"¥"];
    string = [array lastObject];
    NSArray *array1 = [string componentsSeparatedByString:@"."];
    if (array1.count == 2) {
        NSString *stringR = [array1 lastObject];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"¥%@.%@",[array1 firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        }
    }
    NSString *string1;
    NSArray *array2 = [sender.text componentsSeparatedByString:@"¥"];
    string1 = [array2 lastObject];
    
    if (sender.tag == 0) {
        _quotationOrder.cost1 = [NSNumber numberWithDouble:[string1 doubleValue]];
    }
    if (sender.tag == 1) {
        _quotationOrder.shipPrice1 = [NSNumber numberWithDouble:[string1 doubleValue]];
    }
    [self calculateTotalPrice1];
}

- (void)total1costMingXi:(UITextField *)sender {
//    NSLog(@"total1costMingXi %ld",sender.tag);
    NSString *string = sender.text;
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count == 2) {
        NSString *stringR = [array lastObject];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        }
    }
//    NSLog(@"%ld",sender.tag);
    
    if (sender.tag < [_inquiryOrder.tempCostDetailCount integerValue]) {
        [_quotationOrder setValue:[NSNumber numberWithDouble:[sender.text doubleValue]] forKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%ld",sender.tag+1]];
    } else if (sender.tag < [_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue]) {
        [_quotationOrder setValue:[NSNumber numberWithDouble:[sender.text doubleValue]] forKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%ld",sender.tag+1-[_inquiryOrder.tempCostDetailCount integerValue]]];
    }
    [self calculateTotalPrice1MingXi];
}

- (QuotationOrderItem *)getQuotationOrderItemByInquiryOrderItemId:(NSString *)inquiryOrderItemId {
    QuotationOrderItem *returnQuotationOrderItem = nil;
    for (QuotationOrderItem *quotationOrderItem in _arrayQuotationOrderItemModel) {
        if ([quotationOrderItem.inquiryOrderItem.inquiryOrderItemId isEqualToString:inquiryOrderItemId]) {
            returnQuotationOrderItem = quotationOrderItem;
            break;
        }
    }
    return returnQuotationOrderItem;
}
- (void)calculateTotalPrice1 {
    double totalPrice = 0;
    totalPrice = totalPrice + [_quotationOrder.cost1 doubleValue] + [_quotationOrder.shipPrice1 doubleValue];
    double subtotalPrice = 0;
    for (QuotationOrderItem *quotationOrderItem in _arrayQuotationOrderItemModel) {
        if ([quotationOrderItem.isSkip integerValue] == 0) {
            subtotalPrice = subtotalPrice + [quotationOrderItem.num1 integerValue]*[quotationOrderItem.price1 doubleValue];
        }
    }
    subtotalPrice = [[NSString stringWithFormat:@"%.2f",subtotalPrice] doubleValue];
    totalPrice = totalPrice + subtotalPrice;
    _quotationOrder.subtotalPrice1 = [NSNumber numberWithDouble:subtotalPrice];
    _quotationOrder.totalPrice1 = [NSNumber numberWithDouble:totalPrice];
    
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1],[NSIndexPath indexPathForRow:1+1+2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)calculateTotalPrice1MingXi {
    double totalPrice = 0;
    
    double costPrice = 0;
    for (int i = 0; i < [_inquiryOrder.tempCostDetailCount integerValue]; i++) {
        NSNumber *supplierTempCost1DetailValue = [_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%d",i+1]];
        costPrice = costPrice+[supplierTempCost1DetailValue doubleValue];
    }
    totalPrice = totalPrice + costPrice;
    _quotationOrder.cost1 = [NSNumber numberWithDouble:costPrice];
    double shipPrice = 0;
    for (int i = 0; i < [_inquiryOrder.tempShipPriceDetailCount integerValue]; i++) {
        NSNumber *supplierTempShipPrice1DetailValue = [_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%d",i+1]];
        shipPrice = shipPrice+[supplierTempShipPrice1DetailValue doubleValue];
    }
    totalPrice = totalPrice + shipPrice;
    _quotationOrder.shipPrice1 = [NSNumber numberWithDouble:shipPrice];
    
    
    double subtotalPrice = 0;
    for (QuotationOrderItem *quotationOrderItem in _arrayQuotationOrderItemModel) {
        if ([quotationOrderItem.isSkip integerValue] == 0) {
            subtotalPrice = subtotalPrice + [quotationOrderItem.num1 integerValue]*[quotationOrderItem.price1 doubleValue];
        }
    }
    subtotalPrice = [[NSString stringWithFormat:@"%.2f",subtotalPrice] doubleValue];
    totalPrice = totalPrice + subtotalPrice;
    _quotationOrder.subtotalPrice1 = [NSNumber numberWithDouble:subtotalPrice];
    
    _quotationOrder.totalPrice1 = [NSNumber numberWithDouble:totalPrice];
    
//    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1],[NSIndexPath indexPathForRow:1+1+[_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue] inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}

- (IBAction)buttonXiuGaiBaoJia:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"提交报价"]) {
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        if ([_inquiryOrder.isQuotationTemplate integerValue] == 1) {
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
            QuotationOrder *quotationOrder = [[QuotationOrder alloc] init];
            quotationOrder.quotationOrderId = _quotationOrder.quotationOrderId;
            quotationOrder.manufacturerId = _quotationOrder.manufacturerId;
            quotationOrder.inquiryOrderId = _quotationOrder.inquiryOrderId;
            quotationOrder.editId = [GlobalSettingManager shareGlobalSettingManager].memberId;
            quotationOrder.editName = loginModel.accountName;
            quotationOrder.status = _quotationOrder.status;
            
            quotationOrder.cost1 = _quotationOrder.cost1;
            quotationOrder.shipPrice1 = _quotationOrder.shipPrice1;
            quotationOrder.subtotalPrice1 = _quotationOrder.subtotalPrice1;
            quotationOrder.totalPrice1 = _quotationOrder.totalPrice1;;
            
            quotationOrder.cost2 = _haveNum2?_quotationOrder.cost2:nil;
            quotationOrder.shipPrice2 = _haveNum2?_quotationOrder.shipPrice2:nil;
            quotationOrder.subtotalPrice2 = _haveNum2?_quotationOrder.subtotalPrice2:nil;
            quotationOrder.totalPrice2 = _haveNum2?_quotationOrder.totalPrice2:nil;
            
            quotationOrder.cost3 = _haveNum3?_quotationOrder.cost3:nil;
            quotationOrder.shipPrice3 = _haveNum3?_quotationOrder.shipPrice3:nil;
            quotationOrder.subtotalPrice3 = _haveNum3?_quotationOrder.subtotalPrice3:nil;
            quotationOrder.totalPrice3 = _haveNum3?_quotationOrder.totalPrice3:nil;
            
            
            NSMutableArray *quotationOrderItems = [[NSMutableArray alloc] init];
            for (QuotationOrderItem *quotationOrderItem in _arrayQuotationOrderItemModel) {
                QuotationOrderItem *obj = [[QuotationOrderItem alloc] init];
                obj.quotationOrderItemId = quotationOrderItem.quotationOrderItemId;
                obj.price1 = quotationOrderItem.price1;
                obj.num1 = quotationOrderItem.num1;
                obj.price2 = _haveNum2?quotationOrderItem.price2:nil;
                obj.num2 = _haveNum2?quotationOrderItem.num2:nil;
                obj.price3 = _haveNum3?quotationOrderItem.price3:nil;
                obj.num3 = _haveNum3?quotationOrderItem.num3:nil;
                obj.isSkip = quotationOrderItem.isSkip;
                if ([quotationOrderItem.isSkip integerValue] == 1) {
                    obj.skipRemark = quotationOrderItem.skipRemark;
                }
                
                for (int i = 0 ; i < [_inquiryOrder.tempPriceDetailCount integerValue]; i++) {
                    [obj setValue:[quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%d",i+1]];
                    if (_haveNum2) {
                        [obj setValue:[quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice2DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempPrice2DetailValue%d",i+1]];
                    }
                    if (_haveNum3) {
                        [obj setValue:[quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice3DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempPrice3DetailValue%d",i+1]];
                    }
                }
                obj.supplierRemark = quotationOrderItem.supplierRemark;
                obj.supplierDeliverTime = quotationOrderItem.supplierDeliverTime;
                [quotationOrderItems addObject:obj];
            }
            quotationOrder.quotationOrderItems = quotationOrderItems;
            
            for (int i = 0 ; i < [_inquiryOrder.tempCostDetailCount integerValue]; i++) {
                [quotationOrder setValue:[_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%d",i+1]];
                if (_haveNum2) {
                    [quotationOrder setValue:[_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempCost2DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempCost2DetailValue%d",i+1]];
                }
                if (_haveNum3) {
                    [quotationOrder setValue:[_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempCost3DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempCost3DetailValue%d",i+1]];
                }
            }
            for (int i = 0 ; i < [_inquiryOrder.tempShipPriceDetailCount integerValue]; i++) {
                [quotationOrder setValue:[_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%d",i+1]];
                if (_haveNum2) {
                    [quotationOrder setValue:[_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempShipPrice2DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempShipPrice2DetailValue%d",i+1]];
                }
                if (_haveNum3) {
                    [quotationOrder setValue:[_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempShipPrice3DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempShipPrice3DetailValue%d",i+1]];
                }
            }
            
            quotationOrder.remark = _quotationOrder.remark;
            MemberResBean *member = [GlobalSettingManager shareGlobalSettingManager].member;
        
            quotationOrder.supplierAccountPeriod = member.enterpriseInfo.accountPeriod;
            quotationOrder.supplierCommision =member.enterpriseInfo.supplierCommision;
            quotationOrder.supplierTaxRate = _quotationOrder.supplierTaxRate;
            
            quotationOrder.isTemporary = _quotationOrder.isTemporary;
            
            postEntityBean.entity = quotationOrder.mj_keyValues;
        } else {
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
            QuotationOrder *quotationOrder = [[QuotationOrder alloc] init];
            quotationOrder.quotationOrderId = _quotationOrder.quotationOrderId;
            quotationOrder.manufacturerId = _quotationOrder.manufacturerId;
            quotationOrder.inquiryOrderId = _quotationOrder.inquiryOrderId;
            quotationOrder.editId = [GlobalSettingManager shareGlobalSettingManager].memberId;
            quotationOrder.editName = loginModel.accountName;
            quotationOrder.status = _quotationOrder.status;
            
            quotationOrder.cost1 = _quotationOrder.cost1;
            quotationOrder.shipPrice1 = _quotationOrder.shipPrice1;
            quotationOrder.subtotalPrice1 = _quotationOrder.subtotalPrice1;
            quotationOrder.totalPrice1 = _quotationOrder.totalPrice1;;
            
            quotationOrder.cost2 = _haveNum2?_quotationOrder.cost2:nil;
            quotationOrder.shipPrice2 = _haveNum2?_quotationOrder.shipPrice2:nil;
            quotationOrder.subtotalPrice2 = _haveNum2?_quotationOrder.subtotalPrice2:nil;
            quotationOrder.totalPrice2 = _haveNum2?_quotationOrder.totalPrice2:nil;
            
            quotationOrder.cost3 = _haveNum3?_quotationOrder.cost3:nil;
            quotationOrder.shipPrice3 = _haveNum3?_quotationOrder.shipPrice3:nil;
            quotationOrder.subtotalPrice3 = _haveNum3?_quotationOrder.subtotalPrice3:nil;
            quotationOrder.totalPrice3 = _haveNum3?_quotationOrder.totalPrice3:nil;
            
            
            NSMutableArray *quotationOrderItems = [[NSMutableArray alloc] init];
            for (QuotationOrderItem *quotationOrderItem in _arrayQuotationOrderItemModel) {
                QuotationOrderItem *obj = [[QuotationOrderItem alloc] init];
                obj.quotationOrderItemId = quotationOrderItem.quotationOrderItemId;
                obj.price1 = quotationOrderItem.price1;
                obj.num1 = quotationOrderItem.num1;
                obj.price2 = _haveNum2?quotationOrderItem.price2:nil;
                obj.num2 = _haveNum2?quotationOrderItem.num2:nil;
                obj.price3 = _haveNum3?quotationOrderItem.price3:nil;
                obj.num3 = _haveNum3?quotationOrderItem.num3:nil;
                
                obj.isSkip = quotationOrderItem.isSkip;
                if ([quotationOrderItem.isSkip integerValue] == 1) {
                    obj.skipRemark = quotationOrderItem.skipRemark;
                }
                obj.supplierRemark = quotationOrderItem.supplierRemark;
                obj.supplierDeliverTime = quotationOrderItem.supplierDeliverTime;
                [quotationOrderItems addObject:obj];
            }
            quotationOrder.quotationOrderItems = quotationOrderItems;
            quotationOrder.remark = _quotationOrder.remark;
            
            MemberResBean *member = [GlobalSettingManager shareGlobalSettingManager].member;
            quotationOrder.supplierAccountPeriod = member.enterpriseInfo.accountPeriod;
            quotationOrder.supplierCommision = member.enterpriseInfo.supplierCommision;
            quotationOrder.supplierTaxRate = _quotationOrder.supplierTaxRate;
            
            quotationOrder.isTemporary = _quotationOrder.isTemporary;
            
            postEntityBean.entity = quotationOrder.mj_keyValues;
        }

        NSDictionary *dic = postEntityBean.mj_keyValues;
        

        
        [HttpMamager postRequestWithURLString:DYZ_quotation_edit parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"修改成功"];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"修改失败"];
            }
            
            BOOL isBreak = false;
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isMemberOfClass:[XunPanXiangQingViewController class]]) {
                    isBreak = true;
                    [self.navigationController popToViewController:vc animated:YES];
                    
         
                }
            }
            
            
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    }
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
