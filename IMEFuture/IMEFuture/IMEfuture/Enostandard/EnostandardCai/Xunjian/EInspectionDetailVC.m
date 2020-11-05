//
//  EInspectionDetailVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "EInspectionDetailVC.h"
#import "VoHeader.h"


#import "EInspectionDetailCell.h"

@interface EInspectionDetailVC () <UITableViewDelegate,UITableViewDataSource> {
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (nonatomic, strong) NSMutableArray *temporaryTaskVoArray;

@property (nonatomic, assign) NSUInteger index;

@end

@implementation EInspectionDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    self.index = NSUIntegerMax;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EInspectionDetailCell" bundle:nil] forCellReuseIdentifier:@"eInspectionDetailCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW-34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
        
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EInspectionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eInspectionDetailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    InspectionBean *model = self.inspectionBean;
    
    cell.label0.text = model.accountingHours;
    cell.label1.text = model.createTime;
    cell.label2.text = model.supplierEnterpriseName;
    cell.label3.text = [[model.inspectionDate componentsSeparatedByString:@""] firstObject];
    cell.label4.text = model.inspectionCommentValue1;
    cell.label5.text = model.inspectionCommentValue2;
    cell.label6.text = model.inspectionCommentValue3;
    cell.label7.text = model.inspectionCommentValue4;
    cell.label8.text = model.inspectionCommentValue5;
    
    
    cell.button1.hidden = YES;
    cell.button2.hidden = YES;
    cell.button3.hidden = YES;
    cell.button4.hidden = YES;
    cell.button5.hidden = YES;
    if (model.fileName1) {
        cell.button1.hidden = false;
    }
    if (model.fileName2) {
        cell.button2.hidden = false;
    }
    cell.button2.hidden = false;
    
    if (model.fileName3) {
        cell.button3.hidden = false;
    }
    if (model.fileName4) {
        cell.button4.hidden = false;
    }
    if (model.fileName5) {
        cell.button5.hidden = false;
    }
    return cell;
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
