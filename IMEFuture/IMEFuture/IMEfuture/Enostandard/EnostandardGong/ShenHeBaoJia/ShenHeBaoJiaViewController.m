//
//  ShaiXuanBaoJiaViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ShenHeBaoJiaViewController.h"
#import "VoHeader.h"

#import "MingXiQueRenBaoJia01.h"
#import "MingXiQueRenBaoJia010.h"
#import "MingXiQueRenBaoJia02.h"
#import "MingXiQueRenBaoJia03.h"
#import "MXBaoJiaCell01.h"
#import "BaoJiaHeaderView01.h"
#import "MXBaoJiaCell111.h"

#import "XunPanXiangQingViewController.h"

#import "UIView+Toast.h"

#import "EGOrderViewController.h"
#import "CommentUtils.h"
#import "PartDetailsViewController.h"
#import "LingJianXiangQingViewController2.h"
#import "NSArray+Transition.h"

@interface ShenHeBaoJiaViewController () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    NSMutableArray *_arrayInquiryOrderItemModel;
    NSMutableArray *_arrayQuotationOrderItemModel;
    NSMutableArray *_arrayYesOpen;
    NSArray *_arrayShenHeBuTongGuo;
    QuotationOrder *_quotationOrder;
    InquiryOrder *_inquiryOrder;
    NSString *_inquiryOrderCode;
    NSString *_stringTitle;
    NSString *_manufacturerId;
    
    UIActivityIndicatorView *_activityIndicatorView;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation ShenHeBaoJiaViewController

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
    
    
    self.inquiryOrderCodeAndTitle.text = @"审核报价";
    
    self.viewShenHeBuTongGuo.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.viewShenHeBuTongGuo.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [self.viewShenHeBuTongGuo addGestureRecognizer:tap];
    _arrayShenHeBuTongGuo = @[@"价格不合理",@"询盘内容不清晰",@"其他原因"];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.backgroundColor = colorRGB(241, 241, 241);
    _activityIndicatorView.color = colorRGB(117, 117, 117);
    _activityIndicatorView.frame = CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar);
    [self.view addSubview:_activityIndicatorView];
    
    
    if ([self.stringSourceVC isEqualToString:@"审核报价"]) {
        [self.buttonNO setTitle:@"不通过" forState:UIControlStateNormal];
        [self.buttonYES setTitle:@"通过审核" forState:UIControlStateNormal];
    }
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    QuotationOrderItem *quotationOrderItem = [[QuotationOrderItem alloc] init];
    quotationOrderItem.q__quotationOrderId = self.quotationOrderSuper.quotationOrderId;
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
                _inquiryOrderCode = quotationOrderItem.inquiryOrderItem.inquiryOrder.inquiryOrderCode;
                _stringTitle = quotationOrderItem.inquiryOrderItem.inquiryOrder.title;
                _manufacturerId = quotationOrderItem.inquiryOrderItem.inquiryOrder.manufacturerId;
                _inquiryOrder = quotationOrderItem.inquiryOrderItem.inquiryOrder;
                
            }
            
            NSLog(@"%@",_inquiryOrder);
            
//            self.inquiryOrderCodeAndTitle.text = [NSString stringWithFormat:@"审核报价/%@",_stringTitle];
            
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arrayShenHeBuTongGuo.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _arrayShenHeBuTongGuo[row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
//            return 1+1+2+1;
            return 1;
        } else if (section == 1) {
            return 0;
        } else if (section < 1+1+_arrayQuotationOrderItemModel.count) {
            NSString *string = _arrayYesOpen[section-2];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[section - 2];
                if (quotationOrderItem.isSkip.integerValue == 0) {//暂不报价
                    return 3;
                } else {//启动报价
                    return 1;
                }
            }
        } else if (section == 1+1+_arrayQuotationOrderItemModel.count) {
            return 1;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
//            return 1+1+[_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue]+1;
            return 1;
        } else if (section == 1) {
            return 0;
        } else if (section < 1+1+_arrayQuotationOrderItemModel.count) {
            NSString *string = _arrayYesOpen[section-2];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[section - 2];
                if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"] && [quotationOrderItem.isSkip integerValue] == 1) {
                    return 1;
                } else {
                    return 1+1+[_inquiryOrder.tempPriceDetailCount integerValue]+2+2;
                }
            }
        } else if (section == 1+1+_arrayQuotationOrderItemModel.count) {
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
            return 40;
        } else if (indexPath.section == 1) {
            return 0;
        } else if (indexPath.section < 1+1+_arrayQuotationOrderItemModel.count) {
            if (indexPath.row == 0) {
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 2];
                if ([_inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
                    return 265;
                } else {
                    return 235;
                }
            } else {
                return 40;
            }
        } else if (indexPath.section == 1+1+_arrayQuotationOrderItemModel.count) {
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
            return 40;
        } else if (indexPath.section == 1) {
            return 0;
        } else if (indexPath.section < 1+1+_arrayQuotationOrderItemModel.count) {
            if (indexPath.row == 0) {
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 2];
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
        } else if (indexPath.section == 1+1+_arrayQuotationOrderItemModel.count) {
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
        return 1+1+_arrayQuotationOrderItemModel.count+1;
    } else if (tableView.tag == 89) {
        return 1+1+_arrayQuotationOrderItemModel.count+1;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 32;
        } else if (section == 1) {
            return 32;
        } else if (section < 1+1+_arrayQuotationOrderItemModel.count) {
            NSString *string = _arrayYesOpen[section-2];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == 1+1+_arrayQuotationOrderItemModel.count) {
            return 32;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 32;
        } else if (section == 1) {
            return 32;
        } else if (section < 1+1+_arrayQuotationOrderItemModel.count) {
            NSString *string = _arrayYesOpen[section-2];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == 1+1+_arrayQuotationOrderItemModel.count) {
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
        } else if (section < 1+1+_arrayQuotationOrderItemModel.count) {
            if (section == 1+_arrayQuotationOrderItemModel.count) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == 1+1+_arrayQuotationOrderItemModel.count) {
            return 0.1;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 0.1;
        } else if (section == 1) {
            return 0.1;
        } else if (section < 1+1+_arrayQuotationOrderItemModel.count) {
            if (section == 1+_arrayQuotationOrderItemModel.count) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == 1+1+_arrayQuotationOrderItemModel.count) {
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
            labelTitle1.text = _stringTitle;
            labelTitle1.textAlignment = NSTextAlignmentRight;
            [view addSubview:labelTitle1];
            
            [self line:view withY:31.5 withTag:0];
            return view;
        } else if (section == 1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 74, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件报价";
            [view addSubview:labelDiYiBaoJia];
            
            return view;
        } else if (section < 1+1+_arrayQuotationOrderItemModel.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewYiBaoJia.hidden = YES;
            view.viewWeiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            
            InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 2];
            QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[section - 2];
            
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
            view.labelName.text = [NSString stringWithFormat:@"%ld、%@",section-2+1,partNumber_specifications];
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
            
            view.buttonOpen.tag = section-2;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-2;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            return view;
        } else if (section == 1+1+_arrayQuotationOrderItemModel.count) {
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
            labelTitle1.text = _stringTitle;
            labelTitle1.textAlignment = NSTextAlignmentRight;
            [view addSubview:labelTitle1];
            
            [self line:view withY:31.5 withTag:0];
            return view;
        } else if (section == 1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 74, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件报价明细";
            [view addSubview:labelDiYiBaoJia];

            return view;
        } else if (section < 1+1+_arrayQuotationOrderItemModel.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewYiBaoJia.hidden = YES;
            view.viewWeiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            
            InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 2];
            QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[section - 2];
            
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
            view.labelName.text = [NSString stringWithFormat:@"%ld、%@",section-2+1,partNumber_specifications];
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
            
            view.buttonOpen.tag = section-2;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-2;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            return view;
        } else if (section == 1+1+_arrayQuotationOrderItemModel.count) {
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
//            if (indexPath.row == 0) {
//                MingXiQueRenBaoJia01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia01" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.view1.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
//                return cell;
//            } else if (indexPath.row < 1+1+2) {
//                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                if (indexPath.row == 1) {
//                    cell.label0.text = [NSString stringWithFormat:@"小计\n(共%ld种零件)",_arrayInquiryOrderItemModel.count];
//                    cell.label1.text = _quotationOrder.subtotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.subtotalPrice1 doubleValue]]:@"0.00";
//                } else if (indexPath.row < 1+1+1) {
//                    cell.label0.text = @"杂费";
//                    cell.label1.text = _quotationOrder.cost1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.cost1 doubleValue]]:@"0.00";
//                } else {
//                    cell.label0.text = @"运费";
//                    cell.label1.text = _quotationOrder.shipPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.shipPrice1 doubleValue]]:@"0.00";
//                }
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
        } else if (indexPath.section == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section < 1+1+_arrayQuotationOrderItemModel.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.imageTopConstraint.constant = 8;
                cell.viewDaoHuoTime.hidden = YES;
                cell.viewZanBuBaoJia.hidden = YES;
                cell.buttonZanBuBaoJia.hidden = YES;
                cell.viewZongjia.hidden = YES;
                cell.viewZongChaKan.hidden = YES;
                
                InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 2];
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 2];
                
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
                
                cell.dyzPartNumber.text = [NSString stringWithFormat:@"%ld、%@",indexPath.section-2+1,partNumber_specifications];
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
                
                cell.buttonClose.tag = indexPath.section - 2;
                [cell.buttonClose addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonClose1.tag = indexPath.section - 2;
                [cell.buttonClose1 addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonImage.tag = indexPath.section - 2;
                [cell.buttonImage addTarget:self action:@selector(buttonImageClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonDetail.tag = indexPath.section - 2;
                [cell.buttonDetail setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.zongChaKanlabel1.textColor = colorGong;
                cell.zongChaKanlabel2.textColor = colorGong;
                cell.zongChaKanlabel2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:@"0.00";
                return cell;
            } else if (indexPath.row == 1) {
                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 2];
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
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 2];

                cell.label0.text = @"零件备注";
                cell.label1.text = quotationOrderItem.supplierRemark.length>0?quotationOrderItem.supplierRemark:@"--";
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 1+1+_arrayQuotationOrderItemModel.count) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 19921126) {
                    [view removeFromSuperview];
                }
            }
            
            CGFloat h;
            if (_quotationOrder.remark) {
                CGSize size = [_quotationOrder.remark boundingRectWithSize:CGSizeMake(kMainW-20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                h = size.height + 15;
            } else {
                h = 30;
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
//            if (indexPath.row == 0) {
//                MingXiQueRenBaoJia01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia01" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.view1.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
//
//                return cell;
//            } else if (indexPath.row < 1+1+[_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue]) {
//                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                if (indexPath.row == 1) {
//                    cell.label0.text = [NSString stringWithFormat:@"小计\n(共%ld种零件)",_arrayInquiryOrderItemModel.count];
//                    cell.label1.text = _quotationOrder.subtotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.subtotalPrice1 doubleValue]]:@"0.00";
//                } else if (indexPath.row < 1+1+[_inquiryOrder.tempCostDetailCount integerValue]) {
//                    cell.label0.text = [_inquiryOrder valueForKey:[NSString stringWithFormat:@"tempCostDetailName%ld",indexPath.row-1]];
//                    NSNumber *supplierTempCost1DetailValue = [_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%ld",indexPath.row-1]];
//                    cell.label1.text = supplierTempCost1DetailValue?[NSString stringWithFormat:@"%.2f",[supplierTempCost1DetailValue doubleValue]]:@"0.00";
//
//                } else {
//                    cell.label0.text = [_inquiryOrder valueForKey:[NSString stringWithFormat:@"tempShipPriceDetailName%ld",indexPath.row-1-[_inquiryOrder.tempCostDetailCount integerValue]]];
//                    NSNumber *supplierTempShipPrice1DetailValue = [_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%ld",indexPath.row-1-[_inquiryOrder.tempCostDetailCount integerValue]]];
//                    cell.label1.text = supplierTempShipPrice1DetailValue?[NSString stringWithFormat:@"%.2f",[supplierTempShipPrice1DetailValue doubleValue]]:@"0.00";
//                }
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
        } else if (indexPath.section == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section < 1+1+_arrayQuotationOrderItemModel.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.imageTopConstraint.constant = 8;
                cell.viewDaoHuoTime.hidden = YES;
                cell.viewZanBuBaoJia.hidden = YES;
                cell.buttonZanBuBaoJia.hidden = YES;
                cell.viewZongjia.hidden = YES;
                cell.viewZongChaKan.hidden = YES;
                
                InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 2];
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 2];
                
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
                
                cell.dyzPartNumber.text = [NSString stringWithFormat:@"%ld、%@",indexPath.section-2+1,partNumber_specifications];
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
                
                cell.buttonClose.tag = indexPath.section - 2;
                [cell.buttonClose addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonClose1.tag = indexPath.section - 2;
                [cell.buttonClose1 addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonImage.tag = indexPath.section - 2;
                [cell.buttonImage addTarget:self action:@selector(buttonImageClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonDetail.tag = indexPath.section - 2;
                [cell.buttonDetail setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            } else if (indexPath.row == 1) {
                MingXiQueRenBaoJia010 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia010" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.view1.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
                
                
                InquiryOrderItem *model = _arrayInquiryOrderItemModel[indexPath.section - 2];
                
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 2];
                cell.label1.text  = quotationOrderItem.num1?[NSString QuantityUnit:model.quantityUnit].length != 0?[NSString stringWithFormat:@"%@(%@)",quotationOrderItem.num1,[NSString QuantityUnit:model.quantityUnit]]:[NSString stringWithFormat:@"%@",quotationOrderItem.num1]:@"--";
                
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]) {
                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.label0.text = [_inquiryOrder valueForKey:[NSString stringWithFormat:@"tempPriceDetailName%ld",indexPath.row-1]];
                
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 2];
                
                NSNumber *supplierTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%ld",indexPath.row-1]];
                
                cell.label1.text = supplierTempPrice1DetailValue?[NSString stringWithFormat:@"%.2f",[supplierTempPrice1DetailValue doubleValue]]:@"0.00";
                
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]+2) {
                MingXiQueRenBaoJia03 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia03" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.view0.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 2];
                if (indexPath.row == 2+[_inquiryOrder.tempPriceDetailCount integerValue]) {
                    cell.label0.text = @"含税单价";
                    cell.label1.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:@"0.00";

                } else if (indexPath.row == 2+[_inquiryOrder.tempPriceDetailCount integerValue]+1) {
                    cell.label0.text = @"不含税单价";
                    cell.label1.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:nil;
                    
                }
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]+2+1) {
                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 2];
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
                QuotationOrderItem *quotationOrderItem = _arrayQuotationOrderItemModel[indexPath.section - 2];
                cell.label0.text = @"零件备注";
                cell.label1.text = quotationOrderItem.supplierRemark.length>0?quotationOrderItem.supplierRemark:@"--";
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 1+1+_arrayQuotationOrderItemModel.count) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 19921126) {
                    [view removeFromSuperview];
                }
            }
            
            
            CGFloat h;
            if (_quotationOrder.remark) {
                CGSize size = [_quotationOrder.remark boundingRectWithSize:CGSizeMake(kMainW-20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                h = size.height + 15;
            } else {
                h = 30;
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
    } else {
        return nil;
    }
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
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sender.tag+2];
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

- (void)tapSelector:(UITapGestureRecognizer *)tap {
    self.viewShenHeBuTongGuo.hidden = YES;
}

#pragma mark 审核 不通过
- (IBAction)buttonBuTongGuo:(UIButton *)sender {
    self.viewShenHeBuTongGuo.hidden = NO;
}

- (IBAction)buttonQuXiao:(UIButton *)sender {
    self.viewShenHeBuTongGuo.hidden = YES;
}

- (IBAction)buttonWanCheng:(UIButton *)sender {//完成
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    QuotationOrder *quotationOrder = [[QuotationOrder alloc] init];
    quotationOrder.quotationOrderId = _quotationOrder.quotationOrderId;
    quotationOrder.manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    quotationOrder.verifyCode = _quotationOrder.verifyCode;
    quotationOrder.editNum = _quotationOrder.editNum;
    quotationOrder.confirmId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    quotationOrder.confirmMsg = _arrayShenHeBuTongGuo[row];
    quotationOrder.confirmName = loginModel.accountName;
    postEntityBean.entity = quotationOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
//    NSLog(@"%@",dic);
    [HttpMamager postRequestWithURLString:DYZ_quotation_cfmf parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"提交成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"提交失败"];
        }
    
        BOOL isBreak = false;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isMemberOfClass:[XunPanXiangQingViewController class]]) {
                isBreak = true;
                [self.navigationController popToViewController:vc animated:YES];
                
                
            }
        }
        if(!isBreak){
            [CommentUtils goToSupplierView:1 withInquiryOrder:_inquiryOrder.inquiryType withViewConTroller:self];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    
}

#pragma mark 审核 通过审核
- (IBAction)buttonShenHeTongGuo:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"通过审核"]) {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"确认审核通过吗？\r\n审核通过后采购商会看到报价" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
            QuotationOrder *quotationOrder = [[QuotationOrder alloc] init];
            quotationOrder.inquiryOrderId = _quotationOrder.inquiryOrderId;
            quotationOrder.quotationOrderId = _quotationOrder.quotationOrderId;
            quotationOrder.manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
            InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
            inquiryOrder.inquiryOrderCode = _inquiryOrderCode;
            inquiryOrder.manufacturerId = _manufacturerId;
            quotationOrder.inquiryOrder = inquiryOrder;
            quotationOrder.verifyCode = _quotationOrder.verifyCode;
            quotationOrder.editNum = _quotationOrder.editNum;
            quotationOrder.confirmId = [GlobalSettingManager shareGlobalSettingManager].memberId;
            quotationOrder.confirmName = loginModel.accountName;
            postEntityBean.entity = quotationOrder.mj_keyValues;
            NSDictionary *dic = postEntityBean.mj_keyValues;
            
//            NSLog(@"%@",dic);
            
            [HttpMamager postRequestWithURLString:DYZ_quotation_cfms parameters:dic success:^(id responseObjectModel) {
                ReturnMsgBean *returnMsgBean = responseObjectModel;
                
                if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"审核成功"];
                } else {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"提交失败"];
                }
                
                BOOL isBreak = false;
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isMemberOfClass:[XunPanXiangQingViewController class]]) {
                        isBreak = true;
                        [self.navigationController popToViewController:vc animated:YES];
        
                    }
                }
                
                if(!isBreak){
                    [CommentUtils goToSupplierView:1 withInquiryOrder:_inquiryOrder.inquiryType withViewConTroller:self];
                }
            } fail:^(NSError *error) {
                
            } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
        }];
        [ac addAction:action];
        [ac addAction:action1];
        [self presentViewController:ac animated:YES completion:nil];
        
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
