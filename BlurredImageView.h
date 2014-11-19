//
//  BlurredImageView.h
//  BlueImageDemo
//
//  Created by Nic on 14/11/19.
//  Copyright (c) 2014年 coldworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlurredImageView : UIImageView

@property (nonatomic) float blurredLevel;   // 可以设置图片的模糊度，范围：0.0～100.0

@end
