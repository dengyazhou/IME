//
//  UploadFile.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@interface UploadFile : BaseEntity

//
//@property (nonatomic,copy) NSString *fileId;
//
//
//
///**
// * 文件类型
// */
//@property (nonatomic,copy) NSString *fileType;//I("图片"),V("视频"),M("音频"),F("文件");
//
///**
// * 文件扩展名
// */
//@property (nonatomic,copy) NSString *fileExtension;//JPG("jpg"),JPEG("jpeg"),GIF("gif"),PNG("png"),STL("stl"),GP3("3gp"),AVI("avi"),FLV("flv"),RMVB("rmvb"),WMV("wmv"),MP3("mp3"),WMA("wma"),TXT("txt"),XLS("xls"),XLSX("xlsx"),DOC("doc"),DOCX("docx"),PPT("ppt"),PDF("pdf"),APK("apk"),ZIP("zip"),RAR("rar");
//
//
///**
// * 文件的真名
// */
//@property (nonatomic,copy) NSString *fileRealName;
//
///**
// * 模块文件路径表ID
// */
//@property (nonatomic,strong) NSNumber *mpId;//Integer
//
///**
// * 文件类型说明表ID
// */
//@property (nonatomic,strong) NSNumber *feId;//Integer
//
///**
// * 上传的人员Id
// */
//@property (nonatomic,copy) NSString *memberId;
//
///**
// * 文件md5码
// */
//@property (nonatomic,copy) NSString *md5Code;
//
///**
// * 关联的主文件ID
// */
//@property (nonatomic,copy) NSString *fileUpId;





@property (nonatomic,copy) NSString *fileName;

@property (nonatomic,copy) NSString *filePath;

@property (nonatomic,copy) NSString *realName;

@property (nonatomic,strong) NSNumber *fileSize;//Long

@property (nonatomic,copy) NSString *folderName;

@property (nonatomic,copy) NSString *bucketName;

@property (nonatomic,copy) NSString *md5String;

@property (nonatomic,strong) NSNumber *flag;

@property (nonatomic,copy) NSString *fileUrl;

@property (nonatomic,copy) NSString *thumbnailUrl;


@end
