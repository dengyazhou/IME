//
//  OrderOperateItem.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/4/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class TradeOrderItem;
@class OrderOperate;

@interface OrderOperateItem : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * operateItemId;

/**
 * 订单项ID
 */
@property (nonatomic,copy) NSString * tradeOrderItemId;

/**
 * 操作数量
 */
@property (nonatomic,strong) NSNumber * operateNum;//Integer

/**
 * 采购数量-订单读入
 */
@property (nonatomic,strong) NSNumber * purchaseNum;//Integer

/**
 * 操作表头
 */
@property (nonatomic,strong)  OrderOperate * orderOperate;

/**
 * 表头ID
 */
@property (nonatomic,copy) NSString * orderOperateId;

/**
 * 相关订单项
 */
@property (nonatomic,strong) TradeOrderItem * tradeOrderItem;

/**
 * 备注
 */
@property (nonatomic,copy) NSString * remark;

/**
 * 验货正品数量（验货单）
 */
@property (nonatomic,strong) NSNumber * qualityQuantity;//Integer

/**
 * 验货次品数量（验货单）
 */
@property (nonatomic,strong) NSNumber * defectiveQuantity;//Integer

/**
 * 补发货数量（验货单）
 */
@property (nonatomic,strong) NSNumber * reissueQuantity;//Integer

/**
 * 关联的操作订单项ID
 * 收货关联发货，验货关联收货
 */
@property (nonatomic,copy) NSString * linkOperateItemId;

/**
 * 已收货数量(累计)
 * 收货时，更新发货单项（到货单）
 */
@property (nonatomic,strong) NSNumber * receiveQuantity;

/**
 * 已收货次数（累计）
 */
@property (nonatomic,strong) NSNumber * receiveNums;//Integer

/**
 * 退货数量（累计）
 * 退货时，更新收货单项（入库单）
 */
@property (nonatomic,strong) NSNumber * refundQuantity;//Integer

/**
 * 退货数量（累计）-展示用
 * 退货时，更新发货单项（到货单）
 */
@property (nonatomic,strong) NSNumber * deRefundQuantity;//Integer

/**
 * 是否点选了入库完成（收货）
 * null/0-未选择；1-选择收货完成
 */
@property (nonatomic,strong) NSNumber * completeType;//Integer

/**
 * 次品处理方式1
 */
@property (nonatomic,copy) NSString * defectiveOperateType1;//DefectiveOperateType

/**
 * 返修数量1
 */
@property (nonatomic,strong) NSNumber * reissueNum1;//Integer

/**
 * 供应商是否需要补发1
 * 0-否；1-是
 */
@property (nonatomic,strong) NSNumber * isNeedSend1;//Integer

/**
 * 不合格原因1
 */
@property (nonatomic,copy) NSString * unReason1;

/**
 * 次品处理方式2
 */
@property (nonatomic,copy) NSString * defectiveOperateType2;//DefectiveOperateType

/**
 * 返修数量2
 */
@property (nonatomic,strong) NSNumber * reissueNum2;//Integer

/**
 * 供应商是否需要补发2
 * 0-否；1-是
 */
@property (nonatomic,strong) NSNumber * isNeedSend2;//Integer

/**
 * 不合格原因2
 */
@property (nonatomic,copy) NSString * unReason2;

/**
 * 次品处理方式3
 */
@property (nonatomic,copy) NSString * defectiveOperateType3;//DefectiveOperateType

/**
 * 返修数量3
 */
@property (nonatomic,strong) NSNumber * reissueNum3;//Integer

/**
 * 供应商是否需要补发3
 * 0-否；1-是
 */
@property (nonatomic,strong) NSNumber * isNeedSend3;//Integer

/**
 * 不合格原因3
 */
@property (nonatomic,copy) NSString * unReason3;

/**
 * 次品处理方式4
 */
@property (nonatomic,copy) NSString * defectiveOperateType4;//DefectiveOperateType

/**
 * 返修数量4
 */
@property (nonatomic,strong) NSNumber * reissueNum4;//Integer

/**
 * 供应商是否需要补发4
 * 0-否；1-是
 */
@property (nonatomic,strong) NSNumber * isNeedSend4;//Integer

/**
 * 不合格原因4
 */
@property (nonatomic,copy) NSString * unReason4;//Integer

/**
 * 次品处理方式5
 */
@property (nonatomic,copy) NSString * defectiveOperateType5;//DefectiveOperateType

/**
 * 返修数量5
 */
@property (nonatomic,strong) NSNumber * reissueNum5;//Integer

/**
 * 供应商是否需要补发5
 * 0-否；1-是
 */
@property (nonatomic,strong) NSNumber * isNeedSend5;//Integer

/**
 * 不合格原因5
 */
@property (nonatomic,copy) NSString * unReason5;

/**
 * 是否免检
 * 0-否；1-是
 */
@property (nonatomic,strong) NSNumber * isMianjian;//Integer

/**
 * 可验货数量（验货单）
 * 从发货单带入-展示用
 */
@property (nonatomic,strong) NSNumber * canInspectNum;//Integer

/**
 * 收货是否完成（到货单）
 * 1-完成；0/null-未完成
 */
@property (nonatomic,strong) NSNumber * receviceStatus;//Integer

/**
 * 单价
 */
@property (nonatomic,strong) NSNumber * price;//BigDecimal

/**
 * 预发货数量
 */
@property (nonatomic,strong) NSNumber * preNum;//Integer

/**
 * 小计
 */
@property (nonatomic,strong) NSNumber * subtotalPrice;//BigDecimal

/**
 * 系统自动验货完成（验货单）
 * 1-是；0-否
 */
@property (nonatomic,strong) NSNumber * sysInspect;//Integer

//---------------------2018.6.19更新-------------------------------------
/**
 * 2018.6.19更新
 * 免检数量(人工选择免检时更新，系统自动验货不更新)
 * 免检数量=可验货数量
 */
@property (nonatomic,strong) NSNumber * mianjianNum;//Integer

/**
 * 验货类型
 * 默认-抽检（S）
 */
@property (nonatomic,copy) NSString * qualityInspectType;//InspectType

//---------------------2018.6.19更新END-------------------------------------


@end
