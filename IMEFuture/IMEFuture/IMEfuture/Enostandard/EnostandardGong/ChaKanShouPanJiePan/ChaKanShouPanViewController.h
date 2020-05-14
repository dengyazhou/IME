//
//  ChaKanShouPanViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InquiryOrder;

@interface ChaKanShouPanViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleHeader;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom1;




@property (nonatomic,copy) NSString *stringResource;

@property (weak, nonatomic) IBOutlet UIButton *buttonCheXiaoShouPan;//撤销授盘

@property (weak, nonatomic) IBOutlet UIButton *buttonJuJueShouPan;//拒绝授盘

@property (weak, nonatomic) IBOutlet UIButton *buttonJieShouShouPan;//接受授盘
@property (weak, nonatomic) IBOutlet UIButton *buttonJieShouShouPan2;

@property (nonatomic,strong) InquiryOrder *inquiryOrder;

@property (nonatomic,strong) NSString *quotationOrderId;

@property (weak, nonatomic) IBOutlet UIView *viewJuJueShouPan;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIButton *buttonWanCheng;

@property (weak, nonatomic) IBOutlet UIView *viewXieYi;
@property (weak, nonatomic) IBOutlet UIView *viewXieYi1;
@property (weak, nonatomic) IBOutlet UIButton *buttonDuiGou;


@end
