//
//  ViewController.m
//  GPUImageDemo
//
//  Created by yolo on 2017/3/30.
//  Copyright © 2017年 Qiun Cheng. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage/GPUImage.h>

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation ViewController {
  UIImage *_image;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  _imageView.userInteractionEnabled         = YES;
  UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGestureToSaveImageWith:)];
  UITapGestureRecognizer *tap               = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImageFromLibrary)];
  _imageView.contentMode                    = UIViewContentModeScaleAspectFit;
  [_imageView addGestureRecognizer:tap];
  [_imageView addGestureRecognizer:longGesture];
  [self.segmentedControl setEnabled:NO];
  
}
- (IBAction)segementedControlChanged:(UISegmentedControl *)sender {
  [self setFilterWithIndex:sender.selectedSegmentIndex];
}

- (void)setFilterWithIndex:(NSInteger)index {
  switch (index) {
    case 0: {
      GPUImageVignetteFilter *vignetteFilter    = [[GPUImageVignetteFilter alloc]init];
      [vignetteFilter forceProcessingAtSize:_imageView.image.size];
      [vignetteFilter useNextFrameForImageCapture];
      
      GPUImagePicture *stillImageSource         = [[GPUImagePicture alloc] initWithImage:_image];
  
      [stillImageSource addTarget:vignetteFilter];
      __weak ViewController *weakSelf = self;
      [stillImageSource processImageWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
          UIImage *newImage                         = [vignetteFilter imageFromCurrentFramebuffer];
          weakSelf.imageView.image                          = newImage;
        });
      }];
    }
      break;
    case 1: {
      GPUImageGammaFilter *gammaFileter = [[GPUImageGammaFilter alloc] init];
      [gammaFileter forceProcessingAtSize:_imageView.image.size];
      [gammaFileter useNextFrameForImageCapture];
      [gammaFileter setGamma:2.0];
      
      GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_image];
      [stillImageSource addTarget:gammaFileter];
      __weak ViewController *weakSelf = self;
      [stillImageSource processImageWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
          UIImage *newImage = [gammaFileter imageFromCurrentFramebuffer];
          [weakSelf.imageView setImage:newImage];
        });
      }];
    }
      break;
      
    default:
      break;
  }
}

- (void)chooseImageFromLibrary {
  if (_imageView.image == nil) {
    [self openLibrary];
  }
  else { /// change image
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定更换图片？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak ViewController *weakSelf = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      [weakSelf openLibrary];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"清除滤镜效果" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      [weakSelf.imageView setImage:_image];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
  }
}

- (void)openLibrary {
  UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
  pickerController.delegate                 = self;
  pickerController.allowsEditing            = NO;
  pickerController.sourceType               = UIImagePickerControllerSourceTypePhotoLibrary;
  [self presentViewController:pickerController animated:YES completion:^{
    
  }];
}

- (void)longGestureToSaveImageWith:(UILongPressGestureRecognizer *)longGesture {
  if (longGesture.state == UIGestureRecognizerStateBegan) {
    if (_imageView.image != nil) {
      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存图片到本地？" message:nil preferredStyle:UIAlertControllerStyleAlert];
      __weak ViewController *weakSelf = self;
      [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(weakSelf.imageView.image, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), nil);
      }]];
      [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
      }]];
      [self presentViewController:alertController animated:YES completion:nil];
    }
  }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
  NSLog(@"save image successfully.");
}

#pragma mark: -
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:^{
  }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  UIImage *image                            = info[UIImagePickerControllerOriginalImage];
  self.imageView.image                      = image;
  __weak ViewController *weakSelf           = self;
  [picker dismissViewControllerAnimated:YES completion:^{
    [weakSelf.segmentedControl setEnabled:YES];
    [weakSelf.segmentedControl setSelectedSegmentIndex:0];
    _image = weakSelf.imageView.image;
  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
