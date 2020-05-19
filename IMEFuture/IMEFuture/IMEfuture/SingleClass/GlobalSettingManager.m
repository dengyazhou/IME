//
//  GlobalSettingManager.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/2.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "GlobalSettingManager.h"



@implementation GlobalSettingManager

+ (instancetype)shareGlobalSettingManager {
    static GlobalSettingManager *gsManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gsManager = [[self alloc] init];
    });
    return gsManager;
}

//- (void)requestPurchaseGlobalTemplate {
//    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
//    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
//    GlobalTemplateBean *globalTemplateBean = [[GlobalTemplateBean alloc] init];
//
//    postEntityBean.entity = globalTemplateBean.mj_keyValues;
//
//    NSDictionary *dic = postEntityBean.mj_keyValues;
//
//    [HttpMamager postRequestWithURLString:DYZ_api_globalTemplate_purchase_getGlobalTemplateForTable parameters:dic success:^(id responseObjectModel) {
//
//        ReturnListBean *returnListBean = responseObjectModel;
//        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
//            self.purchaseGlobalTemplateArray = [GlobalTemplateBean mj_objectArrayWithKeyValuesArray:returnListBean.list];
//        }
//
//    } fail:^(NSError *error) {
//
//    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
//}

//- (void)requestSupplierGlobalTemplate {
//    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
//    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
//    GlobalTemplateBean *globalTemplateBean = [[GlobalTemplateBean alloc] init];
//
//    postEntityBean.entity = globalTemplateBean.mj_keyValues;
//
//    NSDictionary *dic = postEntityBean.mj_keyValues;
//
//    [HttpMamager postRequestWithURLString:DYZ_api_globalTemplate_supplier_getGlobalTemplateForTable parameters:dic success:^(id responseObjectModel) {
//        ReturnListBean *returnListBean = responseObjectModel;
//        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
//            self.supplierGlobalTemplateArray = [GlobalTemplateBean mj_objectArrayWithKeyValuesArray:returnListBean.list];
//        }
//
//    } fail:^(NSError *error) {
//
//    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
//}

- (void)requestfbCompetenceAllWithfbToken:(NSString *)token {
    if (token == nil) {
        return;
    }
    if (token.length == 0) {
        return;
    }
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = token;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_aip_inquiry_competence_all parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.competenceTypeArray = returnListBean.list;
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    
}

- (void)requesttpfGetparameterlistWithSiteCode:(NSString *)siteCode {
    if (siteCode == nil) {
        return;
    }
    if (siteCode.length == 0) {
        return;
    }

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
        ParameterEntityVo *vo = [[ParameterEntityVo alloc] init];
        vo.siteCode = siteCode;
        postEntityBean.entity = vo.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_mes_parameter_getparameterlist parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *returnListBean = responseObjectModel;
            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                NSMutableArray <ParameterEntityVo *> *array =  [ParameterEntityVo mj_objectArrayWithKeyValuesArray:returnListBean.list];
                for (ParameterEntityVo *vo in array) {
                    if ([vo.parameterCode isEqualToString:@"MATERIALARRIVEDORDEROPERATINGMODE"]) {// IQC入库 模式
                        for (ParameterValueVo *valueVo in vo.parameterValue) {
                            if (valueVo.defaultFlag.integerValue == 1) {
                                self.iQCPattern = valueVo.value.integerValue;
                            }
                        }
                    }
                    if ([vo.parameterCode isEqualToString:@"PLANWORKTIMEDISPLAY"]) {// 计划工时 是否显示
                        self.showPlanHour = vo.defaultValue.integerValue;
                    }
                    if ([vo.parameterCode isEqualToString:@"ALLOWSINGLEPERSONMULTITASK"]) {// 多工单报工入口 是否显示
                        self.showMultiltask = vo.defaultValue.integerValue;
                    }
                }
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
            }
            
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    });
}



@end
