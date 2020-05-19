//
//  ECTGSPingJiaViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ECTGSPingJiaViewController1.h"
#import "VoHeader.h"
#import "ECTGSPingJiaCell.h"
#import "ECTGSPingJiaCell1.h"



@interface ECTGSPingJiaViewController1 () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray *_arrayPurchase;
    NSArray *_arrayQualityComWeight;//质量类 权重
    
    NSArray *_arrayScore;
    
    NSString *_quScoreTemp1;
    NSString *_quScore1;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *viewPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation ECTGSPingJiaViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _viewPicker.hidden = YES;
    _viewPicker.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    UITapGestureRecognizer *tapCancel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureCancel:)];
    [_viewPicker addGestureRecognizer:tapCancel];
    
    MemberResBean *member = [GlobalSettingManager shareGlobalSettingManager].member;
    _arrayQualityComWeight = @[member.enterpriseInfo.comWeight5?member.enterpriseInfo.comWeight5:@"--"];
    _arrayPurchase = @[@"产品质量"];
    
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
    
    _quScore1 = [self.enterpriseCommentSuper.quScore1 stringValue];
}

- (void)tapSelector:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayPurchase.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != _arrayPurchase.count) {
        ECTGSPingJiaCell *eCTGSPingJiaCell = [tableView dequeueReusableCellWithIdentifier:@"eCTGSPingJiaCell" forIndexPath:indexPath];
        eCTGSPingJiaCell.label0.text = _arrayPurchase[indexPath.row];
        eCTGSPingJiaCell.label1.text = [NSString stringWithFormat:@"(权重:%@%@)",_arrayQualityComWeight[indexPath.row],@"%"];
        
        if (indexPath.row == 0) {
            if (self.enterpriseCommentSuper.quScore1) {
                [eCTGSPingJiaCell.button0 setTitle:[NSString stringWithFormat:@"%@分",[self.enterpriseCommentSuper.quScore1 stringValue]] forState:UIControlStateNormal];
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
        eCTGSPingJiaCell1.textView.text = self.enterpriseCommentSuper.content2?self.enterpriseCommentSuper.content2:@"暂无备注";
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
    self.enterpriseCommentSuper.content2 = textView.text;
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
        _quScore1 = _quScoreTemp1?_quScoreTemp1:_quScore1;
        self.enterpriseCommentSuper.quScore1 = [NSNumber numberWithDouble:[_quScore1 doubleValue]];
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
    
    MemberResBean *member = [GlobalSettingManager shareGlobalSettingManager].member;
    
    enterpriseComment.srManufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    enterpriseComment.srEnterpriseName = member.enterpriseInfo.epName;
    enterpriseComment.srMemberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    
    enterpriseComment.trManufacturerId = self.enterpriseRelationSuperSuper.passiveEnterprise.manufacturerId;
    enterpriseComment.trEnterpriseName = self.enterpriseRelationSuperSuper.passiveEnterprise.enterpriseName;
    enterpriseComment.commentStatus = [NSNumber numberWithInteger:0];
    
    enterpriseComment.content2 = self.enterpriseCommentSuper.content2;
    enterpriseComment.quScore1 = [NSNumber numberWithDouble:[_quScore1 doubleValue]];
    
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
    enterpriseComment.content2 = self.enterpriseCommentSuper.content2;
    enterpriseComment.quScore1 = [NSNumber numberWithDouble:[_quScore1 doubleValue]];
    
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
        _quScoreTemp1 = [_arrayScore objectAtIndex:row];
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
