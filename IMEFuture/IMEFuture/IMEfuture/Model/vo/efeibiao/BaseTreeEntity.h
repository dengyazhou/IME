//
//  BaseTreeEntity.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/12.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@interface BaseTreeEntity : BaseEntity

@property (nonatomic,copy) NSString * upId;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,strong) NSNumber * level;//Integer

@property (nonatomic,copy) NSString * treePath;

@property (nonatomic,strong) NSNumber * isTip;//Integer

@property (nonatomic,strong) NSNumber * childNum;//Integer

@end
