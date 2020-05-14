//
//  XunPanXiangQingViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InquiryOrder;
@class QuotationOrder;

@interface XunPanXiangQingViewController : UIViewController

/**
 区分采购商、供应商、游客
DefaultPurchase @"Purchase"
DefaultSupplier @"Supplier"
DefaultCenter @"Center"
 */
@property (nonatomic,copy) NSString *isDefaultPurchase;

@property (nonatomic,copy) NSString *inquiryOrderId;


@property (weak, nonatomic) IBOutlet UITableView *tableView;




@property (weak, nonatomic) IBOutlet UIView *viewJuJueShouPan;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewYiJia;
@property (weak, nonatomic) IBOutlet UIButton *buttonWanCheng;


//询盘单关注
@property (weak, nonatomic) IBOutlet UIButton *buttonInquiryAttention;

@property (weak, nonatomic) IBOutlet UIButton *buttonHasProject;//加入项目


@property (strong,nonatomic) UIView *viewPickView0;
@property (strong,nonatomic) UIView *viewPickView1;
@property (strong,nonatomic) UIPickerView *pickerView;


- (void)requestData:(void(^)(id data))dataBlock;


@end
