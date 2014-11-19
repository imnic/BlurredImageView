//
//  BlurredImageView.m
//  BlueImageDemo
//
//  Created by Nic on 14/11/19.
//  Copyright (c) 2014年 coldworks. All rights reserved.
//

#import "BlurredImageView.h"

@interface BlurredImageView ()

@property (nonatomic, strong) CIImage *ciImage;
@property (nonatomic, strong) CIContext *ciContext;

@end

@implementation BlurredImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContext];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        [self setupContext];
    }
    return self;
}

- (void)setupContext
{
    _ciContext = [CIContext contextWithOptions:nil];
}

- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    
    if (!self.ciImage)
    {
        self.ciImage = [[CIImage alloc] initWithImage:image];
    }
}

- (void)setBlurredLevel:(float)blurredLevel
{
    if (blurredLevel > 100.0) {
        blurredLevel = 100.0;
    }
    else if (blurredLevel < 0.0)
    {
        blurredLevel = 0.0;
    }
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:self.ciImage forKey:kCIInputImageKey];
    [filter setValue:@(blurredLevel) forKey:kCIInputRadiusKey];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGRect rect             = [result extent];
    rect.origin.x          += (rect.size.width  - self.image.size.width ) / 2;
    rect.origin.y          += (rect.size.height - self.image.size.height) / 2;
    rect.size               = self.image.size;
    
    CGImageRef cgImage = [self.ciContext createCGImage:result fromRect:rect];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage scale:self.image.scale orientation:self.image.imageOrientation];
    
    CGImageRelease(cgImage);
    
    self.image = image;
}

@end
