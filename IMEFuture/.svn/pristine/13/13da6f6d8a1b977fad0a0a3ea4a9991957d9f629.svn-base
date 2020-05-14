//
//  ECTGSPingJiaViewController2.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/12/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ECTGSPingJiaViewController2.h"
#import "VoHeader.h"

@interface ECTGSPingJiaViewController2 ()


@property (weak, nonatomic) IBOutlet UIButton *buttonPutIn;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *labelPlaceHolder;
@end

@implementation ECTGSPingJiaViewController2


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.labelPlaceHolder.hidden = YES;
        self.buttonPutIn.enabled = YES;
        [self.buttonPutIn setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
    } else {
        self.labelPlaceHolder.hidden = NO;
        self.buttonPutIn.enabled = NO;
        [self.buttonPutIn setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
    }
    
}

//提交
- (IBAction)putIn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
