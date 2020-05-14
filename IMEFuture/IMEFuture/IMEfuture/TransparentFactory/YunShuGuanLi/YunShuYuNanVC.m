//
//  YunShuYuNanVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/8.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "YunShuYuNanVC.h"
#import "VoHeader.h"

@interface YunShuYuNanVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation YunShuYuNanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    self.imageView.image = [UIImage imageWithData:self.uploadImageBean.data];
    
}

- (IBAction)delete:(id)sender {
    
    self.callBack();
    self.uploadImageBean = nil;
    [self.navigationController popViewControllerAnimated:true];
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
