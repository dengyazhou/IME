//
//  LianXiRenSouSuoViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/7/27.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "LianXiRenSouSuoViewController1.h"

#import "Header.h"

#import "XHJAddressBook.h"
#import "PersonModel.h"
#import "PersonCell.h"
#import "BeiYaoQingRenXingXiViewController.h"

#define  mainWidth [UIScreen mainScreen].bounds.size.width
#define  mainHeigth  [UIScreen mainScreen].bounds.size.height

@interface LianXiRenSouSuoViewController1 () <UITableViewDataSource,UITableViewDelegate> {
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property(nonatomic,strong)NSMutableArray *listContent;
@property(nonatomic,strong)NSMutableArray *listContent1;//此数组存放所有的联系人
@property (strong, nonatomic) NSMutableArray *sectionTitles;

@property (strong, nonatomic) PersonModel *people;
@property (weak, nonatomic) IBOutlet UITableView *tableShow;
@property (weak, nonatomic) IBOutlet UIView *viewNoContent;//无相关数据
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;



@end

@implementation LianXiRenSouSuoViewController1 {
    XHJAddressBook *_addBook;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.textField.borderStyle = UITextBorderStyleNone;
    [self.textField addTarget:self action:@selector(actionEditingChangedTextField:) forControlEvents:UIControlEventEditingChanged];
    self.viewNoContent.hidden = YES;
    
    _sectionTitles=[NSMutableArray new];
    
    self.tableShow.delegate=self;
    self.tableShow.dataSource=self;
    self.tableShow.tableFooterView = [UIView new];
    self.tableShow.sectionIndexBackgroundColor=[UIColor clearColor];
    self.tableShow.sectionIndexColor = colorRGB(89, 178, 50);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self initData];
        dispatch_sync(dispatch_get_main_queue(), ^
                      {
//                          [self setTitleList];
                          [self.tableShow reloadData];
                          if (_listContent.count>0) {
                      
                          } else {

                          }
                      });
    });
}

-(NSMutableArray*)listContent
{
    if(_listContent==nil)
    {
        _listContent=[NSMutableArray new];
    }
    return _listContent;
}
- (NSMutableArray *)listContent1 {
    if (_listContent1 == nil) {
        _listContent1 = [NSMutableArray new];
    }
    return _listContent1;
}
-(void)initData
{
    _addBook=[[XHJAddressBook alloc]init];
    self.listContent=[_addBook getAllPersonSouSuo];
    self.listContent1 = [_addBook getAllPersonSouSuo];
    if(_listContent==nil)
    {
        NSLog(@"数据为空或通讯录权限拒绝访问，请到系统开启");
        return;
    }
}

- (void)actionEditingChangedTextField:(UITextField *)sender {
    self.listContent = [[NSMutableArray alloc] initWithCapacity:0];
    if (sender.text.length > 0) {
        for (id value in self.listContent1) {
            PersonModel *personModel = (PersonModel *)value;
            if ([personModel.phonename containsString:sender.text]||[personModel.tel containsString:sender.text]) {
                [self.listContent addObject:personModel];
            }
        }
    } else {
        self.listContent = self.listContent1;
    }
    if (self.listContent.count > 0) {
        self.viewNoContent.hidden = YES;
    } else {
        self.viewNoContent.hidden = NO;
    }
    [self.tableShow reloadData];
}

- (IBAction)buttonCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listContent count];
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdenfer=@"addressCell";
    PersonCell *personcell=(PersonCell*)[tableView dequeueReusableCellWithIdentifier:cellIdenfer];
    if(personcell==nil)
    {
        personcell=[[PersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenfer];
    }
    
    _people = (PersonModel *)[_listContent objectAtIndex:indexPath.row];
    [personcell setData:_people];
    
    return personcell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.people = (PersonModel *)[_listContent objectAtIndex:indexPath.row];
    
    UIViewController *vc = self.presentingViewController;
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>%@",vc);
}


- (IBAction)back:(id)sender {
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
