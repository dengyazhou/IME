//
//  ShouPanViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuotationOrder;

@interface ShouPanViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;


@property (nonatomic,copy) NSString *inquiryOrderId;
@property (nonatomic,copy) NSString *quotationOrderId;

@property (weak, nonatomic) IBOutlet UIView *viewBG0;

@property (weak, nonatomic) IBOutlet UIView *viewBG1;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *textViewText;



@end
