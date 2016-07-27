//
//  ViewController.m
//  imagePickerController
//
//  Created by yy on 16/7/26.
//  Copyright © 2016年 yueyang. All rights reserved.
//

#import "ViewController.h"

#define UIScreenHeight   [UIScreen mainScreen].bounds.size.height
#define UIScreenWidth    [UIScreen mainScreen].bounds.size.width


@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) UIImageView *img;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(UIScreenWidth/2 - 60, UIScreenHeight/2 + 130, 120, 50)];
    [_btn setTitle:@"hit me baby" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor colorWithRed:0.28 green:0.60 blue:0.88 alpha:1.00] forState:UIControlStateNormal];
    _btn.layer.cornerRadius = 20;
    _btn.backgroundColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.81 alpha:1.00];
    [_btn addTarget:self action:@selector(pickImageMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(UIScreenWidth/2 - 100, UIScreenHeight/2 - 100, 200, 200)];
    [self.view addSubview:_img];
    
}

-(void)pickImageMethod:(id)sender
{
    //创建
    UIAlertController *al = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                         {
                             
                             NSLog(@"取消");
                         }];
    [al addAction:a2];
    
    UIAlertAction *a3 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                         {
                             [self takePhoto];
                             NSLog(@"打开相机");
                             
                         }];
    [al addAction:a3];
    
    UIAlertAction *a4 = [UIAlertAction actionWithTitle:@"从相册添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                         {
                             
                             [self localPhoto];
                             NSLog(@"打开相册");
                         }];
    [al addAction:a4];
    [self presentViewController:al animated:YES completion:nil];

}

-(void)takePhoto
{
    //判断设备是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
         /*创建UIImagePickerController*/
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        
        /*设备不支持相机*/
        UIAlertController *al = [UIAlertController alertControllerWithTitle:@"⚠" message:@"该设备不支持相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            nil;
        }];
        [al addAction:a2];
        [self presentViewController:al animated:YES completion:nil];
    }
}

-(void)localPhoto
{
    //判断设备是否支持打开系统图库
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        /*创建UIImagePickerController*/
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        
        /*打开相册错误*/
        UIAlertController *al = [UIAlertController alertControllerWithTitle:@"⚠" message:@"打开相册错误"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            nil;
        }];
        [al addAction:a2];
        [self presentViewController:al animated:YES completion:nil];
    }

}


#pragma -mark 选择相册照片或相机拍摄照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",info);
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    /********************
     info是一个字典，包含以下键值对：
     UIImagePickerControllerCropRect   裁剪尺寸
     UIImagePickerControllerEditedImage   裁剪后的URL
     UIImagePickerControllerMediaType   指定用户选择的媒体类型（文章最后进行扩展）
     UIImagePickerControllerOriginalImage   原始图片
     UIImagePickerControllerReferenceURL  原始图片的URL
     ********************/
    
    //NSData *imgData = UIImagePNGRepresentation(image);   将图片转换为数据源格式，用于上传图片还有JPEG格式的用UIImageJPEGRepresentation(UIImage * __nonnull image, CGFloat compressionQuality);
    _img.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma -mark 点击取消后的代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
