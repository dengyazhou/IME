//
//  ProjectDrawingResBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/4/2.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "DrawInfoBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectDrawingResBean : NSObject

//0: 未查询到数据,或参数有错误 1:查询到数据
@property (nonatomic,strong) NSNumber * status; //Integer
//错误信息
@property (nonatomic,copy) NSString * message;
//所属企业id ,原值返回
@property (nonatomic,copy) NSString * enterpriseId;
//清单明细id,原值返回
@property (nonatomic,copy) NSString * bomAccId;
//版本id,原值返回
@property (nonatomic,copy) NSString * versionId;
//零件号
@property (nonatomic,copy) NSString * accessoryCode;
//图号
@property (nonatomic,copy) NSString * figureNo;
//版本号
@property (nonatomic,copy) NSString * versionCode;
//物料编码
@property (nonatomic,copy) NSString * materialCode;
//零件名
@property (nonatomic,copy) NSString * accName;
//数量
@property (nonatomic,strong) NSNumber * num;//BigDecimal
//创建人
@property (nonatomic,copy) NSString * createUser;
//要求到货日期(毫秒)
@property (nonatomic,strong) NSNumber * deliveryDate;//Long
//价格
@property (nonatomic,strong) NSNumber * price;//Double
//供应商
@property (nonatomic,copy) NSString * supplier;
//交货地址
@property (nonatomic,copy) NSString * deliveryAddress;
//工艺
@property (nonatomic,copy) NSString * tech;
//材质
@property (nonatomic,copy) NSString * material;
//轮廓长
@property (nonatomic,copy) NSString * outlineLong;
//轮廓宽
@property (nonatomic,copy) NSString * outlineWidth;
//轮廓高
@property (nonatomic,copy) NSString * outlineHeight;
//重量
@property (nonatomic,copy) NSString * weight;
//单位
@property (nonatomic,copy) NSString * numUnit;
//品牌
@property (nonatomic,copy) NSString * brand;
//规格
@property (nonatomic,copy) NSString * specifications;
//描述
@property (nonatomic,copy) NSString * remarks;
//图纸明细 见下方对照表
@property (nonatomic,strong) NSMutableArray <DrawInfoBean *> *drawInfo; //List<T> drawInfo
//对应的询盘 订单 清单id
@property (nonatomic,copy) NSString * idd;

@end

NS_ASSUME_NONNULL_END
