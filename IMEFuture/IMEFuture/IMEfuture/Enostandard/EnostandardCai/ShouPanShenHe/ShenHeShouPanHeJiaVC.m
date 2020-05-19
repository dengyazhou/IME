//
//  ShenHeShouPanHeJiaVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/3/27.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ShenHeShouPanHeJiaVC.h"
#import "VoHeader.h"

#import "BaoJiaDingJiaCell1.h"

#import "MXBaoJiaCell01.h"
#import "BaoJiaHeaderView01.h"
#import "YiJiaECMingXiCell00.h"
#import "YiJiaECMingXiCell01.h"
#import "YiJiaECMingXiCell02.h"
#import "YiJiaECMingXiXiuGaiCell00.h"
#import "YiJiaECMingXiXiuGaiCell01.h"
#import "YiJiaECMingXiXiuGaiCell10.h"
#import "YiJiaECMingXiXiuGaiCell11.h"
#import "YiJiaECHeJiaXiXiuGaiCell00.h"
#import "YiJiaECHeJiaXiXiuGaiCell01.h"
#import "MXBaoJiaCell111.h"
#import "MingXiQueRenBaoJia02.h"

#import "Masonry.h"


#import "QiYeXinXiXiangQingViewController.h"
#import "XunPanXiangQingViewController.h"

#import "CommentUtils.h"
#import "EGOrderViewController.h"

#import "ECInquiryViewController.h"



#import "DingDanXiangQingCaiViewController.h"

#import "UIButtonIM.h"

#import "PartDetailsViewController.h"
#import "LingJianXiangQingViewController2.h"
#import "NSArray+Transition.h"
#import "UIViewXuanZeYuanYing.h"

#import "RefreshManager.h"

@interface ShenHeShouPanHeJiaVC () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate,UITextViewDelegate>{
    NSMutableArray *_arrayInquiryOrderItemModel;
    NSMutableArray *_quotationOrderItems;
    NSMutableArray *_arrayYesOpen;
    NSInteger _integerButtonLineColor;
    
    QuotationOrder *_quotationOrder;
    
    NSArray *_arrayJuJueShouPan;
    InquiryOrder *_inquiryOrder;
    
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

@implementation ShenHeShouPanHeJiaVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

    
    _arrayJuJueShouPan = @[@"报价有问题",@"还在磋商中",@"工厂产能不足",@"不能按时完成",@"其他原因"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell01" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaoJiaHeaderView01" bundle:nil] forHeaderFooterViewReuseIdentifier:@"baoJiaHeaderView01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiCell00" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiCell00"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiCell01" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiCell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiCell02" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiCell02"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECHeJiaXiXiuGaiCell00" bundle:nil] forCellReuseIdentifier:@"yiJiaECHeJiaXiXiuGaiCell00"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECHeJiaXiXiuGaiCell01" bundle:nil] forCellReuseIdentifier:@"yiJiaECHeJiaXiXiuGaiCell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell10" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell10"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell11" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell11"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell00" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell00"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia02" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia02"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tag = 88;
    
    
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    [self.tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell01" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"BaoJiaHeaderView01" bundle:nil] forHeaderFooterViewReuseIdentifier:@"baoJiaHeaderView01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiCell00" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiCell00"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiCell01" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiCell01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiCell02" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiCell02"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell00" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell00"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell01" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell10" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell10"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell11" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell11"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MingXiQueRenBaoJia02" bundle:nil] forCellReuseIdentifier:@"mingXiQueRenBaoJia02"];
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
//            return 1+1+2+1+1;
            return 1;
        } else if (section == 2) {
            return 0;
        } else if (section < 3+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
//                return 1+1+2;
                return 1+1+2+2;
            }
        } else if (section == 2+_quotationOrderItems.count+1) {
            return 1;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
//            return 1+1+[_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue]+1+1;
            return 1;
        } else if (section == 2) {
            return 0;
        } else if (section < 3+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
//                return 1+1+[_inquiryOrder.tempPriceDetailCount integerValue]+2;
                return 1+1+[_inquiryOrder.tempPriceDetailCount integerValue]+2+2;
            }
        } else if (section == 2+_quotationOrderItems.count+1) {
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
            if (indexPath.row == 0) {
                return 40;
            } else {
                return 40;
            }
        } else if (indexPath.section == 2) {
            return 0;
        } else if (indexPath.section < 3+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                return 221;
            } else if (indexPath.row == 1) {
                return 40;
            } else {
                return 40;
            }
        } else if (indexPath.section == 2+_quotationOrderItems.count+1) {
            return 79;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (indexPath.section == 0) {
            return 68;
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                return 40;
            } else {
                return 40;
            }
        } else if (indexPath.section == 2) {
            return 0;
        } else if (indexPath.section < 3+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                return 221;
            } else if (indexPath.row == 1) {
                return 40;
            } else {
                return 40;
            }
        } else if (indexPath.section == 2+_quotationOrderItems.count+1) {
            return 79;
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

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 0.1;
        } else if (section == 1) {
            return 32;
        } else if (section == 2) {
            return 32;
        } else if (section < 3+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == 2+_quotationOrderItems.count+1) {
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
        } else if (section < 3+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == 2+_quotationOrderItems.count+1) {
            return 32;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 0.1;
        } else if (section == 1) {
            return 0.1;
        } else if (section == 2) {
            return 0.1;
        } else if (section < 3+_quotationOrderItems.count) {
            if (section == 3+_quotationOrderItems.count-1) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == 2+_quotationOrderItems.count+1) {
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
        } else if (section < 3+_quotationOrderItems.count) {
            if (section == 2+_quotationOrderItems.count-1) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == 2+_quotationOrderItems.count+1) {
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
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 74, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件总计";
            [view addSubview:labelDiYiBaoJia];
            
            UILabel *labelTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(15+74+10, 0, kMainW-30-74-10, 32)];
            labelTitle1.font = [UIFont systemFontOfSize:12];
            labelTitle1.textColor = colorText153;
            labelTitle1.text = _inquiryOrder.title;
            labelTitle1.textAlignment = NSTextAlignmentRight;
            [view addSubview:labelTitle1];
            
            return view;
        } else if (section == 2) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件报价";
            [view addSubview:labelDiYiBaoJia];
            
            return view;
        } else if (section < 3+_quotationOrderItems.count) {

            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewWeiBaoJia.hidden = YES;
            view.viewYiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            view.viewHeJia.hidden = YES;
            view.viewHeJia1.hidden = YES;
            
            InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 3];
            QuotationOrderItem *quotationOrderItem = _quotationOrderItems[section - 3];
            
            if ([quotationOrderItem.purchasePrice1 doubleValue]>0) {
                view.viewHeJia.hidden = NO;
            } else {
                view.viewHeJia1.hidden = NO;
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
            view.labelHeJia00.textColor = colorRGB(255, 151, 0);
            double totalPurchasePrice = 0;
            totalPurchasePrice = [quotationOrderItem.num1 integerValue]*[quotationOrderItem.purchasePrice1 doubleValue];
            view.labelHeJia1.text = [NSString stringWithFormat:@"%.2f",totalPurchasePrice];
            view.labelHeJia1.textColor = colorRGB(255, 151, 0);
            view.labelHeJia10.text = @"我的比价";
            
            view.labelHeJia11.textColor = colorRGB(255, 151, 0);
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 integerValue]*[quotationOrderItem.price1 doubleValue];
            view.labelHeJia2.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            view.labelHeJia20.text = @"供应商报价";
            view.labelHeJia21.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            view.labelHeJia210.text = @"供应商报价";
            
            view.buttonOpen.tag = section-3;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-3;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            return view;
            
        } else if (section == 2+_quotationOrderItems.count+1) {
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
            return 0;
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
            
            UILabel *labelTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(15+74+10, 0, kMainW-30-74-10, 32)];
            labelTitle1.font = [UIFont systemFontOfSize:12];
            labelTitle1.textColor = colorText153;
            labelTitle1.text = _inquiryOrder.title;
            labelTitle1.textAlignment = NSTextAlignmentRight;
            [view addSubview:labelTitle1];
            
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
        } else if (section < 3+_quotationOrderItems.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewWeiBaoJia.hidden = YES;
            view.viewYiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            view.viewHeJia.hidden = YES;
            view.viewHeJia1.hidden = YES;
            
            InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 3];
            QuotationOrderItem *quotationOrderItem = _quotationOrderItems[section - 3];
            
            if ([quotationOrderItem.purchasePrice1 doubleValue]>0) {
                view.viewHeJia.hidden = NO;
            } else {
                view.viewHeJia1.hidden = NO;
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
            view.labelHeJia00.textColor = colorRGB(255, 151, 0);
            double totalPurchasePrice = 0;
            totalPurchasePrice = [quotationOrderItem.num1 integerValue]*[quotationOrderItem.purchasePrice1 doubleValue];
            view.labelHeJia1.text = [NSString stringWithFormat:@"%.2f",totalPurchasePrice];
            view.labelHeJia1.textColor = colorRGB(255, 151, 0);
            view.labelHeJia10.text = @"我的比价";
            
            view.labelHeJia11.textColor = colorRGB(255, 151, 0);
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 integerValue]*[quotationOrderItem.price1 doubleValue];
            view.labelHeJia2.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            view.labelHeJia20.text = @"供应商报价";
            view.labelHeJia21.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            view.labelHeJia210.text = @"供应商报价";
            
            view.buttonOpen.tag = section-3;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-3;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            return view;

        } else if (section == 2+_quotationOrderItems.count+1) {
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
            return 0;
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
            
            
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            if ([_quotationOrder.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
                [imageViewH sd_setImageWithURL:[NSURL URLWithString:_inquiryOrder.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
                label2.text = [NSString stringWithFormat:@"%@ %@",_inquiryOrder.member.enterpriseInfo.province?_inquiryOrder.member.enterpriseInfo.province:@"",_inquiryOrder.member.enterpriseInfo.city?_inquiryOrder.member.enterpriseInfo.city:@""];
                label1.text = _inquiryOrder.member.enterpriseInfo.enterpriseName;
           
            } else {//供应商身份进来
                [imageViewH sd_setImageWithURL:[NSURL URLWithString:_quotationOrder.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
                
                label2.text = [NSString stringWithFormat:@"%@ %@",_quotationOrder.member.enterpriseInfo.province?_quotationOrder.member.enterpriseInfo.province:@"",_quotationOrder.member.enterpriseInfo.city?_quotationOrder.member.enterpriseInfo.city:@""];
                label1.text = _quotationOrder.member.enterpriseInfo.enterpriseName;
                
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else if (indexPath.section == 1) {
//            if (indexPath.row == 0) {
//                YiJiaECMingXiCell00 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell00" forIndexPath:indexPath];
//                cell.view1.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
//                cell.view2.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
//                cell.label1.text = @"我的比价(元)";
//                cell.label2.text = @"供应商报价(元)";
//                return cell;
//            } else if (indexPath.row < 1+1+2) {
//                if (indexPath.row == 1) {
//                    YiJiaECMingXiCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell01" forIndexPath:indexPath];
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                    cell.label0.text = [NSString stringWithFormat:@"小计\n(共%ld种零件)",_quotationOrderItems.count];
//                    cell.label1.text = _quotationOrder.purchaseSubtotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.purchaseSubtotalPrice1 doubleValue]]:@"0.00";
//                    cell.label2.text = _quotationOrder.subtotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.subtotalPrice1 doubleValue]]:@"0.00";
//                    return cell;
//                } else if (indexPath.row < 1+1+2) {
//                    YiJiaECHeJiaXiXiuGaiCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECHeJiaXiXiuGaiCell01" forIndexPath:indexPath];
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                    if (indexPath.row < 1+1+1) {
//                        cell.label0.text = @"杂费";
//                        cell.textField1.text = [NSString stringWithFormat:@"%.2f",[_quotationOrder.purchaseCost1 doubleValue]];
//                        cell.label2.text = [NSString stringWithFormat:@"%.2f",[_quotationOrder.cost1 doubleValue]];
//                    } else {
//                        cell.label0.text = @"运费";
//                        cell.textField1.text = [NSString stringWithFormat:@"%.2f",[_quotationOrder.purchaseShipPrice1 doubleValue]];
//                        cell.label2.text = [NSString stringWithFormat:@"%.2f",[_quotationOrder.shipPrice1 doubleValue]];
//                    }
//                    cell.textField1.enabled = NO;
//                    cell.textField1.backgroundColor = [UIColor whiteColor];
//                    cell.textField1.borderStyle = UITextBorderStyleNone;
//                    return cell;
//                } else {
//                    return nil;
//                }
//            } else if (indexPath.row <= 1+1+2+1) {
//                YiJiaECMingXiCell02 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell02" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.view0.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
//                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrder.supplierTaxRate doubleValue]*100];
//                if (indexPath.row == 1+1+2) {
//                    cell.label1.textColor = colorRGB(255, 151, 0);
//                    cell.label0.text = [NSString stringWithFormat:@"总计\n(含税价%@%@)",stringTaxRate,@"%"];
//                    cell.label1.text = _quotationOrder.purchaseTotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.purchaseTotalPrice1 doubleValue]]:@"0.00";
//                    cell.label2.text = _quotationOrder.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.totalPrice1 doubleValue]]:@"0.00";
//                } else if (indexPath.row == 1+1+2+1) {
//                    cell.label1.textColor = colorRGB(51, 51, 51);
//                    cell.label0.text = @"总计\n(不含税价)";
//                    cell.label1.text = _quotationOrder.purchaseTotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.purchaseTotalPrice1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:@"0.00";
//                    cell.label2.text = _quotationOrder.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.totalPrice1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:@"0.00";
//                }
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
                cell.label1.textColor = colorCai;
                cell.label2.textColor = colorCai;
                
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section < 3+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.viewZanBuBaoJia.hidden = YES;
                cell.buttonZanBuBaoJia.hidden = YES;
                cell.viewZongjia.hidden = YES;
                
                //                cell.viewZongYiJia.hidden = YES;
                //                cell.viewZongYiJia.hidden = NO;
                
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
                    
                    NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_inquiryOrder.member.enterpriseInfo.enterpriseId,inquiryOrderItem.partNumber,inquiryOrderItem.picVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
                
                cell.buttonDetail.tag = indexPath.section - 3;
                [cell.buttonDetail setTitleColor:colorRGB(255, 151, 0) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.zongYiJialabel1.text = [NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]];
                cell.zongYiJialabel2.text = @"供应商报价:";
                
                cell.labelTargetPrice.hidden = NO;
                cell.labelTargetPrice.text = [NSString stringWithFormat:@"含税核算价:¥%.2f",[quotationOrderItem.targetPrice1 doubleValue]];
                
                return cell;
            } else if (indexPath.row == 1) {
                YiJiaECMingXiCell00 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell00" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.view1.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                cell.view2.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                
                cell.label1.text = @"我的比价(元)";
                cell.label2.text = @"供应商报价(元)";
                
                return cell;
            } else if (indexPath.row == 2) {
                YiJiaECHeJiaXiXiuGaiCell00 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECHeJiaXiXiuGaiCell00" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                cell.label0.text = @"含税单价";
                cell.textField1.textColor = colorRGB(255, 151, 0);
                cell.textField1.text = [NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]];
                cell.label2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:@"0.00";
                
                cell.textField1.enabled = NO;
                cell.textField1.backgroundColor = [UIColor whiteColor];
                cell.textField1.borderStyle = UITextBorderStyleNone;
                
                return cell;
            } else if (indexPath.row == 3) {
                YiJiaECMingXiCell02 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell02" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                cell.view0.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                cell.label0.text = @"不含税单价";
                cell.label1.textColor = colorRGB(51, 51, 51);
                cell.label1.text = quotationOrderItem.purchasePrice1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:nil;
                cell.label2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:nil;
                return cell;
            } else if (indexPath.row == 4) {
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
            } else if (indexPath.row == 5) {
                MingXiQueRenBaoJia02 *cell = [tableView dequeueReusableCellWithIdentifier:@"mingXiQueRenBaoJia02" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                cell.label0.text = @"零件备注";
                cell.label1.text = quotationOrderItem.supplierRemark.length>0?quotationOrderItem.supplierRemark:@"--";
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 2+_quotationOrderItems.count+1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 19921126) {
                    [view removeFromSuperview];
                }
            }
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, kMainW-20, 79)];
            textView.font = [UIFont systemFontOfSize:14];
            textView.textColor = colorRGB(102, 102, 102);
            textView.tag = 19921126;
            if (_quotationOrder.purchaseRemark.length > 0) {
                textView.text = _quotationOrder.purchaseRemark;
            } else {
                textView.text = @"暂无备注";
            }
            
            [cell.contentView addSubview:textView];
        
            textView.editable = NO;
            
            return cell;
        } else {
            return nil;
        }
    } else if (tableView.tag == 89) {
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
            
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            if ([_quotationOrder.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
                [imageViewH sd_setImageWithURL:[NSURL URLWithString:_inquiryOrder.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
                label2.text = [NSString stringWithFormat:@"%@ %@",_inquiryOrder.member.enterpriseInfo.province?_inquiryOrder.member.enterpriseInfo.province:@"",_inquiryOrder.member.enterpriseInfo.city?_inquiryOrder.member.enterpriseInfo.city:@""];
                label1.text = _inquiryOrder.member.enterpriseInfo.enterpriseName;
  
            } else {//供应商身份进来
                [imageViewH sd_setImageWithURL:[NSURL URLWithString:_quotationOrder.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
                
                label2.text = [NSString stringWithFormat:@"%@ %@",_quotationOrder.member.enterpriseInfo.province?_quotationOrder.member.enterpriseInfo.province:@"",_quotationOrder.member.enterpriseInfo.city?_quotationOrder.member.enterpriseInfo.city:@""];
                label1.text = _quotationOrder.member.enterpriseInfo.enterpriseName;
       
            }
            
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else if (indexPath.section == 1) {
//            if (indexPath.row == 0) {
//                YiJiaECMingXiCell00 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell00" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.view1.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
//                cell.view2.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
//                cell.label1.text = @"我的比价(元)";
//                cell.label2.text = @"供应商报价(元)";
//                return cell;
//            } else if (indexPath.row < 1+1+[_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue]) {
//                if (indexPath.row == 1) {
//                    YiJiaECMingXiCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell01" forIndexPath:indexPath];
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                    cell.label0.text = [NSString stringWithFormat:@"小计\n(共%ld种零件)",_quotationOrderItems.count];
//                    cell.label1.text = _quotationOrder.purchaseSubtotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.purchaseSubtotalPrice1 doubleValue]]:@"0.00";
//                    cell.label2.text = _quotationOrder.subtotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.subtotalPrice1 doubleValue]]:@"0.00";
//                    return cell;
//                } else if (indexPath.row < 1+1+[_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue]) {
//                    YiJiaECMingXiXiuGaiCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell01" forIndexPath:indexPath];
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                    if (indexPath.row < 1+1+[_inquiryOrder.tempCostDetailCount integerValue]) {
//                        cell.label0.text = [_inquiryOrder valueForKey:[NSString stringWithFormat:@"tempCostDetailName%ld",indexPath.row-1]];
//                        NSNumber *purchaseTempCost1DetailValue = [_quotationOrder valueForKey:[NSString stringWithFormat:@"purchaseTempCost1DetailValue%ld",indexPath.row-1]];
//                        cell.textField1.text = purchaseTempCost1DetailValue?[NSString stringWithFormat:@"%.2f",[purchaseTempCost1DetailValue doubleValue]]:@"0.00";
//                        NSNumber *supplierTempCost1DetailValue = [_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%ld",indexPath.row-1]];
//                        cell.label2.text = supplierTempCost1DetailValue?[NSString stringWithFormat:@"%.2f",[supplierTempCost1DetailValue doubleValue]]:@"0.00";
//                    } else {
//                        cell.label0.text = [_inquiryOrder valueForKey:[NSString stringWithFormat:@"tempShipPriceDetailName%ld",indexPath.row-1-[_inquiryOrder.tempCostDetailCount integerValue]]];
//                        NSNumber *purchaseTempShipPrice1DetailValue = [_quotationOrder valueForKey:[NSString stringWithFormat:@"purchaseTempShipPrice1DetailValue%ld",indexPath.row-1-[_inquiryOrder.tempCostDetailCount integerValue]]];
//                        cell.textField1.text = purchaseTempShipPrice1DetailValue?[NSString stringWithFormat:@"%.2f",[purchaseTempShipPrice1DetailValue doubleValue]]:@"0.00";
//                        NSNumber *supplierTempShipPrice1DetailValue = [_quotationOrder valueForKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%ld",indexPath.row-1-[_inquiryOrder.tempCostDetailCount integerValue]]];
//                        cell.label2.text = supplierTempShipPrice1DetailValue?[NSString stringWithFormat:@"%.2f",[supplierTempShipPrice1DetailValue doubleValue]]:@"0.00";
//                    }
//
//                    cell.textField1.enabled = NO;
//                    cell.textField1.backgroundColor = [UIColor whiteColor];
//                    cell.textField1.borderStyle = UITextBorderStyleNone;
//                    return cell;
//                } else {
//                    return nil;
//                }
//            } else if (indexPath.row <= 1+1+[_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue]+1) {
//                YiJiaECMingXiCell02 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell02" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.view0.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
//                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrder.supplierTaxRate doubleValue]*100];
//                if (indexPath.row == 1+1+[_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue]) {
//                    cell.label1.textColor = colorRGB(255, 151, 0);
//                    cell.label0.text = [NSString stringWithFormat:@"总计\n(含税价%@%@)",stringTaxRate,@"%"];
//                    cell.label1.text = _quotationOrder.purchaseTotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.purchaseTotalPrice1 doubleValue]]:@"0.00";
//                    cell.label2.text = _quotationOrder.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.totalPrice1 doubleValue]]:@"0.00";
//                } else if (indexPath.row == 1+1+[_inquiryOrder.tempCostDetailCount integerValue]+[_inquiryOrder.tempShipPriceDetailCount integerValue]+1) {
//                    cell.label1.textColor = colorRGB(51, 51, 51);
//                    cell.label0.text = @"总计\n(不含税价)";
//                    cell.label1.text = _quotationOrder.purchaseTotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.purchaseTotalPrice1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:@"0.00";
//                    cell.label2.text = _quotationOrder.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrder.totalPrice1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:@"0.00";
//                }
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
                cell.label1.textColor = colorCai;
                cell.label2.textColor = colorCai;
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section < 3+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.viewZanBuBaoJia.hidden = YES;
                cell.buttonZanBuBaoJia.hidden = YES;
                cell.viewZongjia.hidden = YES;
                
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
                    
                    NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_inquiryOrder.member.enterpriseInfo.enterpriseId,inquiryOrderItem.partNumber,inquiryOrderItem.picVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
                
                cell.buttonDetail.tag = indexPath.section - 3;
                [cell.buttonDetail setTitleColor:colorRGB(255, 151, 0) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            } else if (indexPath.row == 1) {
                YiJiaECMingXiCell00 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell00" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.view1.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                cell.view2.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                
                cell.label1.text = @"我的比价(元)";
                cell.label2.text = @"供应商报价(元)";
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]) {
                YiJiaECMingXiXiuGaiCell11 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell11" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                
                cell.label0.text = [_inquiryOrder valueForKey:[NSString stringWithFormat:@"tempPriceDetailName%ld",indexPath.row-1]];
                
                
                NSNumber *purchaseTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"purchaseTempPrice1DetailValue%ld",indexPath.row-1]];
                cell.textField1.text = purchaseTempPrice1DetailValue?[NSString stringWithFormat:@"%.2f",[purchaseTempPrice1DetailValue doubleValue]]:@"0.00";
                NSNumber *supplierTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%ld",indexPath.row-1]];
                cell.label2.text = supplierTempPrice1DetailValue?[NSString stringWithFormat:@"%.2f",[supplierTempPrice1DetailValue doubleValue]]:@"0.00";
                
                cell.textField1SuperView.tag = indexPath.section - 3;
                
                cell.textField1.enabled = NO;
                cell.textField1.backgroundColor = [UIColor whiteColor];
                cell.textField1.borderStyle = UITextBorderStyleNone;
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrder.tempPriceDetailCount integerValue]+2) {
                YiJiaECMingXiCell02 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell02" forIndexPath:indexPath];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                
                cell.view0.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                if (indexPath.row == 2+[_inquiryOrder.tempPriceDetailCount integerValue]) {
                    cell.label0.text = @"含税单价";
                    cell.label1.textColor = colorRGB(255, 151, 0);
                    cell.label1.text = quotationOrderItem.purchasePrice1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]]:@"0.00";
                    cell.label2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:@"0.00";
                } else if (indexPath.row == 2+[_inquiryOrder.tempPriceDetailCount integerValue]+1) {
                    cell.label0.text = @"不含税单价";
                    cell.label1.textColor = colorRGB(51, 51, 51);
                    cell.label1.text = quotationOrderItem.purchasePrice1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:nil;
                    cell.label2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]/(1+[_quotationOrder.supplierTaxRate doubleValue])]:nil;
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
        } else if (indexPath.section == 2+_quotationOrderItems.count+1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 19921126) {
                    [view removeFromSuperview];
                }
            }
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, kMainW-20, 79)];
            textView.font = [UIFont systemFontOfSize:14];
            textView.textColor = colorRGB(102, 102, 102);
            textView.tag = 19921126;
            if (_quotationOrder.purchaseRemark.length > 0) {
                textView.text = _quotationOrder.purchaseRemark;
            } else {
                textView.text = @"暂无备注";
            }

            [cell.contentView addSubview:textView];

            textView.editable = NO;
            
            return cell;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (void)buttonOpenClick:(UIButton *)sender {
    [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"yes"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        QiYeXinXiXiangQingViewController *qyxxxqVC = [[QiYeXinXiXiangQingViewController alloc] init];
        qyxxxqVC.enterpriseInfo = _quotationOrder.member.enterpriseInfo;
        qyxxxqVC.isPrivate = _inquiryOrder.isPrivate;
        qyxxxqVC.ucenterId = _quotationOrder.member.ucenterId;
        qyxxxqVC.passiveId = _quotationOrder.member.manufacturerId;
        qyxxxqVC.quotationOrderStatus = _quotationOrder.status;
        qyxxxqVC.caiOrGong = @"cai";
        [self.navigationController pushViewController:qyxxxqVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}

#pragma mark UITextFieldDelegate
//键盘只能输入@"-.1234567890"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"-.1234567890"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
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
