//
//  WebDatailURL.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebDatailURL : UIViewController

@property (nonatomic,copy) NSString *detailUrl;
@property (nonatomic,copy) NSString *titleTitle;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *imagePath;
@property (nonatomic,assign) BOOL isShare;

@property (weak, nonatomic) IBOutlet UILabel *labelHeaderTitle;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end
