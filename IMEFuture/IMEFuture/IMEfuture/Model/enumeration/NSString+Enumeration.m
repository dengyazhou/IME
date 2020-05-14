//
//  NSString+Enumeration.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/16.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NSString+Enumeration.h"

@implementation NSString (Enumeration)

+ (NSString *)QuantityUnit:(NSString *)string {
//    if ([string isEqualToString:@"A"]) {
//        return @"件";
//    }
//    if ([string isEqualToString:@"B"]) {
//        return @"张";
//    }
//    if ([string isEqualToString:@"C"]) {
//        return @"只";
//    }
//    if ([string isEqualToString:@"D"]) {
//        return @"双";
//    }
//    if ([string isEqualToString:@"E"]) {
//        return @"台";
//    }
//    if ([string isEqualToString:@"F"]) {
//        return @"卷";
//    }
//    if ([string isEqualToString:@"G"]) {
//        return @"辆";
//    }
//    if ([string isEqualToString:@"H"]) {
//        return @"箱";
//    }
//    if ([string isEqualToString:@"I"]) {
//        return @"包";
//    }
//    if ([string isEqualToString:@"J"]) {
//        return @"套";
//    }
//    if ([string isEqualToString:@"K"]) {
//        return @"桶";
//    }
//    if ([string isEqualToString:@"L"]) {
//        return @"打";
//    }
//    if ([string isEqualToString:@"M"]) {
//        return @"袋";
//    }
//    if ([string isEqualToString:@"N"]) {
//        return @"个";
//    }
    return string;
}

+ (NSString*)PayType:(NSString *)string {
    if ([string isEqualToString:@"A"]) {
        return @"支付宝";
    }
    if ([string isEqualToString:@"W"]) {
        return @"微信";
    }
    if ([string isEqualToString:@"L"]) {
        return @"余额";
    }
    if ([string isEqualToString:@"C"]) {
        return @"信用";
    }
    if ([string isEqualToString:@"P"]) {
        return @"平安见证宝";
    }
    if ([string isEqualToString:@"B"]) {
        return @"银行";
    }
    if ([string isEqualToString:@"X"]) {
        return @"线下付款";
    }
    return nil;
}

+ (NSString *)DeliveryMethod:(NSString *)string {
    if ([string isEqualToString:@"A"]) {
        return @"快递";
    }
    if ([string isEqualToString:@"B"]) {
        return @"汽运";
    }
    if ([string isEqualToString:@"C"]) {
        return @"水运";
    }
    if ([string isEqualToString:@"D"]) {
        return @"铁道运输";
    }
    if ([string isEqualToString:@"E"]) {
        return @"空运";
    }
    if ([string isEqualToString:@"F"]) {
        return @"不限";
    }
    if ([string isEqualToString:@"SUPPLIER"]) {
        return @"供应商送货";
    }
    if ([string isEqualToString:@"LOGISTICS"]) {
        return @"快递物流";
    }
    if ([string isEqualToString:@"SELF"]) {
        return @"自提";
    }
    return nil;
}

+ (NSString *)SizeUnit:(NSString *)string {
    if ([string isEqualToString:@"A"]) {
        return @"英寸";
    }
    if ([string isEqualToString:@"B"]) {
        return @"毫米";
    }
    return nil;
}

+ (NSString *)Industry:(NSString *)string {
    if ([string isEqualToString:@"AA"]) {
        return @"机械及工具行业";
    }
    if ([string isEqualToString:@"AB"]) {
        return @"造纸和纸浆工业";
    }
    if ([string isEqualToString:@"AC"]) {
        return @"木加工工业";
    }
    if ([string isEqualToString:@"AD"]) {
        return @"HVAC（加热，通风和空气调节装置）";
    }
    if ([string isEqualToString:@"AE"]) {
        return @"公用事业设备行业";
    }
    if ([string isEqualToString:@"AF"]) {
        return @"农用机械";
    }
    if ([string isEqualToString:@"AG"]) {
        return @"包装";
    }
    if ([string isEqualToString:@"AH"]) {
        return @"化工";
    }
    if ([string isEqualToString:@"AI"]) {
        return @"医药工业";
    }
    if ([string isEqualToString:@"AJ"]) {
        return @"印刷行业";
    }
    if ([string isEqualToString:@"AK"]) {
        return @"塑料和橡胶工业";
    }
    if ([string isEqualToString:@"AL"]) {
        return @"工程及工程设计行业";
    }
    if ([string isEqualToString:@"AM"]) {
        return @"建筑及起重行业";
    }
    if ([string isEqualToString:@"AN"]) {
        return @"政府军事";
    }
    if ([string isEqualToString:@"AO"]) {
        return @"政府非军事";
    }
    if ([string isEqualToString:@"AP"]) {
        return @"教育";
    }
    if ([string isEqualToString:@"AQ"]) {
        return @"汽车工业";
    }
    if ([string isEqualToString:@"AR"]) {
        return @"测量与测试行业";
    }
    if ([string isEqualToString:@"AS"]) {
        return @"消费产品";
    }
    if ([string isEqualToString:@"AT"]) {
        return @"生物工艺学/制药学";
    }
    if ([string isEqualToString:@"AU"]) {
        return @"电信产业";
    }
    if ([string isEqualToString:@"AV"]) {
        return @"电子产品与电子元器件行业";
    }
    if ([string isEqualToString:@"AW"]) {
        return @"电子仪器仪表、设备业";
    }
    if ([string isEqualToString:@"AX"]) {
        return @"石油和天然气";
    }
    if ([string isEqualToString:@"AY"]) {
        return @"矿业";
    }
    if ([string isEqualToString:@"AZ"]) {
        return @"纺织工业";
    }
    if ([string isEqualToString:@"BA"]) {
        return @"航空航天业";
    }
    if ([string isEqualToString:@"BB"]) {
        return @"计算机，系统和外设";
    }
    if ([string isEqualToString:@"BC"]) {
        return @"运输";
    }
    if ([string isEqualToString:@"BD"]) {
        return @"金属制品行业";
    }
    if ([string isEqualToString:@"BE"]) {
        return @"食品工业";
    }
    if ([string isEqualToString:@"BF"]) {
        return @"饮料行业";
    }
    if ([string isEqualToString:@"CZ"]) {
        return @"其他";
    }
    return @"--";
}

+ (NSString *)QuotationOrderStatus:(NSString *)string {
    if ([string isEqualToString:@"WC"]) {
        return @"待审核";
    }
    if ([string isEqualToString:@"CR"]) {
        return @"取消授盘";
    }
    if ([string isEqualToString:@"RR"]) {
        return @"拒绝接盘";
    }
    if ([string isEqualToString:@"CF"]) {
        return @"审核失败";
    }
    if ([string isEqualToString:@"WS"]) {
        return @"等待采购授盘";
    }
    if ([string isEqualToString:@"WR"]) {
        return @"等待供应商接盘";
    }
    if ([string isEqualToString:@"SO"]) {
        return @"授盘其他供应商";
    }
    if ([string isEqualToString:@"SR"]) {
        return @"成功接盘";
    }
    if ([string isEqualToString:@"TO"]) {
        return @"已过期";
    }
    if ([string isEqualToString:@"CL"]) {
        return @"已关闭";
    }
    if ([string isEqualToString:@"CC"]) {
        return @"已取消";
    }
    return nil;
}

+ (NSString *)TradeOrderPurchaseStatus:(NSString *)string {
    if ([string isEqualToString:@"WAITAPPROVAL"]) {
        return @"待审批";
    }
    if ([string isEqualToString:@"WAITORDER"]) {
        return @"待接单";
    }
    if ([string isEqualToString:@"purchasePaid"]) {
        return @"待发货";
    }
    if ([string isEqualToString:@"supplierDelivered"]) {
        return @"待收货";
    }
    if ([string isEqualToString:@"examineCargoForPurchase"]) {
        return @"待质检";
    }
    if ([string isEqualToString:@"waitBalance"]) {
        return @"待对账";
    }
    if ([string isEqualToString:@"success"]) {
        return @"已完成";
    }
    if ([string isEqualToString:@"REFUSEDAPPROVAL"]) {
        return @"审批失败";
    }
    if ([string isEqualToString:@"REFUSEDORDER"]) {
        return @"拒绝接单";
    }
    if ([string isEqualToString:@"ACCEPTFAILED"]) {
        return @"验收不通过";
    }
    if ([string isEqualToString:@"close"]) {
        return @"已关闭";
    }
    return nil;
}
+ (NSString *)TradeOrderSupplierStatus:(NSString *)string {
    if ([string isEqualToString:@"waitingPaymentForPurchase"]) {
        return @"等待采购商付款";
    }
    if ([string isEqualToString:@"paymentOvertime"]) {
        return @"付款超时";
    }
    if ([string isEqualToString:@"paymentConfirm"]) {
        return @"付款确认中";
    }
    if ([string isEqualToString:@"purchasePaid"]) {
        return @"待发货";
    }
    if ([string isEqualToString:@"supplierDelivered"]) {
        return @"供应商已发货";
    }
    if ([string isEqualToString:@"examineCargoForPurchase"]) {
        return @"等待采购商验货";
    }
    if ([string isEqualToString:@"alreadyExamineCargoForPurchase"]) {
        return @"采购商已验货";
    }
    if ([string isEqualToString:@"waitBalance"]) {
        return @"待对账";
    }
    if ([string isEqualToString:@"success"]) {
        return @"交易成功";
    }
    if ([string isEqualToString:@"close"]) {
        return @"交易关闭";
    }
    return nil;
}

+ (NSString *)UserType:(NSString *)string {
    if ([string isEqualToString:@"NORMAL"]) {
        return @"普通用户";
    }
    if ([string isEqualToString:@"ENTERPRISE"]) {
        return @"企业用户";
    }
    return nil;
}

+ (NSString *)RelationType:(NSString *)string {
    if ([string isEqualToString:@"A"]) {
        return @"关注";
    }
    if ([string isEqualToString:@"B"]) {
        return @"拉黑";
    }
    if ([string isEqualToString:@"T"]) {
        return @"合作";
    }
    if ([string isEqualToString:@"O"]) {
        return @"交易";
    }
    if ([string isEqualToString:@"D"]) {
        return @"托管";
    }
    return nil;
}
+ (NSString *)RegisterType:(NSString *)string {
    if ([string isEqualToString:@"PHONE"]) {
        return @"手机号验证";
    }
    if ([string isEqualToString:@"EMAIL"]) {
        return @"邮箱验证";
    }
    if ([string isEqualToString:@"OAUTH"]) {
        return @"第三方oauth";
    }
    return nil;
}
+ (NSString *)PurchasePayStatus:(NSString *)string {
    if ([string isEqualToString:@"PAID"]) {
        return @"已付款";
    }
    if ([string isEqualToString:@"NONPAYMENT"]) {
        return @"未付款";
    }
    if ([string isEqualToString:@"NONEEDTOPAY"]) {
        return @"无需付款";
    }
    return nil;
}

+ (NSString *)OauthType:(NSString *)string {
    if ([string isEqualToString:@"QQ"]) {
        return @"QQ";
    }
    if ([string isEqualToString:@"WECHAT"]) {
        return @"微信";
    }
    if ([string isEqualToString:@"WEIBO"]) {
        return @"新浪微博";
    }
    if ([string isEqualToString:@"NONE"]) {
        return @"非第三方认证";
    }
    return nil;
}
+ (NSString *)NotificationSendStatus:(NSString *)string {
    if ([string isEqualToString:@"unSend"]) {
        return @"未发送";
    }
    if ([string isEqualToString:@"sent"]) {
        return @"已发送";
    }
    if ([string isEqualToString:@"sendSuccess"]) {
        return @"发送成功";
    }
    if ([string isEqualToString:@"sendFail"]) {
        return @"发送失败";
    }
    return nil;
}
+ (NSString *)ModuleName:(NSString *)string {
    if ([string isEqualToString:@"M"]) {
        return @"用户";
    }
    if ([string isEqualToString:@"C"]) {
        return @"权限";
    }
    return nil;
}
+ (NSString *)MemberType:(NSString *)string {
    if ([string isEqualToString:@"F"]) {
        return @"工厂";
    }
    if ([string isEqualToString:@"C"]) {
        return @"员工";
    }
    return nil;
}
+ (NSString *)LogType:(NSString *)string {
    if ([string isEqualToString:@"A"]) {
        return @"添加";
    }
    if ([string isEqualToString:@"D"]) {
        return @"删除";
    }
    if ([string isEqualToString:@"U"]) {
        return @"修改";
    }
    if ([string isEqualToString:@"P"]) {
        return @"发布";
    }
    if ([string isEqualToString:@"F"]) {
        return @"封锁";
    }
    if ([string isEqualToString:@"L"]) {
        return @"锁定";
    }
    if ([string isEqualToString:@"J"]) {
        return @"对接";
    }
    if ([string isEqualToString:@"E"]) {
        return @"启用";
    }
    if ([string isEqualToString:@"T"]) {
        return @"禁用";
    }
    if ([string isEqualToString:@"S"]) {
        return @"激活";
    }
    if ([string isEqualToString:@"C"]) {
        return @"通过";
    }
    if ([string isEqualToString:@"R"]) {
        return @"拒绝";
    }
    return nil;
}
+ (NSString *)InquiryType:(NSString *)string {
    if ([string isEqualToString:@"COM"]) {
        return @"普通";//0
    }
    if ([string isEqualToString:@"DIR"]) {
        return @"定向";//2
    }
    if ([string isEqualToString:@"ATG"]) {
        return @"管家报价";//4
    }
    if ([string isEqualToString:@"FTG"]) {
        return @"定价管家";//5
    }
    if ([string isEqualToString:@"TTG"]) {
        return @"议价管家";//6
    }
    return nil;
}
+ (NSString *)FileType:(NSString *)string {
    if ([string isEqualToString:@"I"]) {
        return @"图片";
    }
    if ([string isEqualToString:@"V"]) {
        return @"视频";
    }
    if ([string isEqualToString:@"M"]) {
        return @"音频";
    }
    if ([string isEqualToString:@"F"]) {
        return @"文件";
    }
    return nil;
}
+ (NSString *)FileExtension:(NSString *)string {
    //暂时不用
    return nil;
}
+ (NSString *)DisabledType:(NSString *)string {
    if ([string isEqualToString:@"E"]) {
        return @"启用";
    }
    if ([string isEqualToString:@"D"]) {
        return @"禁用";
    }
    return nil;
}
+ (NSString *)CompetenceType:(NSString *)string {
    //暂时不用
    return nil;
}
+ (NSString *)CompetenceAddType:(NSString *)string {
    if ([string isEqualToString:@"M"]) {
        return @"用户分配";
    }
    if ([string isEqualToString:@"R"]) {
        return @"角色分配";
    }
    return nil;
}
+ (NSString *)CommentType:(NSString *)string {
    if ([string isEqualToString:@"SUPPLIER"]) {
        return @"供应商评价";
    }
    if ([string isEqualToString:@"PURCHASE"]) {
        return @"采购商评价";
    }
    return nil;
}
+ (NSString *)AppCategory:(NSString *)string {
    if ([string isEqualToString:@"UNCATEGORY"]) {
        return @"未分类";
    }
    if ([string isEqualToString:@"ANDROID"]) {
        return @"安卓";
    }
    if ([string isEqualToString:@"IOS"]) {
        return @"苹果";
    }
    return nil;
}
+ (NSString *)AppType:(NSString *)string {
    if ([string isEqualToString:@"IMEFUTURE"]) {
        return @"智造家";
    }
    if ([string isEqualToString:@"IMEFUTUREMES"]) {
        return @"智造家MES";
    }
    if ([string isEqualToString:@"DRAWINGPLUGIN"]) {
        return @"图纸云插件";
    }
    return nil;
}
+ (NSString *)PubType:(NSString *)string {
    if ([string isEqualToString:@"P"]) {
        return @"发布";
    }
    if ([string isEqualToString:@"D"]) {
        return @"草稿";
    }
    if ([string isEqualToString:@"R"]) {
        return @"封锁";
    }
    return nil;
}
+ (NSString *)RecommendContent:(NSString *)string {
    if ([string isEqualToString:@"N"]) {
        return @"行业资讯";
    }
    if ([string isEqualToString:@"E"]) {
        return @"会展大厅";
    }
    if ([string isEqualToString:@"T"]) {
        return @"SAAS工具";
    }
    if ([string isEqualToString:@"TA"]) {
        return @"标签";
    }
    if ([string isEqualToString:@"C"]) {
        return @"自定义";
    }
    return nil;
}
+ (NSString *)RecommendPage:(NSString *)string {
    //暂时不用
    return nil;
}
+ (NSString *)RecommendType:(NSString *)string {
    if ([string isEqualToString:@"R"]) {
        return @"推荐位";
    }
    if ([string isEqualToString:@"A"]) {
        return @"广告位";
    }
    return nil;
}
+ (NSString *)Channel:(NSString *)string {
    if ([string isEqualToString:@"pcweb"]) {
        return @"pcweb";
    }
    if ([string isEqualToString:@"app"]) {
        return @"app";
    }
    if ([string isEqualToString:@"weixin"]) {
        return @"weixin";
    }
    if ([string isEqualToString:@"sms"]) {
        return @"sms";
    }
    if ([string isEqualToString:@"email"]) {
        return @"email";
    }
    if ([string isEqualToString:@"pcweb_app"]) {
        return @"pcweb_app";
    }
    if ([string isEqualToString:@"pcweb_app_weixin"]) {
        return @"pcweb_app_weixin";
    }
    return nil;
}
+ (NSString *)SendStatus:(NSString *)string {
    if ([string isEqualToString:@"unSend"]) {
        return @"未发送";
    }
    if ([string isEqualToString:@"sent"]) {
        return @"已发送";
    }
    if ([string isEqualToString:@"sendSuccess"]) {
        return @"发送成功";
    }
    if ([string isEqualToString:@"reSend"]) {
        return @"已重发";
    }
    if ([string isEqualToString:@"sendFail"]) {
        return @"发送失败";
    }
    if ([string isEqualToString:@"delete"]) {
        return @"已删除";
    }
    return nil;
}

+ (NSString *)Type:(NSString *)string{
    if ([string isEqualToString:@"ND1"]) {
        return @"给供应商推荐询盘";
    }
    if ([string isEqualToString:@"ND2"]) {
        return @"收到报价询盘邀请";
    }
    if ([string isEqualToString:@"ND3"]) {
        return @"询价单有人报价";
    }
    if ([string isEqualToString:@"ND4"]) {
        return @"有人修改报价";
    }
    if ([string isEqualToString:@"ND5"]) {
        return @"拒绝授盘";
    }
    if ([string isEqualToString:@"ND6"]) {
        return @"接受授盘，生成订单，通知采购商";
    }
    if ([string isEqualToString:@"ND7"]) {
        return @"询盘过期";
    }
    if ([string isEqualToString:@"ND8"]) {
        return @"收到授盘";
    }
    if ([string isEqualToString:@"ND9"]) {
        return @"接受授盘，生成订单，通知供应商";
    }
    if ([string isEqualToString:@"ND10"]) {
        return @"报价的询盘已经授盘给其他供应商";
    }
    if ([string isEqualToString:@"ND11"]) {
        return @"订单付款，平台收到付款，通知供应商";
    }
    if ([string isEqualToString:@"ND12"]) {
        return @"平台付款给供应商";
    }
    if ([string isEqualToString:@"ND13"]) {
        return @"确认收货";
    }
    if ([string isEqualToString:@"ND14"]) {
        return @"采购商发起纠纷";
    }
    if ([string isEqualToString:@"ND15"]) {
        return @"仲裁结果通知供应商";
    }
    if ([string isEqualToString:@"ND16"]) {
        return @"订单付款，平台收到付款，通知采购商";
    }
    if ([string isEqualToString:@"ND17"]) {
        return @"供应商已发货";
    }
    if ([string isEqualToString:@"ND18"]) {
        return @"供应商发起纠纷";
    }
    if ([string isEqualToString:@"ND19"]) {
        return @"仲裁结果通知采购商";
    }
    if ([string isEqualToString:@"ND20"]) {
        return @"收到退款";
    }
    if ([string isEqualToString:@"ND21"]) {
        return @"采购商验货";
    }
    if ([string isEqualToString:@"ND22"]) {
        return @"提醒采购商付款";
    }
    if ([string isEqualToString:@"ND23"]) {
        return @"新询盘咨询";
    }
    if ([string isEqualToString:@"ND24"]) {
        return @"询盘咨询被回答";
    }
    if ([string isEqualToString:@"ND25"]) {
        return @"收到定向询盘邀请";
    }
    if ([string isEqualToString:@"ND26"]) {
        return @"收到管家询盘邀请";
    }
    if ([string isEqualToString:@"ND27"]) {
        return @"催报价";
    }
    if ([string isEqualToString:@"ND28"]) {
        return @"催发货";
    }
    if ([string isEqualToString:@"ND30"]) {
        return @"供应商修改管家询盘价格";
    }
    if ([string isEqualToString:@"ND31"]) {
        return @"供应商确认管家询盘价格";
    }
    if ([string isEqualToString:@"ND32"]) {
        return @"采购商修改管家询盘价格";
    }
    if ([string isEqualToString:@"ND33"]) {
        return @"采购商确认管家询盘价格";
    }
    if ([string isEqualToString:@"ND101"]) {
        return @"仓库已收货（采购商）";
    }
    if ([string isEqualToString:@"ND102"]) {
        return @"质检不合格不需要补发货（采购商）";
    }
    if ([string isEqualToString:@"ND103"]) {
        return @"质检不合格需要补发货（采购商）";
    }
    if ([string isEqualToString:@"ND104"]) {
        return @"质检合格（采购商）";
    }
    if ([string isEqualToString:@"ND105"]) {
        return @"质检不合格需要补发货（供应商）";
    }
    if ([string isEqualToString:@"ND106"]) {
        return @"同意对账申请（需要财务操作付款）";
    }
    if ([string isEqualToString:@"ND107"]) {
        return @"拒绝对账申请（供应商）";
    }
    if ([string isEqualToString:@"ND108"]) {
        return @"同意付款申请（供应商）";
    }
    if ([string isEqualToString:@"ND109"]) {
        return @"申请对账（采购商）";
    }
    if ([string isEqualToString:@"ND110"]) {
        return @"撤销申请（采购商）";
    }
    if ([string isEqualToString:@"ND111"]) {
        return @"设置开票日期（采购商）";
    }
    if ([string isEqualToString:@"ND112"]) {
        return @"发起变更（供应商）";
    }
    if ([string isEqualToString:@"ND113"]) {
        return @"同意变更（供应商）";
    }
    if ([string isEqualToString:@"ND114"]) {
        return @"拒绝变更（供应商）";
    }
    if ([string isEqualToString:@"ND115"]) {
        return @"发起变更（采购商）";
    }
    if ([string isEqualToString:@"ND116"]) {
        return @"同意变更（采购商）";
    }
    if ([string isEqualToString:@"ND117"]) {
        return @"拒绝变更（采购商）";
    }
    if ([string isEqualToString:@"ND118"]) {
        return @"同意对账申请（无须财务操作付款）";
    }
    if ([string isEqualToString:@"ND119"]) {
        return @"仓库收货数量与发货数量不符合";
    }
    if ([string isEqualToString:@"ND120"]) {
        return @"授盘审核成功";
    }
    if ([string isEqualToString:@"ND121"]) {
        return @"授盘审核失败";
    }
    if ([string isEqualToString:@"ND122"]) {
        return @"被预授盘的供应商修改报价";
    }
    if ([string isEqualToString:@"A"]) {
        return @"发布普通询盘";
    }
    if ([string isEqualToString:@"B"]) {
        return @"授盘";
    }
    if ([string isEqualToString:@"C"]) {
        return @"取消授盘";
    }
    if ([string isEqualToString:@"D"]) {
        return @"取消询盘";
    }
    if ([string isEqualToString:@"E"]) {
        return @"回复本企业所有的询盘提问";
    }
    if ([string isEqualToString:@"F"]) {
        return @"付款";
    }
    if ([string isEqualToString:@"G"]) {
        return @"收货";
    }
    if ([string isEqualToString:@"H"]) {
        return @"验货";
    }
    if ([string isEqualToString:@"I"]) {
        return @"添加报价";
    }
    if ([string isEqualToString:@"J"]) {
        return @"修改报价";
    }
    if ([string isEqualToString:@"K"]) {
        return @"报价审核通过";
    }
    if ([string isEqualToString:@"L"]) {
        return @"接盘";
    }
    if ([string isEqualToString:@"M"]) {
        return @"拒绝接盘";
    }
    if ([string isEqualToString:@"N"]) {
        return @"报价审核失败";
    }
    if ([string isEqualToString:@"O"]) {
        return @"下载图纸";
    }
    if ([string isEqualToString:@"P"]) {
        return @"e非标发货";
    }
    if ([string isEqualToString:@"Q"]) {
        return @"供应商评价订单";
    }
    if ([string isEqualToString:@"R"]) {
        return @"员工角色列表";
    }
    if ([string isEqualToString:@"S"]) {
        return @"添加员工角色";
    }
    if ([string isEqualToString:@"T"]) {
        return @"回复自己的询盘提问";
    }
    if ([string isEqualToString:@"U"]) {
        return @"添加管家供应商";
    }
    if ([string isEqualToString:@"V"]) {
        return @"删除管家供应商";
    }
    if ([string isEqualToString:@"W"]) {
        return @"添加管家供应商评价";
    }
    if ([string isEqualToString:@"X"]) {
        return @"修改管家供应商评价";
    }
    if ([string isEqualToString:@"Y"]) {
        return @"我是采购商入口";
    }
    if ([string isEqualToString:@"Z"]) {
        return @"采购商评价订单";
    }
    if ([string isEqualToString:@"AA"]) {
        return @"我是供应商入口";
    }
    if ([string isEqualToString:@"AB"]) {
        return @"非标管家入口";
    }
    if ([string isEqualToString:@"AC"]) {
        return @"发布管家询盘";
    }
    if ([string isEqualToString:@"AD"]) {
        return @"采购商下载议价报表";
    }
    if ([string isEqualToString:@"AE"]) {
        return @"添加管家订单评价";
    }
    if ([string isEqualToString:@"AG"]) {
        return @"修改管家订单评价";
    }
    if ([string isEqualToString:@"AF"]) {
        return @"设置管家供应商权重";
    }
    if ([string isEqualToString:@"AH"]) {
        return @"新增报价模板";
    }
    if ([string isEqualToString:@"AI"]) {
        return @"编辑报价模板";
    }
    if ([string isEqualToString:@"AJ"]) {
        return @"删除报价模板";
    }
    if ([string isEqualToString:@"AK"]) {
        return @"查看报价模板";
    }
    if ([string isEqualToString:@"AL"]) {
        return @"查看订单价格";
    }
    if ([string isEqualToString:@"AM"]) {
        return @"退货";
    }
    if ([string isEqualToString:@"AN"]) {
        return @"补发货";
    }
    if ([string isEqualToString:@"AO"]) {
        return @"管家发货";
    }
    if ([string isEqualToString:@"AP"]) {
        return @"供应商申请对账";
    }
    if ([string isEqualToString:@"AQ"]) {
        return @"供应商撤销申请";
    }
    if ([string isEqualToString:@"AR"]) {
        return @"采购商设置收票日期";
    }
    if ([string isEqualToString:@"AS"]) {
        return @"供应商发起变更";
    }
    if ([string isEqualToString:@"AT"]) {
        return @"供应商拒绝变更";
    }
    if ([string isEqualToString:@"AU"]) {
        return @"供应商同意变更";
    }
    if ([string isEqualToString:@"AV"]) {
        return @"采购商同意对账申请";
    }
    if ([string isEqualToString:@"AW"]) {
        return @"采购商拒绝对账申请";
    }
    if ([string isEqualToString:@"AX"]) {
        return @"采购商同意付款申请";
    }
    if ([string isEqualToString:@"AY"]) {
        return @"采购商发起变更";
    }
    if ([string isEqualToString:@"AZ"]) {
        return @"采购商拒绝变更";
    }
    if ([string isEqualToString:@"BA"]) {
        return @"采购商同意变更";
    }
    if ([string isEqualToString:@"BB"]) {
        return @"设置项目所属采购员";
    }
    if ([string isEqualToString:@"BC"]) {
        return @"授盘审核通过";
    }
    if ([string isEqualToString:@"BD"]) {
        return @"授盘审核失败";
    }
    return nil;
}

+ (NSString*)ColorStyle:(NSString *)string {
    if ([string isEqualToString:@"NULL"]) {
        return @"#ffffff";
    }
    if ([string isEqualToString:@"A"]) {
        return @"#83dbff";
    }
    if ([string isEqualToString:@"B"]) {
        return @"#fa96e6";
    }
    if ([string isEqualToString:@"C"]) {
        return @"#fceca4";
    }
    if ([string isEqualToString:@"D"]) {
        return @"#819cff";
    }
    if ([string isEqualToString:@"E"]) {
        return @"#ffae83";
    }
    if ([string isEqualToString:@"F"]) {
        return @"#ffa0a0";
    }
    if ([string isEqualToString:@"G"]) {
        return @"#79dfd6";
    }
    if ([string isEqualToString:@"H"]) {
        return @"#9ac6e5";
    }
    return nil;
}

+ (NSString *)PurchasePorjectStatus:(NSString *)string {
    if ([string isEqualToString:@"ING"]) {
        return @"进行中";
    }
    if ([string isEqualToString:@"FINISH"]) {
        return @"已结束";
    }
    return nil;
}

+ (NSString *)LogisticsEnum:(NSString *)string{
    if ([string isEqualToString:@"SF"]) {
        return @"顺丰速递";
    }
    if ([string isEqualToString:@"DB"]) {
        return @"德邦物流";
    }
    if ([string isEqualToString:@"YT"]) {
        return @"圆通快递";
    }
    if ([string isEqualToString:@"ZT"]) {
        return @"中通快递";
    }
    if ([string isEqualToString:@"ST"]) {
        return @"申通快递";
    }
    if ([string isEqualToString:@"YD"]) {
        return @"韵达快递";
    }
    if ([string isEqualToString:@"XX"]) {
        return @"线下物流";
    }
    if ([string isEqualToString:@"QT"]) {
        return @"其他物流";
    }
    return nil;
}

+ (NSString *)OperateStatus:(NSString *)string {
    if ([string isEqualToString:@"ADD"]) {
        return @"增加";
    }
    if ([string isEqualToString:@"SUB"]) {
        return @"扣除";
    }
    return nil;
}

+ (NSString *)OrderOperateType:(NSString *)string{
    if ([string isEqualToString:@"S"]) {
        return @"采购到货单";
    }
    if ([string isEqualToString:@"R"]) {
        return @"采购入库";
    }
    if ([string isEqualToString:@"I"]) {
        return @"采购验货";
    }
    if ([string isEqualToString:@"RE"]) {
        return @"采购出库";
    }
    if ([string isEqualToString:@"SR"]) {
        return @"补货到货单";
    }
    return nil;
}

+ (NSString *)InviteMode:(NSString *)string {
    if ([string isEqualToString:@"LINK"]) {
        return @"链接/二维码";
    }
    if ([string isEqualToString:@"TARGET"]) {
        return @"定向";
    }
    return nil;
}

+ (NSString *)InviteType:(NSString *)string {
    if ([string isEqualToString:@"Q"]) {
        return @"报价";
    }
    if ([string isEqualToString:@"UQ"]) {
        return @"修改报价";
    }
    if ([string isEqualToString:@"RQ"]) {
        return @"确认报价";
    }
    if ([string isEqualToString:@"R"]) {
        return @"授盘";
    }
    if ([string isEqualToString:@"D"]) {
        return @"发货";
    }
    if ([string isEqualToString:@"UR"]) {
        return @"注册";
    }
    if ([string isEqualToString:@"NR"]) {
        return @"普通注册";
    }
    if ([string isEqualToString:@"DQ"]) {
        return @"核价备注";
    }
    return nil;
}

+ (NSString *)AppName:(NSString *)strting {
    if ([strting isEqualToString:@"USERCENTER"]) {
        return @"用户中心";
    }
    if ([strting isEqualToString:@"TMGC"]) {
        return @"透明工厂";
    }
    if ([strting isEqualToString:@"FEIBIAO"]) {
        return @"非标交易";
    }
    if ([strting isEqualToString:@"DRAW"]) {
        return @"图纸云";
    }
    if ([strting isEqualToString:@"SBBJY"]) {
        return @"设备备件云";
    }
    if ([strting isEqualToString:@"WEIKE"]) {
        return @"智客";
    }
    if ([strting isEqualToString:@"CRM"]) {
        return @"智造家客服";
    }
    return nil;
}

+ (NSString *)DefectiveOperateType:(NSString *)string {
    if ([string isEqualToString:@"RP"]) {
        return @"返修";
    }
    if ([string isEqualToString:@"RE"]) {
        return @"退货";
    }
    if ([string isEqualToString:@"DE"]) {
        return @"报废";
    }
    if ([string isEqualToString:@"OT"]) {
        return @"其他";
    }
    if ([string isEqualToString:@"DJ"]) {
        return @"降级接收";
    }
    return nil;
}

+ (NSString *)StorageType:(NSString *)string {
    if ([string isEqualToString:@"N"]) {
        return @"数量调整";
    }
    if ([string isEqualToString:@"I"]) {
        return @"质检不合格";
    }
    return nil;
}

+ (NSString *)ChangeStatus:(NSString *)string {
    if ([string isEqualToString:@"WAITCONFIRM"]) {
        return @"待确认";
    }
    if ([string isEqualToString:@"REFUSE"]) {
        return @"已拒绝";
    }
    if ([string isEqualToString:@"AGREE"]) {
        return @"已同意";
    }
    if ([string isEqualToString:@"CANCEL"]) {
        return @"已撤销";
    }
    return nil;
}

+ (NSString *)ChangeType:(NSString *)string {
    if ([string isEqualToString:@"AMOUNT"]) {
        return @"金额变更";
    }
    if ([string isEqualToString:@"QUANTITY"]) {
        return @"数量变更";
    }
    if ([string isEqualToString:@"DRAWING"]) {
        return @"图纸变更";
    }
    if ([string isEqualToString:@"OTHER"]) {
        return @"其他";
    }
    return nil;
}

+ (NSString *)TgBalanceOrderStatus:(NSString *)string {
    if ([string isEqualToString:@"ING"]) {
        return @"待审核";
    }
    if ([string isEqualToString:@"REFUSE"]) {
        return @"已拒绝";
    }
    if ([string isEqualToString:@"CANCEL"]) {
        return @"撤销";
    }
    if ([string isEqualToString:@"SUCCESS"]) {
        return @"已完成";
    }
    return nil;
}

+ (NSString *)TgBalancePayStatus:(NSString *)string {
    if ([string isEqualToString:@"WAITPAY"]) {
        return @"未付款";
    }
    if ([string isEqualToString:@"PAYED"]) {
        return @"已付款";
    }
    return nil;
}

+ (NSString *)TgBalancePayType:(NSString *)string {
    if ([string isEqualToString:@"ONE"]) {
        return @"收票后按账期支付";
    }
    if ([string isEqualToString:@"TWO"]) {
        return @"收票后定金加尾款支付";
    }
    if ([string isEqualToString:@"MANY"]) {
        return @"收票后分期支付";
    }
    return nil;
}

+ (NSString *)ImagePreviewSize:(NSString *)string {
    if ([string isEqualToString:@"SMALL"]) {
        return @"小图，80x70";
    }
    if ([string isEqualToString:@"MID"]) {
        return @"中图，160x140";
    }
    if ([string isEqualToString:@"LARGE"]) {
        return @"大图，240x210";
    }
    if ([string isEqualToString:@"SUPERLARGE"]) {
        return @"超大图，240x210";
    }
    return nil;
}

+ (NSString *)StaticFile:(NSString *)string {
    if ([string isEqualToString:@"PREVIEW_PROCESSING"]) {
        return @"图片处理中";
    }
    return nil;
}

+ (NSString *)InspectType:(NSString *)string {
    if ([string isEqualToString:@"S"]) {
        return @"抽检";
    }
    
    if ([string isEqualToString:@"F"]) {
        return @"全检";
    }
    
    if ([string isEqualToString:@"E"]) {
        return @"免检";
    }
    
    if ([string isEqualToString:@"A"]) {
        return @"系统";
    }
    return nil;
}

+ (NSString *)PartSourceType:(NSString *)string {
    if ([string isEqualToString:@"DRAWING"]) {
        return @"图纸云导入";
    }
    
    if ([string isEqualToString:@"ERP"]) {
        return @"对接";
    }
    
    if ([string isEqualToString:@"IMPORT"]) {
        return @"导入";
    }
    
    if ([string isEqualToString:@"ADD"]) {
        return @"手动添加";
    }
    
    if ([string isEqualToString:@"OLD"]) {
        return @"未知";
    }
    
    if ([string isEqualToString:@"INQUIRY"]) {
        return @"无清单";
    }
    return nil;
}

+ (NSString *)ProjectInfoChangeType:(NSString *)string {
    if ([string isEqualToString:@"ADD"]) {
        return @"添加物料";
    }
    if ([string isEqualToString:@"DELETE"]) {
        return @"删除物料";
    }
    if ([string isEqualToString:@"UPDATE"]) {
        return @"物料替换";
    }
    if ([string isEqualToString:@"DRAWING"]) {
        return @"图纸变更";
    }
    if ([string isEqualToString:@"PROPERTY"]) {
        return @"属性变更";
    }
    return nil;
}

+ (NSString *)ProjectInfoStatus:(NSString *)string {
    if ([string isEqualToString:@"WAITFORPURCHASE"]) {
        return @"待采购";
    }
    if ([string isEqualToString:@"INQUIRY"]) {
        return @"询盘阶段";
    }
    if ([string isEqualToString:@"TRADEORDER"]) {
        return @"订单阶段";
    }
    if ([string isEqualToString:@"COMPLETE"]) {
        return @"已完成";
    }
    return  nil;
}

+ (NSString *)ReceiveOrderStatus:(NSString *)string {
    if ([string isEqualToString:@"WAITINSPECT"]) {
        return @"待质检";
    }
    if ([string isEqualToString:@"INSPECTING"]) {
        return @"质检中";
    }
    if ([string isEqualToString:@"INSPECTED"]) {
        return @"已质检";
    }
    return  nil;
}

+ (NSString *)PartType:(NSString *)string {
    if ([string isEqualToString:@"FBJ"]) {
        return @"非标件";
    }
    if ([string isEqualToString:@"BZJ"]) {
        return @"标准件";
    }
    if ([string isEqualToString:@"SCYL"]) {
        return @"生产原料";
    }
    if ([string isEqualToString:@"GXWX"]) {
        return @"工序外协";
    }
    if ([string isEqualToString:@"FWJ"]) {
        return @"服务件";
    }
    return nil;
}

+ (NSString *)ProcessType:(NSString *)string {
    if ([string isEqualToString:@"BGBL"]) {
        return @"包工包料";
    }
    if ([string isEqualToString:@"QLJG"]) {
        return @"取料加工";
    }
    if ([string isEqualToString:@"ZJG"]) {
        return @"追加工";
    }
    return @"--";
}

+ (NSString *)InquiryOrderStatus:(NSString *)string {
    if ([string isEqualToString:@"NEW"]) {
        return @"未报价";
    }
    if ([string isEqualToString:@"QUOTATION"]) {
        return @"已报价";
    }
    if ([string isEqualToString:@"SEND"]) {
        return @"已授单";
    }
    if ([string isEqualToString:@"REFUSE"]) {
        return @"拒绝报价";
    }
    if ([string isEqualToString:@"CANCEL"]) {
        return @"询盘取消";
    }
    return nil;
}

+ (NSString *)InquiryAndEpStatus:(NSString *)string {
    if ([string isEqualToString:@"NEW"]) {
        return @"未报价";
    }
    if ([string isEqualToString:@"QUOTATION"]) {
        return @"已报价";
    }
    if ([string isEqualToString:@"SEND"]) {
        return @"已授单";
    }
    if ([string isEqualToString:@"REFUSE"]) {
        return @"已拒绝";
    }
    if ([string isEqualToString:@"SENDOTHER"]) {
        return @"授单他人";
    }
    if ([string isEqualToString:@"CANCEL"]) {
        return @"询盘取消";
    }
    return nil;
}

+ (NSString *)InquiryOrderItemStatus:(NSString *)string {
    if ([string isEqualToString:@"SEND"]) {
        return @"已授单";
    }
    if ([string isEqualToString:@"CANCEL"]) {
        return @"询盘取消";
    }
    if ([string isEqualToString:@"DELETE"]) {
        return @"已删除";
    }
    return nil;
}

@end
