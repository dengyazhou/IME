//
//  ReleaseHeader.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/8.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReleaseHeader : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *label01;
@property (weak, nonatomic) IBOutlet UILabel *label02;
@property (weak, nonatomic) IBOutlet UILabel *label03;
@property (weak, nonatomic) IBOutlet UILabel *label04;
@property (weak, nonatomic) IBOutlet UILabel *label05;
@property (weak, nonatomic) IBOutlet UILabel *label06;


@property (weak, nonatomic) IBOutlet UITableView *tableViewWorkCenter;
@property (weak, nonatomic) IBOutlet UITableView *tableViewMateriaProcess;

@property (weak, nonatomic) IBOutlet UIButton *buttonWorkCenter;
@property (weak, nonatomic) IBOutlet UIButton *buttonMateriaProcess;

@property (weak, nonatomic) IBOutlet UILabel *labelWorkCenter;
@property (weak, nonatomic) IBOutlet UILabel *labelMateriaProcess;

@property (nonatomic, strong) NSMutableArray *workCenterList;
@property (nonatomic, strong) NSMutableArray *materiaProcessAssignList;


@property (nonatomic,copy) void(^reloadDatablock)(void);

- (void)callBackReloadData:(void(^)(void))reloadDatablock;

@property (weak, nonatomic) IBOutlet UITextField *textFiledBatchesRelease;

@property (weak, nonatomic) IBOutlet UIButton *buttonBatchesRelease;//分批下达

@property (nonatomic,copy) void(^batchesReleaseblock)(void);

- (void)callBackBatchesReleaseblock:(void(^)(void))batchesReleaseblock;



@end

NS_ASSUME_NONNULL_END
