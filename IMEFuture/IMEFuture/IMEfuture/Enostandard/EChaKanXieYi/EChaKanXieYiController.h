//
//  EChaKanXieYi.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/9/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EChaKanXieYiControllerDelegate <NSObject>

- (void)tongYiXieYiEChaKanXieYiControllerDelegate;
- (void)buTongYiXieYiEChaKanXieYiControllerDelegate;

@end

@interface EChaKanXieYiController : UIViewController

@property (nonatomic,assign) id <EChaKanXieYiControllerDelegate> delegate;



@property (weak, nonatomic) IBOutlet UIView *webBG;//以后会去掉

@property (nonatomic,copy) NSString *detailUrl;


@end
