//
//  TemporaryTaskDetailedListVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "TemporaryTaskDetailedListVC.h"
#import "VoHeader.h"

#import "TemporaryTaskDetailedListCell.h"

#import "TemporaryTaskVC.h"

@interface TemporaryTaskDetailedListVC () <UITableViewDelegate,UITableViewDataSource> {
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (nonatomic, strong) NSMutableArray *temporaryTaskVoArray;

@property (nonatomic, assign) NSUInteger index;

@end

@implementation TemporaryTaskDetailedListVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    self.index = NSUIntegerMax;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TemporaryTaskDetailedListCell" bundle:nil] forCellReuseIdentifier:@"temporaryTaskDetailedListCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW-34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.temporaryTaskVoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TemporaryTaskDetailedListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"temporaryTaskDetailedListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.viewBg.layer.shadowOffset = CGSizeMake(0, 0);//默认为(0, -3)
    cell.viewBg.layer.shadowRadius = 4;
    cell.viewBg.layer.shadowOpacity = 1;//默认为0，所以根本看不见
    
    cell.imageSelect.hidden = true;
    cell.label11.hidden = true;
    cell.label2.hidden = true;
    
    if (indexPath.row == self.index) {
        cell.viewBg.layer.shadowColor = [UIColor colorWithRed:65/255.0 green:178/255.0 blue:253/255.0 alpha:0.64].CGColor;
        cell.imageSelect.hidden = false;
    } else {
        cell.viewBg.layer.shadowColor = [UIColor clearColor].CGColor;
        cell.imageSelect.hidden = true;
    }
    
    TemporaryTaskVo *temporaryTask = self.temporaryTaskVoArray[indexPath.row];
    cell.labelName.text = temporaryTask.createUserText;
    cell.label0.text = temporaryTask.name;
    cell.label10.text = [self stringGetTimeFormatter:temporaryTask.startDateTime];
    //临时任务状态 0 创建 1 进行中 2 暂停 3 完成 4 关闭
//    if (temporaryTask.status.integerValue == 1) {
//        cell.label11.hidden = true;
//        cell.label2.hidden = true;
//        cell.label3.text = @"进行中";
//    } else if (temporaryTask.status.integerValue == 2) {
//        cell.label11.hidden = false;
//        cell.label11.text = [self stringGetTimeFormatter:temporaryTask.actualEndDateTime];
//        cell.label2.hidden = false;
//        cell.label2.text = [self stringGetSecond:temporaryTask.workTime.longValue];
//        cell.label3.text = @"暂停";
//    } else if (temporaryTask.status.integerValue == 3) {
//        cell.label11.hidden = false;
//        cell.label11.text = [self stringGetTimeFormatter:temporaryTask.actualEndDateTime];
//        cell.label2.hidden = false;
//        cell.label2.text = [self stringGetSecond:temporaryTask.workTime.longValue];
//        cell.label3.text = @"完成";
//    }
    if (temporaryTask.status.integerValue == 0) {
        cell.label11.hidden = true;
        cell.label2.hidden = true;
        cell.label3.text = @"创建";
    } else if (temporaryTask.status.integerValue == 1) {
        cell.label11.hidden = true;
        cell.label2.hidden = true;
        cell.label3.text = @"进行中";
    } else if (temporaryTask.status.integerValue == 2) {
        cell.label11.hidden = false;
        cell.label11.text = [self stringGetTimeFormatter:temporaryTask.actualEndDateTime];
        cell.label2.hidden = false;
        cell.label2.text = [self stringGetSecond:temporaryTask.workTime.longValue];
        cell.label3.text = @"暂停";
    }
    cell.label21.text = (temporaryTask.planWorkTimeStr == nil || [temporaryTask.planWorkTimeStr isEqualToString:@""])?@"00:00:00":temporaryTask.planWorkTimeStr;
    
    return cell;
}

- (NSString *)stringGetTimeFormatter:(NSString *)time {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *stringDate = [formatter dateFromString:time];

    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yy/MM/dd HH:mm:ss"];
    
    NSString *dateString = [formatter1 stringFromDate:stringDate];
    
    return dateString;
}

- (NSString *)stringGetSecond:(NSUInteger)second {
    NSUInteger hours = second/1000/60/60;
    NSUInteger minute = second/1000/60%60;
    NSUInteger sec = second/1000%60;
    NSString *strTime = [NSString stringWithFormat:@"%.2lu:%.2lu:%.2lu",(unsigned long)hours,(unsigned long)minute,(unsigned long)sec];
    return strTime;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    TemporaryTaskVo *temporaryTask = self.temporaryTaskVoArray[indexPath.row];
    TemporaryTaskVC *vc = [[TemporaryTaskVC alloc] init];
    vc.idDYZ = temporaryTask.idDYZ;
    vc.leaderFlag = self.leaderFlag;
    [self.navigationController pushViewController:vc animated:true];
    
    
    
}

- (IBAction)addTemporaryTask:(id)sender {
    TemporaryTaskVC *vc = [[TemporaryTaskVC alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)initRequest{
    _viewLoading.hidden = false;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    TemporaryTaskVo  *temporaryTaskVo  = [[TemporaryTaskVo  alloc] init];
    temporaryTaskVo.siteCode = userInfo.siteCode;
    temporaryTaskVo.createUser = userInfo.userCode;
    temporaryTaskVo.leaderFlag = [NSNumber numberWithInteger:self.leaderFlag];
    postEntityBean.entity = temporaryTaskVo.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_mes_temporaryTask_getTemporaryTaskList parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.temporaryTaskVoArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dicTemp in returnListBean.list) {
                TemporaryTaskVo *vo = [TemporaryTaskVo mj_objectWithKeyValues:dicTemp];
                if (vo.status.integerValue == 3 || vo.status.integerValue == 4) {//完成和关闭，不在列表中显示
                    
                } else {
                    [self.temporaryTaskVoArray addObject:vo];
                }
            }
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = true;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
