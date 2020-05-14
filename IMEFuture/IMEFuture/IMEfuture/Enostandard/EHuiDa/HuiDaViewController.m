//
//  HuiDaViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "HuiDaViewController.h"
#import "VoHeader.h"


@interface HuiDaViewController () <UITextViewDelegate>{
    UILabel *_labelTextView;
    BOOL _haveE;
    BOOL _haveT;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation HuiDaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [self initUI];
    
    
    _haveE = NO;
    _haveT = NO;
    
    /*
    for (NSString *stringType in _arrayType) {
        if ([stringType isEqualToString:@"E"]) {
            _haveE = YES;
            break;
        }
    }
    for (NSString *stringType in _arrayType) {
        if ([stringType isEqualToString:@"T"]) {
            _haveT = YES;
            break;
        }
    }
     */

}

- (void)initUI {
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, 0.5)];
    labelLine.backgroundColor = colorRGB(221, 221, 221);
    [self.view addSubview:labelLine];
    
    UILabel *labelLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, _height_NavBar+46-0.5, kMainW, 0.5)];
    labelLine1.backgroundColor = colorRGB(221, 221, 221);
    [self.view addSubview:labelLine1];
    self.textViewHuiDa.delegate = self;
    
    _labelTextView = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, kMainW-20, 17)];
    _labelTextView.font = [UIFont systemFontOfSize:17];
    _labelTextView.textColor = colorRGB(177, 177, 177);
    _labelTextView.text = @"请填写回答内容";
    [_textViewHuiDa addSubview:_labelTextView];
    self.labelWenTi.text = [NSString stringWithFormat:@"(%@)%@",self.inquiryOrderQ.partName,self.inquiryOrderQ.content];
    
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        _labelTextView.hidden = YES;
    } else {
        _labelTextView.hidden = NO;
    }
}

- (IBAction)buttonTiJiao:(UIButton *)sender {
    if (_haveE == YES) {
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        postEntityBean.memberId = loginModel.memberId;
        InquiryOrderQA *inquiryOrderQA = [[InquiryOrderQA alloc] init];
        inquiryOrderQA.inquiryOrderId = self.inquiryOrderQ.inquiryOrderId;
        inquiryOrderQA.inquiryOrderItemId = self.inquiryOrderQ.inquiryOrderItemId;//需要选择的
        inquiryOrderQA.partName = self.inquiryOrderQ.partName;//需要选择的
        inquiryOrderQA.lineNumber = self.inquiryOrderQ.lineNumber;//需要选择的
        inquiryOrderQA.memberId = loginModel.memberId;
        inquiryOrderQA.content = _textViewHuiDa.text;
        inquiryOrderQA.qaType = [NSNumber numberWithInteger:1];
        inquiryOrderQA.relatedFlag = self.inquiryOrderQ.qaId;
        postEntityBean.entity = inquiryOrderQA.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
//        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_qa_answerEpQa parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            [self.navigationController popViewControllerAnimated:YES];
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"回答成功"];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"回答失败"];
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
        
    } else {
        
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        postEntityBean.memberId = loginModel.memberId;
        InquiryOrderQA *inquiryOrderQA = [[InquiryOrderQA alloc] init];
        inquiryOrderQA.inquiryOrderId = self.inquiryOrderQ.inquiryOrderId;
        inquiryOrderQA.inquiryOrderItemId = self.inquiryOrderQ.inquiryOrderItemId;//需要选择的
        inquiryOrderQA.partName = self.inquiryOrderQ.partName;//需要选择的
        inquiryOrderQA.lineNumber = self.inquiryOrderQ.lineNumber;//需要选择的
        inquiryOrderQA.memberId = loginModel.memberId;
        inquiryOrderQA.content = _textViewHuiDa.text;
        inquiryOrderQA.qaType = [NSNumber numberWithInteger:1];
        inquiryOrderQA.relatedFlag = self.inquiryOrderQ.qaId;
        postEntityBean.entity = inquiryOrderQA.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
//        NSLog(@"%@",dic);
        
        [HttpMamager postRequestWithURLString:DYZ_qa_answerMyQa parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            [self.navigationController popViewControllerAnimated:YES];
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"回答成功"];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"回答失败"];
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    }
}

- (IBAction)back:(UIButton *)sender {
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
