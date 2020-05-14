//
//  FaHuoCell090502.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "FaHuoCell090502.h"

@interface FaHuoCell090502 () <UITextViewDelegate>

@end

@implementation FaHuoCell090502

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textView.delegate = self;
}

- (void)setModel:(DeliverOrderDetailBean *)model {
    _model = model;
    if (model.selfAddress.length > 0) {
        self.labelZiTiDiZhi.hidden = true;
    } else {
        self.labelZiTiDiZhi.hidden = false;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.textFieldBeginDYZCallBack) {
        self.textFieldBeginDYZCallBack();
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    _model.selfAddress = textView.text;
    if (textView.text.length > 0) {
        self.labelZiTiDiZhi.hidden = true;
    } else {
        self.labelZiTiDiZhi.hidden = false;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
