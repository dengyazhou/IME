//
//  ReleaseCell.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/8.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ReleaseCell.h"

#import "VoHeader.h"

#import <ReactiveObjC.h>

@interface ReleaseCell () <UITableViewDelegate,UITableViewDataSource> {
    
}

@end

@implementation ReleaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.tableViewWorkCenter.delegate = self;
    self.tableViewWorkCenter.dataSource = self;
    [self.tableViewWorkCenter registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableViewWorkCenter.rowHeight = 25;
    
    self.tableViewMateriaProcess.delegate = self;
    self.tableViewMateriaProcess.dataSource = self;
    [self.tableViewMateriaProcess registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableViewMateriaProcess.rowHeight = 25;

    @weakify(self);
    [[self.buttonWorkCenter rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.tableViewWorkCenter.hidden = !self.tableViewWorkCenter.isHidden;
    }];
    
    [[self.buttonMateriaProcess rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.tableViewMateriaProcess.hidden = !self.tableViewMateriaProcess.isHidden;
    }];
    
    [[self.buttonStartDateTime rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.startDateTimeblock();
    }];
    
    [[self.buttonEndDateTime rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.endDateTimeblock();
    }];
    
    [[self.textFiledPlannedQuantity.rac_textSignal skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.textFiledPlannedQuantityblock(x);
    }];
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableViewWorkCenter) {
        return self.workCenterList.count;
    }
    if (tableView == self.tableViewMateriaProcess) {
        return self.materiaProcessAssignList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableViewWorkCenter) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        WorkCenterVo *model = self.workCenterList[indexPath.row];
        
        cell.textLabel.text = model.workCenterText;
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        
        return cell;
    }
    if (tableView == self.tableViewMateriaProcess) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        MateriaProcessAssignVo *model = self.materiaProcessAssignList[indexPath.row];
        
        cell.textLabel.text = model.processText;
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableViewWorkCenter) {
        for (WorkCenterVo *model in self.workCenterList) {
            model.selectDyz = [NSNumber numberWithInteger:0];
        }
        WorkCenterVo *model = self.workCenterList[indexPath.row];
        model.selectDyz = [NSNumber numberWithInteger:1];
       
    }
    if (tableView == self.tableViewMateriaProcess) {
        for (MateriaProcessAssignVo *model in self.materiaProcessAssignList) {
            model.selectDyz = [NSNumber numberWithInteger:0];
        }
        MateriaProcessAssignVo *model = self.materiaProcessAssignList[indexPath.row];
        model.selectDyz = [NSNumber numberWithInteger:1];
        
    }
    tableView.hidden = YES;
    
    self.reloadDatablock();
}

- (void)callBackReloadData:(void (^)(void))reloadDatablock {
    self.reloadDatablock = reloadDatablock;
}

- (void)callStartDateTime:(void (^)(void))block {
    self.startDateTimeblock = block;
}

- (void)callEndDateTime:(void (^)(void))block {
    self.endDateTimeblock = block;
}

- (void)callTextFiledPlannedQuantity:(void (^)(NSString * _Nonnull))block {
    self.textFiledPlannedQuantityblock = block;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
