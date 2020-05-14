//
//  UIViewCiPingChuLiFangShi.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/15.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "UIViewCiPingChuLiFangShi.h"

#import "NSString+Enumeration.h"

#import "CiPingChuLiFangShiCell0.h"
#import "CiPingChuLiFangShiCell1.h"
#import "CiPingChuLiModel.h"


@interface UIViewCiPingChuLiFangShi () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayCiPingChuLiModel;
    NSNumber *_defectiveQuantity;
}

@end

@implementation UIViewCiPingChuLiFangShi

- (void)initTableView:(NSMutableArray *)arrayCiPingChuLiModel defectiveQuantity:(NSNumber *)defectiveQuantity {
    _arrayCiPingChuLiModel = arrayCiPingChuLiModel;
    _defectiveQuantity = defectiveQuantity;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CiPingChuLiFangShiCell0" bundle:nil] forCellReuseIdentifier:@"ciPingChuLiFangShiCell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CiPingChuLiFangShiCell1" bundle:nil] forCellReuseIdentifier:@"ciPingChuLiFangShiCell1"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayCiPingChuLiModel.count+1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return 44;
//    } else {
//        return 100;
//    };
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CiPingChuLiFangShiCell0 *ciPingChuLiFangShiCell0 = [tableView dequeueReusableCellWithIdentifier:@"ciPingChuLiFangShiCell0" forIndexPath:indexPath];
        ciPingChuLiFangShiCell0.selectionStyle = UITableViewCellSelectionStyleNone;
        ciPingChuLiFangShiCell0.label0.text = [NSString stringWithFormat:@"次品数：%@",_defectiveQuantity];
        return ciPingChuLiFangShiCell0;
    } else {
        CiPingChuLiFangShiCell1 *ciPingChuLiFangShiCell1 = [tableView dequeueReusableCellWithIdentifier:@"ciPingChuLiFangShiCell1" forIndexPath:indexPath];
        ciPingChuLiFangShiCell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
        CiPingChuLiModel *model = _arrayCiPingChuLiModel[indexPath.row-1];
        
        ciPingChuLiFangShiCell1.label00.text = [NSString stringWithFormat:@"方式%ld",indexPath.row];
        ciPingChuLiFangShiCell1.label0.text = [NSString stringWithFormat:@"处理方式：%@",[NSString DefectiveOperateType:model.defectiveOperateType]];
        ciPingChuLiFangShiCell1.label1.text = [NSString stringWithFormat:@"返修数量：%@",model.reissueNum];
        ciPingChuLiFangShiCell1.label2.text = [NSString stringWithFormat:@"次品类型：%@",model.unType!=nil?model.unType:@""];
        ciPingChuLiFangShiCell1.label3.text = [NSString stringWithFormat:@"不合格原因：%@",model.unReason];
        return ciPingChuLiFangShiCell1;
    }
}

- (IBAction)buttonClick:(UIButton *)sender {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
