//
//  HttpMamager.h
//  XiaChuFangDYZ
//
//  Created by Mac on 16/2/28.
//  Copyright © 2016年 Syxdzybs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UploadImageBean;


@interface HttpMamager : NSObject


+ (void)postRequestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void(^)(id responseObjectModel))success fail:(void(^)(NSError *error))fail isKindOfModel:(Class)model;

+ (void)postRequestLoginWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void(^)(id responseObjectModel))success fail:(void(^)(NSError *error))fail;

//上传图片
+ (void)postRequestImageWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters UploadImageBean:(NSArray <UploadImageBean * > *)array success:(void(^)(id responseObjectModel))success progress:(void (^)(NSProgress *))progress fail:(void(^)(NSError *error))fail isKindOfModelClass:(Class)modelClass;





@end
