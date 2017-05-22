//
//  QRCodeViewController.m
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/8/25.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "QRCodeViewController.h"
#import "QRCodeCameraViewController.h"
#import "QRCodePhotoLibrary.h"
#import "QRCodeCreate.h"

@interface QRCodeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (nonatomic,strong) UIImagePickerController *photoPicker;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)clickBtn:(UIButton *)sender {
    
    if (sender.tag == 1001) {
        //启用摄像头读取
        [self readQRCodeByCamera];
    } else if (sender.tag == 1002) {
        //从相册读取
        [self readQRCodeByPhotoLibrary];
    } else if (sender.tag == 1003) {
        //生成二维码
        [self createQRCode];
    } else if (sender.tag == 1004) {
        //生成带中心logo的二维码
        [self createQRCodeWithIcon];
    }
}
#pragma mark - define 

- (void)readQRCodeByCamera {
    
    QRCodeCameraViewController *cameraVC = [[QRCodeCameraViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    [cameraVC QRCodeCompletionSuccess:^(NSString *str) {
        weakSelf.resultLabel.text = str;
    } Failure:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    [self.navigationController pushViewController:cameraVC animated:YES];

}

- (void)createQRCode {

    QRCodeCreate *cc = [[QRCodeCreate alloc] init];
    __weak typeof(self) weakSelf = self;
    [cc QRCodeWithContent:@"123" CompletionSuccess:^(UIImage *image) {
        weakSelf.imgView1.image = image;
    } Failure:^(NSString *str) {
        NSLog(@"%@",str);
    }];

}

- (void)createQRCodeWithIcon {
    
    QRCodeCreate *cc = [[QRCodeCreate alloc] init];
    __weak typeof(self) weakSelf = self;
    [cc QRCodeWithContent:@"123" icon:[UIImage imageNamed:@"111"] CompletionSuccess:^(UIImage *image) {
        weakSelf.imgView2.image = image;
    } Failure:^(NSString *str) {
        NSLog(@"%@",str);
    }];
}

- (void)readQRCodeByPhotoLibrary {

    self.photoPicker = [[UIImagePickerController alloc] init];
    self.photoPicker.delegate = self;
    self.photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.photoPicker animated:YES completion:NULL];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *srcImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    QRCodePhotoLibrary *pl = [[QRCodePhotoLibrary alloc] init];
    __weak typeof(self) weakSelf = self;
    [pl QRCodeWithImage:srcImage CompletionSuccess:^(NSString *str) {
        weakSelf.resultLabel.text = str;
    } Failure:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    
}


@end
