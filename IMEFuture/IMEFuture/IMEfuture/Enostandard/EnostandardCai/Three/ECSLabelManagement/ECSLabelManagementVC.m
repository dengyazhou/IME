//
//  ECSLabelManagementVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/6/30.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ECSLabelManagementVC.h"
#import "VoHeader.h"

@interface ECSLabelManagementVC () {
    BOOL _isDelete;
    
    UIView *_viewLoading;
    UIView *_viewLoading1;//透明
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (nonatomic,strong) NSMutableArray *arrayLabel;
@property (nonatomic,strong) NSMutableArray *arrayTGSupplierTag;

@property (weak, nonatomic) IBOutlet UIButton *buttonEdit;//标签删除、关闭删除

@property (weak, nonatomic) IBOutlet UITextField *textfield;//请输入标签
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;//新增

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewLabel;//装标签

@property (weak, nonatomic) IBOutlet UILabel *lableExplain;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;


@end

@implementation ECSLabelManagementVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (NSMutableArray *)arrayLabel {
    if (!_arrayLabel) {
        _arrayLabel = [NSMutableArray arrayWithCapacity:0];
    }
    return _arrayLabel;
}

- (NSMutableArray *)arrayTGSupplierTag {
    if (!_arrayTGSupplierTag) {
        _arrayTGSupplierTag = [NSMutableArray arrayWithCapacity:0];
    }
    return _arrayTGSupplierTag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    _viewLoading1 = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    _viewLoading1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewLoading1];
    _viewLoading1.hidden = YES;
    
    [self initRequestTgSupplierTagQuerytg];
    
    self.lableExplain.adjustsFontSizeToFitWidth = YES;
    _isDelete = true;
    
    
    
    [self.buttonEdit addTarget:self action:@selector(buttonEditClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.textfield addTarget:self action:@selector(textfieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [self.buttonAdd addTarget:self action:@selector(buttonAddTag:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewLabel)];
    [self.scrollViewLabel addGestureRecognizer:tap];
    
}

- (void)buttonEditClick:(UIButton *)sender {
    if (_isDelete == true) {//删除状态
        [sender setTitle:@" 关闭删除" forState:UIControlStateNormal];
        self.buttonAdd.backgroundColor = colorRGB(204, 204, 204);
        self.buttonAdd.enabled = NO;
        self.textfield.placeholder = @"标签删除时无法添加标签";
        self.textfield.enabled = NO;
        
        self.lableExplain.text = @"删除的标签不能恢复，请谨慎操作";
        self.lableExplain.textColor = [UIColor redColor];
        [self statusDelete];
        
    } else {//正常状态
        [sender setTitle:@" 标签删除" forState:UIControlStateNormal];
        self.buttonAdd.backgroundColor = colorRGB(255, 134, 0);
        self.buttonAdd.enabled = YES;
        self.textfield.placeholder = @"请输入标签";
        self.textfield.enabled = YES;
        
        self.lableExplain.text = @" 最多可以添加20个标签，每个标签字数不超过15个";
        self.lableExplain.textColor = colorRGB(208, 208, 208);
        [self statusAdd];
        
    }
    _isDelete = !_isDelete;
}

- (void)statusAdd {
    [self.scrollViewLabel.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 15, 0, 0);
    button1.backgroundColor = [UIColor redColor];
    [self.scrollViewLabel addSubview:button1];
    
    for (int i = 0; i < self.arrayLabel.count; i++) {
        CGSize size = [self.arrayLabel[i] boundingRectWithSize:CGSizeMake(1000, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        CGFloat arrW = size.width + 30;
        CGFloat arrB = CGRectGetMaxX(button1.frame);
        if ((arrB+10+arrW+10) > kMainW) {
            //换行
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 100 + i;
            button.frame = CGRectMake(15, CGRectGetMaxY(button1.frame)+15, arrW, 31);
            [button setTitle:self.arrayLabel[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.backgroundColor = colorRGB(241, 241, 241);
            [button setTitleColor:colorRGB(52, 52, 52) forState:UIControlStateNormal];
            button.layer.cornerRadius = 2;
            [self.scrollViewLabel addSubview:button];
            button1 = button;
        } else {
            //不换行
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 100 + i;
            button.frame = CGRectMake(arrB + 15, CGRectGetMinY(button1.frame), arrW, 31);
            [button setTitle:self.arrayLabel[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.backgroundColor = colorRGB(241, 241, 241);
            [button setTitleColor:colorRGB(52, 52, 52) forState:UIControlStateNormal];
            button.layer.cornerRadius = 2;
            [self.scrollViewLabel addSubview:button];
            button1 = button;
        }
    }
    
    CGFloat heightScroll = kMainH-(_height_NavBar+15+61+14.5+33);
    CGFloat heightButton = CGRectGetMaxY(button1.frame);
    
    if (heightButton>heightScroll) {
        self.scrollViewLabel.contentSize = CGSizeMake(kMainW, heightButton);
    } else {
        self.scrollViewLabel.contentSize = CGSizeMake(kMainW, heightScroll);
    }
}

- (void)statusDelete {
    [self.scrollViewLabel.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 15, 0, 0);
    button1.backgroundColor = [UIColor redColor];
    [self.scrollViewLabel addSubview:button1];
    
    for (int i = 0; i < self.arrayLabel.count; i++) {
        CGSize size = [self.arrayLabel[i] boundingRectWithSize:CGSizeMake(1000, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        CGFloat arrW = size.width + 30;
        CGFloat arrB = CGRectGetMaxX(button1.frame);
        if ((arrB+10+arrW+10) > kMainW) {
            //换行
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 100 + i;
            button.frame = CGRectMake(15, CGRectGetMaxY(button1.frame)+15, arrW, 31);
            [button setTitle:self.arrayLabel[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.backgroundColor = colorRGB(241, 241, 241);
            [button setTitleColor:colorRGB(52, 52, 52) forState:UIControlStateNormal];
            button.layer.cornerRadius = 2;
            [button addTarget:self action:@selector(buttonDeleteTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollViewLabel addSubview:button];
            button1 = button;
            
        } else {
            //不换行
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 100 + i;
            button.frame = CGRectMake(arrB + 15, CGRectGetMinY(button1.frame), arrW, 31);
            [button setTitle:self.arrayLabel[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.backgroundColor = colorRGB(241, 241, 241);
            [button setTitleColor:colorRGB(52, 52, 52) forState:UIControlStateNormal];
            button.layer.cornerRadius = 2;
            [button addTarget:self action:@selector(buttonDeleteTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollViewLabel addSubview:button];
            button1 = button;
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ime-icon-shut-down"]];
        imageView.center = CGPointMake(CGRectGetMaxX(button1.frame), CGRectGetMinY(button1.frame));
        [imageView sizeToFit];
        [self.scrollViewLabel addSubview:imageView];
    }
    
    CGFloat heightScroll = kMainH-(_height_NavBar+15+61+14.5+33);
    CGFloat heightButton = CGRectGetMaxY(button1.frame);
    
    if (heightButton>heightScroll) {
        self.scrollViewLabel.contentSize = CGSizeMake(kMainW, heightButton);
    } else {
        self.scrollViewLabel.contentSize = CGSizeMake(kMainW, heightScroll);
    }
}

- (void)buttonDeleteTag:(UIButton *)sender {//tag = 100
    _viewLoading1.hidden = NO;
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    TGSupplierTag *tGSupplierTagTemp = self.arrayTGSupplierTag[sender.tag - 100];
    
    TGSupplierTag *tGSupplierTag = [[TGSupplierTag alloc] init];
    tGSupplierTag.tagId = tGSupplierTagTemp.tagId;
    
    postEntityBean.entity = tGSupplierTag.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
//    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_tgSupplierTag_deletetg parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *model = responseObjectModel;
        _viewLoading1.hidden = YES;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"删除成功"];
            
            [self.arrayLabel removeObjectAtIndex:sender.tag - 100];
            [self statusDelete];
            
            [self.arrayTGSupplierTag removeObjectAtIndex:sender.tag - 100];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"删除失败"];
        }
    } fail:^(NSError *error) {
        _viewLoading1.hidden = YES;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"删除失败"];
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)buttonAddTag:(UIButton *)sender {
    _viewLoading1.hidden = NO;
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    if (self.textfield.text.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"不能为空"];
        _viewLoading1.hidden = YES;
        return;
    }
    if (self.arrayLabel.count == 20) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"标签最多可创建20个"];
        _viewLoading1.hidden = YES;
        return;
    }
    BOOL has = false;
    for (NSString *stringTag in self.arrayLabel) {
        if ([self.textfield.text isEqualToString:stringTag]) {
            has = true;
            break;
        }
    }
    if (has) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"已有标签"];
        _viewLoading1.hidden = YES;
        return;
    }
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    TGSupplierTag *tGSupplierTag = [[TGSupplierTag alloc] init];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    tGSupplierTag.manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    tGSupplierTag.tagName = self.textfield.text;
    
    postEntityBean.entity = tGSupplierTag.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
//    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_tgSupplierTag_addtg parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *model = responseObjectModel;
        _viewLoading1.hidden = YES;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"添加成功"];
            
            [self.arrayLabel insertObject:self.textfield.text atIndex:0];
            [self statusAdd];
            
            TGSupplierTag *tGSupplierTag = [[TGSupplierTag alloc] init];
            tGSupplierTag.tagName = self.textfield.text;
            tGSupplierTag.tagId = model.returnMsg;
            [self.arrayTGSupplierTag insertObject:tGSupplierTag atIndex:0];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"添加失败"];
        }
    } fail:^(NSError *error) {
        _viewLoading1.hidden = YES;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"添加失败"];
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)tapViewLabel {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)textfieldEditingChanged:(UITextField *)textField {
    //获取高亮部分
    NSString *toBeString = textField.text;
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position){
        if (toBeString.length > 15){
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:15];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:15];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 15)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

//查询托管供应商标签
- (void)initRequestTgSupplierTagQuerytg {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];

    TGSupplierTag *tGSupplierTag = [[TGSupplierTag alloc] init];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    tGSupplierTag.manufacturerId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    
    postEntityBean.entity = tGSupplierTag.mj_keyValues;

    NSDictionary *dic = postEntityBean.mj_keyValues;
    
//    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_tgSupplierTag_querytg parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _viewLoading.hidden = YES;
            
            NSMutableArray *arrayTGSupplierTag = model.list;
            for (NSDictionary *dic in arrayTGSupplierTag) {
                TGSupplierTag *obj = [TGSupplierTag mj_objectWithKeyValues:dic];
                [self.arrayLabel addObject:obj.tagName];
                [self.arrayTGSupplierTag addObject:obj];
            }
            [self statusAdd];
        } else {
            
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
