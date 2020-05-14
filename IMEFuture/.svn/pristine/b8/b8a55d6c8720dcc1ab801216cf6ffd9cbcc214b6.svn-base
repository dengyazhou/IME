//
//  CompanyViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/6/28.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WoViewController;
@class LoginModel;


@protocol CompanyViewControllerDelegate <NSObject>

@optional
- (void)getLoginModel:(LoginModel *)model;
- (void)hiddenWoQiYe:(BOOL)a hiddenWoGeRen:(BOOL)b;
- (void)notLoginExchangeViewController;
- (void)loginSuccess;

@end

@interface CompanyViewController : UIViewController

@property (nonatomic,assign) id<CompanyViewControllerDelegate> delegate;

@property (nonatomic,strong) WoViewController *woVC;
@property (nonatomic,strong) UIViewController *viewController;



@property (weak, nonatomic) IBOutlet UITextField *textFieldUser;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPsw;

@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;

@property (weak, nonatomic) NSString *sourceVC;//判断从那个tabBarController进来


@property(nonatomic,copy) NSString *isH5;

@property (nonatomic,copy) void(^backBlock)(NSString *string);





@end

