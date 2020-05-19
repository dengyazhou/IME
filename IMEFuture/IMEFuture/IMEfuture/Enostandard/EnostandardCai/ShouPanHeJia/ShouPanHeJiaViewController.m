//
//  ShouPanHeJiaViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/3/27.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ShouPanHeJiaViewController.h"
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
#import "YiJiaECMingXiXiuGaiCell12.h"
#import "YiJiaECMingXiXiuGaiCell13.h"
#import "MXBaoJiaCell111.h"

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
#import "UIViewXuanZeYaoQiuDaoHuoRiQi.h"
#import "IMETabBarViewController.h"
#import "RefreshManager.h"
#import "GlobalSettingManager.h"

@interface ShouPanHeJiaViewController () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate,UITextViewDelegate>{
    NSMutableArray *_arrayInquiryOrderItemModel;
    NSMutableArray *_quotationOrderItems;
    NSMutableArray *_arrayYesOpen;
    NSInteger _integerButtonLineColor;
    QuotationOrder *_quotationOrderHttp;
    NSArray *_arrayJuJueShouPan;
    InquiryOrder *_inquiryOrderHttp;
    
    UIView *_viewLoading;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation ShouPanHeJiaViewController

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
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell12" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell12"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell13" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell13"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
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
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell12" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell12"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell13" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell13"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView1.tableFooterView = [UIView new];
    self.tableView1.tag = 89;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    tap.delegate = self;
    [self.tableView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [self.tableView1 addGestureRecognizer:tap1];
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    

    [self initRequest];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 0;
        } else if (section < 2+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-2];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
//                return 1;
//                return 1+1+2;
                return 1+1+2+2;
            }
        } else if (section == 2+_quotationOrderItems.count) {
//            return 1+1+2+1+1;
            return 1;
        } else if (section == 2+_quotationOrderItems.count+1) {
            return 1;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 0;
        } else if (section < 2+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-2];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
                return 1+1+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+2+2;
            }
        } else if (section == 2+_quotationOrderItems.count) {

            return 1;
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
            return 0;
        } else if (indexPath.section < 2+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
//                return 265;
                return 221;
            } else if (indexPath.row == 1) {
                return 60;
            } else {
                return 40;
            }
        } else if (indexPath.section == 2+_quotationOrderItems.count) {
//            if (indexPath.row == 0) {
//                return 60;
//            } else {
//                return 40;
//            }
            return 40;
        } else if (indexPath.section == 2+_quotationOrderItems.count+1) {
            return 79;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (indexPath.section == 0) {
            return 68;
        } else if (indexPath.section == 1) {
            return 0;
        } else if (indexPath.section < 2+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                return 221;
            } else if (indexPath.row == 1) {
                return 60;
            } else {
                return 40;
            }
        } else if (indexPath.section == 2+_quotationOrderItems.count) {
//            if (indexPath.row == 0) {
//                return 60;
//            } else {
//                return 40;
//            }
            return 40;
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
        } else if (section < 2+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-2];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == 2+_quotationOrderItems.count) {
            return 32;
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
        } else if (section < 2+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-2];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == 2+_quotationOrderItems.count) {
            return 32;
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
        } else if (section < 2+_quotationOrderItems.count) {
            if (section == 2+_quotationOrderItems.count-1) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == 2+_quotationOrderItems.count) {
            return 0.1;
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
        } else if (section < 2+_quotationOrderItems.count) {
            if (section == 2+_quotationOrderItems.count-1) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == 2+_quotationOrderItems.count) {
            return 0.1;
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
            labelDiYiBaoJia.text = @"零件报价";
            [view addSubview:labelDiYiBaoJia];
            
            UILabel *labelTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(15+74+10, 0, kMainW-30-74-10, 32)];
            labelTitle1.font = [UIFont systemFontOfSize:12];
            labelTitle1.textColor = colorText153;
            labelTitle1.text = _inquiryOrderHttp.title;
            labelTitle1.textAlignment = NSTextAlignmentRight;
            [view addSubview:labelTitle1];
            
            return view;
        } else if (section < 2+_quotationOrderItems.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewWeiBaoJia.hidden = YES;
            view.viewYiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            view.viewHeJia.hidden = YES;
            view.viewHeJia1.hidden = YES;
            
            InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 2];
            QuotationOrderItem *quotationOrderItem = _quotationOrderItems[section - 2];
            
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
            view.labelName.text = [NSString stringWithFormat:@"%ld、%@",section-2+1,partNumber_specifications];
            
            double totalPurchasePrice = 0;
            totalPurchasePrice = [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.purchasePrice1 doubleValue];
            view.labelHeJia1.text = [NSString stringWithFormat:@"%.2f",totalPurchasePrice];
            view.labelHeJia1.textColor = colorRGB(255, 151, 0);
            view.labelHeJia10.text = @"我的比价";
            
            view.labelHeJia11.textColor = colorRGB(255, 151, 0);
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.price1 doubleValue];
            
            if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                view.labelHeJia2.text = @"****";
                view.labelHeJia21.text = @"****";
            } else {
                view.labelHeJia2.text = [NSString stringWithFormat:@"%.2f",totalPrice];
                view.labelHeJia21.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            }
            view.labelHeJia20.text = @"供应商报价";
            view.labelHeJia210.text = @"供应商报价";
            
            if ([quotationOrderItem.isSkip integerValue] == 0) {
                view.labelHeJia11.text = @"未比价";
            } else {
                view.labelHeJia11.text = @"忽略未比价";
            }
            

            view.buttonOpen.tag = section-2;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-2;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            return view;
        } else if (section == 2+_quotationOrderItems.count) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件总计";
            [view addSubview:labelDiYiBaoJia];
            
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
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 74, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件报价明细";
            [view addSubview:labelDiYiBaoJia];
            
            UILabel *labelTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(15+74+10, 0, kMainW-30-74-10, 32)];
            labelTitle1.font = [UIFont systemFontOfSize:12];
            labelTitle1.textColor = colorText153;
            labelTitle1.text = _inquiryOrderHttp.title;
            labelTitle1.textAlignment = NSTextAlignmentRight;
            [view addSubview:labelTitle1];
            
            return view;
        } else if (section < 2+_quotationOrderItems.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewWeiBaoJia.hidden = YES;
            view.viewYiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            view.viewHeJia.hidden = YES;
            view.viewHeJia1.hidden = YES;
            
            InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 2];
            QuotationOrderItem *quotationOrderItem = _quotationOrderItems[section - 2];
            
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
            view.labelName.text = [NSString stringWithFormat:@"%ld、%@",section-2+1,partNumber_specifications];
            view.labelHeJia00.textColor = colorRGB(255, 151, 0);
            double totalPurchasePrice = 0;
            totalPurchasePrice = [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.purchasePrice1 doubleValue];
            view.labelHeJia1.text = [NSString stringWithFormat:@"%.2f",totalPurchasePrice];
            view.labelHeJia1.textColor = colorRGB(255, 151, 0);
            view.labelHeJia10.text = @"我的比价";
            view.labelHeJia11.textColor = colorRGB(255, 151, 0);
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.price1 doubleValue];
            if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                view.labelHeJia2.text = @"****";
                view.labelHeJia21.text = @"****";
            } else {
                view.labelHeJia2.text = [NSString stringWithFormat:@"%.2f",totalPrice];
                view.labelHeJia21.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            }
            
            view.labelHeJia20.text = @"供应商报价";
            view.labelHeJia210.text = @"供应商报价";
            
            if ([quotationOrderItem.isSkip integerValue] == 0) {
                view.labelHeJia11.text = @"未比价";
            } else {
                view.labelHeJia11.text = @"忽略未比价";
            }
            
            view.buttonOpen.tag = section-2;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-2;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            return view;

        } else if (section == 2+_quotationOrderItems.count) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件总计";
            [view addSubview:labelDiYiBaoJia];
            
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
            if ([_quotationOrderHttp.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
                [imageViewH sd_setImageWithURL:[NSURL URLWithString:_inquiryOrderHttp.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
                label2.text = [NSString stringWithFormat:@"%@ %@",_inquiryOrderHttp.member.enterpriseInfo.province?_inquiryOrderHttp.member.enterpriseInfo.province:@"",_inquiryOrderHttp.member.enterpriseInfo.city?_inquiryOrderHttp.member.enterpriseInfo.city:@""];
                label1.text = _inquiryOrderHttp.member.enterpriseInfo.enterpriseName;
      
            } else {//供应商身份进来
                [imageViewH sd_setImageWithURL:[NSURL URLWithString:_quotationOrderHttp.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
                
                label2.text = [NSString stringWithFormat:@"%@ %@",_quotationOrderHttp.member.enterpriseInfo.province?_quotationOrderHttp.member.enterpriseInfo.province:@"",_quotationOrderHttp.member.enterpriseInfo.city?_quotationOrderHttp.member.enterpriseInfo.city:@""];
                label1.text = _quotationOrderHttp.member.enterpriseInfo.enterpriseName;
                
            }
            
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else if (indexPath.section == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section < 2+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.viewZanBuBaoJia.hidden = YES;
                cell.buttonZanBuBaoJia.hidden = YES;
                cell.viewZongjia.hidden = YES;
                
//                cell.viewZongYiJia.hidden = YES;
//                cell.viewZongYiJia.hidden = NO;
                
                InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 2];
                QuotationOrderItem *quotationOrderItem =  _quotationOrderItems[indexPath.section - 2];
                
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
                
                if ([inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:inquiryOrderItem.sec_thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                } else {
                    
                    NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_inquiryOrderHttp.member.enterpriseInfo.enterpriseId,inquiryOrderItem.partNumber,inquiryOrderItem.picVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                }
            
                
                NSString *batchDeliverItem = [[inquiryOrderItem.deliveryTime componentsSeparatedByString:@" "] firstObject];
                cell.labelDaoHuoTime.text = [NSString stringWithFormat:@"交货日期:%@",batchDeliverItem];
                
                cell.buttonClose.tag = indexPath.section - 2;
                [cell.buttonClose addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonClose1.tag = indexPath.section - 2;
                [cell.buttonClose1 addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonImage.tag = indexPath.section - 2;
                [cell.buttonImage addTarget:self action:@selector(buttonImageClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonDetail.tag = indexPath.section - 2;
                [cell.buttonDetail setTitleColor:colorRGB(255, 151, 0) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.zongYiJialabel1.text = [NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]];
                cell.zongYiJialabel2.text = @"供应商报价:";
                
//                cell.zongYiJiaTextField.delegate = self;
//                cell.zongYiJiaTextField.tag = indexPath.section - 2;
//                cell.zongYiJiaTextField.inputAccessoryView = [self addToolbar];
//                [cell.zongYiJiaTextField addTarget:self action:@selector(priceCalculation:) forControlEvents:UIControlEventEditingChanged];
//                cell.zongYiJiaTextField.text = quotationOrderItem.purchasePrice1?[NSString stringWithFormat:@"%@",quotationOrderItem.purchasePrice1]:nil;
                
                cell.labelTargetPrice.hidden = NO;
                cell.labelTargetPrice.text = [NSString stringWithFormat:@"未税核算价:%@",inquiryOrderItem.price1.stringValue];
                
                return cell;
            } else if (indexPath.row == 1) {
                YiJiaECMingXiXiuGaiCell10 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell10" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.view1.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                cell.view2.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                
                cell.label1.text = @"我的比价(元)";
                cell.label2.text = @"供应商报价(元)";
                
                cell.button2.tag = indexPath.section - 2;
                [cell.button2 setImage:[UIImage imageNamed:@"icon_BiJia"] forState:UIControlStateNormal];
                [cell.button2 addTarget:self action:@selector(buttonImportPriceMingXi:) forControlEvents:UIControlEventTouchUpInside];
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]) {
                YiJiaECMingXiXiuGaiCell11 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell11" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 2];
                
                cell.label0.text = [_inquiryOrderHttp valueForKey:[NSString stringWithFormat:@"tempPriceDetailName%ld",indexPath.row-1]];
                
                
                NSNumber *purchaseTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"purchaseTempPrice1DetailValue%ld",indexPath.row-1]];
                if ([purchaseTempPrice1DetailValue doubleValue] == 0) {
                    cell.textField1.text = nil;
                    cell.textField1.placeholder = purchaseTempPrice1DetailValue?[NSString stringWithFormat:@"%@",purchaseTempPrice1DetailValue]:nil;
                } else {
                    cell.textField1.text = purchaseTempPrice1DetailValue?[NSString stringWithFormat:@"%@",purchaseTempPrice1DetailValue]:nil;
                }
                NSNumber *supplierTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%ld",indexPath.row-1]];
                cell.label2.text = supplierTempPrice1DetailValue?[NSString stringWithFormat:@"%.2f",[supplierTempPrice1DetailValue doubleValue]]:@"0.00";
                
                cell.textField1SuperView.tag = indexPath.section - 2;
                cell.textField1.tag = indexPath.row - 2;
                //                cell.textField1.delegate = self;
                [cell.textField1 addTarget:self action:@selector(price1MingXi:) forControlEvents:UIControlEventEditingChanged];
                cell.textField1.inputAccessoryView = [self addToolbar];
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+2) {
                if (indexPath.row == 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]) {
                    YiJiaECHeJiaXiXiuGaiCell00 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECHeJiaXiXiuGaiCell00" forIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 2];
                    cell.label0.text = @"含税单价";
                    cell.textField1.textColor = colorRGB(255, 151, 0);
                    if ([quotationOrderItem.purchasePrice1 doubleValue] == 0) {
                        cell.textField1.text = nil;
                        cell.textField1.placeholder = [NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]];
                    } else {
                        cell.textField1.text = [NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]];
                    }
                    
                    if ([quotationOrderItem.isSkip integerValue] == 1) {
                        cell.textField1.enabled = NO;
                    } else {
                        cell.textField1.enabled = YES;
                    }
                    
                    cell.label2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:@"0.00";
                    cell.textField1.delegate = self;
                    cell.textField1.tag = indexPath.section - 2;
                    cell.textField1.inputAccessoryView = [self addToolbar];
                    [cell.textField1 addTarget:self action:@selector(priceCalculation:) forControlEvents:UIControlEventEditingChanged];
                    return cell;
                } else if (indexPath.row == 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+1) {
                    YiJiaECMingXiCell02 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell02" forIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 2];
                    cell.view0.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                    cell.label0.text = @"不含税单价";
                    cell.label1.textColor = colorRGB(51, 51, 51);
                    cell.label1.text = quotationOrderItem.purchasePrice1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]/(1+[_quotationOrderHttp.supplierTaxRate doubleValue])]:nil;
                    cell.label2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]/(1+[_quotationOrderHttp.supplierTaxRate doubleValue])]:nil;
                    return cell;
                } else {
                    return nil;
                }
            } else if (indexPath.row < 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+2+1) {
                YiJiaECMingXiXiuGaiCell12 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell12" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem =  _quotationOrderItems[indexPath.section - 2];
                
                cell.label0.text = @"回复交期";
                
                cell.textField1.placeholder = @"请选择";
                cell.textField1.tag = indexPath.section - 2;
                cell.textField1.tintColor = [UIColor clearColor];
                cell.textField1.inputView = [UIView new];
                [cell.textField1 addTarget:self action:@selector(textFieldPurchaseDeliverTime:) forControlEvents:UIControlEventEditingDidBegin];
                if (quotationOrderItem.purchaseDeliverTime) {
                    cell.textField1.text = [[quotationOrderItem.purchaseDeliverTime componentsSeparatedByString:@" "] firstObject];
                } else {
                    cell.textField1.text = nil;
                }
                
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+2+2) {
                YiJiaECMingXiXiuGaiCell13 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell13" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem =  _quotationOrderItems[indexPath.section - 2];
                
                cell.label0.text = @"零件备注";
                
                cell.textField1.placeholder = @"请输入";
                cell.textField1.tag = indexPath.section - 2;
                cell.textField1.inputAccessoryView = [self addToolbar];
                [cell.textField1 addTarget:self action:@selector(textFieldPurchaseRemark:) forControlEvents:UIControlEventEditingChanged];
                cell.textField1.text = quotationOrderItem.purchaseRemark?quotationOrderItem.purchaseRemark:nil;
                
                
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 2+_quotationOrderItems.count) {
//            if (indexPath.row == 0) {
//                YiJiaECMingXiXiuGaiCell00 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell00" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.view1.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
//                cell.view2.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
//                cell.label1.text = @"我的比价(元)";
//                cell.label2.text = @"供应商报价(元)";
//                [cell.button2 setImage:[UIImage imageNamed:@"icon_BiJia"] forState:UIControlStateNormal];
//                [cell.button2 addTarget:self action:@selector(buttonImportSuppliers:) forControlEvents:UIControlEventTouchUpInside];
//                return cell;
//            } else if (indexPath.row < 1+1+2) {
//                if (indexPath.row == 1) {
//                    YiJiaECMingXiCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell01" forIndexPath:indexPath];
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                    cell.label0.text = [NSString stringWithFormat:@"小计\n(共%ld种零件)",_quotationOrderItems.count];
//                    cell.label1.text = _quotationOrderHttp.purchaseSubtotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.purchaseSubtotalPrice1 doubleValue]]:@"0.00";
//                    cell.label2.text = _quotationOrderHttp.subtotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.subtotalPrice1 doubleValue]]:@"0.00";
//                    return cell;
//                } else if (indexPath.row < 1+1+2) {
//                    YiJiaECHeJiaXiXiuGaiCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECHeJiaXiXiuGaiCell01" forIndexPath:indexPath];
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                    if (indexPath.row < 1+1+1) {
//                        cell.label0.text = @"杂费";
//                        if ([_quotationOrderHttp.purchaseCost1 doubleValue] == 0) {
//                            cell.textField1.text = nil;
//                            cell.textField1.placeholder = [NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.purchaseCost1 doubleValue]];
//                        } else {
//                            cell.textField1.text = [NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.purchaseCost1 doubleValue]];
//                        }
//                        cell.label2.text = [NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.cost1 doubleValue]];
//                    } else {
//                        cell.label0.text = @"运费";
//                        if ([_quotationOrderHttp.purchaseShipPrice1 doubleValue] == 0) {
//                            cell.textField1.text = nil;//初始化 不然有重用的效果
//                            cell.textField1.placeholder = [NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.purchaseShipPrice1 doubleValue]];
//                        } else {
//                            cell.textField1.text = [NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.purchaseShipPrice1 doubleValue]];
//                        }
//                        cell.label2.text = [NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.shipPrice1 doubleValue]];
//                    }
//                    cell.textField1.delegate = self;
//                    cell.textField1.tag = indexPath.row-2;
//                    [cell.textField1 addTarget:self action:@selector(totalCost:) forControlEvents:UIControlEventEditingChanged];
//                    cell.textField1.inputAccessoryView = [self addToolbar];
//                    return cell;
//                } else {
//                    return nil;
//                }
//            } else if (indexPath.row <= 1+1+2+1) {
//                YiJiaECMingXiCell02 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell02" forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.view0.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
//                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrderHttp.supplierTaxRate doubleValue]*100];
//                if (indexPath.row == 1+1+2) {
//                    cell.label1.textColor = colorRGB(255, 151, 0);
//                    cell.label0.text = [NSString stringWithFormat:@"总计\n(含税价%@%@)",stringTaxRate,@"%"];
//                    cell.label1.text = _quotationOrderHttp.purchaseTotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.purchaseTotalPrice1 doubleValue]]:@"0.00";
//                    cell.label2.text = _quotationOrderHttp.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.totalPrice1 doubleValue]]:@"0.00";
//                } else if (indexPath.row == 1+1+2+1) {
//                    cell.label1.textColor = colorRGB(51, 51, 51);
//                    cell.label0.text = @"总计\n(不含税价)";
//                    cell.label1.text = _quotationOrderHttp.purchaseTotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.purchaseTotalPrice1 doubleValue]/(1+[_quotationOrderHttp.supplierTaxRate doubleValue])]:@"0.00";
//                    cell.label2.text = _quotationOrderHttp.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.totalPrice1 doubleValue]/(1+[_quotationOrderHttp.supplierTaxRate doubleValue])]:@"0.00";
//                }
//                return cell;
//            } else {
//                return nil;
//            }
            if (indexPath.row == 0) {
                MXBaoJiaCell111 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell111" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrderHttp.supplierTaxRate doubleValue]*100];
                cell.label0.text = @"未税总计";
                if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                    cell.label2.text = @"****";//未税核算价
                } else {
                    cell.label2.text = _quotationOrderHttp.purchaseTotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.purchaseTotalPrice1 doubleValue]]:@"0.00";
                }
                
                cell.label1.textColor = colorCai;
                cell.label2.textColor = colorCai;
                
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
            textView.text = _quotationOrderHttp.purchaseRemark;
            textView.delegate = self;
            [cell.contentView addSubview:textView];
            textView.inputAccessoryView = [self addToolbar];
        
//            // placeholder
//            UILabel *label = [UILabel new];
//            label.font = textView.font;
//            label.text = @"额外需要注明的内容";
//            label.numberOfLines = 0;
//            label.textColor = colorRGB(204, 204, 204);
//            [label sizeToFit];
//            [textView addSubview:label];
//            // kvc
//            [textView setValue:label forKey:@"_placeholderLabel"];

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
            if ([_quotationOrderHttp.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
                [imageViewH sd_setImageWithURL:[NSURL URLWithString:_inquiryOrderHttp.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
                label2.text = [NSString stringWithFormat:@"%@ %@",_inquiryOrderHttp.member.enterpriseInfo.province?_inquiryOrderHttp.member.enterpriseInfo.province:@"",_inquiryOrderHttp.member.enterpriseInfo.city?_inquiryOrderHttp.member.enterpriseInfo.city:@""];
                label1.text = _inquiryOrderHttp.member.enterpriseInfo.enterpriseName;
                
            } else {//供应商身份进来
                [imageViewH sd_setImageWithURL:[NSURL URLWithString:_quotationOrderHttp.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
                
                label2.text = [NSString stringWithFormat:@"%@ %@",_quotationOrderHttp.member.enterpriseInfo.province?_quotationOrderHttp.member.enterpriseInfo.province:@"",_quotationOrderHttp.member.enterpriseInfo.city?_quotationOrderHttp.member.enterpriseInfo.city:@""];
                label1.text = _quotationOrderHttp.member.enterpriseInfo.enterpriseName;
                
            }
            
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else if (indexPath.section == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section < 2+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.viewZanBuBaoJia.hidden = YES;
                cell.buttonZanBuBaoJia.hidden = YES;
                cell.viewZongjia.hidden = YES;
                
                InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 2];
                QuotationOrderItem *quotationOrderItem =  _quotationOrderItems[indexPath.section - 2];
                
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
                
                if ([inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:inquiryOrderItem.sec_thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                } else {
                    
                    NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_inquiryOrderHttp.member.enterpriseInfo.enterpriseId,inquiryOrderItem.partNumber,inquiryOrderItem.picVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                }
                
                NSString *batchDeliverItem = [[inquiryOrderItem.deliveryTime componentsSeparatedByString:@" "] firstObject];
                cell.labelDaoHuoTime.text = [NSString stringWithFormat:@"交货日期:%@",batchDeliverItem];
                
                cell.buttonClose.tag = indexPath.section - 2;
                [cell.buttonClose addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonClose1.tag = indexPath.section - 2;
                [cell.buttonClose1 addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonImage.tag = indexPath.section - 2;
                [cell.buttonImage addTarget:self action:@selector(buttonImageClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonDetail.tag = indexPath.section - 2;
                [cell.buttonDetail setTitleColor:colorRGB(255, 151, 0) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            } else if (indexPath.row == 1) {
                YiJiaECMingXiXiuGaiCell10 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell10" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.view1.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                cell.view2.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                
                cell.label1.text = @"我的比价(元)";
                cell.label2.text = @"供应商报价(元)";
                
                cell.button2.tag = indexPath.section - 2;
                [cell.button2 setImage:[UIImage imageNamed:@"icon_BiJia"] forState:UIControlStateNormal];
                [cell.button2 addTarget:self action:@selector(buttonImportPriceMingXi:) forControlEvents:UIControlEventTouchUpInside];
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]) {
                YiJiaECMingXiXiuGaiCell11 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell11" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 2];
                
                cell.label0.text = [_inquiryOrderHttp valueForKey:[NSString stringWithFormat:@"tempPriceDetailName%ld",indexPath.row-1]];
                
                
                NSNumber *purchaseTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"purchaseTempPrice1DetailValue%ld",indexPath.row-1]];
                if ([purchaseTempPrice1DetailValue doubleValue] == 0) {
                    cell.textField1.text = nil;
                    cell.textField1.placeholder = purchaseTempPrice1DetailValue?[NSString stringWithFormat:@"%@",purchaseTempPrice1DetailValue]:nil;
                } else {
                    cell.textField1.text = purchaseTempPrice1DetailValue?[NSString stringWithFormat:@"%@",purchaseTempPrice1DetailValue]:nil;
                }
                if ([quotationOrderItem.isSkip integerValue] == 1) {
                    cell.textField1.enabled = NO;
                } else {
                    cell.textField1.enabled = YES;
                }
                NSNumber *supplierTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%ld",indexPath.row-1]];
                cell.label2.text = supplierTempPrice1DetailValue?[NSString stringWithFormat:@"%.2f",[supplierTempPrice1DetailValue doubleValue]]:@"0.00";
                
                cell.textField1SuperView.tag = indexPath.section - 2;
                cell.textField1.tag = indexPath.row - 2;
//                cell.textField1.delegate = self;
                [cell.textField1 addTarget:self action:@selector(price1MingXi:) forControlEvents:UIControlEventEditingChanged];
                cell.textField1.inputAccessoryView = [self addToolbar];
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+2) {
                YiJiaECMingXiCell02 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell02" forIndexPath:indexPath];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 2];
                
                cell.view0.backgroundColor = [colorRGB(255, 151, 0) colorWithAlphaComponent:0.05];
                if (indexPath.row == 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]) {
                    cell.label0.text = @"含税单价";
                    cell.label1.textColor = colorRGB(255, 151, 0);
                    cell.label1.text = quotationOrderItem.purchasePrice1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]]:@"0.00";
                    cell.label2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:@"0.00";
                } else if (indexPath.row == 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+1) {
                    cell.label0.text = @"不含税单价";
                    cell.label1.textColor = colorRGB(51, 51, 51);
                    cell.label1.text = quotationOrderItem.purchasePrice1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]/(1+[_quotationOrderHttp.supplierTaxRate doubleValue])]:nil;
                    cell.label2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]/(1+[_quotationOrderHttp.supplierTaxRate doubleValue])]:nil;
                }
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+2+1) {
                YiJiaECMingXiXiuGaiCell12 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell12" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem =  _quotationOrderItems[indexPath.section - 2];
                
                cell.label0.text = @"回复交期";
                
                cell.textField1.placeholder = @"请选择";
                cell.textField1.tag = indexPath.section - 2;
                cell.textField1.tintColor = [UIColor clearColor];
                cell.textField1.inputView = [UIView new];
                [cell.textField1 addTarget:self action:@selector(textFieldPurchaseDeliverTime:) forControlEvents:UIControlEventEditingDidBegin];
                if (quotationOrderItem.purchaseDeliverTime) {
                    cell.textField1.text = [[quotationOrderItem.purchaseDeliverTime componentsSeparatedByString:@" "] firstObject];
                } else {
                    cell.textField1.text = nil;
                }
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+2+2) {
                YiJiaECMingXiXiuGaiCell13 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell13" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem =  _quotationOrderItems[indexPath.section - 2];
                cell.label0.text = @"零件备注";
                
                cell.textField1.placeholder = @"请输入";
                cell.textField1.tag = indexPath.section - 2;
                cell.textField1.inputAccessoryView = [self addToolbar];
                [cell.textField1 addTarget:self action:@selector(textFieldPurchaseRemark:) forControlEvents:UIControlEventEditingChanged];
                cell.textField1.text = quotationOrderItem.purchaseRemark?quotationOrderItem.purchaseRemark:nil;
                
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 2+_quotationOrderItems.count) {

            if (indexPath.row == 0) {
                MXBaoJiaCell111 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell111" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrderHttp.supplierTaxRate doubleValue]*100];

                cell.label0.text = @"未税总计";
                if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                    cell.label2.text = @"****";//未税核算价
                } else {
                    cell.label2.text = _quotationOrderHttp.purchaseTotalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.purchaseTotalPrice1 doubleValue]]:@"0.00";
                }
                cell.label1.textColor = colorCai;
                cell.label2.textColor = colorCai;
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
            textView.text = _quotationOrderHttp.purchaseRemark;
            textView.delegate = self;
            [cell.contentView addSubview:textView];
            textView.inputAccessoryView = [self addToolbar];
        
            
//            // placeholder
//            UILabel *label = [UILabel new];
//            label.font = textView.font;
//            label.text = @"额外需要注明的内容";
//            label.numberOfLines = 0;
//            label.textColor = colorRGB(204, 204, 204);
//            [label sizeToFit];
//            [textView addSubview:label];
//            // kvc
//            [textView setValue:label forKey:@"_placeholderLabel"];
            

            
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
#pragma UITextViewDelegate 代理
- (void)textViewDidChange:(UITextView *)textView {
    _quotationOrderHttp.purchaseRemark = textView.text;
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
                    if ([_inquiryOrderHttp.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
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
        if ([_inquiryOrderHttp.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
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
    if ([_inquiryOrderHttp.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {//采购商身份进来
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

- (void)buttonImportTotalMingXi:(UIButton *)sender {
    
    for (int i = 0; i < [_inquiryOrderHttp.tempCostDetailCount integerValue]; i++) {
        [_quotationOrderHttp setValue:[_quotationOrderHttp valueForKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"purchaseTempCost1DetailValue%d",i+1]];
    }
    for (int i = 0; i < [_inquiryOrderHttp.tempShipPriceDetailCount integerValue]; i++) {
        [_quotationOrderHttp setValue:[_quotationOrderHttp valueForKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"purchaseTempShipPrice1DetailValue%d",i+1]];
    }


    [self calculateTotalPrice1MingXi];
    [_tableView1 reloadData];
}

- (void)buttonImportPriceMingXi:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    QuotationOrderItem *quotationOrderItem = _quotationOrderItems[sender.tag];
    for (int i = 0; i < [_inquiryOrderHttp.tempPriceDetailCount integerValue]; i++) {
        [quotationOrderItem setValue:[quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"purchaseTempPrice1DetailValue%d",i+1]];
    }
    
    quotationOrderItem.purchasePrice1 = quotationOrderItem.price1;
    [self calculateTotalPrice1MingXi];
    [_tableView1 reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        QiYeXinXiXiangQingViewController *qyxxxqVC = [[QiYeXinXiXiangQingViewController alloc] init];
        qyxxxqVC.enterpriseInfo = _quotationOrderHttp.member.enterpriseInfo;
        qyxxxqVC.isPrivate = _inquiryOrderHttp.isPrivate;
        qyxxxqVC.ucenterId = _quotationOrderHttp.member.ucenterId;
        qyxxxqVC.passiveId = _quotationOrderHttp.member.manufacturerId;
        qyxxxqVC.quotationOrderStatus = _quotationOrderHttp.status;
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

- (IBAction)caiGouShangYiJiaCommit:(id)sender {
    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:23]]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
        return;
    }
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    
    
    QuotationOrder *quotationOrder = [[QuotationOrder alloc] init];
    quotationOrder.sec_isDesignated = [NSNumber numberWithInteger:1];
    quotationOrder.quotationOrderId = _quotationOrderHttp.quotationOrderId;
    quotationOrder.purchaseSubtotalPrice1 = _quotationOrderHttp.purchaseSubtotalPrice1;
    quotationOrder.purchaseTotalPrice1 = _quotationOrderHttp.purchaseTotalPrice1;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    quotationOrder.sec_tradeOrderTime = dateString;
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:0];
    for (QuotationOrderItem *item in _quotationOrderHttp.quotationOrderItems) {
        if (item.purchasePrice1.doubleValue == 0) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请比价"];
            return;
        }
    }
    for (QuotationOrderItem *item in _quotationOrderHttp.quotationOrderItems) {
        QuotationOrderItem *itemNew = [[QuotationOrderItem alloc] init];
        itemNew.quotationOrderItemId = item.quotationOrderItemId;
        itemNew.purchaseRemark = @"";
        itemNew.purchaseDeliverTime = item.purchaseDeliverTime;
        itemNew.purchasePrice1 = item.purchasePrice1;
        itemNew.purchaseTempPrice1DetailValue1 = item.purchaseTempPrice1DetailValue1;
        itemNew.purchaseTempPrice1DetailValue2 = item.purchaseTempPrice1DetailValue2;
        itemNew.purchaseTempPrice1DetailValue3 = item.purchaseTempPrice1DetailValue3;
        itemNew.purchaseTempPrice1DetailValue4 = item.purchaseTempPrice1DetailValue4;
        itemNew.purchaseTempPrice1DetailValue5 = item.purchaseTempPrice1DetailValue5;
        itemNew.purchaseTempPrice1DetailValue6 = item.purchaseTempPrice1DetailValue6;
        itemNew.purchaseTempPrice1DetailValue7 = item.purchaseTempPrice1DetailValue7;
        itemNew.purchaseTempPrice1DetailValue8 = item.purchaseTempPrice1DetailValue8;
        itemNew.purchaseTempPrice1DetailValue9 = item.purchaseTempPrice1DetailValue9;
        itemNew.purchaseTempPrice1DetailValue10 = item.purchaseTempPrice1DetailValue10;
        itemNew.purchaseTempPrice1DetailValue11 = item.purchaseTempPrice1DetailValue11;
        itemNew.purchaseTempPrice1DetailValue12 = item.purchaseTempPrice1DetailValue12;
        itemNew.purchaseTempPrice1DetailValue13 = item.purchaseTempPrice1DetailValue13;
        itemNew.purchaseTempPrice1DetailValue14 = item.purchaseTempPrice1DetailValue14;
        itemNew.purchaseTempPrice1DetailValue15 = item.purchaseTempPrice1DetailValue15;
        itemNew.purchaseTempPrice1DetailValue16 = item.purchaseTempPrice1DetailValue16;
        itemNew.purchaseTempPrice1DetailValue17 = item.purchaseTempPrice1DetailValue17;
        itemNew.purchaseTempPrice1DetailValue18 = item.purchaseTempPrice1DetailValue18;
        itemNew.purchaseTempPrice1DetailValue19 = item.purchaseTempPrice1DetailValue19;
        [itemArray addObject:itemNew];
    }
    quotationOrder.quotationOrderItems = itemArray;
    postEntityBean.entity = quotationOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [self quotationPedit:dic];
    

}

- (void)quotationPedit:(NSDictionary *)dic{
    
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
                if ([vc isMemberOfClass:[IMETabBarViewController class]]) {
                    
                    IMETabBarViewController *tab = (IMETabBarViewController *)vc;
                    
                    if ([tab.viewControllers[0] isMemberOfClass:[ECInquiryViewController class]]) {
                        isBreak = true;
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
- (void)priceCalculation:(UITextField *)sender{
    
    if ([sender.text isEqualToString:@"."]) {
        sender.text = nil;
    }
    QuotationOrderItem *quotationOrderItem = _quotationOrderItems[sender.tag];
    NSArray *array1 = [sender.text componentsSeparatedByString:@"."];
    if (array1.count >= 2) {
        NSString *stringR = array1[1];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array1 firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        } else {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array1 firstObject],array1[1]];
        }
    }
    quotationOrderItem.purchasePrice1 = [NSNumber numberWithDouble:[sender.text doubleValue]];
    
    [self calculateTotalPrice1];

    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2+_quotationOrderItems.count],[NSIndexPath indexPathForRow:2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+1 inSection:sender.tag+2]] withRowAnimation:UITableViewRowAnimationNone];

}

#pragma mark 总价询盘 回复交期  明细询盘
- (void)textFieldPurchaseDeliverTime:(UITextField *)sender {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeYaoQiuDaoHuoRiQi" owner:self options:nil];
    UIViewXuanZeYaoQiuDaoHuoRiQi *viewXZSJ = [nib objectAtIndex:0];
    viewXZSJ.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewXZSJ];
    viewXZSJ.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [viewXZSJ initDataPickerButtonClick:^(NSString *string) {
        NSLog(@"%@",string);
        QuotationOrderItem *quotationOrderItem = _quotationOrderItems[sender.tag];
        if (quotationOrderItem) {
            quotationOrderItem.purchaseDeliverTime = string;
            sender.text = [[quotationOrderItem.purchaseDeliverTime componentsSeparatedByString:@" "] firstObject];
        }
    } buttonQuXiao:^{
        [sender resignFirstResponder];
    }];
}

#pragma mark 总价询盘 零件备注  明细询盘
- (void)textFieldPurchaseRemark:(UITextField *)sender {
    QuotationOrderItem *quotationOrderItem = _quotationOrderItems[sender.tag];
    quotationOrderItem.purchaseRemark = sender.text;
}

- (void)totalCost:(UITextField *)sender{
    NSLog(@"sender.tag:>>>:%ld",sender.tag);
    if ([sender.text isEqualToString:@"."]) {
        sender.text = nil;
    }
    NSArray *array1 = [sender.text componentsSeparatedByString:@"."];
    if (array1.count >= 2) {
        NSString *stringR = array1[1];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array1 firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        } else {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array1 firstObject],array1[1]];
        }
    }
    if (sender.tag == 0) {
        _quotationOrderHttp.purchaseCost1 = [NSNumber numberWithDouble:[sender.text doubleValue]];
    }
    if (sender.tag == 1) {
        _quotationOrderHttp.purchaseShipPrice1 = [NSNumber numberWithDouble:[sender.text doubleValue]];
    }
    
    [self calculateTotalPrice1];
}

- (void)calculateTotalPrice1 {
    double totalPrice = 0;
    totalPrice = totalPrice + [_quotationOrderHttp.purchaseCost1 doubleValue] + [_quotationOrderHttp.purchaseShipPrice1 doubleValue];
    double subtotalPrice = 0;
    for (QuotationOrderItem *quotationOrderItem in _quotationOrderItems) {
        subtotalPrice = subtotalPrice + [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.purchasePrice1 doubleValue];
    }
    subtotalPrice = [[NSString stringWithFormat:@"%.2f",subtotalPrice] doubleValue];
    totalPrice = totalPrice + subtotalPrice;
    _quotationOrderHttp.purchaseSubtotalPrice1 = [NSNumber numberWithDouble:subtotalPrice];
    _quotationOrderHttp.purchaseTotalPrice1 = [NSNumber numberWithDouble:totalPrice];
    
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1+1+2 inSection:2+_quotationOrderItems.count],[NSIndexPath indexPathForRow:1+1+2+1 inSection:2+_quotationOrderItems.count]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2+_quotationOrderItems.count]] withRowAnimation:UITableViewRowAnimationNone];

}

- (void)buttonImportTarget:(UIButton *)sender{
    for (QuotationOrderItem *quotationOrderItem in _quotationOrderItems) {
        quotationOrderItem.purchasePrice1 = quotationOrderItem.targetPrice1;
    }
    _quotationOrderHttp.purchaseCost1 = _quotationOrderHttp.targetCost1;
    _quotationOrderHttp.purchaseShipPrice1 = _quotationOrderHttp.targetShipPrice1;
    _quotationOrderHttp.purchaseSubtotalPrice1 = _quotationOrderHttp.targetSubtotalPrice1;
    _quotationOrderHttp.purchaseTotalPrice1 = _quotationOrderHttp.targetTotalPrice1;
    [self.tableView reloadData];
}

- (void)buttonImportSuppliers:(UIButton *)sender{
//    for (QuotationOrderItem *quotationOrderItem in _quotationOrderItems) {
//        quotationOrderItem.purchasePrice1 = quotationOrderItem.price1;
//    }
    _quotationOrderHttp.purchaseCost1 = _quotationOrderHttp.cost1;
    _quotationOrderHttp.purchaseShipPrice1 = _quotationOrderHttp.shipPrice1;
//    _quotationOrderHttp.purchaseSubtotalPrice1 = _quotationOrderHttp.subtotalPrice1;
//    _quotationOrderHttp.purchaseTotalPrice1 = _quotationOrderHttp.totalPrice1;
    [self calculateTotalPrice1];
    [self.tableView reloadData];
}

- (void)price1MingXi:(UITextField *)sender {
    NSString *string = sender.text;
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count == 2) {
        NSString *stringR = [array lastObject];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        }
    }
    
    UIView *view = sender.superview;
    NSLog(@"price1MingXi %ld %ld",view.tag,sender.tag);
    
    QuotationOrderItem *quotationOrderItem = _quotationOrderItems[view.tag];
    if (quotationOrderItem) {
        [quotationOrderItem setValue:[NSNumber numberWithDouble:[sender.text doubleValue]] forKey:[NSString stringWithFormat:@"purchaseTempPrice1DetailValue%ld",sender.tag+1]];
    }
    
    double price1 = 0;
    for (int i = 0; i < [_inquiryOrderHttp.tempPriceDetailCount integerValue]; i++) {
        NSNumber *purchaseTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"purchaseTempPrice1DetailValue%d",i+1]];
        price1 = price1 + [purchaseTempPrice1DetailValue doubleValue];
    }
    price1 = [[NSString stringWithFormat:@"%.2f",price1] doubleValue];
    quotationOrderItem.purchasePrice1 = [NSNumber numberWithDouble:price1];
    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2+[_inquiryOrderHttp.tempPriceDetailCount integerValue] inSection:view.tag+2],[NSIndexPath indexPathForRow:2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+1 inSection:view.tag+2]] withRowAnimation:UITableViewRowAnimationNone];
    [self calculateTotalPrice1MingXi];
//    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2+_quotationOrderItems.count]] withRowAnimation:UITableViewRowAnimationNone];
    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2+_quotationOrderItems.count]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)total1costMingXi:(UITextField *)sender {
    NSString *string = sender.text;
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count == 2) {
        NSString *stringR = [array lastObject];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        }
    }
    
    if (sender.tag < [_inquiryOrderHttp.tempCostDetailCount integerValue]) {
        [_quotationOrderHttp setValue:[NSNumber numberWithDouble:[sender.text doubleValue]] forKey:[NSString stringWithFormat:@"purchaseTempCost1DetailValue%ld",sender.tag+1]];
    } else if (sender.tag < [_inquiryOrderHttp.tempCostDetailCount integerValue]+[_inquiryOrderHttp.tempShipPriceDetailCount integerValue]) {
        [_quotationOrderHttp setValue:[NSNumber numberWithDouble:[sender.text doubleValue]] forKey:[NSString stringWithFormat:@"purchaseTempShipPrice1DetailValue%ld",sender.tag+1-[_inquiryOrderHttp.tempCostDetailCount integerValue]]];
    }
    [self calculateTotalPrice1MingXi];
}

- (void)calculateTotalPrice1MingXi {
    double totalPrice = 0;
    
    double costPrice = 0;
    for (int i = 0; i < [_inquiryOrderHttp.tempCostDetailCount integerValue]; i++) {
        NSNumber *purchaseTempCost1DetailValue = [_quotationOrderHttp valueForKey:[NSString stringWithFormat:@"purchaseTempCost1DetailValue%d",i+1]];
        costPrice = costPrice+[purchaseTempCost1DetailValue doubleValue];
    }
    totalPrice = totalPrice + costPrice;
    _quotationOrderHttp.purchaseCost1 = [NSNumber numberWithDouble:costPrice];
    double shipPrice = 0;
    for (int i = 0; i < [_inquiryOrderHttp.tempShipPriceDetailCount integerValue]; i++) {
        NSNumber *purchaseTempShipPrice1DetailValue = [_quotationOrderHttp valueForKey:[NSString stringWithFormat:@"purchaseTempShipPrice1DetailValue%d",i+1]];
        shipPrice = shipPrice+[purchaseTempShipPrice1DetailValue doubleValue];
    }
    totalPrice = totalPrice + shipPrice;
    _quotationOrderHttp.purchaseShipPrice1 = [NSNumber numberWithDouble:shipPrice];
    
    
    double subtotalPrice = 0;
    for (QuotationOrderItem *quotationOrderItem in _quotationOrderItems) {
        subtotalPrice = subtotalPrice + [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.purchasePrice1 doubleValue];
    }
    subtotalPrice = [[NSString stringWithFormat:@"%.2f",subtotalPrice] doubleValue];
    totalPrice = totalPrice + subtotalPrice;
    _quotationOrderHttp.purchaseSubtotalPrice1 = [NSNumber numberWithDouble:subtotalPrice];
    
    _quotationOrderHttp.purchaseTotalPrice1 = [NSNumber numberWithDouble:totalPrice];
    
    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2+_quotationOrderItems.count]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)tapSelector:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 60;
        self.tableViewBottom1.constant = 60;
    } else {
        self.tableViewBottom.constant = rect.size.height;
        self.tableViewBottom1.constant = rect.size.height;
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

- (void)initRequest{
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    QuotationOrder *quotationOrder = [[QuotationOrder alloc] init];
    quotationOrder.inquiryOrderId = self.inquiryOrderId;
    quotationOrder.quotationOrderId = self.quotationOrderId;
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
            
            for (NSInteger i=0; i<quotationOrder.quotationOrderItems.count; i++) {
                QuotationOrderItem *quotationOrderItem = quotationOrder.quotationOrderItems[i];
                quotationOrderItem.purchaseDeliverTime =  quotationOrderItem.inquiryOrderItem.deliveryTime;
                [_quotationOrderItems addObject:quotationOrderItem];
                [_arrayInquiryOrderItemModel addObject:quotationOrderItem.inquiryOrderItem];
                [_arrayYesOpen addObject:@"no"];
            }
            
            _quotationOrderHttp = quotationOrder;
            _inquiryOrderHttp = quotationOrder.inquiryOrder;
            
            _integerButtonLineColor = [_quotationOrderHttp.dealIndex integerValue]-1;
            _viewLoading.hidden = YES;
            
            if ([_inquiryOrderHttp.isQuotationTemplate integerValue] == 1) {//明细
                self.tableView.hidden = YES;
                [self.tableView1 reloadData];
            } else {
                self.tableView1.hidden = YES;
                [self.tableView reloadData];
            }
        } else {
            
        }
        
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
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
