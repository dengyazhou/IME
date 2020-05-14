//
//  XuanZeXunPanGongYiVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/2/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "XuanZeXunPanGongYiVC.h"
#import "VoHeader.h"

#import "XunPanGongYiHeader.h"
#import "XunPanGongYiCell.h"


@interface XuanZeXunPanGongYiVC () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayArrayDataName;
    NSMutableArray *_arrayArrayData;//大数组，里面装的是小数组
    
    NSMutableArray *_arrayYesOrNo;
    
    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation XuanZeXunPanGongYiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    if (self.arrayTempBaseTag.count > 0) {
        
    } else {
        self.arrayTempBaseTag = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"XunPanGongYiHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"xunPanGongYiHeader"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XunPanGongYiCell" bundle:nil] forCellReuseIdentifier:@"xunPanGongYiCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    [self initRequest];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XunPanGongYiHeader *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"xunPanGongYiHeader"];
    BaseTag *baseTag = _arrayArrayDataName[section];
    view.label0.text = baseTag.name;
    
    BOOL isNoSelect = NO;
    for (BaseTag *base in self.arrayTempBaseTag) {
        if ([baseTag.baseTagId integerValue] == [base.baseTagId integerValue]) {
            isNoSelect = YES;
        }
    }
    
    if (isNoSelect == NO) {
        view.imageView1.image = [UIImage imageNamed:@"multiselect_unchecked"];
    } else {
        view.imageView1.image = [UIImage imageNamed:@"multiselect_selected"];
    }
    
    view.button0.tag = section;
    [view.button0 addTarget:self action:@selector(button0Click:) forControlEvents:UIControlEventTouchUpInside];
    
    view.button1.tag = section;
    [view.button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *stringYesOrNo = _arrayYesOrNo[section];
    if ([stringYesOrNo isEqualToString:@"NO"]) {
        [view.button1 setImage:[UIImage imageNamed:@"icon_drop_down"] forState:UIControlStateNormal];
    } else if ([stringYesOrNo isEqualToString:@"YES"]) {
        [view.button1 setImage:[UIImage imageNamed:@"icon_retract"] forState:UIControlStateNormal];
    }
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 0.5)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kMainW-15, 0.5)];
    viewLine.backgroundColor = colorRGB(221, 221, 221);
    [view addSubview:viewLine];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrayArrayData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *array = _arrayArrayData[section];
    NSString *stringYesOrNo = _arrayYesOrNo[section];
    if ([stringYesOrNo isEqualToString:@"YES"]) {
        return array.count;
    } else if ([stringYesOrNo isEqualToString:@"NO"]) {
        return 0;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XunPanGongYiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xunPanGongYiCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BaseTag *baseTag = _arrayArrayData[indexPath.section][indexPath.row];
    cell.label0.text = baseTag.name;
    
    BOOL isNoSelect = NO;
    for (BaseTag *base in self.arrayTempBaseTag) {
        if ([baseTag.baseTagId integerValue] == [base.baseTagId integerValue]) {
            isNoSelect = YES;
        }
    }
    
    if (isNoSelect == NO) {
        cell.imageView1.image = [UIImage imageNamed:@"multiselect_unchecked"];
    } else {
        cell.imageView1.image = [UIImage imageNamed:@"multiselect_selected"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL isNoSelect = NO;
    NSInteger index = 999;//随便取的默认值
    
    BaseTag *baseTag = _arrayArrayData[indexPath.section][indexPath.row];
    for (NSInteger i = 0; i < self.arrayTempBaseTag.count; i++) {
        BaseTag *base = self.arrayTempBaseTag[i];
        if ([baseTag.baseTagId integerValue] == [base.baseTagId integerValue]) {
            isNoSelect = YES;
            index = i;
        }
    }
    if (isNoSelect == NO) {
        BOOL isNoSelect1 = NO;
        for (BaseTag *base1 in self.arrayTempBaseTag) {
            if ([baseTag.upId integerValue] == [base1.baseTagId integerValue]) {
                isNoSelect1 = YES;
            }
        }
        if (isNoSelect1 == NO) {
            if (self.arrayTempBaseTag.count >= 9) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"最多选10个工艺"];
                return;
            }
            [self.arrayTempBaseTag addObject:baseTag];
            for (BaseTag *base2 in _arrayArrayDataName) {
                if ([baseTag.upId integerValue] == [base2.baseTagId integerValue]) {
                    [self.arrayTempBaseTag addObject:base2];
                }
            }
        } else {
            if (self.arrayTempBaseTag.count >= 10) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"最多选10个工艺"];
                return;
            }
            [self.arrayTempBaseTag addObject:baseTag];
        }
    } else {
        [self.arrayTempBaseTag removeObjectAtIndex:index];
    }
    
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)button0Click:(UIButton *)sender {
    BOOL isNoSelect = NO;
    NSInteger index = 999;//随便取的默认值
    
    BaseTag *baseTag = _arrayArrayDataName[sender.tag];

    for (NSInteger i = 0; i < self.arrayTempBaseTag.count; i++) {
        BaseTag *base = self.arrayTempBaseTag[i];
        if ([baseTag.baseTagId integerValue] == [base.baseTagId integerValue]) {
            isNoSelect = YES;
            index = i;
        }
    }
    if (isNoSelect == NO) {
        if (self.arrayTempBaseTag.count >= 10) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"最多选10个工艺"];
            return;
        }
        [self.arrayTempBaseTag addObject:baseTag];
    } else {
        BaseTag *base1 = self.arrayTempBaseTag[index];
        [self.arrayTempBaseTag removeObjectAtIndex:index];
        
        NSMutableArray *arrayTem = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (BaseTag *base2 in self.arrayTempBaseTag) {
            if ([base1.baseTagId integerValue] == [base2.upId integerValue]) {
                [arrayTem addObject:base2];
            }
        }
        
        for (BaseTag *base3 in arrayTem) {
            [self.arrayTempBaseTag removeObject:base3];
        }
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)button1Click:(UIButton *)sender {
    NSString *stringYesOrNo = _arrayYesOrNo[sender.tag];
    if ([stringYesOrNo isEqualToString:@"YES"]) {
        [_arrayYesOrNo replaceObjectAtIndex:sender.tag withObject:@"NO"];
    } else if ([stringYesOrNo isEqualToString:@"NO"]) {
        [_arrayYesOrNo replaceObjectAtIndex:sender.tag withObject:@"YES"];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 确认
- (IBAction)buttonQueRen:(id)sender {
    self.buttonBackBlock(self.arrayTempBaseTag);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    BaseTag *baseTag = [[BaseTag alloc] init];
    postEntityBean.entity = baseTag.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_tag_getlist parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = YES;
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            _arrayArrayDataName = [[NSMutableArray alloc] initWithCapacity:0];
            _arrayYesOrNo = [[NSMutableArray alloc] initWithCapacity:0];
            _arrayArrayData = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in returnListBean.list) {
                BaseTag *baseTag = [BaseTag mj_objectWithKeyValues:dic];
                if ([baseTag.upId integerValue] == 0) {
                    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
                    for (NSDictionary *dic1 in returnListBean.list) {
                        BaseTag *baseTag1 = [BaseTag mj_objectWithKeyValues:dic1];
                        if ([baseTag.baseTagId integerValue] == [baseTag1.upId integerValue]) {
                            [array addObject:baseTag1];
                        }
                    }
                    [_arrayArrayDataName addObject:baseTag];
                    [_arrayYesOrNo addObject:@"NO"];
                    [_arrayArrayData addObject:array];
                }
            }
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
