//
//  CheckDefectivePhoneViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/23.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "CheckDefectivePhoneViewController.h"
#import "UrlContant.h"
#import "UIImageView+WebCache.h"

@interface CheckDefectivePhoneViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewNocontent;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewShow;
@end

@implementation CheckDefectivePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imageViewNocontent.hidden = true;
    self.imageViewShow.hidden = true;
    
    if ([self.fileName localizedStandardContainsString:@"png"] || [self.fileName localizedStandardContainsString:@"jpg"] || [self.fileName localizedStandardContainsString:@"jpeg"] ||
        [self.fileName localizedStandardContainsString:@"gif"] || [self.fileName localizedStandardContainsString:@"bmp"]) {
        self.imageViewShow.hidden = false;
        [self.imageViewShow sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?filePath=%@&fileRealName=%@&fileBucketName=%@&filename=%@",DYZ_efeibiao_uploadfile_downloadInspectFile,self.filePath,self.fileRealName,self.bucketName,self.fileName]] placeholderImage:nil];
    } else {
        self.imageViewNocontent.hidden = false;
    }
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
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
