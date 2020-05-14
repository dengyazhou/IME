//
//  XuanZeYaoQiuDaoHuoRiQiVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/3/2.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "XuanZeYaoQiuDaoHuoRiQiVC.h"
#import "XuanZeYaoQiuDaoHuoRiQiCell.h"
#import "VoHeader.h"
#import "UIViewXuanZeYaoQiuDaoHuoRiQi.h"

#import "ToolTransition.h"

@interface XuanZeYaoQiuDaoHuoRiQiVC () <UITableViewDelegate,UITableViewDataSource> {
    NSArray *_arrayString;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation XuanZeYaoQiuDaoHuoRiQiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    if (self.arrayBatchDeliverItem.count > 0) {
        
    } else {
        self.arrayBatchDeliverItem = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    _arrayString = @[@"第一批",@"第二批",@"第三批",@"第四批",@"第五批"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"XuanZeYaoQiuDaoHuoRiQiCell" bundle:nil] forCellReuseIdentifier:@"xuanZeYaoQiuDaoHuoRiQiCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 118;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 60;
    } else {
        self.tableViewBottom.constant = rect.size.height;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayBatchDeliverItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XuanZeYaoQiuDaoHuoRiQiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xuanZeYaoQiuDaoHuoRiQiCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    BatchDeliverItem *deliverItem = self.arrayBatchDeliverItem[indexPath.row];
    
    cell.label0.text = _arrayString[indexPath.row];
    
    cell.buttonShanChu.tag = indexPath.row;
    [cell.buttonShanChu addTarget:self action:@selector(buttonShanChu:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    cell.textField1.rightView = imageView;
    cell.textField1.rightViewMode = UITextFieldViewModeAlways;
    cell.textField1.text = [[deliverItem.deliverTm componentsSeparatedByString:@" "] firstObject];//2018-03-30 日期
    cell.buttonTextField1.tag = indexPath.row;
    [cell.buttonTextField1 addTarget:self action:@selector(buttonTextFieldClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.textField2.text = deliverItem.num;//数量
    cell.textField2.rightViewMode = UITextFieldViewModeAlways;
    cell.textField2.tag = indexPath.row;
    [cell.textField2 addTarget:self action:@selector(textFieldShuLiang:) forControlEvents:UIControlEventEditingChanged];
    cell.textField2.inputAccessoryView = [self addToolbar];
    
    return cell;
}

#pragma 删除
- (void)buttonShanChu:(UIButton *)sender {
    NSLog(@"%s",__FUNCTION__);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否删除当前批次？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.arrayBatchDeliverItem.count ==  1) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"至少有一种批次"];
            return;
        }
        [self.arrayBatchDeliverItem removeObjectAtIndex:sender.tag];
        [self.tableView reloadData];
    }];
    [alertController addAction:action0];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark 要求到货日期
- (void)buttonTextFieldClick:(UIButton *)sender {
    BatchDeliverItem *deliverItem = self.arrayBatchDeliverItem[sender.tag];

    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeYaoQiuDaoHuoRiQi" owner:self options:nil];
    UIViewXuanZeYaoQiuDaoHuoRiQi *viewXZSJ = [nib objectAtIndex:0];
    viewXZSJ.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewXZSJ];
    viewXZSJ.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [viewXZSJ initDataPickerButtonClick:^(NSString *string) {
        NSLog(@"%@",string);
        deliverItem.deliverTm = string;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } buttonQuXiao:^{
        [sender resignFirstResponder];
    }];
}

#pragma mark 数量
- (void)textFieldShuLiang:(UITextField *)sender {
    BatchDeliverItem *deliverItem = self.arrayBatchDeliverItem[sender.tag];
    deliverItem.num = sender.text;
}

#pragma mark 新增交货日期
- (IBAction)xinZengJiaoHuoRiQi:(UIButton *)sender {
    
    
    if (self.arrayBatchDeliverItem.count < 5) {
        BatchDeliverItem *deliverItem = [[BatchDeliverItem alloc] init];
        [self.arrayBatchDeliverItem addObject:deliverItem];;
        [self.tableView reloadData];
    } else {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"最多5个批次"];
    }
    
    if (self.arrayBatchDeliverItem.count >= 4) {
        [self.tableView setContentOffset:CGPointMake(0, 118*self.arrayBatchDeliverItem.count-3)];
    }
}

#pragma mark 确认
- (IBAction)buttonQuRen:(UIButton *)sender {
    if (self.arrayBatchDeliverItem.count == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请添加批次"];
        return;
    }
    for (NSInteger i = 0; i < self.arrayBatchDeliverItem.count; i++) {
        BatchDeliverItem * deliverItem = self.arrayBatchDeliverItem[i];
        NSString *deliverTm = deliverItem.deliverTm;
        NSString *num = deliverItem.num;
        if (deliverTm == nil) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"交货日期不能为空"];
            return;
        }
        if (!(num != nil&&[num integerValue] > 0)) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"数量必须大于0"];
            return;
        }
        if (!(i == self.arrayBatchDeliverItem.count-1)) {
            BatchDeliverItem * deliverItem1 = self.arrayBatchDeliverItem[i+1];
            NSString *deliverTm1 = deliverItem1.deliverTm;
            if (deliverTm1 == nil) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"交货日期不能为空"];
                return;
            }
            NSInteger aa = [ToolTransition compareDate:deliverTm withDate:deliverTm1];
            if (aa == -1) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"交货日期有先后顺序"];
                return;
            }
        }
        NSLog(@"%ld deliverTm:%@ num:%@",i,deliverTm,num);
    }
    self.buttonBackBlock(self.arrayBatchDeliverItem);
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
