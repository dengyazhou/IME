//
//  InquiryOrderQA.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"
@class InquiryOrder;
@class Member;
@interface InquiryOrderQA : BaseEntity
/**
 */
@property (nonatomic,copy) NSString * qaId;

/**
 * 询盘单ID
 */
@property (nonatomic,copy) NSString *inquiryOrderId;

/**
 * 询盘单实体
 */
@property (nonatomic,strong)  InquiryOrder * inquiryOrder;

/**
 * 询盘单itemID
 */
@property (nonatomic,copy) NSString *inquiryOrderItemId;

/**
 * 零件名称
 */
@property (nonatomic,copy) NSString *partName;

/**
 * 行号
 */
@property (nonatomic,strong) NSNumber * lineNumber;//Integer

/**
 * 用户ID
 */
@property (nonatomic,copy) NSString *memberId;

/**
 * 用户实体
 */
@property (nonatomic,strong)  Member *member;

/**
 * 内容
 */
@property (nonatomic,copy) NSString * content;

/**
 * 问答类型（问：0；答：1）
 */
@property (nonatomic,strong) NSNumber * qaType;//Integer

/**
 * 问答关系标识
 * 答：问主键+当前时间戳
 */
@property (nonatomic,copy) NSString *relatedFlag;

@end
