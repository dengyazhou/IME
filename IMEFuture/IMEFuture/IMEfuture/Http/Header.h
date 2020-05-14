//
//  Header.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/1.
//  Copyright © 2016年 Netease. All rights reserved.
//

#ifndef Header_h
#define Header_h


#define kMainW ([UIScreen mainScreen].bounds.size.width)
#define kMainH ([UIScreen mainScreen].bounds.size.height)

#define colorRGB(_R_,_G_,_B_) [UIColor colorWithRed:_R_/255.0 green:_G_/255.0 blue:_B_/255.0 alpha:1]

#define colorCai colorRGB(255, 132, 0)
#define colorGong colorRGB(0, 168, 255)
#define colorBG colorRGB(241, 241, 241)
#define colorLine colorRGB(221, 221, 221)

#define colorText153 colorRGB(153, 153, 153)

#define pageSizeDYZ @8


#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define IS_IPHONE_X (Screen_Height == 812.0f || Screen_Height == 896) ? YES : NO
#define Height_NavContentBar 44.0f
#define Height_StatusBar  ((IS_IPHONE_X==YES)?44.0f: 20.0f)
#define Height_NavBar    ((IS_IPHONE_X==YES)?88.0f: 64.0f)
#define Height_TabBar    ((IS_IPHONE_X==YES)?83.0f: 49.0f)
#define Height_BottomBar    ((IS_IPHONE_X==YES)?34.0f: 0.0f)


//#define DEBUGIME
#ifdef DEBUGIME
#define NSLogDYZ( s, ... ) NSLog( @"%@",[NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define NSLogDYZ( s, ... )
#endif


#define EFeiBiaoToken @"efeibiaoToken"

#define DefaultPurchase @"Purchase"
#define DefaultSupplier @"Supplier"
#define DefaultCenter @"Center"




#define showAlert(__message__) UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:__message__ preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];\
[alertC addAction:action];\
[self presentViewController:alertC animated:YES completion:nil];


#endif /* Header_h */
