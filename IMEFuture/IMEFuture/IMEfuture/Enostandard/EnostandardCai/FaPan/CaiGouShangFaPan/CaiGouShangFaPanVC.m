//
//  CaiGouShangFaPanVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/3/1.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "CaiGouShangFaPanVC.h"
#import "VoHeader.h"


#import "EFBFaPanViewController.h"
#import "BJFaPanViewController.h"


@interface CaiGouShangFaPanVC () {
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation CaiGouShangFaPanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
}

- (IBAction)buttonClickSelectInquiryType:(UIButton *)sender {
    switch (sender.tag) {
        case 0:{//e非标询盘
            EFBFaPanViewController *eFBFaPanViewController = [[EFBFaPanViewController alloc] init];
            eFBFaPanViewController.inquiryOrder = [[InquiryOrder alloc] init];
            eFBFaPanViewController.inquiryOrder.inquiryType = @"COM";
            [self.navigationController pushViewController:eFBFaPanViewController animated:YES];
            break;
        }
        case 1:{//报价询盘
            BJFaPanViewController *bJFaPanViewController = [[BJFaPanViewController alloc] init];
            bJFaPanViewController.inquiryOrder = [[InquiryOrder alloc] init];
            bJFaPanViewController.inquiryOrder.inquiryType = @"ATG";
            [self.navigationController pushViewController:bJFaPanViewController animated:YES];
            break;
        }
        case 2:{//后议价询盘
            BJFaPanViewController *bJFaPanViewController = [[BJFaPanViewController alloc] init];
            bJFaPanViewController.inquiryOrder = [[InquiryOrder alloc] init];
            bJFaPanViewController.inquiryOrder.inquiryType = @"TTG";
            [self.navigationController pushViewController:bJFaPanViewController animated:YES];
            break;
        }
        case 3:{//指定价询盘
            BJFaPanViewController *bJFaPanViewController = [[BJFaPanViewController alloc] init];
            bJFaPanViewController.inquiryOrder = [[InquiryOrder alloc] init];
            bJFaPanViewController.inquiryOrder.inquiryType = @"FTG";
            [self.navigationController pushViewController:bJFaPanViewController animated:YES];
            break;
        }
        default:
            break;
    }
}

- (IBAction)back:(id)sender {
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
