//
//  UrlContant.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/9.
//  Copyright © 2018年 Netease. All rights reserved.
// 

import Foundation

//私有化部署
//let DYZBaseURL = "http://mgateway.imefuture.vip"


//正式环境
//let DYZBaseURL = "https://mgateway.imefuture.com"

//测试环境
let DYZBaseURL = "https://betamapi.imefuture.com"

//本地
//let DYZBaseURL = "http://192.168.255.196:9090/gateway"
//let DYZBaseURL = "http://192.168.255.119:9090/gateway"
//国罗
//let DYZBaseURL = "http://192.168.66.198:9090/gateway";
//weiwei
//let DYZBaseURL = "http://192.168.255.132:9090/gateway"
//let DYZBaseURL = "http://s2r9260622.wicp.vip/gateway"
//liuBo
//let DYZBaseURL = "http://192.168.255.103:9191/gateway"
//liXuYang
//let DYZBaseURL = "http://192.168.255.104:9090/gateway"
//let DYZBaseURL = "http://2350141n1a.wicp.vip/gateway"
//jyh
//let DYZBaseURL = "http://192.168.255.108:9090/gateway"
//let DYZBaseURL = "http://2z924u3140.wicp.vip/gateway"


let DYZ_scanRest_chartScan = DYZBaseURL + "/rs" + "/mes/scan/chartScan"

let DYZ_scanRest_workUnitScan = DYZBaseURL + "/rs" + "/mes/scan/workUnitScan"

let DYZ_scanRest_personnelScanCheck = DYZBaseURL + "/rs" + "/mes/scan/personnelScanCheck"

let DYZ_workRest_shutDownCauseList = DYZBaseURL + "/rs" + "/mes/workLog/shutDownCauseList"

let DYZ_workLog_getWorkTime = DYZBaseURL + "/rs" + "/mes/workLog/getWorkTime"

let DYZ_workRest_workLog = DYZBaseURL + "/rs" + "/mes/workLog/workLog"

let DYZ_workRest_continueWork = DYZBaseURL + "/rs" + "/mes/workLog/continueWork"

let DYZ_scan_personnelScan = DYZBaseURL + "/rs" + "/mes/scan/personnelScan"

let DYZ_scan_workUnitBindingScan = DYZBaseURL + "/rs" + "/mes/scan/workUnitBindingScan"

let DYZ_productionOrderConfirm_doConfirmProduction = DYZBaseURL + "/rs" + "/mes/productionOrderConfirm/doConfirmProduction"

let DYZ_defectCause_getDefectCauseByCode = DYZBaseURL + "/rs" + "/mes/defectCause/getDefectCauseByCode"

let DYZ_userRoleAuthorities_getUserRoleAuthorities = DYZBaseURL + "/rs" + "/mes/userRoleAuthorities/getUserRoleAuthorities"

let DYZ_routingInspection_getRoutingInspectionListByProductionControlNum = DYZBaseURL + "/rs" + "/mes/routingInspection/getRoutingInspectionListByProductionControlNum"

let DYZ_routingInspection_getRoutingInspectionListByWorkUnitCode = DYZBaseURL + "/rs" + "/mes/routingInspection/getRoutingInspectionListByWorkUnitCode"

let DYZ_routingInspection_updateRoutingInspectionProduction = DYZBaseURL + "/rs" + "/mes/routingInspection/updateRoutingInspectionProduction"

let DYZ_materialArrivedOrder_materialArrivedOrderDetailList = DYZBaseURL + "/rs" + "/mes/materialArrivedOrder/materialArrivedOrderDetailList"

let DYZ_materialArrivedOrder_updateMaterialArrivedOrderDetailForCheck = DYZBaseURL + "/rs" + "/mes/materialArrivedOrder/updateMaterialArrivedOrderDetailForCheck"

let DYZ_materialArrivedOrder_updateMaterialArrivedOrderDetails = DYZBaseURL + "/rs" + "/mes/materialArrivedOrder/updateMaterialArrivedOrderDetails"

let DYZ_materialOutgoingOrder_getMaterialOutgoingOrderDetailList = DYZBaseURL + "/rs" + "/mes/materialOutgoingOrder/getMaterialOutgoingOrderDetailList"

let DYZ_materialOutgoingOrder_updateMaterialOutgoingOrderDetailForCheck = DYZBaseURL + "/rs" + "/mes/materialOutgoingOrder/updateMaterialOutgoingOrderDetailForCheck"

let DYZ_materialOutgoingOrder_updateMaterialOutgoingOrderDetails = DYZBaseURL + "/rs" + "/mes/materialOutgoingOrder/updateMaterialOutgoingOrderDetails"

let DYZ_reqOutbound_selectRequisitions = DYZBaseURL + "/rs" + "/mes/reqOutbound/selectRequisitions"

let DYZ_reqOutbound_saveReqOutbound = DYZBaseURL + "/rs" + "/mes/reqOutbound/saveReqOutbound"

let DYZ_spotCheckUpLog_selectSpotCheckUpLog = DYZBaseURL + "/rs" + "/mes/spotCheckUpLog/selectSpotCheckUpLog"

let DYZ_spotCheckUpLog_updateSpotCheckUpLog = DYZBaseURL + "/rs" + "/mes/spotCheckUpLog/updateSpotCheckUpLog"

let DYZ_workingOrder_getWorkingOrderList = DYZBaseURL + "/rs" + "/mes/workingOrder/getWorkingOrderList"

let DYZ_operationOutsourcing_getOperationOutsourcing = DYZBaseURL + "/rs" + "/mes/operationOutsourcing/getOperationOutsourcing"

let DYZ_operationOutsourcing_outwardDeliveryOutsourcing = DYZBaseURL + "/rs" + "/mes/operationOutsourcing/outwardDeliveryOutsourcing"

let DYZ_operationOutsourcing_takeDeliveryOutsourcing = DYZBaseURL + "/rs" + "/mes/operationOutsourcing/takeDeliveryOutsourcing"

let DYZ_batchWork_workUnitScan = DYZBaseURL + "/rs" + "/mes/batchWork/workUnitScan"

let DYZ_batchWork_chartScan = DYZBaseURL + "/rs" + "/mes/batchWork/chartScan"

let DYZ_batchWork_createBatchWork = DYZBaseURL + "/rs" + "/mes/batchWork/createBatchWork"

let DYZ_batchWork_getWorkTime = DYZBaseURL + "/rs" + "/mes/batchWork/getWorkTime"

let DYZ_batchWork_workLog = DYZBaseURL + "/rs" + "/mes/batchWork/workLog"

let DYZ_batchWork_continueWork = DYZBaseURL + "/rs" + "/mes/batchWork/continueWork"

let DYZ_batchProductionOrderConfirm_doConfirmProduction = DYZBaseURL + "/rs" + "/mes/batchProductionOrderConfirm/doConfirmProduction"

let DYZ_batchWork_getBatchWorkingOrders = DYZBaseURL + "/rs" + "/mes/batchWork/getBatchWorkingOrders" //多工单在制工单接口

let DYZ_blankingWork_workLog = DYZBaseURL + "/rs" + "/mes/blankingWork/workLog" //下料报工---开始、暂停、完工接口

let DYZ_blankingWork_continueWork = DYZBaseURL + "/rs" + "/mes/blankingWork/continueWork" //下料报工---继续接口

let DYZ_blankingWork_getWorkTime = DYZBaseURL + "/rs" + "/mes/blankingWork/getWorkTime" //扫描完成获得开工界面

let DYZ_blankingWork_blankingChartScan = DYZBaseURL + "/rs" + "/mes/blankingWork/blankingChartScan" //下料图纸扫描接口

let DYZ_blankingWork_doConfirmProduction = DYZBaseURL + "/rs" + "/mes/blankingWork/doConfirmProduction" //下料报工完成提交

let DYZ_operationOutsourcing_getOperationOutsourcingOrder = DYZBaseURL + "/rs" + "/mes/operationOutsourcing/getOperationOutsourcingOrder" //委外单查询

let DYZ_mes_operationOutsourcing_delivery = DYZBaseURL + "/rs" + "/mes/operationOutsourcing/delivery" //委外单发货

let DYZ_mes_operationOutsourcing_receiving = DYZBaseURL + "/rs" + "/mes/operationOutsourcing/receiving" //委外单收货

let DYZ_mes_productionOrderConfirm_validateWorkRecordType = DYZBaseURL + "/rs" + "/mes/productionOrderConfirm/validateWorkRecordType" //检验报工记录类型接口




let DYZ_mes_operationOutsourcing_getOperationOutsourcingSourceVosByControlNum = DYZBaseURL + "/rs" + "/mes/operationOutsourcing/getOperationOutsourcingSourceVosByControlNum" //创建委外单扫描

let DYZ_mes_operationOutsourcing_saveOperationOutsourcingOrder = DYZBaseURL + "/rs" + "/mes/operationOutsourcing/saveOperationOutsourcingOrder" //保存委外单

let DYZ_mes_supplier_getSupplierVoList = DYZBaseURL + "/rs" + "/mes/supplier/getSupplierVoList" //获得供应商列表接口

let DYZ_mes_modelSequence_preGeneratedModelSequence = DYZBaseURL + "/rs" + "/mes/modelSequence/preGeneratedModelSequence" //预生成模具序列号接口

let DYZ_multiUserWork_getMultiWorkingOrders = DYZBaseURL + "/rs" + "/mes/multiUserWork/getMultiWorkingOrders"

 
let DYZ_multiUserWork_createMultiUserWork = DYZBaseURL + "/rs" + "/mes/multiUserWork/createMultiUserWork" //创建多人报工单

let DYZ_multiUserWork_getWorkTime = DYZBaseURL + "/rs" + "/mes/multiUserWork/getWorkTime" //扫描完成获得开工界面

let DYZ_multiUserWork_workLog = DYZBaseURL + "/rs" + "/mes/multiUserWork/workLog" //开始-暂停-完工接口

let DYZ_multiUserWork_continueWork = DYZBaseURL + "/rs" + "/mes/multiUserWork/continueWork" //继续接口

let DYZ_multiUserWork_doMultiUserConfirmProduction = DYZBaseURL + "/rs" + "/mes/multiUserWork/doMultiUserConfirmProduction" //多人报工完成提交

let DYZ_productionControl_selectProductionControlVo = DYZBaseURL + "/rs" + "/mes/productionControl/selectProductionControlVo"

let DYZ_warehouse_getWarehouseList = DYZBaseURL + "/rs" + "/mes/warehouse/getWarehouseList" //查询仓库列表

let DYZ_requisition_selectReqMaterialByProjectForCreateRequisition = DYZBaseURL + "/rs" + "/mes/requisition/selectReqMaterialByProjectForCreateRequisition" //按项目领料创建领料单，获取物料信息

let DYZ_requisition_createRequisition = DYZBaseURL + "/rs" + "/mes/requisition/createRequisition" //创建领料单

