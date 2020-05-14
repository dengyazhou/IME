//
//  FenLeiSouSuoViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/6.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "FenLeiSouSuoViewController.h"
#import "VoHeader.h"


#import "FenLeiSouSuoJieGuoViewController.h"
#import "Masonry.h"



@interface FenLeiSouSuoViewController () <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource> {
    UIView *_viewBGSouSuo;
    UITableView *_tableView;
    NSMutableArray *_arrayBaseTagName;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITextField *textFieldSouSuo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation FenLeiSouSuoViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textFieldSouSuo becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    self.textFieldSouSuo.placeholder = self.textFieldPlaceholder;
    
    [self initUI];
    
    [HttpMamager postRequestWithURLString:DYZ_tag_list parameters:nil success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            _arrayBaseTagName = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in returnListBean.list) {
                BaseTag *baseTag = [BaseTag mj_objectWithKeyValues:dic];
//                NSLog(@"%@",baseTag.name);
                [_arrayBaseTagName addObject:baseTag.name];
            }
            [self initViewBGSouSuo];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.status];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    
}

- (void)initUI {
    self.textFieldSouSuo.delegate = self;
    [self initTableView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    FenLeiSouSuoJieGuoViewController *flssjgVC = [[FenLeiSouSuoJieGuoViewController alloc] init];
    flssjgVC.stringSearchContent = self.textFieldSouSuo.text;
    [self.navigationController  pushViewController:flssjgVC animated:YES];
    return true;
}
- (IBAction)editingChanged:(UITextField *)sender {
//    if (sender.text.length > 0) {
//        _viewBGSouSuo.hidden = YES;
//        _tableView.hidden = NO;
//    } else {
//        _viewBGSouSuo.hidden = NO;
//        _tableView.hidden = YES;
//    }
}

- (void)initViewBGSouSuo {
    _viewBGSouSuo = [[UIView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewBGSouSuo];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, kMainW, 0.5)];
    label1.backgroundColor = colorLine;
    [_viewBGSouSuo addSubview:label1];
    UILabel *labelLiShiSouSuo = [[UILabel alloc] init];
    labelLiShiSouSuo.frame = CGRectMake(10, 14, 150, 14);
    labelLiShiSouSuo.font = [UIFont systemFontOfSize:14];
//    labelLiShiSouSuo.text = @"历史搜索";
    labelLiShiSouSuo.text = @"热门工艺搜索";
    labelLiShiSouSuo.textColor = colorRGB(32, 32, 32);
    [_viewBGSouSuo addSubview:labelLiShiSouSuo];

    UIView *viewLiShi = [[UIView alloc] init];
    viewLiShi.frame = CGRectMake(0, CGRectGetMaxY(label1.frame), kMainW, 0);
    [_viewBGSouSuo addSubview:viewLiShi];
    UIButton *buttonMid = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonMid.frame = CGRectMake(0, 10, 0, 0);
    buttonMid.backgroundColor = [UIColor redColor];
    [viewLiShi addSubview:buttonMid];
    NSInteger arrayCount;
    if (_arrayBaseTagName.count >= 10) {
        arrayCount = 10;
    } else {
        arrayCount = _arrayBaseTagName.count;
    }
    for (int i = 0; i < arrayCount; i++) {
        CGSize size = [_arrayBaseTagName[i] boundingRectWithSize:CGSizeMake(1000, 12) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
        CGFloat arrW = size.width + 30;
        CGFloat arrB = CGRectGetMaxX(buttonMid.frame);
        if ((arrB+10+arrW+10) > kMainW) {
            //换行
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 10 + i;
            button.frame = CGRectMake(10, CGRectGetMaxY(buttonMid.frame)+10, arrW, 30);
            [button setTitle:_arrayBaseTagName[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.backgroundColor = colorRGB(241, 241, 241);
            [button setTitleColor:colorRGB(32, 32, 32) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [viewLiShi addSubview:button];
            buttonMid = button;
        } else {
            //不换行
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 10 + i;
            button.frame = CGRectMake(arrB + 10, CGRectGetMinY(buttonMid.frame), arrW, 30);
            [button setTitle:_arrayBaseTagName[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.backgroundColor = colorRGB(241, 241, 241);
            [button setTitleColor:colorRGB(32, 32, 32) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [viewLiShi addSubview:button];
            buttonMid = button;
        }
    }
    viewLiShi.frame = CGRectMake(0, CGRectGetMaxY(label1.frame), kMainW, CGRectGetMaxY(buttonMid.frame)+10);
}

- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    _tableView.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"666";
    return cell;
}

- (void)buttonClick:(UIButton *)sender {
//    NSLog(@"%ld",sender.tag);
    FenLeiSouSuoJieGuoViewController *flssjgVC = [[FenLeiSouSuoJieGuoViewController alloc] init];
    flssjgVC.stringSearchContent = sender.currentTitle;
    [self.navigationController  pushViewController:flssjgVC animated:YES];
}
- (IBAction)back:(UIButton *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
