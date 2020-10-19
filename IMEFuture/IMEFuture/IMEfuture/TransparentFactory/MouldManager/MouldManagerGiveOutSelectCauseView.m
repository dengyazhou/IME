//
//  MouldManagerGiveOutSelectCauseView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/10/14.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "MouldManagerGiveOutSelectCauseView.h"

#import <ReactiveObjC.h>

@interface MouldManagerGiveOutSelectCauseView () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *tableViewBg;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation MouldManagerGiveOutSelectCauseView

+ (instancetype)loadMyView {
    return [[[NSBundle mainBundle] loadNibNamed:@"MouldManagerGiveOutSelectCauseView" owner:self options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.backgroundColor = [UIColor redColor];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    UITapGestureRecognizer *bgViewTap = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:bgViewTap];
    bgViewTap.delegate = self;
    
    @weakify(self);
    [bgViewTap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        
        self.hidden = true;
    }];
    

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.tableViewBg]) {
        return NO;
    }
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ModelReturnCauseVo *model = self.dataArray[indexPath.row];
    
    cell.textLabel.text = model.causeText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ModelReturnCauseVo *model = self.dataArray[indexPath.row];
    self.selectBlock(self.index, model);
    self.hidden = YES;
}

- (void)loadTableWithArray:(NSMutableArray *)dataArray {
    self.dataArray = dataArray;
    [self.tableView reloadData];
}



- (void)callBackSelectTableViewIndex:(void (^)(NSInteger, ModelReturnCauseVo * _Nonnull))block {
    self.selectBlock = block;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
