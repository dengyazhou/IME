//
//  YanHuoCell0903.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "YanHuoCell0903.h"
#import "Header.h"
#import "UrlContant.h"

#import "UIImageView+WebCache.h"

@implementation YanHuoCell0903

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iamgeView1.layer.borderWidth = 1;
    self.iamgeView1.layer.borderColor = colorRGB(216, 216, 217).CGColor;
}

- (void)setModel:(InspectOrderItemVo *)model {

    self.LabelBiTian.hidden = true;
    self.labelNum.hidden = true;
    
    

    self.labelreceiveNum.text = model.canInspectNum.stringValue;
    self.labelqualityQuantity.text = model.qualityQuantity.stringValue;
    self.labeldefectiveQuantity.text = model.defectiveQuantity.stringValue;
    
    self.buttonCheckImage.hidden = true;
    self.buttonSelectImage.hidden = true;
    self.buttonDelectImage.hidden = true;
    if (model.fileName.length > 0) {
        self.buttonCheckImage.hidden = false;
        self.buttonDelectImage.hidden = false;
    } else {
        self.buttonSelectImage.hidden = false;
    }
    
    [self.iamgeView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?filePath=%@&fileRealName=%@&fileBucketName=%@&filename=%@",DYZ_efeibiao_uploadfile_downloadInspectFile,model.filePath,model.fileRealName,model.bucketName,model.fileRealName]] placeholderImage:nil];
    
    NSInteger count = 0;
    for (NSInteger i=0; i<5; i++) {
        if ([model valueForKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]]) {
            count++;
        } else {
            break;
        }
    }
    if (count == 0) {
        self.LabelBiTian.hidden = false;
    } else {
        self.labelNum.hidden = false;
        self.labelNum.text = [NSString stringWithFormat:@"%ld种处理方式",count];
    }
    
    if (model.isMianjian.integerValue == 1) {//免检
        self.imageViewIsMianJian.hidden = false;
        self.view1.hidden = true;
        [self.buttonMianjian setTitle:@"取消免检" forState:UIControlStateNormal];
    } else {
        self.imageViewIsMianJian.hidden = true;
        self.view1.hidden = false;
        [self.buttonMianjian setTitle:@"免检" forState:UIControlStateNormal];
    }
}

- (IBAction)buttonCheckImageClick:(UIButton *)sender {
    if (self.buttonCheckImageCallBack) {
        self.buttonCheckImageCallBack();
    }
}
- (IBAction)buttonSelectImageClick:(UIButton *)sender {
    if (self.buttonSelectImageCallBack) {
        self.buttonSelectImageCallBack();
    }
}
- (IBAction)buttonDelectImageClick:(UIButton *)sender {
    if (self.buttonDelectImageCallBack) {
        self.buttonDelectImageCallBack();
    }
}

- (IBAction)buttonSelectDefectiveMethod:(UIButton *)sender {
    if (self.buttonSelectDefectiveMethodCallBack) {
        self.buttonSelectDefectiveMethodCallBack();
    }
}

- (IBAction)buttonPartDetail:(id)sender {
    if (self.buttonPartDetailCallBack) {
        self.buttonPartDetailCallBack();
    }
}

- (IBAction)buttonMianJian:(UIButton *)sender {
    if (self.buttonMianJianCallBack) {
        self.buttonMianJianCallBack(sender);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
