//
//  TpfBaoGongReasonView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/20.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "TpfBaoGongReasonView.h"
#import "Header.h"
#import "MyAlertCenter.h"


#import "ShutDownCauseVo.h"
#import <Masonry.h>
#import "UIColor+DYZColorChange.h"


@interface TpfBaoGongReasonView() <UITableViewDelegate,UITableViewDataSource>{
    NSArray *_dataArray;
    NSInteger _index;//默认值是99 表示没有选择原因
}

@property (nonatomic,strong) UIView *viewWhiteBG;
@property (nonatomic,strong) UIView *view0;
@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) UIView *view2;

@end

@implementation TpfBaoGongReasonView

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        _index = 99;
        _dataArray = dataArray;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [self addSubview:self.viewWhiteBG];
        
        [self.viewWhiteBG addSubview:self.view0];
        [self.viewWhiteBG addSubview:self.view1];
        [self.viewWhiteBG addSubview:self.view2];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.viewWhiteBG.bounds = CGRectMake(0, 0, kMainW-(kMainW/375.0*53)*2, CGRectGetMaxY(self.view2.frame));
    self.viewWhiteBG.center = self.center;
    
}

- (UIView *)viewWhiteBG {
    if (!_viewWhiteBG) {
        _viewWhiteBG = [[UIView alloc] init];
        _viewWhiteBG.bounds = CGRectMake(0, 0, kMainW-(kMainW/375.0*53)*2, 0);//366
        _viewWhiteBG.layer.cornerRadius = 10;
        _viewWhiteBG.layer.masksToBounds = YES;
        _viewWhiteBG.backgroundColor = [UIColor whiteColor];
    }
    return _viewWhiteBG;
}

- (UIView *)view0 {
    if (!_view0) {
        _view0 = [[UIView alloc] init];
        _view0.frame = CGRectMake(0, 0, CGRectGetWidth(self.viewWhiteBG.frame), 55);
        _view0.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_view0.frame), CGRectGetHeight(_view0.frame))];
        [button setImage:[UIImage imageNamed:@"warning"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"warning"] forState:UIControlStateHighlighted];//为了点击下去保持图片不变色
        [button setTitle:@"  确定要暂停工作吗？" forState:UIControlStateNormal];
        [button setTitleColor:colorRGB(245, 47, 62) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [_view0 addSubview:button];
        
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(_view0.frame)-0.5, CGRectGetWidth(self.viewWhiteBG.frame)-20, 0.5)];
        viewLine.backgroundColor = colorRGB(221, 221, 221);
        [_view0 addSubview:viewLine];
    }
    return _view0;
}

- (UIView *)view1 {
    if (!_view1) {
        _view1 = [[UIView alloc] init];
        CGFloat h = _dataArray.count*44>242?242:_dataArray.count*44;
        _view1.frame = CGRectMake(0, CGRectGetMaxY(self.view0.frame), CGRectGetWidth(self.viewWhiteBG.frame), h);
        _view1.backgroundColor = [UIColor redColor];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_view1.frame), CGRectGetHeight(_view1.frame)) style:UITableViewStylePlain];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        BOOL isYes = _dataArray.count*44>242?YES:NO;
        tableView.scrollEnabled = isYes;
        [_view1 addSubview:tableView];
    }
    return _view1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:@"unchecked"];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#646464"];
    if (_index == indexPath.row) {
        cell.imageView.image = [UIImage imageNamed:@"checked"];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#F52F3E"];
    }
    ShutDownCauseVo *model = _dataArray[indexPath.row];
    
    cell.textLabel.text = model.shutDownCauseText;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _index = indexPath.row;
    [tableView reloadData];
}

- (UIView *)view2 {
    if (!_view2) {
        _view2 = [[UIView alloc] init];
        _view2.frame = CGRectMake(0, CGRectGetMaxY(self.view1.frame), CGRectGetWidth(self.viewWhiteBG.frame), 69);
        _view2.backgroundColor = [UIColor whiteColor];
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_view2.frame), 0.5)];
        viewLine.backgroundColor = colorRGB(221, 221, 221);
        [_view2 addSubview:viewLine];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.backgroundColor = [UIColor colorWithHexString:@"#007AFE"];
        button1.layer.cornerRadius = 2;
        button1.titleLabel.font = [UIFont systemFontOfSize:17];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setTitle:@"确认" forState:UIControlStateNormal];
        [_view2 addSubview:button1];
        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_view2);
            make.left.mas_offset(20);
            make.width.mas_equalTo((CGRectGetWidth(self.viewWhiteBG.frame)-14-20*2)/2.0);
            make.height.mas_equalTo(40);
        }];
        [button1 addTarget:self action:@selector(button1Confirm:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.layer.cornerRadius = 2;
        button2.layer.borderColor = [UIColor colorWithHexString:@"#007AFE"].CGColor;
        button2.layer.borderWidth = 1;
        button2.titleLabel.font = [UIFont systemFontOfSize:17];
        [button2 setTitleColor:[UIColor colorWithHexString:@"#007AFE"] forState:UIControlStateNormal];
        [button2 setTitle:@"取消" forState:UIControlStateNormal];
        [_view2 addSubview:button2];
        [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(button1);
            make.trailing.mas_equalTo(-20);
            make.width.and.height.equalTo(button1);
        }];
        [button2 addTarget:self action:@selector(button2Cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _view2;
}

- (void)button1Confirm:(UIButton *)sender {
    if (_index == 99) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择暂停原因"];
        return;
    }
    
    id model = _dataArray[_index];
    self.block1Confirm(model);
    [self removeFromSuperview];
}

- (void)blockConfirm:(void (^)(id))block {
    self.block1Confirm = block;
}

- (void)button2Cancel:(UIButton *)sender {
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
