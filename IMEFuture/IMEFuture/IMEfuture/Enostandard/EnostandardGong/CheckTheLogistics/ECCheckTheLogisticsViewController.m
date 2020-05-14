//
//  ECCheckTheLogisticsViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/3/30.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ECCheckTheLogisticsViewController.h"
#import "VoHeader.h"

#import "ECChakanWuliuCell.h"
#import "ECChakanWuliuCell1.h"



@interface ECCheckTheLogisticsViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_arrayRoute;
    UIActivityIndicatorView *_activityView;
    
    UIView *_viewNoContent;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation ECCheckTheLogisticsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_activityView startAnimating];
    [self initRequrstLogisticsList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ECChakanWuliuCell" bundle:nil] forCellReuseIdentifier:@"eCChakanWuliuCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ECChakanWuliuCell1" bundle:nil] forCellReuseIdentifier:@"eCChakanWuliuCell1"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (!_viewNoContent) {
        _viewNoContent = [self viewNoContent];
        [self.view addSubview:_viewNoContent];
    }
    _viewNoContent.hidden = YES;
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityView.frame = CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar);
    _activityView.backgroundColor = colorRGB(230, 230, 230);
    [self.view addSubview:_activityView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self getHeight];
    }
    if (indexPath.section == 1) {
        return 90;
    }
    return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return _arrayRoute.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ECChakanWuliuCell *eCChakanWuliuCell = [tableView dequeueReusableCellWithIdentifier:@"eCChakanWuliuCell" forIndexPath:indexPath];
        eCChakanWuliuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        eCChakanWuliuCell.label0.text = self.logisticsCompany?self.logisticsCompany:@"--";
        eCChakanWuliuCell.label1.text = self.logisticsNo?self.logisticsNo:@"--";
        eCChakanWuliuCell.label2.text = self.logisticsRemark?self.logisticsRemark:@"--";
        
        return eCChakanWuliuCell;
    }
    if (indexPath.section == 1) {
        Route *route = _arrayRoute[indexPath.row];
        ECChakanWuliuCell1 *eCChakanWuliuCell1 = [tableView dequeueReusableCellWithIdentifier:@"eCChakanWuliuCell1" forIndexPath:indexPath];
        eCChakanWuliuCell1.selectionStyle = UITableViewCellSelectionStyleNone;
        eCChakanWuliuCell1.viewLineTop.hidden = YES;
        eCChakanWuliuCell1.viewLineBottom.hidden = YES;
        eCChakanWuliuCell1.viewLineBottom1.hidden = YES;
        eCChakanWuliuCell1.viewLineTopL.hidden = YES;
        eCChakanWuliuCell1.viewLineBottomL.hidden = YES;
        eCChakanWuliuCell1.viewCircular.backgroundColor = colorRGB(221, 221, 221);
        
        if (indexPath.row == 0) {
            eCChakanWuliuCell1.viewLineTop.hidden = NO;
            eCChakanWuliuCell1.viewLineBottom.hidden = NO;
            eCChakanWuliuCell1.viewLineBottomL.hidden = NO;
            eCChakanWuliuCell1.viewCircular.backgroundColor = colorRGB(91, 178, 24);
        } else {
            if (indexPath.row != _arrayRoute.count-1) {
                eCChakanWuliuCell1.viewLineBottom.hidden = NO;
            } else {
                eCChakanWuliuCell1.viewLineBottom1.hidden = NO;
            }
            eCChakanWuliuCell1.viewLineTopL.hidden = NO;
            eCChakanWuliuCell1.viewLineBottomL.hidden = NO;
        }
        eCChakanWuliuCell1.label0.text = [NSString stringWithFormat:@"%@ %@",route.accept_address,route.remark];
        eCChakanWuliuCell1.label1.text = [NSString stringWithFormat:@"%@",route.accept_time];
        
        return eCChakanWuliuCell1;
    }
    return nil;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initRequrstLogisticsList{
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    Route *route = [[Route alloc] init];
    route.opcode = self.logisticsNo;
    postEntityBean.entity = route.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    NSLog(@"%@",dic);

    [HttpMamager postRequestWithURLString:DYZ_logistics_list parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *model = responseObjectModel;
        
        if ([model.status isEqualToString:@"SUCCESS"]) {
            _arrayRoute = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in model.list) {
                Route *route = [Route mj_objectWithKeyValues:dic];
                [_arrayRoute addObject:route];
            }
            
            if (_arrayRoute.count > 0) {
                _viewNoContent.hidden = YES;
                self.tableView.scrollEnabled = YES;
            } else {
                _viewNoContent.hidden = NO;
                self.tableView.scrollEnabled = NO;
            }
            
            [self.tableView reloadData];
        } else {
            
        }
        
        [_activityView stopAnimating];
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (UIView *)viewNoContent {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _height_NavBar+[self getHeight]+10, kMainW, kMainH - (_height_NavBar+[self getHeight]+10))];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, kMainW, 21);
    label.center = CGPointMake(view.center.x, view.center.y-200);
    label.text = @"暂无数据";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = colorRGB(32, 32, 32);
    [view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.bounds = CGRectMake(0, 0, kMainW, 42);
    label1.center = CGPointMake(kMainW/2, CGRectGetMaxY(label.frame)+CGRectGetHeight(label1.frame)/2.0);
    label1.text = @"建议您下次选择平台推荐的物流方式，\n就能实时跟踪物流信息！";
    label1.font = [UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = colorRGB(117, 117, 117);
    label1.numberOfLines = 0;
    
    [view addSubview:label1];
    return view;
}

- (CGFloat)getHeight{
    NSString *string0 = self.logisticsCompany.length!=0?self.logisticsCompany:@"--";
    CGSize size0 = [string0 boundingRectWithSize:CGSizeMake(kMainW-10-110, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    NSString *string2 = self.logisticsRemark.length!=0?self.logisticsRemark:@"--";
    CGSize size2 = [string2 boundingRectWithSize:CGSizeMake(kMainW-10-82, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    
    return 8+size0.height+5+17+5+size2.height+8;
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
