//
//  YanHuoDetailCell0903.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "YanHuoDetailCell0903.h"
#import "Header.h"
#import "UrlContant.h"
#import "UIImageView+WebCache.h"

@implementation YanHuoDetailCell0903

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iamgeView1.layer.borderWidth = 1;
    self.iamgeView1.layer.borderColor = colorRGB(216, 216, 216).CGColor;
}

- (void)setModel:(InspectOrderItemVo *)model {
    _model = model;
    self.labelCanInspectNum.text = model.canInspectNum.stringValue;
    self.labelQualityQuantity.text = model.qualityQuantity.stringValue;
    self.labelDefectiveQuantity.text = model.defectiveQuantity.stringValue;
    [self.iamgeViewFilePath sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?filePath=%@&fileRealName=%@&fileBucketName=%@&filename=%@",DYZ_efeibiao_uploadfile_downloadInspectFile,model.filePath,model.fileRealName,model.bucketName,model.fileName]] placeholderImage:nil];
    
    if (model.fileName) {
        self.view1.hidden = false;
        if (model.isMianjian.integerValue == 1) {//免检
            self.imageViewIsMianJian.hidden = false;
            self.buttonIsMianJIan.hidden = true;
        } else {
            self.imageViewIsMianJian.hidden = true;
            self.buttonIsMianJIan.hidden = false;
        }
    } else {
        self.view1.hidden = true;
        if (model.isMianjian.integerValue == 1) {//免检
            self.imageViewIsMianJian.hidden = false;
            self.buttonIsMianJIan.hidden = true;
        } else {
            self.imageViewIsMianJian.hidden = true;
            self.buttonIsMianJIan.hidden = false;
        }
    }
    
    
    
}

- (IBAction)buttonDefectivePhone:(id)sender {
    if (self.model.fileName) {
        if (self.buttonPartPhoneCallBack) {
            self.buttonPartPhoneCallBack();
        }
    }
}

- (IBAction)buttonPartDetail:(id)sender {
    if (self.buttonPartDetailCallBack) {
        self.buttonPartDetailCallBack();
    }
}

- (IBAction)buttonDefectiveOperate:(id)sender {
    if (self.buttonDefectiveOperateCallBack) {
        self.buttonDefectiveOperateCallBack();
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
