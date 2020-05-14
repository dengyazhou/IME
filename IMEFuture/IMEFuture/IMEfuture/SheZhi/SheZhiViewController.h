//
//  SheZhiViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/10/24.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SheZhiViewControllerDelegate <NSObject>

- (void)loginOutSheZhiViewController;

@end

@interface SheZhiViewController : UIViewController

@property (nonatomic,assign) id <SheZhiViewControllerDelegate> delegate;

@end
