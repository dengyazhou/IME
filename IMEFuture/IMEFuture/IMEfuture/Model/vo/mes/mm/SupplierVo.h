//
//  SupplierVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/12/12.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface SupplierVo : ImeCommonVo

/**
 * 供应商编号
 */
@property (nonatomic, copy) NSString * supplierCode;

/**
 * 供应商描述
 */
@property (nonatomic, copy) NSString * supplierText;

@property (nonatomic, assign) BOOL isSelect;



@end

NS_ASSUME_NONNULL_END
