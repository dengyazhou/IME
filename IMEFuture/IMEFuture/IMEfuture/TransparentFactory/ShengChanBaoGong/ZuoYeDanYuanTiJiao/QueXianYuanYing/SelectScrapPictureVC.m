//
//  SelectScrapPictureVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/3/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "SelectScrapPictureVC.h"
#import "VoHeader.h"

#import "ZuoYeDanYuanTiJiaoCollectionViewCell.h"
#import "ZuoYeDanYuanTiJiaoCollectionViewCell1.h"
#import "TpfCheckBigPictureAndDeletePictureVC.h"

#import "UploadImageBean.h"
#import <AVFoundation/AVFoundation.h>

@interface SelectScrapPictureVC () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;


@property (nonatomic,strong) UIImagePickerController *imagePicker;


@property(nonatomic,strong) NSMutableArray <UploadImageBean * >*arrayDateImage;

@end

@implementation SelectScrapPictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    self.heightBottomBar.constant = Height_BottomBar;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.estimatedItemSize = CGSizeMake(0.1, 0.1);
//    if (@available(iOS 10.0, *)) {
//        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
//    } else {
//        // Fallback on earlier versions
//    }
    
    
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    layout.minimumLineSpacing = 0.1;
    layout.minimumInteritemSpacing = 0.1;
    self.collectionView.collectionViewLayout = layout;
    
     
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZuoYeDanYuanTiJiaoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"zuoYeDanYuanTiJiaoCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZuoYeDanYuanTiJiaoCollectionViewCell1" bundle:nil] forCellWithReuseIdentifier:@"zuoYeDanYuanTiJiaoCollectionViewCell1"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayUploadImageBean.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.arrayUploadImageBean.count) {
        ZuoYeDanYuanTiJiaoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zuoYeDanYuanTiJiaoCollectionViewCell" forIndexPath:indexPath];
        cell.imageViewYZ.image = [UIImage imageWithData:self.arrayUploadImageBean[indexPath.row].data];
        [cell.button addTarget:self action:@selector(buttonClickChaKanDaTuD:) forControlEvents:UIControlEventTouchUpInside];
        cell.button.tag = indexPath.row;
        return cell;
    } else if (indexPath.row == self.arrayUploadImageBean.count) {
        ZuoYeDanYuanTiJiaoCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zuoYeDanYuanTiJiaoCollectionViewCell1" forIndexPath:indexPath];
        [cell.button addTarget:self action:@selector(buttonAddImage:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else {
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(90,90);
}



- (void)buttonAddImage:(UIButton *)button {
    [self addImage];
}

- (void)buttonClickChaKanDaTuD:(UIButton *)button {
    TpfCheckBigPictureAndDeletePictureVC *vc = [[TpfCheckBigPictureAndDeletePictureVC alloc] init];
    vc.arrayUploadImageBean = self.arrayUploadImageBean;
    vc.index = button.tag;
    vc.buttonBackBlock = ^{
        [self.collectionView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)buttonConfirm:(id)sender {
    if (self.blockArrayUploadImageBean) {
        self.blockArrayUploadImageBean(self.arrayUploadImageBean);
    }
    [self.navigationController popViewControllerAnimated:true];
}

- (void)addImage {
    if (self.arrayUploadImageBean.count >= 10) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"最多添加10张图片"];
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相机权限
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。
            authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.imagePicker = [[UIImagePickerController alloc] init];
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                self.imagePicker.delegate = self;
                self.imagePicker.allowsEditing = NO;
                [self presentViewController:self.imagePicker animated:YES completion:nil];
                
                
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请在iPhone的“设置－隐私”选项中，允许智造家访问你的摄像机和麦克风" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:action];
                [self.imagePicker presentViewController:alertController animated:YES completion:nil];
            }
        }else{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.imagePicker = [[UIImagePickerController alloc] init];
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                self.imagePicker.delegate = self;
                self.imagePicker.allowsEditing = NO;
                [self presentViewController:self.imagePicker animated:YES completion:nil];
                
            }
            else
            {
                NSLog(@"手机不支持相机");
            }
        }
        
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            self.imagePicker = [[UIImagePickerController alloc] init];
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.imagePicker.delegate = self;
            self.imagePicker.allowsEditing = NO;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [action0 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action3 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    [alertController addAction:action0];
    [alertController addAction:action1];
    [alertController addAction:action3];
    
    if ([alertController respondsToSelector:@selector(popoverPresentationController)]) {
        alertController.popoverPresentationController.sourceView = self.view;//必须加
        alertController.popoverPresentationController.sourceRect = CGRectMake(0, kMainH, kMainW, kMainH);//可选
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
//    CGSize size = CGSizeMake(640, 640);
    CGSize size = CGSizeMake(320, 320);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data = UIImageJPEGRepresentation(newImage, 0.6);
    
    UploadImageBean *uploadImageBean = [[UploadImageBean alloc] init];
    uploadImageBean.data = data;
    uploadImageBean.name = self.TypeUploadImageName;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [formatter stringFromDate:[NSDate date]];
    if (self.productionControlNumAndprocessOperationId) {
        uploadImageBean.fileName = [NSString stringWithFormat:@"%@.png",self.productionControlNumAndprocessOperationId];
    } else if (self.confirmUser) {
        uploadImageBean.fileName = [NSString stringWithFormat:@"%@%@.png",strDate,self.confirmUser];
    } else {
        uploadImageBean.fileName = [NSString stringWithFormat:@"%@.png",strDate];
    }
    uploadImageBean.mimeType = @"image/png";
    
    [self.arrayUploadImageBean addObject:uploadImageBean];
    

    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
