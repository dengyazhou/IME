//
//  CiPingChuLiFangShiViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/26.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "CiPingChuLiFangShiViewController09.h"
#import "VoHeader.h"

#import "CiPingChuLiFangShiCell.h"
#import "CiPingChuLiModel.h"
#import "UIViewXuanZeChuLiFangShi.h"
#import "UIViewXuanZeChuLiType.h"

//unType
@interface CiPingChuLiFangShiViewController09 () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate> {
    NSMutableArray *_arrayCiPingChuLiModel;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;


@property (nonatomic, strong) NSMutableArray *arrayDataInspectQReasonList;

@end

@implementation CiPingChuLiFangShiViewController09

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CiPingChuLiFangShiCell" bundle:nil] forCellReuseIdentifier:@"ciPingChuLiFangShiCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.label0.text = [NSString stringWithFormat:@"%@",self.inspectOrderItemVo.canInspectNum];
    self.label1.text = [NSString stringWithFormat:@"%@",self.inspectOrderItemVo.qualityQuantity];
    self.label2.text = [NSString stringWithFormat:@"%@",self.inspectOrderItemVo.defectiveQuantity];
    
    _arrayCiPingChuLiModel = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i=0; i<4; i++) {
        if ([self.inspectOrderItemVo valueForKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]]) {
            CiPingChuLiModel *model = [[CiPingChuLiModel alloc] init];
            model.defectiveOperateType = [self.inspectOrderItemVo valueForKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]];
            model.reissueNum = [self.inspectOrderItemVo valueForKey:[NSString stringWithFormat:@"reissueNum%ld",i+1]];
            model.unType = [self.inspectOrderItemVo valueForKey:[NSString stringWithFormat:@"unType%ld",i+1]];
            model.unReason = [self.inspectOrderItemVo valueForKey:[NSString stringWithFormat:@"unReason%ld",i+1]];
            [_arrayCiPingChuLiModel addObject:model];
        } else {
            break;
        }
    }

    
    [self initRequest];
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 65;
    } else {
        self.tableViewBottom.constant = rect.size.height;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayCiPingChuLiModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 244;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CiPingChuLiFangShiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ciPingChuLiFangShiCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.buttonChuLiFangShi.hidden = YES;
    cell.buttonChuLiFangShiQingXuanZe.hidden = YES;
    
    
    cell.labelBeiZhu.hidden = YES;
    
    CiPingChuLiModel *model = _arrayCiPingChuLiModel[indexPath.row];
    if (model.unReason.length > 0) {
        cell.labelBeiZhu.hidden = YES;
    } else {
        cell.labelBeiZhu.hidden = NO;
    }
    
    cell.label0.text = [NSString stringWithFormat:@"处理方式%ld",indexPath.row+1];
    if (model.defectiveOperateType) {
        cell.buttonChuLiFangShi.hidden = NO;
        [cell.buttonChuLiFangShi setTitle:[NSString stringWithFormat:@"%@",[NSString DefectiveOperateType:model.defectiveOperateType]] forState:UIControlStateNormal];
    } else {
        cell.buttonChuLiFangShiQingXuanZe.hidden = NO;
    }
    cell.textField.text = [model.reissueNum doubleValue]==0?nil:[NSString stringWithFormat:@"%@",model.reissueNum];
    if (model.unType) {

    } else {
        
    }
    
    
    cell.textField1.text = model.unType;
    
    cell.textView.text = [NSString stringWithFormat:@"%@",model.unReason];
    
    cell.buttonShanChu.tag = indexPath.row;
    [cell.buttonShanChu addTarget:self action:@selector(buttonClickShanChu:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.buttonChuLiFangShi.tag = indexPath.row;
    [cell.buttonChuLiFangShi addTarget:self action:@selector(buttonClickChuLiFangShi:) forControlEvents:UIControlEventTouchUpInside];
    cell.buttonChuLiFangShiQingXuanZe.tag = indexPath.row;
    [cell.buttonChuLiFangShiQingXuanZe addTarget:self action:@selector(buttonClickChuLiFangShi:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.textField.tag = indexPath.row;
    [cell.textField addTarget:self action:@selector(textFieldEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    cell.textField.inputAccessoryView = [self addToolbar];
    
    cell.textField1.tag = indexPath.row;
    [cell.textField1 addTarget:self action:@selector(textField1EditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    cell.textField1.inputAccessoryView = [self addToolbar];
    
    cell.buttonTpye.tag = indexPath.row;
    [cell.buttonTpye addTarget:self action:@selector(buttonClickChuLiType:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.textView.tag = indexPath.row;
    cell.textView.delegate = self;
    cell.textView.inputAccessoryView = [self addToolbar];
    
    return cell;
}

//处理方式
- (void)buttonClickChuLiFangShi:(UIButton *)sender {
    CiPingChuLiModel *model = _arrayCiPingChuLiModel[sender.tag];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeChuLiFangShi" owner:self options:nil];
    UIViewXuanZeChuLiFangShi *viewXZWL = [nib objectAtIndex:0];
    viewXZWL.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewXZWL];
    viewXZWL.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [viewXZWL initPickerViewButtonClick:^(NSString *string) {
        NSLog(@"%@",string);
        
        model.defectiveOperateType = string;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
}
// 次品类型
- (void)buttonClickChuLiType:(UIButton *)sender {
    CiPingChuLiModel *model = _arrayCiPingChuLiModel[sender.tag];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeChuLiType" owner:self options:nil];
    UIViewXuanZeChuLiType *viewTpey = [nib objectAtIndex:0];
    viewTpey.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewTpey];
    viewTpey.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [viewTpey initPickerViewButtonClick:^(NSString *string) {
        NSLog(@"%@",string);
        model.unType = string;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } withArray:self.arrayDataInspectQReasonList];
}


//数量
- (void)textFieldEditingDidEnd:(UITextField *)sender {
    
    CiPingChuLiModel *model = _arrayCiPingChuLiModel[sender.tag];
    model.reissueNum = [NSNumber numberWithDouble:[sender.text doubleValue]];
    double total = 0;
    for (CiPingChuLiModel *model1 in _arrayCiPingChuLiModel) {
        total =  total + [model1.reissueNum doubleValue];
    }
    
    if (total > [self.inspectOrderItemVo.canInspectNum doubleValue]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"处理零件的数量之和不能超过可验货数量"];
        model.reissueNum = [NSNumber numberWithDouble:[self.inspectOrderItemVo.canInspectNum doubleValue] - (total - [model.reissueNum doubleValue])];
    }
    
    double total123 = 0;
    for (CiPingChuLiModel *model123 in _arrayCiPingChuLiModel) {
        total123 =  total123 + [model123.reissueNum doubleValue];
    }
    self.inspectOrderItemVo.defectiveQuantity = [NSNumber numberWithDouble:total123];
    self.inspectOrderItemVo.qualityQuantity = [NSNumber numberWithDouble:self.inspectOrderItemVo.canInspectNum.doubleValue - self.inspectOrderItemVo.defectiveQuantity.doubleValue];
    self.label0.text = [NSString stringWithFormat:@"%@",self.inspectOrderItemVo.canInspectNum];
    self.label1.text = [NSString stringWithFormat:@"%@",self.inspectOrderItemVo.qualityQuantity];
    self.label2.text = [NSString stringWithFormat:@"%@",self.inspectOrderItemVo.defectiveQuantity];
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

//次品类型
- (void)textField1EditingDidEnd:(UITextField *)sender {
    CiPingChuLiModel *model = _arrayCiPingChuLiModel[sender.tag];
    model.unType = sender.text;
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
//    [self.tableView setContentOffset:CGPointMake(0, 10000)];
}
//备注
- (void)textViewDidChange:(UITextView *)textView {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textView.tag inSection:0];
    CiPingChuLiFangShiCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (textView.text.length > 0) {
        cell.labelBeiZhu.hidden = YES;
    } else {
        cell.labelBeiZhu.hidden = NO;
    }
    
    CiPingChuLiModel *model = _arrayCiPingChuLiModel[textView.tag];
    model.unReason = textView.text;
}

//删除处理方式
- (void)buttonClickShanChu:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否删除该处理方式" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        if (_arrayCiPingChuLiModel.count ==  1) {
//            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"至少有一种次品处理方式"];
//            return;
//        }
        [_arrayCiPingChuLiModel removeObjectAtIndex:sender.tag];
        
        for (NSInteger i=0; i<4; i++) {
            if (i < _arrayCiPingChuLiModel.count) {
                CiPingChuLiModel *model = _arrayCiPingChuLiModel[i];
                [self.inspectOrderItemVo setValue:model.defectiveOperateType forKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]];
                [self.inspectOrderItemVo setValue:model.reissueNum forKey:[NSString stringWithFormat:@"reissueNum%ld",i+1]];
                [self.inspectOrderItemVo setValue:model.unType forKey:[NSString stringWithFormat:@"unType%ld",i+1]];
                [self.inspectOrderItemVo setValue:model.unReason forKey:[NSString stringWithFormat:@"unReason%ld",i+1]];
            } else {
                [self.inspectOrderItemVo setValue:nil forKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]];
                [self.inspectOrderItemVo setValue:nil forKey:[NSString stringWithFormat:@"reissueNum%ld",i+1]];
                [self.inspectOrderItemVo setValue:nil forKey:[NSString stringWithFormat:@"unType%ld",i+1]];
                [self.inspectOrderItemVo setValue:nil forKey:[NSString stringWithFormat:@"unReason%ld",i+1]];
            }
        }
        
        double total123 = 0;
        for (CiPingChuLiModel *model123 in _arrayCiPingChuLiModel) {
            total123 =  total123 + [model123.reissueNum doubleValue];
        }
        self.inspectOrderItemVo.defectiveQuantity = [NSNumber numberWithDouble:total123];
        self.inspectOrderItemVo.qualityQuantity = [NSNumber numberWithDouble:self.inspectOrderItemVo.canInspectNum.doubleValue - self.inspectOrderItemVo.defectiveQuantity.doubleValue];
        self.label0.text = [NSString stringWithFormat:@"%@",self.inspectOrderItemVo.canInspectNum];
        self.label1.text = [NSString stringWithFormat:@"%@",self.inspectOrderItemVo.qualityQuantity];
        self.label2.text = [NSString stringWithFormat:@"%@",self.inspectOrderItemVo.defectiveQuantity];
        
        [self.tableView reloadData];
    }];
    [alertController addAction:action0];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];
}

//新增处理方式
- (IBAction)buttonXinZenChuLiFangShi:(UIButton *)sender {
    if (_arrayCiPingChuLiModel.count < 4) {
        CiPingChuLiModel *model = [[CiPingChuLiModel alloc] init];
        model.defectiveOperateType = nil;
        model.reissueNum = nil;
        model.unType = nil;
        model.unReason = @"";
        [_arrayCiPingChuLiModel addObject:model];
        [self.tableView reloadData];
    } else {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"次品处理方式不能超过4种"];
    }
}

// 确认
- (IBAction)buttonQueRen:(UIButton *)sender {
    for (NSInteger i=0; i<4; i++) {
        if (i < _arrayCiPingChuLiModel.count) {
            CiPingChuLiModel *model = _arrayCiPingChuLiModel[i];
            [self.inspectOrderItemVo setValue:model.defectiveOperateType forKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]];
            [self.inspectOrderItemVo setValue:model.reissueNum forKey:[NSString stringWithFormat:@"reissueNum%ld",i+1]];
            [self.inspectOrderItemVo setValue:model.unType forKey:[NSString stringWithFormat:@"unType%ld",i+1]];
            [self.inspectOrderItemVo setValue:model.unReason forKey:[NSString stringWithFormat:@"unReason%ld",i+1]];
            if (!model.defectiveOperateType) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择处理方式"];
                return;
            }
            if ([model.reissueNum doubleValue] == 0) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请填写数量"];
                return;
            }
            if (model.unType.length <= 0) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请填写次品类型"];
                return;
            }
            if (model.unReason.length <= 0) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请填写不合格原因"];
                return;
            }
        } else {
            [self.inspectOrderItemVo setValue:nil forKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]];
            [self.inspectOrderItemVo setValue:nil forKey:[NSString stringWithFormat:@"reissueNum%ld",i+1]];
            [self.inspectOrderItemVo setValue:nil forKey:[NSString stringWithFormat:@"unType%ld",i+1]];
            [self.inspectOrderItemVo setValue:nil forKey:[NSString stringWithFormat:@"unReason%ld",i+1]];
        }
    }
    
    self.block(self.inspectOrderItemVo);
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIToolbar *)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 38)];
    toolbar.tintColor = colorRGB(0, 168, 255);
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space,bar];
    return toolbar;
}

- (void)textFieldDone {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}


- (IBAction)back:(UIButton *)sender {
    for (NSInteger i=0; i<4; i++) {
        if (i < _arrayCiPingChuLiModel.count) {
            CiPingChuLiModel *model = _arrayCiPingChuLiModel[i];
            [self.inspectOrderItemVo setValue:model.defectiveOperateType forKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]];
            [self.inspectOrderItemVo setValue:model.reissueNum forKey:[NSString stringWithFormat:@"reissueNum%ld",i+1]];
            [self.inspectOrderItemVo setValue:model.unType forKey:[NSString stringWithFormat:@"unType%ld",i+1]];
            [self.inspectOrderItemVo setValue:model.unReason forKey:[NSString stringWithFormat:@"unReason%ld",i+1]];
        } else {
            [self.inspectOrderItemVo setValue:nil forKey:[NSString stringWithFormat:@"defectiveOperateType%ld",i+1]];
            [self.inspectOrderItemVo setValue:nil forKey:[NSString stringWithFormat:@"reissueNum%ld",i+1]];
            [self.inspectOrderItemVo setValue:nil forKey:[NSString stringWithFormat:@"unType%ld",i+1]];
            [self.inspectOrderItemVo setValue:nil forKey:[NSString stringWithFormat:@"unReason%ld",i+1]];
        }
    }
    self.block(self.inspectOrderItemVo);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initRequest{
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    DeliverOrderReqBean *deliverOrderReqBean = [DeliverOrderReqBean new];
    deliverOrderReqBean.upId = @"0";
    postEntityBean.entity = deliverOrderReqBean.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_inspect_qReasonList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            NSMutableArray *arrayTemp = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSInteger i=0; i<returnListBean.list.count; i++) {
                InspectQReasonList *model = [InspectQReasonList mj_objectWithKeyValues:returnListBean.list[i]];
                [arrayTemp addObject:model];
            }
            self.arrayDataInspectQReasonList = arrayTemp;
            
            
            
            
            if (_arrayCiPingChuLiModel.count == 0) {//没有次品处理方式的时候，添加一条默认的
                
                CiPingChuLiModel *model = [[CiPingChuLiModel alloc] init];
                
                model.reissueNum = self.inspectOrderItemVo.canInspectNum;
                self.inspectOrderItemVo.defectiveQuantity = self.inspectOrderItemVo.canInspectNum;
                self.inspectOrderItemVo.qualityQuantity = [NSNumber numberWithDouble:self.inspectOrderItemVo.canInspectNum.doubleValue - self.inspectOrderItemVo.defectiveQuantity.doubleValue];
                self.label0.text = [NSString stringWithFormat:@"%@",self.inspectOrderItemVo.canInspectNum];
                self.label1.text = [NSString stringWithFormat:@"%@",self.inspectOrderItemVo.qualityQuantity];
                self.label2.text = [NSString stringWithFormat:@"%@",self.inspectOrderItemVo.defectiveQuantity];
                
                
                
                model.defectiveOperateType = @"RE";
        //        model.reissueNum = self.inspectOrderItemVo.defectiveQuantity;
                if (self.arrayDataInspectQReasonList.count > 0) {
                    InspectQReasonList *iq = self.arrayDataInspectQReasonList[0];
                    model.unType = iq.name;
                }
               
                model.unReason = @"";
                [_arrayCiPingChuLiModel addObject:model];
                
                [self.tableView reloadData];
            }
            
            
            
        } else {
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
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
