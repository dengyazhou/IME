//
//  VoHeader.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/17.
//  Copyright © 2016年 Netease. All rights reserved.
//

#ifndef VoHeader_h
#define VoHeader_h

#import "Header.h"
#import "NSString+Enumeration.h"
#import "NSString+Utils.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "LoginModel.h"
#import "DatabaseTool.h"
#import "MJRefresh.h"
#import "HttpMamager.h"
#import "UrlContant.h"
#import "MyAlertCenter.h"
#import "UIView+AddViewNoNetAndNoContent.h"
#import "ToolTransition.h"

#import "FunctionDYZ.h"




//base
#import "OrderByBean.h"
#import "PagerBean.h"
#import "PostEntityBean.h"
#import "ReturnEntityBean.h"
#import "ReturnListBean.h"
#import "ReturnMsgBean.h"

//cms
#import "AppVersion.h"

#import "Recommend.h"
#import "RecommendPosition.h"

//drawing
#import "DrawingFastUploadFileRequestBean.h"
#import "DrawingFastUploadRequestBean.h"
#import "DrawingFastUploadResultBean.h"

//efeibiao
#import "AccDrawingInter.h"
#import "AccInter.h"
#import "AccVersionInter.h"
#import "BaseAddress.h"
#import "BaseCustomField.h"
#import "BaseEntity.h"
#import "BaseTreeEntity.h"
#import "Competence.h"
#import "EfeibiaoPostEntityBean.h"
#import "EnterpriseInfo.h"
#import "EnterpriseRelation.h"
#import "FileModule.h"
#import "IdentityBean.h"
#import "InquiryOrder.h"
#import "InquiryOrderAttention.h"
#import "InquiryOrderEnterprise.h"
#import "InquiryOrderItem.h"
#import "InquiryOrderItemFile.h"
#import "InquiryOrderQA.h"
#import "Materials.h"
#import "Member.h"
#import "MemberCompetence.h"
#import "MemberRole.h"
#import "OperateFields.h"
#import "Person.h"
#import "PreviewBean.h"
#import "QuotationOrder.h"
#import "QuotationOrderItem.h"
#import "Role.h"
#import "UploadFile.h"
#import "Zone.h"

#import "Comment.h"
#import "EnterpriseComment.h"

#import "Factory.h"
#import "FactoryProductInfo.h"
#import "Head.h"
#import "MO.h"
#import "OperationConfirm.h"
#import "ProductionConfirmInfo.h"
#import "ProductionConfirmInfoForShow.h"
#import "ProductionOrderInfo.h"
#import "ProductionOrderInfoForShow.h"
#import "TpfOperation.h"
#import "TpfOperationForShow.h"
#import "TpfProcess.h"

#import "EnterprisePayType.h"
#import "EnterprisePayTypeInfo.h"
#import "TgBalanceOrder.h"
#import "TgBalanceOrderItem.h"
#import "TgBalancePayOrder.h"
#import "TgBalancePayOrderItem.h"

#import "Invitation.h"
#import "InvitationItem.h"

#import "BaseTag.h"
#import "BatchDeliverItem.h"
#import "ChangeRecord.h"
#import "ChangeRecordItem.h"
#import "FactoryDeliverBean.h"
#import "FactoryDeliverInfoBean.h"
#import "OrderOperate.h"
#import "OrderOperateItem.h"
#import "TradeOrder.h"
#import "TradeOrderItem.h"
#import "TradeOrderItemFile.h"
#import "TradeOrderPurchaseInquiryTypeCount.h"
#import "TradeOrderPurchaseStatusCount.h"
#import "TradeOrderSupplierInquiryTypeCount.h"
#import "TradeOrderSupplierStatusCount.h"

#import "PurchaseProject.h"
#import "PurchaseProjectInfo.h"

#import "QuotationTemplate.h"
#import "QuotationTemplateItem.h"

#import "EnterpriseRelationTag.h"
#import "TGSupplierTag.h"

//logistics
#import "Route.h"
#import "SFOrder.h"

//mes
#import "MesPostEntityBean.h"
#import "TmpFactory.h"
#import "AttachmentVo.h"
#import "WorkUnitVo.h"
#import "ShutDownCauseVo.h"
#import "WorkTimeLogVo.h"
#import "PersonnelVo.h"
#import "ProductionControlVo.h"
#import "ConfirmReportVo.h"
#import "ReportWorkDefectCauseVo.h"
#import "ReportWorkProductionOrderConfirmVo.h"
#import "ReportWorkWorkUnitScanVo.h"
#import "UserInfoVo.h"
#import "UserTokenVo.h"
#import "RoutingInspectionVo.h"
#import "ProcessOperationVo.h"
#import "MaterialArrivedOrderDetailVo.h"
#import "MaterialOutgoingOrderDetailVo.h"
#import "ReqOutboundVo.h"
#import "SpotCheckUpLogVo.h"
#import "WorkingOrderVO.h"
#import "OperationOutsourcingDetailVo.h"
#import "OperationOutsourcingVo.h"
#import "OperationVo.h"
#import "ImeCommonVo.h"
#import "BatchWorkVo.h"
#import "ProductionOperationVo.h"
#import "BatchWorkItemReportVo.h"
#import "BatchConfirmReportVo.h"
#import "BlankingWorkTimeLogVo.h"
#import "BlankingWorkTimeLogDetailVo.h"
#import "BlankingConfirmReportVo.h"

//notification
#import "InterfaceResultBean.h"
#import "PageQueryBean.h"
#import "PmBean.h"
#import "PmPageBean.h"

#import "AppNotification.h"
#import "EmailNotification.h"
#import "Notification.h"
#import "NotificationItem.h"
#import "ParamsBean.h"
#import "PcwebNotification.h"
#import "SendStatusStatistics.h"

//ucenter
#import "EnterpriseAddressBean.h"
#import "EnterpriseBean.h"
#import "EnterpriseFileBean.h"
#import "EnterpriseRefuseInfoBean.h"
#import "EnterpriseSpecialAppInfoBean.h"
#import "InviteInfo.h"
#import "MemberBean.h"
#import "TechnologyBean.h"
#import "UserBean.h"

//web
#import "AppInfoBean.h"
#import "BaseBean.h"
#import "ExhibitionBean.h"
#import "NewsBean.h"
#import "ReturnInfoBean.h"
#import "TagReBean.h"

#import "AreaResBean.h"
#import "DeliverOrderDetailBean.h"
#import "DeliverOrderItemBean.h"
#import "DeliverOrderReqBean.h"
#import "DeliverOrderResBean.h"
#import "ReceiveBean.h"
#import "ReceiveItemBean.h"
#import "ReceiveOrder.h"
#import "PurchaseOrderReqBean.h"
#import "PurchaseOrderResBean.h"
#import "CreateDeliverOrderBean.h"
#import "PurchaseInfo.h"
#import "InspectOrderVo.h"
#import "EnterpriseExpand.h"
#import "OssUploadBean.h"
#import "OperationOutsourcingOrderItemVo.h"
#import "OperationOutsourcingOrderVo.h"
#import "OperationOutsourcingReceivingNoteItemVo.h"
#import "OperationOutsourcingReceivingNoteVo.h"

#import "DrawingCloudBean.h"
#import "DrawingMsgBean.h"
#import "ProjectDrawingResBean.h"
#import "DrawInfoBean.h"

#import "TpfOrderBean.h"

#import "TransportOrderVo.h"
#import "TransportOrderDetailVo.h"
#import "TransportOrderAttachmentVo.h"

#import "TemporaryTaskVo.h"
#import "TemporaryTaskTypeVo.h"
#import "TemporaryTaskShutdownVo.h"

#import "GlobalTemplateBean.h"


#import "ProcessOperationDetailVo.h"
#import "ProcessOperationConfirmDetailVo.h"
#import "OperationOutsourcingSourceVo.h"
#import "SupplierVo.h"
#import "MaterialOutgoingOrderDetailInventoryLotnumVo.h"
#import "MaterialOutgoingOrderCheckVo.h"
#import "MaterialVo.h"

#import "ParameterEntityVo.h"
#import "ParameterValueVo.h"

#import "MemberReqBean.h"

#import "GlobalSettingManager.h"
#import "EfeibiaoReturnEntityBean.h"
#import "MemberResBean.h"
#import "EnterpriseInfoResBean.h"
#import "ModelSequenceVo.h"

#import "MultiUserWorkVo.h"
#import "MultiUserConfirmReportVo.h"
#import "MultiUserConfirmReportItemVo.h"

#import "WorkCenterVo.h"
#import "DrawingPreviewVo.h"
#import "PersonnelTypeVo.h"

#import "InspectQReasonList.h"

#import "ProductionOrderVo.h"
#import "MateriaProcessAssignVo.h"
#import "EquipmentMaintenancePlanMonthVo.h"
#import "EquipmentMaintenanceLogVo.h"

#endif /* VoHeader_h */
