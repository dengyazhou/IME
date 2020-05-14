//
//  SaoYiSaoVC.m
//  二维码扫描
//
//  Created by 邓亚洲 on 2018/6/4.
//  Copyright © 2018年 小码DYZ. All rights reserved.
//

#import "SaoYiSaoVC.h"
#import "Header.h"

#import <AudioToolbox/AudioToolbox.h>
#import <ZXCapture.h>
#import <ZXResult.h>
#import <ZXResultPoint.h>


@interface SaoYiSaoVC (){
    CGAffineTransform _captureSizeTransform;
}


@property (weak, nonatomic) IBOutlet UIView *viewNat;

@property (nonatomic, strong) ZXCapture *capture;
@property (weak, nonatomic) IBOutlet UIView *scanRectView;
@property (weak, nonatomic) IBOutlet UILabel *waitLabel;

@property (nonatomic) BOOL scanning;
@property (nonatomic) BOOL isFirstApplyOrientation;



@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation SaoYiSaoVC

- (void)dealloc {
    [self.capture.layer removeFromSuperlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.heightNavBar.constant = Height_NavBar;
    self.labelTitle.text = self.scanTitle;

    self.capture = [[ZXCapture alloc] init];
    self.capture.sessionPreset = AVCaptureSessionPreset1920x1080;
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.delegate = self;

    self.scanning = NO;

    [self.view.layer addSublayer:self.capture.layer];


    [self.view bringSubviewToFront:self.viewNat];
    [self.view bringSubviewToFront:self.scanRectView];
    [self.view bringSubviewToFront:self.waitLabel];

}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        NSLog(@"111>>>>>%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"222>>>>>%@",[NSThread currentThread]);
            if (granted) {
                //配置扫描view
                if (_isFirstApplyOrientation) return;
                _isFirstApplyOrientation = TRUE;
                [self applyOrientation];
            } else {
                NSString *title = @"请在iPhone的”设置-隐私-相机“选项中，允许App访问你的相机";
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:@"" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                [alertView show];
            }

        });
    }];

  
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
  } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
   {
     [self applyOrientation];
   }];
}

#pragma mark - Private
- (void)applyOrientation {
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  float scanRectRotation;
  float captureRotation;

  switch (orientation) {
    case UIInterfaceOrientationPortrait:
      captureRotation = 0;
      scanRectRotation = 90;
      break;
    case UIInterfaceOrientationLandscapeLeft:
      captureRotation = 90;
      scanRectRotation = 180;
      break;
    case UIInterfaceOrientationLandscapeRight:
      captureRotation = 270;
      scanRectRotation = 0;
      break;
    case UIInterfaceOrientationPortraitUpsideDown:
      captureRotation = 180;
      scanRectRotation = 270;
      break;
    default:
      captureRotation = 0;
      scanRectRotation = 90;
      break;
  }
  self.capture.layer.frame = self.view.frame;
  CGAffineTransform transform = CGAffineTransformMakeRotation((CGFloat) (captureRotation / 180 * M_PI));
  [self.capture setTransform:transform];
  [self.capture setRotation:scanRectRotation];

  [self applyRectOfInterest:orientation];
}

- (void)applyRectOfInterest:(UIInterfaceOrientation)orientation {
  CGFloat scaleVideoX, scaleVideoY;
  CGFloat videoSizeX, videoSizeY;
  CGRect transformedVideoRect = self.scanRectView.frame;
  if([self.capture.sessionPreset isEqualToString:AVCaptureSessionPreset1920x1080]) {
    videoSizeX = 1080;
    videoSizeY = 1920;
  } else {
    videoSizeX = 720;
    videoSizeY = 1280;
  }
  if(UIInterfaceOrientationIsPortrait(orientation)) {
    scaleVideoX = self.capture.layer.frame.size.width / videoSizeX;
    scaleVideoY = self.capture.layer.frame.size.height / videoSizeY;

    // Convert CGPoint under portrait mode to map with orientation of image
    // because the image will be cropped before rotate
    // reference: https://github.com/TheLevelUp/ZXingObjC/issues/222
    CGFloat realX = transformedVideoRect.origin.y;
    CGFloat realY = self.capture.layer.frame.size.width - transformedVideoRect.size.width - transformedVideoRect.origin.x;
    CGFloat realWidth = transformedVideoRect.size.height;
    CGFloat realHeight = transformedVideoRect.size.width;
    transformedVideoRect = CGRectMake(realX, realY, realWidth, realHeight);

  } else {
    scaleVideoX = self.capture.layer.frame.size.width / videoSizeY;
    scaleVideoY = self.capture.layer.frame.size.height / videoSizeX;
  }

  _captureSizeTransform = CGAffineTransformMakeScale(1.0/scaleVideoX, 1.0/scaleVideoY);
  self.capture.scanRect = CGRectApplyAffineTransform(transformedVideoRect, _captureSizeTransform);
}

#pragma mark - Private Methods

- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format {
  switch (format) {
    case kBarcodeFormatAztec:
      return @"Aztec";

    case kBarcodeFormatCodabar:
      return @"CODABAR";

    case kBarcodeFormatCode39:
      return @"Code 39";

    case kBarcodeFormatCode93:
      return @"Code 93";

    case kBarcodeFormatCode128:
      return @"Code 128";

    case kBarcodeFormatDataMatrix:
      return @"Data Matrix";

    case kBarcodeFormatEan8:
      return @"EAN-8";

    case kBarcodeFormatEan13:
      return @"EAN-13";

    case kBarcodeFormatITF:
      return @"ITF";

    case kBarcodeFormatPDF417:
      return @"PDF417";

    case kBarcodeFormatQRCode:
      return @"QR Code";

    case kBarcodeFormatRSS14:
      return @"RSS 14";

    case kBarcodeFormatRSSExpanded:
      return @"RSS Expanded";

    case kBarcodeFormatUPCA:
      return @"UPCA";

    case kBarcodeFormatUPCE:
      return @"UPCE";

    case kBarcodeFormatUPCEANExtension:
      return @"UPC/EAN extension";

    default:
      return @"Unknown";
  }
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureCameraIsReady:(ZXCapture *)capture {
  self.scanning = YES;
}

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
  if (!self.scanning) return;
  if (!result) return;

  // We got a result.
  [self.capture stop];
  self.scanning = NO;

  // Display found barcode location
  CGAffineTransform inverse = CGAffineTransformInvert(_captureSizeTransform);
  NSMutableArray *points = [[NSMutableArray alloc] init];
  NSString *location = @"";
  for (ZXResultPoint *resultPoint in result.resultPoints) {
    CGPoint cgPoint = CGPointMake(resultPoint.x, resultPoint.y);
    CGPoint transformedPoint = CGPointApplyAffineTransform(cgPoint, inverse);
    transformedPoint = [self.scanRectView convertPoint:transformedPoint toView:self.scanRectView.window];
    NSValue* windowPointValue = [NSValue valueWithCGPoint:transformedPoint];
    location = [NSString stringWithFormat:@"%@ (%f, %f)", location, transformedPoint.x, transformedPoint.y];
    [points addObject:windowPointValue];
  }

  // Display information about the result onscreen.
  NSString *formatString = [self barcodeFormatToString:result.barcodeFormat];
  NSString *display = [NSString stringWithFormat:@"Scanned!\n\nFormat: %@\n\nContents:\n%@\nLocation: %@", formatString, result.text, location];
//  [self.decodedLabel performSelectorOnMainThread:@selector(setText:) withObject:display waitUntilDone:YES];

//    NSLog(@"%@",result.text);

  // Vibrate
  AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    self.scanning = YES;
    [self.capture start];
  });

    if (self.resultBlock) {
        self.resultBlock(result.text?result.text:@"");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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


#pragma mark ---------------以前------------------

//#import "SaoYiSaoVC.h"
//#import <AVFoundation/AVFoundation.h>
//#import "Header.h"
//
//@interface SaoYiSaoVC () <AVCaptureMetadataOutputObjectsDelegate> {
//    NSTimer * _timer;
//    UIView * _boxView;
//    UIView * _viewPreview;
//
//    CGFloat _height_NavBar;
//}
//
//@property (nonatomic,strong) AVCaptureSession *captureSession;
//@property (nonatomic,strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
//@property (nonatomic,strong) UIImageView *scanImageView;
//@property (nonatomic,assign) BOOL isReading;
//
//@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
//
//@end
//
//@implementation SaoYiSaoVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    _height_NavBar = Height_NavBar;
//    self.heightNavBar.constant = _height_NavBar;
//
//    self.labelTitle.text = self.scanTitle;
//
//    _viewPreview = [[UIView alloc] initWithFrame:CGRectMake(0, _height_NavBar, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_height_NavBar)];
//    _viewPreview.backgroundColor = colorRGB(241, 241, 241);
//    [self.view addSubview:_viewPreview];
//
//    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//
//        NSLog(@"111>>>>>%@",[NSThread currentThread]);
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            NSLog(@"222>>>>>%@",[NSThread currentThread]);
//            if (granted) {
//                //配置扫描view
//                [self loadScanView];
//            } else {
//                NSString *title = @"请在iPhone的”设置-隐私-相机“选项中，允许App访问你的相机";
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:@"" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
//                [alertView show];
//            }
//
//        });
//    }];
//}
//
//- (void)loadScanView {
//    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
//    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    //2.用captureDevice创建输入流
//    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
//    //3.创建媒体数据输出流
//    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
//    //4.实例化捕捉会话
//    _captureSession = [[AVCaptureSession alloc] init];
//    //4.1.将输入流添加到会话
//    [_captureSession addInput:input];
//    //4.2.将媒体输出流添加到会话中
//    [_captureSession addOutput:output];
//    //5.设置代理 在主线程里刷新
//    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//    //5.2.设置输出媒体数据类型为QRCode
//    [output setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
//    //6.实例化预览图层
//    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
//    //7.设置预览图层填充方式
//    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
//    //8.设置图层的frame
//    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
//    //9.将图层添加到预览view的图层上
//    [_viewPreview.layer addSublayer:_videoPreviewLayer];
//    //10.设置扫描范围
//    output.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
//    //10.1.扫描框
//    _boxView = [[UIView alloc] initWithFrame:CGRectMake(_viewPreview.bounds.size.width * 0.2, _viewPreview.bounds.size.height*0.2, _viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f, _viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f)];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _boxView.bounds.size.width, _boxView.bounds.size.height)];
//    imageView.image = [UIImage imageNamed:@"组119"];
//    [_boxView addSubview:imageView];
//
//    _scanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _boxView.bounds.size.width, 2)];
//    _scanImageView.image = [UIImage imageNamed:@"椭圆1"];
//    [_boxView addSubview:_scanImageView];
//
//    [_viewPreview addSubview:_boxView];
//
//    //设置透明 背景
//    UIView *viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _viewPreview.bounds.size.width, _viewPreview.bounds.size.height*0.2)];
//    viewTop.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//    [_viewPreview addSubview:viewTop];
//    UIView *viewLeft = [[UIView alloc] initWithFrame:CGRectMake(0, _viewPreview.bounds.size.height*0.2, _viewPreview.bounds.size.width * 0.2, _viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f)];
//    viewLeft.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//    [_viewPreview addSubview:viewLeft];
//    UIView *viewRight = [[UIView alloc] initWithFrame:CGRectMake(_viewPreview.bounds.size.width * 0.2+(_viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f), _viewPreview.bounds.size.height*0.2, _viewPreview.bounds.size.width * 0.2, _viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f)];
//    viewRight.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//    [_viewPreview addSubview:viewRight];
//    UIView *viewBottom = [[UIView alloc] initWithFrame:CGRectMake(0, _viewPreview.bounds.size.height*0.2+(_viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f), _viewPreview.bounds.size.width, _viewPreview.bounds.size.height-(_viewPreview.bounds.size.height*0.2+(_viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f)))];
//    viewBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//    [_viewPreview addSubview:viewBottom];
//
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, _viewPreview.bounds.size.height*0.2+(_viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f)+15, _viewPreview.bounds.size.width, 20)];
//    label.text = @"请对准二维码，耐心等待";
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:18];
//
//    label.textAlignment = NSTextAlignmentCenter;
//    [_viewPreview addSubview:label];
//
//
//    [self startRunning];
//}
//
//#pragma mark 开始
//- (void)startRunning {
//    if (self.captureSession) {
//        self.isReading = YES;
//        [self.captureSession startRunning];
//        _timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveUpAndDownLine) userInfo:nil repeats: YES];
//    }
//}
//
//- (void)moveUpAndDownLine {
//    CGRect frame = self.scanImageView.frame;
//    if (_boxView.frame.size.height < self.scanImageView.frame.origin.y) {
//        frame.origin.y = 0;
//        self.scanImageView.frame = frame;
//    } else {
//        frame.origin.y += 1;
//        [UIView animateWithDuration:0.01 animations:^{
//            self.scanImageView.frame = frame;
//        }];
//    }
//}
//
//#pragma mark - AVCaptureMetadataOutputObjectsDelegate
//- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
//    //判断是否有数据
//    if (!_isReading) {
//        return;
//    }
//    if (metadataObjects.count > 0) {
//        _isReading = NO;
//        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
//        NSString *result = metadataObject.stringValue;
//        if (self.resultBlock) {
//            self.resultBlock(result?result:@"");
//        }
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//}
//
//#pragma mark 结束
//- (void)stopRunning {
//    if ([_timer isValid]) {
//        [_timer invalidate];
//        _timer = nil ;
//    }
//    [self.captureSession stopRunning];
//    [_scanImageView removeFromSuperview];
//    [_viewPreview removeFromSuperview];
//    [_videoPreviewLayer removeFromSuperlayer];
//}
//
//- (IBAction)back:(id)sender {
//    [self stopRunning];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end