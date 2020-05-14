//
//  ECTGSPingJiaViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ECTGSPingJiaViewController.h"
#import "VoHeader.h"
#import "ECTGSPingJiaCell.h"
#import "ECTGSPingJiaCell1.h"


@interface ECTGSPingJiaViewController () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray *_arrayPurchase;
    NSArray *_arrayPurchaseComWeight;//采购类 权重
    
    NSArray *_arrayScore;
    
    NSString *_puScoreTemp;
    NSString *_puScoreTemp1;
    NSString *_puScoreTemp2;
    NSString *_puScoreTemp3;
    NSString *_puScore;
    NSString *_puScore1;
    NSString *_puScore2;
    NSString *_puScore3;
    
    
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *viewPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation ECTGSPingJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    _viewPicker.hidden = YES;
    _viewPicker.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    UITapGestureRecognizer *tapCancel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureCancel:)];
    [_viewPicker addGestureRecognizer:tapCancel];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    Member *memberModel = [Member mj_objectWithKeyValues:loginModel.member];
    _arrayPurchaseComWeight = @[memberModel.enterpriseInfo.comWeight1?memberModel.enterpriseInfo.comWeight1:@"--",memberModel.enterpriseInfo.comWeight2?memberModel.enterpriseInfo.comWeight2:@"--",memberModel.enterpriseInfo.comWeight3?memberModel.enterpriseInfo.comWeight3:@"--",memberModel.enterpriseInfo.comWeight4?memberModel.enterpriseInfo.comWeight4:@"--"];
    _arrayPurchase = @[@"报价及时性及配合",@"报价专业性",@"加急事项的处理能力",@"交货及时率"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ECTGSPingJiaCell" bundle:nil] forCellReuseIdentifier:@"eCTGSPingJiaCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ECTGSPingJiaCell1" bundle:nil] forCellReuseIdentifier:@"eCTGSPingJiaCell1"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [self.tableView addGestureRecognizer:tap];
    
    _arrayScore = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    if (!self.enterpriseCommentSuper) {
        self.enterpriseCommentSuper = [[EnterpriseComment alloc] init];
    }
    
    _puScore = [self.enterpriseCommentSuper.puScore stringValue];
    _puScore1 = [self.enterpriseCommentSuper.puScore1 stringValue];
    _puScore2 = [self.enterpriseCommentSuper.puScore2 stringValue];
    _puScore3 = [self.enterpriseCommentSuper.puScore3 stringValue];
    
}

- (void)tapSelector:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 0;
    } else {
        self.tableViewBottom.constant = rect.size.height;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayPurchase.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != _arrayPurchase.count) {
        ECTGSPingJiaCell *eCTGSPingJiaCell = [tableView dequeueReusableCellWithIdentifier:@"eCTGSPingJiaCell" forIndexPath:indexPath];
        eCTGSPingJiaCell.label0.text = _arrayPurchase[indexPath.row];
        eCTGSPingJiaCell.label1.text = [NSString stringWithFormat:@"(权重:%@%@)",_arrayPurchaseComWeight[indexPath.row],@"%"];
        if (indexPath.row == 0) {
            if (self.enterpriseCommentSuper.puScore) {
                [eCTGSPingJiaCell.button0 setTitle:[NSString stringWithFormat:@"%@分",[self.enterpriseCommentSuper.puScore stringValue]] forState:UIControlStateNormal];
            } else {
                [eCTGSPingJiaCell.button0 setTitle:@"请选择" forState:UIControlStateNormal];
            }
        }
        if (indexPath.row == 1) {
            if (self.enterpriseCommentSuper.puScore1) {
                [eCTGSPingJiaCell.button0 setTitle:[NSString stringWithFormat:@"%@分",[self.enterpriseCommentSuper.puScore1 stringValue]] forState:UIControlStateNormal];
            } else {
                [eCTGSPingJiaCell.button0 setTitle:@"请选择" forState:UIControlStateNormal];
            }
        }
        if (indexPath.row == 2) {
            if (self.enterpriseCommentSuper.puScore2) {
                [eCTGSPingJiaCell.button0 setTitle:[NSString stringWithFormat:@"%@分",[self.enterpriseCommentSuper.puScore2 stringValue]] forState:UIControlStateNormal];
            } else {
                [eCTGSPingJiaCell.button0 setTitle:@"请选择" forState:UIControlStateNormal];
            }
        }
        if (indexPath.row == 3) {
            if (self.enterpriseCommentSuper.puScore3) {
                [eCTGSPingJiaCell.button0 setTitle:[NSString stringWithFormat:@"%@分",[self.enterpriseCommentSuper.puScore3 stringValue]] forState:UIControlStateNormal];
            } else {
                [eCTGSPingJiaCell.button0 setTitle:@"请选择" forState:UIControlStateNormal];
            }
        }
        [eCTGSPingJiaCell.button0 addTarget:self action:@selector(selectScore:) forControlEvents:UIControlEventTouchUpInside];
        eCTGSPingJiaCell.button0.tag = indexPath.row;
        return eCTGSPingJiaCell;
    } else {
        ECTGSPingJiaCell1 *eCTGSPingJiaCell1 = [tableView dequeueReusableCellWithIdentifier:@"eCTGSPingJiaCell1" forIndexPath:indexPath];
        eCTGSPingJiaCell1.textView.delegate = self;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, CGRectGetWidth(eCTGSPingJiaCell1.textView.frame), 16)];
        label.textColor = colorRGB(177, 177, 177);
        label.font = [UIFont systemFontOfSize:17];
        label.tag = 19921125;
        label.text = @"请输入备注内容";
        [eCTGSPingJiaCell1.textView addSubview:label];
        eCTGSPingJiaCell1.textView.text = self.enterpriseCommentSuper.content?self.enterpriseCommentSuper.content:@"暂无备注";
        label.hidden = YES;
        return eCTGSPingJiaCell1;
    }
}

#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    UILabel *label = [textView viewWithTag:19921125];
    if (textView.text.length > 0) {
        label.hidden = YES;
    } else {
        label.hidden = NO;
    }
    self.enterpriseCommentSuper.content = textView.text;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != _arrayPurchase.count) {
        return 65;
    } else {
        return 85;
    }
}

- (IBAction)buttonSubmit:(UIButton *)sender {
    if ([_returnCode isEqualToString:@"-99"]) {
        [self initRequestEnterpriseCommentAddEpComment];
    }
    if ([_returnCode isEqualToString:@"0"]) {
        [self initRequestEnterpriseCommentUpdateEpComment];
    }
}

- (IBAction)buttonCancel:(UIButton *)sender {
    _viewPicker.hidden = YES;
}
- (void)tapGestureCancel:(UITapGestureRecognizer *)tap {
    _viewPicker.hidden = YES;
}
- (IBAction)buttonFinish:(UIButton *)sender {
    _viewPicker.hidden = YES;
    if (_pickerView.tag == 0) {
        _puScore = _puScoreTemp?_puScoreTemp:_puScore;
        self.enterpriseCommentSuper.puScore = [NSNumber numberWithDouble:[_puScore doubleValue]];
    }
    if (_pickerView.tag == 1) {
        _puScore1 = _puScoreTemp1?_puScoreTemp1:_puScore1;
        self.enterpriseCommentSuper.puScore1 = [NSNumber numberWithDouble:[_puScore1 doubleValue]];
    }
    if (_pickerView.tag == 2) {
        _puScore2 = _puScoreTemp2?_puScoreTemp2:_puScore2;
        self.enterpriseCommentSuper.puScore2 = [NSNumber numberWithDouble:[_puScore2 doubleValue]];
    }
    if (_pickerView.tag == 3) {
        _puScore3 = _puScoreTemp3?_puScoreTemp3:_puScore3;
        self.enterpriseCommentSuper.puScore3 = [NSNumber numberWithDouble:[_puScore3 doubleValue]];
    }
    [self.tableView reloadData];
}

- (void)selectScore:(UIButton *)sender {
    _viewPicker.hidden = NO;
    _pickerView.tag = sender.tag;
}
- (void)initRequestEnterpriseCommentAddEpComment{
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    EnterpriseComment *enterpriseComment = [[EnterpriseComment alloc] init];
    enterpriseComment.coMonth = [NSNumber numberWithInteger:[_stringMonth integerValue]];
    enterpriseComment.coYear = [NSNumber numberWithInteger:[_stringYear integerValue]];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    Member *member = [Member mj_objectWithKeyValues:loginModel.member];
    
    enterpriseComment.srManufacturerId = loginModel.manufacturerId;
    enterpriseComment.srEnterpriseName = member.enterpriseInfo.enterpriseName;
    enterpriseComment.srMemberId = loginModel.memberId;
    
    enterpriseComment.trManufacturerId = self.enterpriseRelationSuperSuper.passiveEnterprise.manufacturerId;
    enterpriseComment.trEnterpriseName = self.enterpriseRelationSuperSuper.passiveEnterprise.enterpriseName;
    enterpriseComment.commentStatus = [NSNumber numberWithInteger:0];
    
    enterpriseComment.content = self.enterpriseCommentSuper.content;
    enterpriseComment.puScore = [NSNumber numberWithDouble:[_puScore doubleValue]];
    enterpriseComment.puScore1 = [NSNumber numberWithDouble:[_puScore1 doubleValue]];
    enterpriseComment.puScore2 = [NSNumber numberWithDouble:[_puScore2 doubleValue]];
    enterpriseComment.puScore3 = [NSNumber numberWithDouble:[_puScore3 doubleValue]];
    
    postEntityBean.entity = enterpriseComment.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    
    [HttpMamager postRequestWithURLString:DYZ_enterpriseComment_addEpComment parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"评价成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"评价失败"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)initRequestEnterpriseCommentUpdateEpComment{
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    EnterpriseComment *enterpriseComment = [[EnterpriseComment alloc] init];
    enterpriseComment.coMonth = [NSNumber numberWithInteger:[_stringMonth integerValue]];
    enterpriseComment.coYear = [NSNumber numberWithInteger:[_stringYear integerValue]];
    
    enterpriseComment.epCommentId = self.enterpriseCommentSuper.epCommentId;
    enterpriseComment.content = self.enterpriseCommentSuper.content;
    enterpriseComment.puScore = [NSNumber numberWithDouble:[_puScore doubleValue]];
    enterpriseComment.puScore1 = [NSNumber numberWithDouble:[_puScore1 doubleValue]];
    enterpriseComment.puScore2 = [NSNumber numberWithDouble:[_puScore2 doubleValue]];
    enterpriseComment.puScore3 = [NSNumber numberWithDouble:[_puScore3 doubleValue]];
    
    postEntityBean.entity = enterpriseComment.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    
    [HttpMamager postRequestWithURLString:DYZ_enterpriseComment_updateEpComment parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"评价成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"评价失败"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (IBAction)left:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arrayScore.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 0) {
        _puScoreTemp = [_arrayScore objectAtIndex:row];
    }
    if (pickerView.tag == 1) {
        _puScoreTemp1 = [_arrayScore objectAtIndex:row];
    }
    if (pickerView.tag == 2) {
        _puScoreTemp2 = [_arrayScore objectAtIndex:row];
    }
    if (pickerView.tag == 3) {
        _puScoreTemp3 = [_arrayScore objectAtIndex:row];
    }
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _arrayScore[row];
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
