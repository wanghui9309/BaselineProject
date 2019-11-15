//
//  HMPhotoViewerController.m
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMPhotoViewerController.h"
#import "HMPhotoProgressView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HMPhotoViewerController ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) HMPhotoProgressView *progressView;
@property (nonatomic) NSURL *url;

@end

@implementation HMPhotoViewerController

#pragma mark - 构造函数
+ (instancetype)viewerWithURLString:(NSString *)urlString photoIndex:(NSInteger)photoIndex {
    return [[self alloc] initWithURLString:urlString photoIndex:photoIndex];
}

- (instancetype)initWithURLString:(NSString *)urlString photoIndex:(NSInteger)photoIndex {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _url = [NSURL URLWithString:urlString];
        _photoIndex = photoIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self loadImage];
}

#pragma mark - 照片相关
- (void)loadImage {
    
    [_imageView sd_setImageWithURL:_url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _progressView.progress = (float)receivedSize / expectedSize;
        });
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) {
            return;
        }
        [self setImagePosition:image];
    }];
}

- (void)setImagePosition:(UIImage *)image {
    CGSize size = [self imageSizeWithScreen:image];
    
    _imageView.frame = CGRectMake(0, 0, size.width, size.height);
    _imageView.center = self.view.center;
}

- (CGSize)imageSizeWithScreen:(UIImage *)image {
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat height = image.size.height * size.width / image.size.width;
    if (height <= size.height) {
        size.height = height;
    }
    
    return size;
}

#pragma mark - 设置界面
- (void)prepareUI {
    _imageView = [[UIImageView alloc] init];
    _imageView.center = self.view.center;
    [self.view addSubview:_imageView];
    
    _progressView = [[HMPhotoProgressView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    _progressView.center = self.view.center;
    [self.view addSubview:_progressView];
    
    _progressView.progress = 1.0;
}

@end
