//
//  HttpMamager.m
//  XiaChuFangDYZ
//
//  Created by Mac on 16/2/28.
//  Copyright © 2016年 Syxdzybs. All rights reserved.
//

#import "HttpMamager.h"
#import "MJExtension.h"
#import "UrlContant.h"

#import "AFNetworking.h"


#import "UserBean.h"

#import "ReturnEntityBean.h"
#import "ReturnListBean.h"

#import "UIViewController+Tool.h"
#import "VoHeader.h"

#import "UploadImageBean.h"

#import "NetworkInformation.h"

static NSTimeInterval const defineTimeoutInterval = 30.0f;

@implementation HttpMamager

+ (void)postRequestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void(^)(id responseObjectModel))success fail:(void(^)(NSError *error))fail isKindOfModel:(Class)model {
    
    /*
     1、没有网不发起网络请求，提示"设备连接网络异常"
     2、有网，请求
     3、超时，判断网的质量，网的质量不好，提示"设备信号弱"；网的质量好，提示"链接服务器超时"
     */
    if ([[NetworkInformation getNetworkTypeByReachability] isEqualToString:@"NONE"]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"设备连接网络异常"];
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    
    NSString * tokenId = [[NSUserDefaults standardUserDefaults] objectForKey:@"tokenId"];
    if (tokenId) {
        [manager.requestSerializer setValue:tokenId forHTTPHeaderField:@"tokenId"];
    }
    [manager.requestSerializer setValue:@"APP" forHTTPHeaderField:@"type"];
    manager.responseSerializer.acceptableContentTypes = nil;//[NSSet setWithObject:@"text/ plain"];
    
    
    //设置超时时间
    manager.requestSerializer.timeoutInterval = defineTimeoutInterval;
    
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@">>>%@",[responseObject mj_JSONString]);
        
        id responseModel = [model mj_objectWithKeyValues:responseObject];
        
        if ([responseModel isMemberOfClass:[ReturnMsgBean class]]) {
            ReturnMsgBean *returnMsgBean = responseModel;
            
            if ([returnMsgBean.returnCode integerValue] == 999999999) {
                UIViewController *viewController = [self getCurrentVC];
                [viewController goHomepage];
            }
            
        } else if ([responseModel isMemberOfClass:[ReturnEntityBean class]]) {

            ReturnEntityBean *returnEntityBean = responseModel;
            
            if ([returnEntityBean.returnCode integerValue] == 999999999) {
                UIViewController *viewController = [self getCurrentVC];
                [viewController goHomepage];
            }
        } else if ([responseModel isMemberOfClass:[ReturnListBean class]]) {
            
            ReturnListBean *returnListBean = responseModel;
            
            if ([returnListBean.returnCode integerValue] == 999999999) {
                UIViewController *viewController = [self getCurrentVC];
                [viewController goHomepage];
            }
        } else {
            NSDictionary *dic = responseObject;
            
            if ([dic[@"returnCode"] integerValue] == 999999999) {
                
                UIViewController *viewController = [self getCurrentVC];
                [viewController goHomepage];
            }
        }
        if (success) {
            success(responseModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (error.code == -1001) {
            NSLog(@"=DYZ======================================请求超时");
            if ([[NetworkInformation getNetworkTypeByReachability] isEqualToString:@"WIFI"]) {
                if ([NetworkInformation getWifiSignalStrength] > 2) {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"链接服务器超时"];
                } else {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"设备信号弱"];
                }
            } else if ([[NetworkInformation getNetworkTypeByReachability] isEqualToString:@"WWAN"]) {
                if ([NetworkInformation getcellularSignalStrength] > 3) {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"链接服务器超时"];
                } else {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"设备信号弱"];
                }
            }
        }
        if (error.code == -1004) {
            NSLog(@"=DYZ======================================未能连接到服务器");
        }
        if (error.code == -1009) {
            NSLog(@"=DYZ======================================断开互联网连接");
        }
        if (fail) {
            fail(error);
        }
    }];
}


+ (void)postRequestLoginWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void(^)(id responseObjectModel))success fail:(void(^)(NSError *error))fail {
    
    if ([[NetworkInformation getNetworkTypeByReachability] isEqualToString:@"NONE"]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"设备连接网络异常"];
        return;
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = defineTimeoutInterval;
    
    if (![urlString isEqualToString:DYZ_user_login]) {
        NSString * tokenId = [[NSUserDefaults standardUserDefaults] objectForKey:@"tokenId"];
        if (tokenId) {
            [manager.requestSerializer setValue:tokenId forHTTPHeaderField:@"tokenId"];
        }
    }
    [manager.requestSerializer setValue:@"APP" forHTTPHeaderField:@"type"];
    manager.responseSerializer.acceptableContentTypes = nil;//[NSSet setWithObject:@"text/plain"];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Login:%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        if (error.code == -1001) {
            NSLog(@"=DYZ======================================请求超时");
            if ([[NetworkInformation getNetworkTypeByReachability] isEqualToString:@"WIFI"]) {
                if ([NetworkInformation getWifiSignalStrength] > 2) {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"链接服务器超时"];
                } else {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"设备信号弱"];
                }
            } else if ([[NetworkInformation getNetworkTypeByReachability] isEqualToString:@"WWAN"]) {
                if ([NetworkInformation getcellularSignalStrength] > 3) {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"链接服务器超时"];
                } else {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"设备信号弱"];
                }
            }
        }
        if (error.code == -1004) {
            NSLog(@"=DYZ======================================未能连接到服务器");
        }
        if (error.code == -1009) {
            NSLog(@"=DYZ======================================断开互联网连接");
        }
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)postRequestImageWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters UploadImageBean:(NSArray<UploadImageBean *> *)array success:(void (^)(id))success progress:(void (^)(NSProgress *))progress fail:(void (^)(NSError *))fail isKindOfModelClass:(Class)modelClass {
    
    if ([[NetworkInformation getNetworkTypeByReachability] isEqualToString:@"NONE"]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"设备连接网络异常"];
        return;
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    NSString * tokenId = [[NSUserDefaults standardUserDefaults] objectForKey:@"tokenId"];
    if (tokenId) {
        [manager.requestSerializer setValue:tokenId forHTTPHeaderField:@"tokenId"];
    }
    [manager.requestSerializer setValue:@"APP" forHTTPHeaderField:@"type"];
    manager.responseSerializer.acceptableContentTypes = nil;
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (array != nil && array.count > 0) {
            for (UploadImageBean *uploadImageBean in array) {
                [formData appendPartWithFileData:uploadImageBean.data name:uploadImageBean.name fileName:uploadImageBean.fileName mimeType:uploadImageBean.mimeType];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",@(uploadProgress.fractionCompleted));
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        id responseModel = [modelClass mj_objectWithKeyValues:responseObject];
        if (success) {
            success(responseModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (error.code == -1001) {
            NSLog(@"=DYZ======================================请求超时");
            if ([[NetworkInformation getNetworkTypeByReachability] isEqualToString:@"WIFI"]) {
                if ([NetworkInformation getWifiSignalStrength] > 2) {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"链接服务器超时"];
                } else {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"设备信号弱"];
                }
            } else if ([[NetworkInformation getNetworkTypeByReachability] isEqualToString:@"WWAN"]) {
                if ([NetworkInformation getcellularSignalStrength] > 3) {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"链接服务器超时"];
                } else {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"设备信号弱"];
                }
            }
        }
        if (fail) {
            fail(error);
        }
    }];
}


#pragma mark https 加密
+ (AFSecurityPolicy*)customSecurityPolicy
{
    
//    NSString *cerPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"/all.imefuture.com.cer"];;
    
    //先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"imefuture.com" ofType:@"cer"];//证书的路径
    
    
//    NSLog(@"%@",cerPath);
    
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
//    securityPolicy.pinnedCertificates = @[certData];
    return securityPolicy;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        
        result = nextResponder;
    else
        
        result = window.rootViewController;
    
    return result;
}

@end
