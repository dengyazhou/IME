//
//  EFBFaPanViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/2/5.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoHeader.h"


@interface BJFaPanViewController : UIViewController

@property (nonatomic,strong) InquiryOrder *inquiryOrder;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end
