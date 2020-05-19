//
//  BaoJiaZiXunViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaoJiaZiXunViewController.h"
#import "VoHeader.h"

#import "BaoJiaZiXunCell.h"
#import "TiWenViewController.h"

#import "HuiDaViewController.h"


@interface BaoJiaZiXunViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_inquiryOrderQArray;
    NSMutableArray *_inquiryOrderAArray;
    NSInteger _count;
    UIView *_viewNoContent;
    InquiryOrder *_inquiryOrder;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation BaoJiaZiXunViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self initRequestInquiryDetail];//询盘详细
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    
    self.buttonTiWen.hidden = YES;
    
    [self initTableView];
    _viewNoContent = [UIView addView:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) imageNamed:@"ime_picture_inquiry_empty" title:@"无咨询"];
    [self.view addSubview:_viewNoContent];
    _viewNoContent.hidden = YES;
    
    
}

- (void)initRequestInquiryDetail {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
    inquiryOrder.inquiryOrderId = self.inquiryOrderId;
    
    postEntityBean.entity = inquiryOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
//    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_inquiry_detail parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _inquiryOrder = [InquiryOrder mj_objectWithKeyValues:model.entity];
            
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            if (![_inquiryOrder.manufacturerId isEqualToString:[GlobalSettingManager shareGlobalSettingManager].manufacturerId]) {
                NSLog(@"-->%@<",_inquiryOrder.inquiryOrderStatus);
                
                if ([_inquiryOrder.inquiryOrderStatus isEqualToString:@"IING"]||[_inquiryOrder.inquiryOrderStatus isEqualToString:@"SQ"]) {
                    self.buttonTiWen.hidden = NO;
                }
            }
            [self initRequestQaList];//QA列表
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    
}
- (void)initRequestQaList {
    _count = 0;
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    InquiryOrderQA *inquiryOrderQA = [[InquiryOrderQA alloc] init];
    inquiryOrderQA.inquiryOrderId = _inquiryOrder.inquiryOrderId;
    postEntityBean.entity = inquiryOrderQA.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
//    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_qa_list parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            NSMutableArray *inquiryOrderQAArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in returnListBean.list) {
                InquiryOrderQA *inquiryOrderQA = [InquiryOrderQA mj_objectWithKeyValues:dic];
                [inquiryOrderQAArray addObject:inquiryOrderQA];
            }
            _inquiryOrderQArray = [[NSMutableArray alloc] init];
            _inquiryOrderAArray = [[NSMutableArray alloc] init];
            
            for (InquiryOrderQA *inquiryOrderQA in inquiryOrderQAArray) {
                if ([inquiryOrderQA.qaType integerValue] == 0) {
                    [_inquiryOrderQArray addObject:inquiryOrderQA];
                    
                    for (InquiryOrderQA *inquiryOrderQA1 in inquiryOrderQAArray) {
                        if ([inquiryOrderQA1.qaType integerValue] == 1) {
                            if ([inquiryOrderQA.relatedFlag isEqualToString:inquiryOrderQA1.relatedFlag]) {
                                [_inquiryOrderAArray addObject:inquiryOrderQA1];
                                break;
                            }
                        }
                    }
                    if (_count == _inquiryOrderAArray.count) {
                        [_inquiryOrderAArray addObject:[[InquiryOrderQA alloc] init]];
                    }
                    _count = _inquiryOrderAArray.count;
                }
                
            }
            
            if (_inquiryOrderQArray.count == 0) {
                _viewNoContent.hidden = NO;
            } else {
                _viewNoContent.hidden = YES;
            }
            [self.tableView reloadData];
        }
        
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}
- (void)initTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BaoJiaZiXunCell" bundle:nil] forCellReuseIdentifier:@"bjzxCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _inquiryOrderQArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaoJiaZiXunCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bjzxCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row != _inquiryOrderQArray.count-1) {
        cell.viewBottomLineLeft.constant = 10;
    } else {
        cell.viewBottomLineLeft.constant = 0;
    }

    
    cell.imageViewA.hidden = YES;
    cell.buttonHuida.hidden = YES;
    
    InquiryOrderQA *inquiryOrderQ = _inquiryOrderQArray[indexPath.row];
    cell.labelQ.text = [NSString stringWithFormat:@"(%@)%@",inquiryOrderQ.partName,inquiryOrderQ.content];
    InquiryOrderQA *inquiryOrderA = _inquiryOrderAArray[indexPath.row];
    if (inquiryOrderA.content) {
        cell.imageViewA.hidden = NO;
    } else {
        cell.buttonHuida.hidden = NO;
    }
    
    cell.labelA.text = inquiryOrderA.content;
    cell.enterpriseName.text = inquiryOrderQ.member.enterpriseInfo.enterpriseName;
    cell.createTime.text = inquiryOrderQ.createTime;
    
    [cell.buttonHuida addTarget:self action:@selector(buttonHuida:) forControlEvents:UIControlEventTouchUpInside];
    cell.buttonHuida.tag = indexPath.row;
    return cell;
}

- (void)buttonHuida:(UIButton *)sender {
    InquiryOrderQA *inquiryOrderQ = _inquiryOrderQArray[sender.tag];
    HuiDaViewController *huiDaViewController = [[HuiDaViewController alloc] init];
    huiDaViewController.inquiryOrderQ = inquiryOrderQ;
    [self.navigationController pushViewController:huiDaViewController animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    InquiryOrderQA *inquiryOrderQ = _inquiryOrderQArray[indexPath.row];
    CGSize sizeQ = [[NSString stringWithFormat:@"(%@)%@",inquiryOrderQ.partName,inquiryOrderQ.content] boundingRectWithSize:CGSizeMake(kMainW-105, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    InquiryOrderQA *inquiryOrderA = _inquiryOrderAArray[indexPath.row];
    CGSize sizeA = [inquiryOrderA.content boundingRectWithSize:CGSizeMake(kMainW-45, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return 55 + sizeQ.height + sizeA.height;
}

- (IBAction)buttonTiWen:(UIButton *)sender {
    TiWenViewController *twVC = [[TiWenViewController alloc] init];
    twVC.inquiryOrder = _inquiryOrder;
    [self.navigationController pushViewController:twVC animated:YES];
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
