//
//  FaHuoCell0906.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "FaHuoCell0906.h"

@interface FaHuoCell0906 () <UITextViewDelegate>

@end

@implementation FaHuoCell0906

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textView.delegate = self;
}

- (void)setModel:(DeliverOrderDetailBean *)model {
    _model = model;
    if (model.remark.length > 0) {
        self.labelBeiZhu.hidden = true;
    } else {
        self.labelBeiZhu.hidden = false;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.textFieldBeginDYZCallBack) {
        self.textFieldBeginDYZCallBack();
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    _model.remark = textView.text;
    if (textView.text.length > 0) {
        self.labelBeiZhu.hidden = true;
    } else {
        self.labelBeiZhu.hidden = false;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
