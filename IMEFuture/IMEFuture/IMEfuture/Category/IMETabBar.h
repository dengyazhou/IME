//
//  IMETabBar.h
//  LiveApp
//
//  Created by 邓亚洲 on 2016/11/7.
//  Copyright © 2016年 邓亚洲. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,IMEItemType) {
    IMEItemTypeLaunch = 10,//启动直播
    IMEItemTypeLive = 100,//展示直播
    IMEItemTypeMe,//我的
};

@class IMETabBar;

typedef void(^TabBlock)(IMETabBar * tabbar,IMEItemType idx);

@protocol IMETabBarDelegate <NSObject>

- (void)tabbar:(IMETabBar *)tabbar clickButton:(IMEItemType)idx;

@end

@interface IMETabBar : UIView

@property (nonatomic,weak) id <IMETabBarDelegate> delegate;

@property (nonatomic,copy) TabBlock block;

@end
