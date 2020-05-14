//
//  NSString+Enumeration.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/16.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Enumeration)


+ (NSString *)QuantityUnit:(NSString *)string;

+ (NSString*)PayType:(NSString *)string;

+ (NSString *)DeliveryMethod:(NSString *)string;

+ (NSString *)SizeUnit:(NSString *)string;

+ (NSString *)Industry:(NSString *)string;

+ (NSString *)QuotationOrderStatus:(NSString *)string;

+ (NSString *)TradeOrderPurchaseStatus:(NSString *)string;

+ (NSString *)TradeOrderSupplierStatus:(NSString *)string;

+ (NSString *)UserType:(NSString *)string;

+ (NSString *)RelationType:(NSString *)string;

+ (NSString *)RegisterType:(NSString *)string;

+ (NSString *)PurchasePayStatus:(NSString *)string;

+ (NSString *)OauthType:(NSString *)string;

+ (NSString *)NotificationSendStatus:(NSString *)string;

+ (NSString *)ModuleName:(NSString *)string;

+ (NSString *)MemberType:(NSString *)string;

+ (NSString *)LogType:(NSString *)string;

+ (NSString *)InquiryType:(NSString *)string;

+ (NSString *)FileType:(NSString *)string;

+ (NSString *)FileExtension:(NSString *)string;

+ (NSString *)DisabledType:(NSString *)string;

+ (NSString *)CompetenceType:(NSString *)string;

+ (NSString *)CompetenceAddType:(NSString *)string;

+ (NSString *)CommentType:(NSString *)string;

+ (NSString *)AppCategory:(NSString *)string;

+ (NSString *)AppType:(NSString *)string;

+ (NSString *)PubType:(NSString *)string;

+ (NSString *)RecommendContent:(NSString *)string;

+ (NSString *)RecommendPage:(NSString *)string;

+ (NSString *)RecommendType:(NSString *)string;

+ (NSString *)Channel:(NSString *)string;

+ (NSString *)SendStatus:(NSString *)string;

+ (NSString *)Type:(NSString *)string;

+ (NSString *)ColorStyle:(NSString *)string;

+ (NSString *)PurchasePorjectStatus:(NSString *)string;

+ (NSString *)LogisticsEnum:(NSString *)string;

+ (NSString *)OperateStatus:(NSString *)string;

+ (NSString *)OrderOperateType:(NSString *)string;

+ (NSString *)InviteMode:(NSString *)string;

+ (NSString *)InviteType:(NSString *)string;

+ (NSString *)AppName:(NSString *)strting;

+ (NSString *)DefectiveOperateType:(NSString *)string;

+ (NSString *)StorageType:(NSString *)string;

+ (NSString *)ChangeStatus:(NSString *)string;

+ (NSString *)ChangeType:(NSString *)string;

+ (NSString *)TgBalanceOrderStatus:(NSString *)string;

+ (NSString *)TgBalancePayStatus:(NSString *)string;

+ (NSString *)TgBalancePayType:(NSString *)string;

+ (NSString *)ImagePreviewSize:(NSString *)string;

+ (NSString *)StaticFile:(NSString *)string;

+ (NSString *)InspectType:(NSString *)string;

+ (NSString *)PartSourceType:(NSString *)string;

+ (NSString *)ProjectInfoChangeType:(NSString *)string;

+ (NSString *)ProjectInfoStatus:(NSString *)string;

+ (NSString *)ReceiveOrderStatus:(NSString *)string;

+ (NSString *)PartType:(NSString *)string;

+ (NSString *)ProcessType:(NSString *)string;

//询盘状态
+ (NSString *)InquiryOrderStatus:(NSString *)string;

//报价状态
+ (NSString *)InquiryAndEpStatus:(NSString *)string;

//询盘明细状态
+ (NSString *)InquiryOrderItemStatus:(NSString *)string;
@end
