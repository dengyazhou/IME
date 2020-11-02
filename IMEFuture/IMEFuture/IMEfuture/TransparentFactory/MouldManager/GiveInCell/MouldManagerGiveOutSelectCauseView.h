//
//  MouldManagerGiveOutSelectCauseView.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/10/14.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModelReturnCauseVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MouldManagerGiveOutSelectCauseView : UIView

@property (nonatomic, assign) NSInteger index;

+ (instancetype)loadMyView;

@property (nonatomic, copy) void(^selectBlock)(NSInteger index,ModelReturnCauseVo *model);
- (void)callBackSelectTableViewIndex:(void(^)(NSInteger index,ModelReturnCauseVo *model))block;

- (void)loadTableWithArray:(NSMutableArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
