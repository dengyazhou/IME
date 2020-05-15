//
//  UrlContant.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/6/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#ifndef UrlContant_h
#define UrlContant_h

//正式环境
//接口url
#define DYZBaseURL @"https://mgateway.imefuture.com"
#define DYZBaseURLItem(_item_)[NSString stringWithFormat:@"%@%@",DYZBaseURL,_item_]
//通知
#define baseNotification @"https://notification.imefuture.com"
#define notification(_pathNo_)[NSString stringWithFormat:@"%@%@",baseNotification,_pathNo_]
//协议
#define IME_AGREEMENT_PUR @"https://efeibiao.imefuture.com/agreement/purchaser.html?entName="
#define IME_AGREEMENT_SUP @"https://efeibiao.imefuture.com/agreement/supplier.html?entName="
//忘记密码
#define PostForgetPassword @"https://account.imefuture.com/forgetpw/forgetPassword.html"
//帐号注册
#define PostAccount @"https://account.imefuture.com/ucweb/register/goRegister.html?https://account.imefuture.com/ucweb/login/goLogin.html&ss=iphone"
//设置url
#define PostURLSheZhi(_path_)[NSString stringWithFormat:@"https://account.imefuture.com%@",_path_]
//智造家e非标
#define IME_betand @"https://www.imefuture.com/feibiao/index.html"
//非标管家
#define IME_beta @"https://www.imefuture.com/feibiaoGJ/?module=feibiaoGJ"
//透明工厂
#define baseUTLTpf @"https://tpf.imefuture.com"
#define IME_TouMingGongChang @"https://tpf.imefuture.com/mes/pages/m/index.html"
#define IME_TouMingGongChangDengLu @"https://tpf.imefuture.com/mes/manage/mobileGetSession"
#define IME_TouMingGongChangXuanChuanYe @"https://www.imefuture.com/tpf/?module=tpf"
//智客管家
#define IME_ThiKeGuanJia @"https://m.izker.com"
//图纸云
#define IME_TuZhiYun @"https://www.imefuture.com/drawingCloud/?module=drawingCloud"
//创建企业
#define IME_CreatEnterprise @"https://account.imefuture.com/ucweb/enterpriseReg/goEpReg.html"
//隐私协议
#define IME_privacy @"https://www.imefuture.com/privacy.html"


//测试环境
//接口url
//#define DYZBaseURL @"https://betamapi.imefuture.com"
//#define DYZBaseURLItem(_item_)[NSString stringWithFormat:@"%@%@",DYZBaseURL,_item_]
////通知
//#define baseNotification @"http://beta.notification.imefuture.com"
//#define notification(_pathNo_)[NSString stringWithFormat:@"%@%@",baseNotification,_pathNo_]
////协议
//#define IME_AGREEMENT_PUR @"https://betand.imefuture.com/agreement/purchaser.html?entName="
//#define IME_AGREEMENT_SUP @"https://betand.imefuture.com/agreement/supplier.html?entName="
////忘记密码
//#define PostForgetPassword @"https://account.imefuture.com/forgetpw/forgetPassword.html"
////帐号注册
//#define PostAccount @"https://betaac.imefuture.com/ucweb/register/goRegister.html?https://betaac.imefuture.com/ucweb/login/goLogin.html&ss=iphone"
////设置url
//#define PostURLSheZhi(_path_)[NSString stringWithFormat:@"https://betaac.imefuture.com%@",_path_]
////智造家e非标
//#define IME_betand @"https://beta.imefuture.com/feibiao/index.html"
////非标管家
//#define IME_beta @"https://beta.imefuture.com/feibiaoGJ/?module=feibiaoGJ"
////透明工厂
//#define baseUTLTpf @"https://testtpf.imefuture.com"
//#define IME_TouMingGongChang @"https://testtpf.imefuture.com/mes/pages/m/index.html"
//#define IME_TouMingGongChangDengLu @"https://testtpf.imefuture.com/mes/manage/mobileGetSession"
//#define IME_TouMingGongChangXuanChuanYe @"https://beta.imefuture.com/tpf/?module=tpf"
////智客管家
//#define IME_ThiKeGuanJia @"https://betawk.izker.com"
////图纸云
//#define IME_TuZhiYun @"https://beta.imefuture.com/drawingCloud/?module=drawingCloud"
////创建企业
//#define IME_CreatEnterprise @"http://testuc.imefuture.com/ucweb/enterpriseReg/goEpReg.html"
////隐私协议
//#define IME_privacy @"https://beta.imefuture.com/privacy.html"

//本地
//接口url
//#define DYZBaseURL @"http://192.168.255.196:9090/gateway"
//#define DYZBaseURL @"http://192.168.255.119:9090/gateway"
//#define DYZBaseURL @"http://192.168.254.247:9090/gateway"


////国罗
//#define DYZBaseURL @"http://192.168.66.198:9090/gateway"
////weiwei
//#define DYZBaseURL @"http://192.168.255.132:9090/gateway"
//#define DYZBaseURL @"http://s2r9260622.wicp.vip/gateway"
////liuBo
//#define DYZBaseURL @"http://192.168.255.103:9191/gateway"
////liXuYang
//#define DYZBaseURL @"http://192.168.255.104:9090/gateway"
//#define DYZBaseURL @"http://2350141n1a.wicp.vip/gateway"
////zhangcheng
//#define DYZBaseURL @"http://192.168.255.191:9090/gateway"
////jyh
//#define DYZBaseURL @"http://192.168.255.108:9090/gateway"
//#define DYZBaseURL @"http://2z924u3140.wicp.vip/gateway"

//
//#define DYZBaseURLItem(_item_)[NSString stringWithFormat:@"%@%@",DYZBaseURL,_item_]
////通知
//#define baseNotification @"http://beta.notification.imefuture.com"
//#define notification(_pathNo_)[NSString stringWithFormat:@"%@%@",baseNotification,_pathNo_]
////协议
//#define IME_AGREEMENT_PUR @"https://betand.imefuture.com/agreement/purchaser.html?entName="
//#define IME_AGREEMENT_SUP @"https://betand.imefuture.com/agreement/supplier.html?entName="
////忘记密码
//#define PostForgetPassword @"https://account.imefuture.com/forgetpw/forgetPassword.html"
////帐号注册
//#define PostAccount @"https://betaac.imefuture.com/ucweb/register/goRegister.html?https://betaac.imefuture.com/ucweb/login/goLogin.html&ss=iphone"
////设置url
//#define PostURLSheZhi(_path_)[NSString stringWithFormat:@"https://betaac.imefuture.com%@",_path_]



#define DYZ_user_login [NSString stringWithFormat:@"%@/ucenter/user/login",DYZBaseURLItem(@"/rs")]

#define DYZ_notify_getUserPmCount [NSString stringWithFormat:@"%@/notify/getUserPmCount",DYZBaseURLItem(@"/rs")]

#define DYZ_information_getInformationList [NSString stringWithFormat:@"%@/web/information/getInformationList",DYZBaseURLItem(@"/rs")]

#define DYZ_cmsRecommend_getAPPRecommendList [NSString stringWithFormat:@"%@/cms/cmsRecommend/getAPPRecommendList",DYZBaseURLItem(@"/rs")]

#define DYZ_notify_getUserPm [NSString stringWithFormat:@"%@/notify/getUserPm",DYZBaseURLItem(@"/rs")]

#define DYZ_user_appUserHeadUpload [NSString stringWithFormat:@"%@/ucenter/user/appUserHeadUpload",DYZBaseURLItem(@"/rs")]

#define DYZ_information_informationActivity [NSString stringWithFormat:@"%@/web/information/informationActivity",DYZBaseURLItem(@"/rs")]

#define DYZ_notify_deleteUserPm [NSString stringWithFormat:@"%@/notify/deleteUserPm",DYZBaseURLItem(@"/rs")]

#define DYZ_notify_readUserPm [NSString stringWithFormat:@"%@/notify/readUserPm",DYZBaseURLItem(@"/rs")]

#define DYZ_user_synlogout [NSString stringWithFormat:@"%@/ucenter/user/synlogout",DYZBaseURLItem(@"/rs")]

#define DYZ_user_ssoLogout [NSString stringWithFormat:@"%@/ucenter/user/ssoLogout",DYZBaseURLItem(@"/rs")]

#define DYZ_user_getUserInviteInfo [NSString stringWithFormat:@"%@/ucenter/user/getUserInviteInfo",DYZBaseURLItem(@"/rs")]

#define DYZ_user_createInviteForAppUc [NSString stringWithFormat:@"%@/ucenter/user/createInviteForAppUc",DYZBaseURLItem(@"/rs")]

#define DYZ_information_searchInformation [NSString stringWithFormat:@"%@/web/information/searchInformation",DYZBaseURLItem(@"/rs")]

#define DYZ_drawingCloud_getThumbnailUrl_jpg [NSString stringWithFormat:@"%@/drawing/drawingCloud/getThumbnailUrl.jpg",DYZBaseURLItem(@"/rs")]

#define DYZ_inquiry_cancel [NSString stringWithFormat:@"%@/efeibiao/inquiry/cancel",DYZBaseURLItem(@"/rs")]

#define DYZ_inquiry_list [NSString stringWithFormat:@"%@/efeibiao/inquiry/list",DYZBaseURLItem(@"/rs")]

#define DYZ_pay_createGuaranteeTrade [NSString stringWithFormat:@"%@/efeibiao/pay/createGuaranteeTrade",DYZBaseURLItem(@"/rs")]

#define DYZ_tradeOrder_confirmSupplierDelivere [NSString stringWithFormat:@"%@/efeibiao/tradeOrder/confirmSupplierDelivere",DYZBaseURLItem(@"/rs")]

#define DYZ_tradeOrder_examineCargo [NSString stringWithFormat:@"%@/efeibiao/tradeOrder/examineCargo",DYZBaseURLItem(@"/rs")]

#define DYZ_purchaseProject_notifySend [NSString stringWithFormat:@"%@/efeibiao/purchaseProject/notifySend",DYZBaseURLItem(@"/rs")]

#define DYZ_tradeOrder_getTradeOrderList [NSString stringWithFormat:@"%@/efeibiao/tradeOrder/getTradeOrderList",DYZBaseURLItem(@"/rs")]

#define DYZ_epRelation_cancelTrustRelation [NSString stringWithFormat:@"%@/efeibiao/epRelation/cancelTrustRelation",DYZBaseURLItem(@"/rs")]

#define DYZ_epRelation_cancelRelation [NSString stringWithFormat:@"%@/efeibiao/epRelation/cancelRelation",DYZBaseURLItem(@"/rs")]

#define DYZ_epRelation_trustRelationList [NSString stringWithFormat:@"%@/efeibiao/epRelation/trustRelationList",DYZBaseURLItem(@"/rs")]

#define DYZ_epRelation_relationList [NSString stringWithFormat:@"%@/efeibiao/epRelation/relationList",DYZBaseURLItem(@"/rs")]

#define DYZ_tgSupplierTag_querytg [NSString stringWithFormat:@"%@/efeibiao/tgSupplierTag/querytg",DYZBaseURLItem(@"/rs")]

#define DYZ_tgSupplierTag_deletetg [NSString stringWithFormat:@"%@/efeibiao/tgSupplierTag/deletetg",DYZBaseURLItem(@"/rs")]

#define DYZ_tgSupplierTag_addtg [NSString stringWithFormat:@"%@/efeibiao/tgSupplierTag/addtg",DYZBaseURLItem(@"/rs")]

#define DYZ_epRelation_addTrustRelation [NSString stringWithFormat:@"%@/efeibiao/epRelation/addTrustRelation",DYZBaseURLItem(@"/rs")]

#define DYZ_enterprise_enterpriseInfoList [NSString stringWithFormat:@"%@/efeibiao/enterprise/enterpriseInfoList",DYZBaseURLItem(@"/rs")]

#define DYZ_purchaseProject_getPurchaseProjectList [NSString stringWithFormat:@"%@/efeibiao/purchaseProject/getPurchaseProjectList",DYZBaseURLItem(@"/rs")]

#define DYZ_purchaseProject_queryDrawingLibrariesInfo [NSString stringWithFormat:@"%@/efeibiao/purchaseProject/queryDrawingLibrariesInfo",DYZBaseURLItem(@"/rs")]

#define DYZ_purchaseProject_notifyQuo [NSString stringWithFormat:@"%@/efeibiao/purchaseProject/notifyQuo",DYZBaseURLItem(@"/rs")]

#define DYZ_purchaseProject_getPurchaseProjectInfoList [NSString stringWithFormat:@"%@/efeibiao/purchaseProject/getPurchaseProjectInfoList",DYZBaseURLItem(@"/rs")]

#define DYZ_purchaseProject_getInquiryOrderOrTradeOrderList [NSString stringWithFormat:@"%@/efeibiao/purchaseProject/getInquiryOrderOrTradeOrderList",DYZBaseURLItem(@"/rs")]

#define DYZ_purchaseProject_getPurchaseProjectInfoNoPubList [NSString stringWithFormat:@"%@/efeibiao/purchaseProject/getPurchaseProjectInfoNoPubList",DYZBaseURLItem(@"/rs")]

#define DYZ_purchaseProject_updateInfoValue [NSString stringWithFormat:@"%@/efeibiao/purchaseProject/updateInfoValue",DYZBaseURLItem(@"/rs")]

#define DYZ_purchaseProject_updatePurchaseProjectInfo [NSString stringWithFormat:@"%@/efeibiao/purchaseProject/updatePurchaseProjectInfo",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_toSee [NSString stringWithFormat:@"%@/efeibiao/quotation/toSee",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_detail [NSString stringWithFormat:@"%@/efeibiao/quotation/detail",DYZBaseURLItem(@"/rs")]

#define DYZ_inquiry_confirm_refuse [NSString stringWithFormat:@"%@/efeibiao/inquiry/confirm/refuse",DYZBaseURLItem(@"/rs")]

#define DYZ_inquiry_confirm_consent [NSString stringWithFormat:@"%@/efeibiao/inquiry/confirm/consent",DYZBaseURLItem(@"/rs")]

#define DYZ_purchaseProject_bindInquiryToProject [NSString stringWithFormat:@"%@/efeibiao/purchaseProject/bindInquiryToProject",DYZBaseURLItem(@"/rs")]

#define DYZ_enterpriseComment_recentEpComment [NSString stringWithFormat:@"%@/efeibiao/enterpriseComment/recentEpComment",DYZBaseURLItem(@"/rs")]

#define DYZ_enterpriseComment_epCommentList [NSString stringWithFormat:@"%@/efeibiao/enterpriseComment/epCommentList",DYZBaseURLItem(@"/rs")]

#define DYZ_epRelation_trustRelationDetail [NSString stringWithFormat:@"%@/efeibiao/epRelation/trustRelationDetail",DYZBaseURLItem(@"/rs")]

#define DYZ_enterpriseComment_addEpComment [NSString stringWithFormat:@"%@/efeibiao/enterpriseComment/addEpComment",DYZBaseURLItem(@"/rs")]

#define DYZ_enterpriseComment_updateEpComment [NSString stringWithFormat:@"%@/efeibiao/enterpriseComment/updateEpComment",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_pedit [NSString stringWithFormat:@"%@/efeibiao/quotation/pedit",DYZBaseURLItem(@"/rs")]

#define DYZ_inquiry_detail [NSString stringWithFormat:@"%@/efeibiao/inquiry/detail",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_endReceive [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/endReceive",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_deliverList [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/deliverList",DYZBaseURLItem(@"/rs")]

#define DYZ_tradeOrder_getTradeOrderDetail [NSString stringWithFormat:@"%@/efeibiao/tradeOrder/getTradeOrderDetail",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_receiveOrderOperate [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/receiveOrderOperate",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_deliverOperate [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/deliverOperate",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_receiveDetailList [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/receiveDetailList",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_supplierRecevice [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/supplierRecevice",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_refundOrderOperate [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/refundOrderOperate",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_deliverDetail [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/deliverDetail",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_receiveList [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/receiveList",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_inspectOrderOperate [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/inspectOrderOperate",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_inspectOperate [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/inspectOperate",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_reissueOperate [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/reissueOperate",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_preOrderList [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/preOrderList",DYZBaseURLItem(@"/rs")]

#define DYZ_i_quotationTemplate_quotationTemplateList [NSString stringWithFormat:@"%@/efeibiao/i/quotationTemplate/quotationTemplateList",DYZBaseURLItem(@"/rs")]



#define DYZ_tag_getlist [NSString stringWithFormat:@"%@/ucenter/tag/getlist",DYZBaseURLItem(@"/rs")]

#define DYZ_enterpriseAddress_getEnterpriseAddressInfo [NSString stringWithFormat:@"%@/ucenter/enterpriseAddress/getEnterpriseAddressInfo",DYZBaseURLItem(@"/rs")]

#define DYZ_enterpriseAddress_updateEnterpriseAddress [NSString stringWithFormat:@"%@/ucenter/enterpriseAddress/updateEnterpriseAddress",DYZBaseURLItem(@"/rs")]

#define DYZ_enterpriseAddress_deleteEnterpriseAddress [NSString stringWithFormat:@"%@/ucenter/enterpriseAddress/deleteEnterpriseAddress",DYZBaseURLItem(@"/rs")]

#define DYZ_enterpriseAddress_addEnterpriseAddress [NSString stringWithFormat:@"%@/ucenter/enterpriseAddress/addEnterpriseAddress",DYZBaseURLItem(@"/rs")]

#define DYZ_efeibiao_uploadfile_upload [NSString stringWithFormat:@"%@/efeibiao/uploadfile/upload",DYZBaseURLItem(@"/rs")]

#define DYZ_inquiry_slist [NSString stringWithFormat:@"%@/efeibiao/inquiry/slist",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_list [NSString stringWithFormat:@"%@/efeibiao/quotation/list",DYZBaseURLItem(@"/rs")]

#define DYZ_tradeOrder_remindPurchasePayment [NSString stringWithFormat:@"%@/efeibiao/tradeOrder/remindPurchasePayment",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_cfmf [NSString stringWithFormat:@"%@/efeibiao/quotation/cfmf",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_cfms [NSString stringWithFormat:@"%@/efeibiao/quotation/cfms",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_edit [NSString stringWithFormat:@"%@/efeibiao/quotation/edit",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_refu [NSString stringWithFormat:@"%@/efeibiao/quotation/refu",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_cancel [NSString stringWithFormat:@"%@/efeibiao/quotation/cancel",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_acc [NSString stringWithFormat:@"%@/efeibiao/quotation/acc",DYZBaseURLItem(@"/rs")]

#define DYZ_tradeOrder_supplierDelivere [NSString stringWithFormat:@"%@/efeibiao/tradeOrder/supplierDelivere",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_sedit [NSString stringWithFormat:@"%@/efeibiao/quotation/sedit",DYZBaseURLItem(@"/rs")]

#define DYZ_logistics_list [NSString stringWithFormat:@"%@/efeibiao/logistics/list",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_inspectList [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/inspectList",DYZBaseURLItem(@"/rs")]

#define DYZ_user_getMemberInfo [NSString stringWithFormat:@"%@/ucenter/user/getMemberInfo",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_deliverOrderOperate [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/deliverOrderOperate",DYZBaseURLItem(@"/rs")]

#define DYZ_i_orderOperate_reissueOrderOperate [NSString stringWithFormat:@"%@/efeibiao/i/orderOperate/reissueOrderOperate",DYZBaseURLItem(@"/rs")]

#define DYZ_epRelation_addRelation [NSString stringWithFormat:@"%@/efeibiao/epRelation/addRelation",DYZBaseURLItem(@"/rs")]

#define DYZ_inquiryAttention_add [NSString stringWithFormat:@"%@/efeibiao/inquiryAttention/add",DYZBaseURLItem(@"/rs")]

#define DYZ_inquiryAttention_cancel [NSString stringWithFormat:@"%@/efeibiao/inquiryAttention/cancel",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_quoed [NSString stringWithFormat:@"%@/efeibiao/quotation/quoed",DYZBaseURLItem(@"/rs")]

#define DYZ_inquiryAttention_checkAttention [NSString stringWithFormat:@"%@/efeibiao/inquiryAttention/checkAttention",DYZBaseURLItem(@"/rs")]

#define DYZ_epRelation_hasRelation [NSString stringWithFormat:@"%@/efeibiao/epRelation/hasRelation",DYZBaseURLItem(@"/rs")]

#define DYZ_drawingCloud_createPreviewUrl [NSString stringWithFormat:@"%@/drawing/drawingCloud/createPreviewUrl",DYZBaseURLItem(@"/rs")]

#define DYZ_comment_list [NSString stringWithFormat:@"%@/efeibiao/comment/list",DYZBaseURLItem(@"/rs")]

#define DYZ_qa_add [NSString stringWithFormat:@"%@/efeibiao/qa/add",DYZBaseURLItem(@"/rs")]

#define DYZ_qa_answerEpQa [NSString stringWithFormat:@"%@/efeibiao/qa/answerEpQa",DYZBaseURLItem(@"/rs")]

#define DYZ_qa_answerMyQa [NSString stringWithFormat:@"%@/efeibiao/qa/answerMyQa",DYZBaseURLItem(@"/rs")]

#define DYZ_qa_list [NSString stringWithFormat:@"%@/efeibiao/qa/list",DYZBaseURLItem(@"/rs")]

#define DYZ_tag_list [NSString stringWithFormat:@"%@/ucenter/tag/list",DYZBaseURLItem(@"/rs")]

#define DYZ_quotation_add [NSString stringWithFormat:@"%@/efeibiao/quotation/add",DYZBaseURLItem(@"/rs")]

#define DYZ_tpf_productionOrderInfo [NSString stringWithFormat:@"%@/efeibiao/tpf/productionOrderInfo",DYZBaseURLItem(@"/rs")]

#define DYZ_enterprise_epInfo [NSString stringWithFormat:@"%@/efeibiao/enterprise/epInfo",DYZBaseURLItem(@"/rs")]

#define DYZ_comment_addPurchaseComment [NSString stringWithFormat:@"%@/efeibiao/comment/addPurchaseComment",DYZBaseURLItem(@"/rs")]

#define DYZ_comment_addSupplierComment [NSString stringWithFormat:@"%@/efeibiao/comment/addSupplierComment",DYZBaseURLItem(@"/rs")]

#define DYZ_enterpriseComment_addEpOrderComment [NSString stringWithFormat:@"%@/efeibiao/enterpriseComment/addEpOrderComment",DYZBaseURLItem(@"/rs")]

#define DYZ_enterpriseComment_updateEpOrderComment [NSString stringWithFormat:@"%@/efeibiao/enterpriseComment/updateEpOrderComment",DYZBaseURLItem(@"/rs")]

#define DYZ_notify_pushCallback [NSString stringWithFormat:@"%@/notify/pushCallback",DYZBaseURLItem(@"/rs")]

#define DYZ_appversion_getLatestVersion [NSString stringWithFormat:@"%@/cms/appversion/getLatestVersion",DYZBaseURLItem(@"/rs")]

#define DYZ_zone_getAllZoneInfo [NSString stringWithFormat:@"%@/ucenter/zone/getAllZoneInfo",DYZBaseURLItem(@"/rs")]

#define DYZ_user_changeIdentity [NSString stringWithFormat:@"%@/ucenter/user/changeIdentity",DYZBaseURLItem(@"/rs")]

#define DYZ_user_ssoLogin [NSString stringWithFormat:@"%@/ucenter/user/ssoLogin",DYZBaseURLItem(@"/rs")]

#define DYZ_html_employee [NSString stringWithFormat:@"%@/mes/pages/m/index.html#/employee",baseUTLTpf]
#define DYZ_html_chooseDeviceType [NSString stringWithFormat:@"%@/mes/pages/m/index.html#chooseDeviceType",baseUTLTpf]
#define DYZ_html_projectStatistics [NSString stringWithFormat:@"%@/mes/pages/m/index.html#/projectStatistics",baseUTLTpf]
#define DYZ_html_myProcessingInfo [NSString stringWithFormat:@"%@/mes/pages/m/index.html#/myProcessingInfo",baseUTLTpf]




#define DYZ_scanRest_chartScan [NSString stringWithFormat:@"%@/mes/scan/chartScan",DYZBaseURLItem(@"/rs")]

#define DYZ_scanRest_workUnitScan [NSString stringWithFormat:@"%@/mes/scan/workUnitScan",DYZBaseURLItem(@"/rs")]

#define DYZ_scanRest_personnelScan [NSString stringWithFormat:@"%@/mes/scan/personnelScan",DYZBaseURLItem(@"/rs")]

#define DYZ_scanRest_personnelScanCheck [NSString stringWithFormat:@"%@/mes/scan/personnelScanCheck",DYZBaseURLItem(@"/rs")]

#define DYZ_workRest_shutDownCauseList [NSString stringWithFormat:@"%@/mes/workLog/shutDownCauseList",DYZBaseURLItem(@"/rs")]

#define DYZ_workRest_getWorkTime [NSString stringWithFormat:@"%@/mes/workLog/getWorkTime",DYZBaseURLItem(@"/rs")]

#define DYZ_workRest_workLog [NSString stringWithFormat:@"%@/mes/workLog/workLog",DYZBaseURLItem(@"/rs")]

#define DYZ_workRest_continueWork [NSString stringWithFormat:@"%@/mes/workLog/continueWork",DYZBaseURLItem(@"/rs")]

#define DYZ_scan_personnelScan [NSString stringWithFormat:@"%@/mes/scan/personnelScan",DYZBaseURLItem(@"/rs")]

#define DYZ_scan_workUnitBindingScan [NSString stringWithFormat:@"%@/mes/scan/workUnitBindingScan",DYZBaseURLItem(@"/rs")]

#define DYZ_productionOrderConfirm_doConfirmProduction [NSString stringWithFormat:@"%@/mes/productionOrderConfirm/doConfirmProduction",DYZBaseURLItem(@"/rs")]

#define DYZ_defectCause_getDefectCauseByCode [NSString stringWithFormat:@"%@/mes/defectCause/getDefectCauseByCode",DYZBaseURLItem(@"/rs")]

#define DYZ_userRoleAuthorities_getUserRoleAuthorities [NSString stringWithFormat:@"%@/mes/userRoleAuthorities/getUserRoleAuthorities",DYZBaseURLItem(@"/rs")]

#define DYZ_routingInspection_getRoutingInspectionListByProductionControlNum [NSString stringWithFormat:@"%@/mes/routingInspection/getRoutingInspectionListByProductionControlNum",DYZBaseURLItem(@"/rs")]

#define DYZ_routingInspection_getRoutingInspectionListByWorkUnitCode [NSString stringWithFormat:@"%@/mes/routingInspection/getRoutingInspectionListByWorkUnitCode",DYZBaseURLItem(@"/rs")]

#define DYZ_routingInspection_updateRoutingInspectionProduction [NSString stringWithFormat:@"%@/mes/routingInspection/updateRoutingInspectionProduction",DYZBaseURLItem(@"/rs")]

#define DYZ_materialArrivedOrder_materialArrivedOrderDetailList [NSString stringWithFormat:@"%@/mes/materialArrivedOrder/materialArrivedOrderDetailList",DYZBaseURLItem(@"/rs")]

#define DYZ_materialArrivedOrder_updateMaterialArrivedOrderDetailForCheck [NSString stringWithFormat:@"%@/mes/materialArrivedOrder/updateMaterialArrivedOrderDetailForCheck",DYZBaseURLItem(@"/rs")]

#define DYZ_materialArrivedOrder_updateMaterialArrivedOrderDetails [NSString stringWithFormat:@"%@/mes/materialArrivedOrder/updateMaterialArrivedOrderDetails",DYZBaseURLItem(@"/rs")]

#define DYZ_materialOutgoingOrder_getMaterialOutgoingOrderDetailList [NSString stringWithFormat:@"%@/mes/materialOutgoingOrder/getMaterialOutgoingOrderDetailList",DYZBaseURLItem(@"/rs")]

#define DYZ_materialOutgoingOrder_updateMaterialOutgoingOrderDetailForCheck [NSString stringWithFormat:@"%@/mes/materialOutgoingOrder/updateMaterialOutgoingOrderDetailForCheck",DYZBaseURLItem(@"/rs")]

#define DYZ_materialOutgoingOrder_updateMaterialOutgoingOrderDetails [NSString stringWithFormat:@"%@/mes/materialOutgoingOrder/updateMaterialOutgoingOrderDetails",DYZBaseURLItem(@"/rs")]

#define DYZ_reqOutbound_selectRequisitions [NSString stringWithFormat:@"%@/mes/reqOutbound/selectRequisitions",DYZBaseURLItem(@"/rs")]

#define DYZ_reqOutbound_saveReqOutbound [NSString stringWithFormat:@"%@/mes/reqOutbound/saveReqOutbound",DYZBaseURLItem(@"/rs")]

#define DYZ_spotCheckUpLog_selectSpotCheckUpLog [NSString stringWithFormat:@"%@/mes/spotCheckUpLog/selectSpotCheckUpLog",DYZBaseURLItem(@"/rs")]

#define DYZ_spotCheckUpLog_updateSpotCheckUpLog [NSString stringWithFormat:@"%@/mes/spotCheckUpLog/updateSpotCheckUpLog",DYZBaseURLItem(@"/rs")]

#define DYZ_workingOrder_getWorkingOrderList [NSString stringWithFormat:@"%@/mes/workingOrder/getWorkingOrderList",DYZBaseURLItem(@"/rs")]

#define DYZ_operationOutsourcing_getOperationOutsourcing [NSString stringWithFormat:@"%@/mes/operationOutsourcing/getOperationOutsourcing",DYZBaseURLItem(@"/rs")]

#define DYZ_operationOutsourcing_outwardDeliveryOutsourcing [NSString stringWithFormat:@"%@/mes/operationOutsourcing/outwardDeliveryOutsourcing",DYZBaseURLItem(@"/rs")]

#define DYZ_operationOutsourcing_takeDeliveryOutsourcing [NSString stringWithFormat:@"%@/mes/operationOutsourcing/takeDeliveryOutsourcing",DYZBaseURLItem(@"/rs")]


#define DYZ_purchaseOrder_purchaseOrderList [NSString stringWithFormat:@"%@/efeibiao/purchaseOrder/purchaseOrderList",DYZBaseURLItem(@"/rs")]

#define DYZ_deliverOrder_purchaseInfo [NSString stringWithFormat:@"%@/efeibiao/deliverOrder/purchaseInfo",DYZBaseURLItem(@"/rs")]

#define DYZ_deliverOrder_supplierDeliverOrder [NSString stringWithFormat:@"%@/efeibiao/deliverOrder/supplierDeliverOrder",DYZBaseURLItem(@"/rs")] //供应商发货

#define DYZ_inspect_appGetInspectOrder [NSString stringWithFormat:@"%@/efeibiao/inspect/appGetInspectOrder",DYZBaseURLItem(@"/rs")] //根据发货单号查询质检发货收货单
#define DYZ_receiveOrder_areaList [NSString stringWithFormat:@"%@/efeibiao/receiveOrder/areaList",DYZBaseURLItem(@"/rs")] //收货区列表
#define DYZ_receiveOrder_purchaseAddReceiveOrder [NSString stringWithFormat:@"%@/efeibiao/receiveOrder/purchaseAddReceiveOrder",DYZBaseURLItem(@"/rs")] //采购商收货

#define DYZ_inspect_addTemp [NSString stringWithFormat:@"%@/efeibiao/inspect/addTemp",DYZBaseURLItem(@"/rs")] //质检暂存

#define DYZ_inspect_add [NSString stringWithFormat:@"%@/efeibiao/inspect/add",DYZBaseURLItem(@"/rs")] //质检验货

#define DYZ_efeibiao_uploadfile_uploadInspectFile [NSString stringWithFormat:@"%@/efeibiao/uploadfile/uploadInspectFile",DYZBaseURLItem(@"/rs")] //质检报告上传

#define DYZ_efeibiao_uploadfile_downloadInspectFile [NSString stringWithFormat:@"%@/efeibiao/uploadfile/downloadInspectFile",DYZBaseURLItem(@"/rs")] //质检报告上传

#define DYZ_drawing_drawingCloud_drawingCloudUrl [NSString stringWithFormat:@"%@/drawing/drawingCloud/drawingCloudUrl_iOS",DYZBaseURLItem(@"/rs")] //获取图纸云图纸url

/* ---------5.20----------*/
#define DYZ_inquiry_purchase_list [NSString stringWithFormat:@"%@/inquiry/purchase/list",DYZBaseURLItem(@"/api")] //采购商查看询盘列表
#define DYZ_inquiry_supplier_list [NSString stringWithFormat:@"%@/inquiry/supplier/list",DYZBaseURLItem(@"/api")] //供应商查看询盘列表
#define DYZ_inquiry_center_list [NSString stringWithFormat:@"%@/inquiry/center/list",DYZBaseURLItem(@"/api")] //游客查看询盘列表

#define DYZ_inquiry_purchase_detail [NSString stringWithFormat:@"%@/inquiry/purchase/detail",DYZBaseURLItem(@"/api")] //采购商查看询盘详情
#define DYZ_inquiry_supplier_detail [NSString stringWithFormat:@"%@/inquiry/supplier/detail",DYZBaseURLItem(@"/api")] //供应商查看询盘详情
#define DYZ_inquiry_center_detail [NSString stringWithFormat:@"%@/inquiry/center/detail",DYZBaseURLItem(@"/api")] //游客查看询盘详情

#define DYZ_inquiry_purchase_send [NSString stringWithFormat:@"%@/inquiry/purchase/send",DYZBaseURLItem(@"/api")] //采购商授盘
#define DYZ_inquiry_purchase_notify_quo [NSString stringWithFormat:@"%@/inquiry/purchase/notify/quo",DYZBaseURLItem(@"/api")] //采购商催报价
#define DYZ_inquiry_purchase_status_count [NSString stringWithFormat:@"%@/inquiry/purchase/status/count",DYZBaseURLItem(@"/api")] //采购商列表统计询盘各状态数量
#define DYZ_inquiry_supplier_status_count [NSString stringWithFormat:@"%@/inquiry/supplier/status/count",DYZBaseURLItem(@"/api")] //供应商列表统计询盘各状态数量
#define DYZ_inquiry_purchase_inquiry_cancel [NSString stringWithFormat:@"%@/inquiry/purchase/inquiry/cancel",DYZBaseURLItem(@"/api")] //采购商取消询盘
#define DYZ_inquiry_purchase_item_del [NSString stringWithFormat:@"%@/inquiry/purchase/item/del",DYZBaseURLItem(@"/api")] //采购商删除零件
#define DYZ_inquiry_purchase_item_copy [NSString stringWithFormat:@"%@/inquiry/purchase/item/copy",DYZBaseURLItem(@"/api")] //采购商拆分询盘明细


#define DYZ_tradeOrder_purchase_tradeOrderList [NSString stringWithFormat:@"%@/tradeOrder/purchase/tradeOrderList",DYZBaseURLItem(@"/api")] //采购商订单列表查询接口
#define DYZ_tradeOrder_supplier_tradeOrderList [NSString stringWithFormat:@"%@/tradeOrder/supplier/tradeOrderList",DYZBaseURLItem(@"/api")] //供应商订单列表查询接口
#define DYZ_tradeOrder_purchase_productionOrderInfo [NSString stringWithFormat:@"%@/tradeOrder/purchase/productionOrderInfo",DYZBaseURLItem(@"/api")] //采购商查询生产详情接口
#define DYZ_tradeOrder_supplier_productionOrderInfo [NSString stringWithFormat:@"%@/tradeOrder/supplier/productionOrderInfo",DYZBaseURLItem(@"/api")] //供应商查询生产详情接口
#define DYZ_tradeOrder_purchase_purchaseOrderDetail [NSString stringWithFormat:@"%@/tradeOrder/purchase/purchaseOrderDetail",DYZBaseURLItem(@"/api")] //采购商订单明细查询接口
#define DYZ_tradeOrder_supplier_supplierOrderDetail [NSString stringWithFormat:@"%@/tradeOrder/supplier/supplierOrderDetail",DYZBaseURLItem(@"/api")] //供应商订单明细查询接口

#define DYZ_inquiry_add [NSString stringWithFormat:@"%@/inquiry/add",DYZBaseURLItem(@"/api")] //发盘
#define DYZ_quo_normal_add [NSString stringWithFormat:@"%@/quo/normal/add",DYZBaseURLItem(@"/api")] //供应商对普通询盘报价
#define DYZ_quo_purchase_detail [NSString stringWithFormat:@"%@/quo/purchase/detail",DYZBaseURLItem(@"/api")] //采购商查询报价详情
#define DYZ_quo_supplier_detail [NSString stringWithFormat:@"%@/quo/supplier/detail",DYZBaseURLItem(@"/api")] //供应商查询报价详情
#define DYZ_inquiry_purchase_select [NSString stringWithFormat:@"%@/inquiry/purchase/select",DYZBaseURLItem(@"/api")] //采购商筛选询盘

#define DYZ_tradeOrder_supplier_accpetOrder [NSString stringWithFormat:@"%@/tradeOrder/supplier/accpetOrder",DYZBaseURLItem(@"/api")] //供应商接盘接口
#define DYZ_tradeOrder_supplier_supplierRefuseOrder [NSString stringWithFormat:@"%@/tradeOrder/supplier/supplierRefuseOrder",DYZBaseURLItem(@"/api")] //供应商拒绝接单接口
#define DYZ_tradeOrder_purchase_purchaseApprovalOrder [NSString stringWithFormat:@"%@/tradeOrder/purchase/purchaseApprovalOrder",DYZBaseURLItem(@"/api")] //采购商审批通过接口
#define DYZ_tradeOrder_purchase_purchaseRefuseOrder [NSString stringWithFormat:@"%@/tradeOrder/purchase/purchaseRefuseOrder",DYZBaseURLItem(@"/api")] //采购商审批拒绝接口

#define DYZ_quo_special_purchase_edit [NSString stringWithFormat:@"%@/quo/special/purchase/edit",DYZBaseURLItem(@"/api")] //采购商修改议价询盘的报价
#define DYZ_quo_special_supplier_edit [NSString stringWithFormat:@"%@/quo/special/supplier/edit",DYZBaseURLItem(@"/api")] //供应商修改议价询盘的报价
#define DYZ_tradeOrder_purchase_closeTradeOrder [NSString stringWithFormat:@"%@/tradeOrder/purchase/closeTradeOrder",DYZBaseURLItem(@"/api")] //采购商关闭订单接口

#define DYZ_api_quo_supplier_refuse [NSString stringWithFormat:@"%@/quo/supplier/refuse",DYZBaseURLItem(@"/api")] //供应商拒绝报价

#define DYZ_api_inquiryHistory_history [NSString stringWithFormat:@"%@/inquiry/inquiryHistory/history",DYZBaseURLItem(@"/api")] //询盘历史web端展示

#define DYZ_api_tradeOrder_purchase_purchaseAccpetOrder [NSString stringWithFormat:@"%@/tradeOrder/purchase/purchaseAccpetOrder",DYZBaseURLItem(@"/api")] //采购商验收服务订单接口

#define DYZ_api_tradeOrder_purchase_purchaseDeleteOrder [NSString stringWithFormat:@"%@/tradeOrder/purchase/purchaseDeleteOrder",DYZBaseURLItem(@"/api")] //采购商删除订单接口

#define DYZ_api_tradeOrder_purchase_reSendOrder [NSString stringWithFormat:@"%@/tradeOrder/purchase/reSendOrder",DYZBaseURLItem(@"/api")] //采购商重新提交授盘接口

#define DYZ_api_tradeOrder_purchase_reApproval [NSString stringWithFormat:@"%@/tradeOrder/purchase/reApproval",DYZBaseURLItem(@"/api")] //采购商重新提交审批接口

#define DYZ_api_globalTemplate_purchase_getGlobalTemplateForTable [NSString stringWithFormat:@"%@/globalTemplate/purchase/getGlobalTemplateForTable",DYZBaseURLItem(@"/api")] //采购商在相应页面获取企业全局配置接口

#define DYZ_api_globalTemplate_supplier_getGlobalTemplateForTable [NSString stringWithFormat:@"%@/globalTemplate/supplier/getGlobalTemplateForTable",DYZBaseURLItem(@"/api")] //供应商在相应页面获取企业全局配置接口



#define DYZ_mes_transportOrder_scanOutgoingOrder [NSString stringWithFormat:@"%@/mes/transportOrder/scanOutgoingOrder",DYZBaseURLItem(@"/rs")] //扫描发货单

#define DYZ_mes_transportOrder_createTransportOrder [NSString stringWithFormat:@"%@/mes/transportOrder/createTransportOrder",DYZBaseURLItem(@"/rs")] //批量提交创建运输单

#define DYZ_mes_transportOrder_getTransportOrderByOrderNum [NSString stringWithFormat:@"%@/mes/transportOrder/getTransportOrderByOrderNum",DYZBaseURLItem(@"/rs")] //查询运输单详情

#define DYZ_mes_transportOrder_getTransportOrderListByUser [NSString stringWithFormat:@"%@/mes/transportOrder/getTransportOrderListByUser",DYZBaseURLItem(@"/rs")] //查询运输列表


#define DYZ_mes_transportOrder_transportOrderStart [NSString stringWithFormat:@"%@/mes/transportOrder/transportOrderStart",DYZBaseURLItem(@"/rs")] //运输单开始接口

#define DYZ_mes_transportOrder_transportOrderArrived [NSString stringWithFormat:@"%@/mes/transportOrder/transportOrderArrived",DYZBaseURLItem(@"/rs")] //运输单送达接口

#define DYZ_mes_transportOrder_transportOrderClose [NSString stringWithFormat:@"%@/mes/transportOrder/transportOrderClose",DYZBaseURLItem(@"/rs")] //运输单关闭接口

#define DYZ_mes_transportOrder_transportOrderDetailDelete [NSString stringWithFormat:@"%@/mes/transportOrder/transportOrderDetailDelete",DYZBaseURLItem(@"/rs")] //运输单删除接口

#define DYZ_mes_transportOrder_transportOrderDelivery [NSString stringWithFormat:@"%@/mes/transportOrder/transportOrderDelivery",DYZBaseURLItem(@"/rs")] //运输单收货开始接口

#define DYZ_mes_transportOrder_transportOrderDeliveryCommit [NSString stringWithFormat:@"%@/mes/transportOrder/transportOrderDeliveryCommit",DYZBaseURLItem(@"/rs")] //运输单收货提交接口


#define DYZ_mes_temporaryTask_temporaryTaskShutdown [NSString stringWithFormat:@"%@/mes/temporaryTask/temporaryTaskShutdown",DYZBaseURLItem(@"/rs")] //临时任务暂停

#define DYZ_mes_temporaryTask_temporaryTaskContinue [NSString stringWithFormat:@"%@/mes/temporaryTask/temporaryTaskContinue",DYZBaseURLItem(@"/rs")] //临时任务继续

#define DYZ_mes_temporaryTask_temporaryTaskCommitByPassword [NSString stringWithFormat:@"%@/mes/temporaryTask/temporaryTaskCommitByPassword",DYZBaseURLItem(@"/rs")] //临时任务通过密码确认完成

#define DYZ_mes_temporaryTask_temporaryTaskStart [NSString stringWithFormat:@"%@/mes/temporaryTask/temporaryTaskStart",DYZBaseURLItem(@"/rs")] //临时任务开始

#define DYZ_mes_temporaryTask_temporaryTaskClose [NSString stringWithFormat:@"%@/mes/temporaryTask/temporaryTaskClose",DYZBaseURLItem(@"/rs")] //临时任务关闭

#define DYZ_mes_temporaryTask_getTemporaryTaskTypeList [NSString stringWithFormat:@"%@/mes/temporaryTask/getTemporaryTaskTypeList",DYZBaseURLItem(@"/rs")] //临时任务类型列表

#define DYZ_mes_temporaryTask_getTemporaryTaskByEmployee [NSString stringWithFormat:@"%@/mes/temporaryTask/getTemporaryTaskByEmployee",DYZBaseURLItem(@"/rs")] //获得员工临时任务

#define DYZ_mes_temporaryTask_getTemporaryTaskList [NSString stringWithFormat:@"%@/mes/temporaryTask/getTemporaryTaskList",DYZBaseURLItem(@"/rs")] //获得临时任务列表

#define DYZ_mes_temporaryTask_getTemporaryTaskConfirmUserList [NSString stringWithFormat:@"%@/mes/temporaryTask/getTemporaryTaskConfirmUserList",DYZBaseURLItem(@"/rs")] //获得临时任务确认人列表

#define DYZ_mes_temporaryTask_temporaryTaskCommit [NSString stringWithFormat:@"%@/mes/temporaryTask/temporaryTaskCommit",DYZBaseURLItem(@"/rs")] //临时任务确认完成

#define DYZ_mes_temporaryTask_getTemporaryTask [NSString stringWithFormat:@"%@/mes/temporaryTask/getTemporaryTask",DYZBaseURLItem(@"/rs")] //获得临时任务详情

#define DYZ_mes_productionOrderConfirm_validateWorkRecordType [NSString stringWithFormat:@"%@/mes/productionOrderConfirm/validateWorkRecordType",DYZBaseURLItem(@"/rs")] //检验报工记录类型接口


#define DYZ_aip_inquiry_competence_all [NSString stringWithFormat:@"%@/inquiry/competence/all",DYZBaseURLItem(@"/api")] //获取用户功能权限ID

#define DYZ_aip_deliverOrder_purchaseSetSdTime [NSString stringWithFormat:@"%@/efeibiao/deliverOrder/purchaseSetSdTime",DYZBaseURLItem(@"/rs")] //采购商回填送达日期

//工序进度查询
#define DYZ_rs_mes_productionControlProcessReport_processDetailsList [NSString stringWithFormat:@"%@/mes/productionControlProcessReport/processDetailsList",DYZBaseURLItem(@"/rs")]

//工序报工明细
#define DYZ_rs_mes_productionControlProcessReport_operationDetailsList [NSString stringWithFormat:@"%@/mes/productionControlProcessReport/operationDetailsList",DYZBaseURLItem(@"/rs")]

//创建委外单扫描
#define DYZ_mes_operationOutsourcing_getOperationOutsourcingSourceVosByControlNum [NSString stringWithFormat:@"%@/mes/operationOutsourcing/getOperationOutsourcingSourceVosByControlNum",DYZBaseURLItem(@"/rs")]
//保存委外单
#define DYZ_mes_operationOutsourcing_saveOperationOutsourcingOrder [NSString stringWithFormat:@"%@/mes/operationOutsourcing/saveOperationOutsourcingOrder",DYZBaseURLItem(@"/rs")]
//获得供应商列表接口
#define DYZ_mes_supplier_getSupplierVoList [NSString stringWithFormat:@"%@/mes/supplier/getSupplierVoList",DYZBaseURLItem(@"/rs")]
//校验物料类型是否模具类型
#define DYZ_mes_material_checkMoldMaterial [NSString stringWithFormat:@"%@/mes/material/checkMoldMaterial",DYZBaseURLItem(@"/rs")]

//扫描作业工单获取发货单数据接口
#define DYZ_mes_materialOutgoingOrder_getMaterialOutgoingOrderByProductionControlNum [NSString stringWithFormat:@"%@/mes/materialOutgoingOrder/getMaterialOutgoingOrderByProductionControlNum",DYZBaseURLItem(@"/rs")]
//app退货接口
#define DYZ_mes_materialOutgoingOrder_backMaterialOutgoingOrderByProductionControlNum [NSString stringWithFormat:@"%@/mes/materialOutgoingOrder/backMaterialOutgoingOrderByProductionControlNum",DYZBaseURLItem(@"/rs")]

//获得参数配置接口
#define DYZ_mes_parameter_getparameterlist [NSString stringWithFormat:@"%@/mes/parameter/getParameterList",DYZBaseURLItem(@"/rs")]

//获取模具接口
#define DYZ_mes_material_getMouldByProductionControlNum [NSString stringWithFormat:@"%@/mes/material/getMouldByProductionControlNum",DYZBaseURLItem(@"/rs")]

#endif /* UrlContant_h */
