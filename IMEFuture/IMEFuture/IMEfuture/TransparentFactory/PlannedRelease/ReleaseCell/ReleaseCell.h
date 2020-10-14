//
//  ReleaseCell.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/8.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReleaseCell : UITableViewCell

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

@property (weak, nonatomic) IBOutlet UILabel *labelStartDateTime;
@property (weak, nonatomic) IBOutlet UILabel *labelEndDateTime;

@property (weak, nonatomic) IBOutlet UIButton *buttonStartDateTime;
@property (weak, nonatomic) IBOutlet UIButton *buttonEndDateTime;
@property (nonatomic,copy) void(^startDateTimeblock)(void);
- (void)callStartDateTime:(void(^)(void))block;
@property (nonatomic,copy) void(^endDateTimeblock)(void);
- (void)callEndDateTime:(void(^)(void))block;

@property (weak, nonatomic) IBOutlet UITextField *textFiledPlannedQuantity;

@property (nonatomic,copy) void(^textFiledPlannedQuantityblock)(NSString *);
- (void)callTextFiledPlannedQuantity:(void(^)(NSString *))block;

@end

NS_ASSUME_NONNULL_END
