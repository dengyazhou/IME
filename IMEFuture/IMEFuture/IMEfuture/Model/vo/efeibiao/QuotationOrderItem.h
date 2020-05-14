//
//  QuotationOrderItem.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/22.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class QuotationOrder;
@class InquiryOrderItem;
//#import "QuotationOrder.h"
//#import "InquiryOrderItem.h"

@interface QuotationOrderItem : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString *  quotationOrderItemId;
/**
 * 采购商填写的交货时间
 */
@property (nonatomic,copy) NSString *  purchaseDeliverTime;//Date
/**
 * 供应商商填写的交货时间
 */
@property (nonatomic,copy) NSString *  supplierDeliverTime;//Date
/**
 * 报价单Id
 */
@property (nonatomic,copy) NSString *  quotationOrderId;
/**
 * 询盘单订单项
 */
@property (nonatomic,strong) InquiryOrderItem *inquiryOrderItem;
/**
 * 询盘单订单项Id
 */
@property (nonatomic,copy) NSString *  inquiryOrderItemId;
/**
 * 是否忽略当前零件不进行报价
 */
@property (nonatomic,strong) NSNumber *isSkip;//Integer
/**
 * 忽略当前零件不进行报价的原因
 */
@property (nonatomic,copy) NSString *  skipRemark;
/**
 * 供应商备注
 */
@property (nonatomic,copy) NSString *  supplierRemark;
/**
 * 采购商备注
 */
@property (nonatomic,copy) NSString *  purchaseRemark;
/**
 * 报价数量
 */
@property (nonatomic,strong) NSNumber * num1;//BigDecimal
/**
 * 第一报价单价(供应商报价)
 */
@property (nonatomic,strong) NSNumber * price1;//BigDecimal
/**
 * 第一报价单价(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchasePrice1;//BigDecimal
/**
 * 报价模板价格明细的总计数量
 */
@property (nonatomic,strong) NSNumber *tempPriceDetailCount;//Integer
/**
 * 第一报价的价格模板价格值1(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue1;//BigDecimal
/**
 * 第一报价的价格模板价格值2(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue2;//BigDecimal
/**
 * 第一报价的价格模板价格值3(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue3;//BigDecimal
/**
 * 第一报价的价格模板价格值4(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue4;//BigDecimal
/**
 * 第一报价的价格模板价格值5(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue5;//BigDecimal
/**
 * 第一报价的价格模板价格值6(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue6;//BigDecimal
/**
 * 第一报价的价格模板价格值7(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue7;//BigDecimal
/**
 * 第一报价的价格模板价格值8(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue8;//BigDecimal
/**
 * 第一报价的价格模板价格值9(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue9;//BigDecimal
/**
 * 第一报价的价格模板价格值10(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue10;//BigDecimal
/**
 * 第一报价的价格模板价格值11(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue11;//BigDecimal
/**
 * 第一报价的价格模板价格值12(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue12;//BigDecimal
/**
 * 第一报价的价格模板价格值13(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue13;//BigDecimal
/**
 * 第一报价的价格模板价格值14(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue14;//BigDecimal
/**
 * 第一报价的价格模板价格值15(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue15;//BigDecimal
/**
 * 第一报价的价格模板价格值16(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue16;//BigDecimal
/**
 * 第一报价的价格模板价格值17(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue17;//BigDecimal
/**
 * 第一报价的价格模板价格值18(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue18;//BigDecimal
/**
 * 第一报价的价格模板价格值19(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseTempPrice1DetailValue19;//BigDecimal
/**
 * 第一报价的价格模板价格值1(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue1;//BigDecimal
/**
 * 第一报价的价格模板价格值2(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue2;//BigDecimal
/**
 * 第一报价的价格模板价格值3(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue3;//BigDecimal
/**
 * 第一报价的价格模板价格值4(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue4;//BigDecimal
/**
 * 第一报价的价格模板价格值5(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue5;//BigDecimal
/**
 * 第一报价的价格模板价格值6(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue6;//BigDecimal
/**
 * 第一报价的价格模板价格值7(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue7;//BigDecimal
/**
 * 第一报价的价格模板价格值8(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue8;//BigDecimal
/**
 * 第一报价的价格模板价格值9(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue9;//BigDecimal
/**
 * 第一报价的价格模板价格值10(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue10;//BigDecimal
/**
 * 第一报价的价格模板价格值11(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue11;//BigDecimal
/**
 * 第一报价的价格模板价格值12(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue12;//BigDecimal
/**
 * 第一报价的价格模板价格值13(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue13;//BigDecimal
/**
 * 第一报价的价格模板价格值14(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue14;//BigDecimal
/**
 * 第一报价的价格模板价格值15(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue15;//BigDecimal
/**
 * 第一报价的价格模板价格值16(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue16;//BigDecimal
/**
 * 第一报价的价格模板价格值17(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue17;//BigDecimal
/**
 * 第一报价的价格模板价格值18(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue18;//BigDecimal
/**
 * 第一报价的价格模板价格值19(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice1DetailValue19;//BigDecimal
/**
 * 暂存报价明细ID
 */
@property (nonatomic,copy) NSString *  sec_tempQuotationOrderItemId;























/**
 * 报价单
 */
@property (nonatomic,strong) QuotationOrder *quotationOrder;

/**
 * 目标价供应商是否可见
 */
@property (nonatomic,strong) NSNumber *isVisiblePrice;//Integer

/**
 * 第一报价单价(采购商目标价)
 */
@property (nonatomic,strong) NSNumber *targetPrice1;//double

/**
 * 第二报价的价格模板价格值1(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue1;//BigDecimal

/**
 * 第二报价的价格模板价格值2(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue2;//BigDecimal

/**
 * 第二报价的价格模板价格值3(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue3;//BigDecimal

/**
 * 第二报价的价格模板价格值4(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue4;//BigDecimal

/**
 * 第二报价的价格模板价格值5(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue5;//BigDecimal

/**
 * 第二报价的价格模板价格值6(供应商报价)
 */
@property (nonatomic,strong) NSNumber *supplierTempPrice2DetailValue6;//BigDecimal

/**
 * 第二报价的价格模板价格值7(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue7;//BigDecimal

/**
 * 第二报价的价格模板价格值8(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue8;//BigDecimal

/**
 * 第二报价的价格模板价格值9(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue9;//BigDecimal

/**
 * 第二报价的价格模板价格值10(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue10;//BigDecimal

/**
 * 第二报价的价格模板价格值11(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue11;//BigDecimal

/**
 * 第二报价的价格模板价格值12(供应商报价)
 */
@property (nonatomic,strong) NSNumber *supplierTempPrice2DetailValue12;//BigDecimal

/**
 * 第二报价的价格模板价格值13(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue13;//BigDecimal

/**
 * 第二报价的价格模板价格值14(供应商报价)
 */
@property (nonatomic,strong) NSNumber *supplierTempPrice2DetailValue14;//BigDecimal

/**
 * 第二报价的价格模板价格值15(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue15;//BigDecimal

/**
 * 第二报价的价格模板价格值16(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue16;//BigDecimal

/**
 * 第二报价的价格模板价格值17(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue17;//BigDecimal

/**
 * 第二报价的价格模板价格值18(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue18;//BigDecimal

/**
 * 第二报价的价格模板价格值19(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice2DetailValue19;//BigDecimal

/**
 * 第三报价的价格模板价格值1(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue1;//BigDecimal

/**
 * 第三报价的价格模板价格值2(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue2;//BigDecimal

/**
 * 第三报价的价格模板价格值3(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue3;//BigDecimal

/**
 * 第三报价的价格模板价格值4(供应商报价)
 */
@property (nonatomic,strong) NSNumber *supplierTempPrice3DetailValue4;//BigDecimal

/**
 * 第三报价的价格模板价格值5(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue5;//BigDecimal

/**
 * 第三报价的价格模板价格值6(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue6;//BigDecimal

/**
 * 第三报价的价格模板价格值7(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue7;//BigDecimal

/**
 * 第三报价的价格模板价格值8(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue8;//BigDecimal

/**
 * 第三报价的价格模板价格值9(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue9;//BigDecimal

/**
 * 第三报价的价格模板价格值10(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue10;//BigDecimal

/**
 * 第三报价的价格模板价格值11(供应商报价)
 */
@property (nonatomic,strong) NSNumber *supplierTempPrice3DetailValue11;//BigDecimal

/**
 * 第三报价的价格模板价格值12(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue12;//BigDecimal

/**
 * 第三报价的价格模板价格值13(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue13;//BigDecimal

/**
 * 第三报价的价格模板价格值14(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue14;//BigDecimal

/**
 * 第三报价的价格模板价格值15(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue15;//BigDecimal

/**
 * 第三报价的价格模板价格值16(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue16;//BigDecimal

/**
 * 第三报价的价格模板价格值17(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue17;//BigDecimal

/**
 * 第三报价的价格模板价格值18(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue18;//BigDecimal

/**
 * 第三报价的价格模板价格值19(供应商报价)
 */
@property (nonatomic,strong) NSNumber * supplierTempPrice3DetailValue19;//BigDecimal
//------170828报价模板相关 end ---------------

/**
 * 第二报价单价
 */
@property (nonatomic,strong) NSNumber *price2;//Double

/**
 * 第二报价数量
 */
@property (nonatomic,strong) NSNumber *num2;//Integer

/**
 * 第三报价单价
 */
@property (nonatomic,strong) NSNumber *price3;//Double

/**
 * 第三报价数量
 */
@property (nonatomic,strong) NSNumber *num3;//Integer

/**
 * 查询某企业的报价单
 */
@property (nonatomic,copy) NSString *qm__manufacturerId;

/**
 * 查询某报价单
 */
@property (nonatomic,copy) NSString *q__quotationOrderId;

/**
 * 查询是否是历史报价
 */
@property (nonatomic,strong) NSNumber *q__isLog;//Integer

/**
 * 查询询盘发起企业
 */
@property (nonatomic,copy) NSString *i__manufacturerId;

/**
 * 查询询盘ID
 */
@property (nonatomic,strong) NSMutableArray * sei_quotationOrderId;//@property (nonatomic,copy) NSString *  [] sei_quotationOrderId;

/**
 * 临时存放
 */
@property (nonatomic,copy) NSString * sec_quotationOrderId;

/**
 * 临时存放
 */
@property (nonatomic,copy) NSString * sec_inquiryOrderItemId;

/**
 * 临时存放
 */
@property (nonatomic,strong) NSNumber *sec_num1;//integer
@end
