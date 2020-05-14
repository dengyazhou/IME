//
//  FenLeiSouSuoJieGuoViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/6.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FenLeiSouSuoJieGuoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *buttonSearch;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,copy) NSString *stringSearchContent;

@end
