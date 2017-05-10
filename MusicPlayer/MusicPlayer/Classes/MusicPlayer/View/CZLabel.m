//
//  CZLabel.m
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "CZLabel.h"

@implementation CZLabel
//rect 应该就是self.bounds
- (void)drawRect:(CGRect)rect
{
    // 文字画出来
    [super drawRect:rect];
    
    // 填充颜色
    [self.highLightColor setFill];
    // 进度矩形
    CGRect colorRect = CGRectMake(0, 0, rect.size.width * self.progress, rect.size.height);
    UIRectFillUsingBlendMode(colorRect, kCGBlendModeSourceIn);
}

- (void)setProgress:(CGFloat)progress
{
    _progress= progress;
    
    // 进度更新的时候, 更新界面
    [self setNeedsDisplay];
}

@end
