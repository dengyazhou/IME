//
//  WoChaKanDaTuViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/8/31.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "WoChaKanDaTuViewController.h"
#import "VoHeader.h"

#import "NSArray+Transition.h"


@interface WoChaKanDaTuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation WoChaKanDaTuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    
    NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
    
    for (NSDictionary *dic in array) {
        IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
        if ([loginModel.ucenterId isEqualToString:identityBean.ucenterId]) {
            if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:loginModel.headImg] placeholderImage:[UIImage imageNamed:@"ime_icon_head-portrait00"]];
            } else {
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:loginModel.headImg] placeholderImage:[UIImage imageNamed:@"ime_icon_head-portrait01"]];
            }
        }
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressSelector:)];
    longPress.minimumPressDuration = 1;
    [self.imageView addGestureRecognizer:longPress];
    self.imageView.userInteractionEnabled = YES;
}

- (void)longPressSelector:(UILongPressGestureRecognizer *)longPress {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self loadImageFinished:self.imageView.image];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [action0 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertController addAction:action0];
    [alertController addAction:action1];
    
    if ([alertController respondsToSelector:@selector(popoverPresentationController)]) {
        alertController.popoverPresentationController.sourceView = self.view;//必须加
        alertController.popoverPresentationController.sourceRect = CGRectMake(0, kMainH, kMainW, kMainH);//可选
    }
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (!error) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"保存图片成功"];
    } else {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"保存图片失败"];
    }
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
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
