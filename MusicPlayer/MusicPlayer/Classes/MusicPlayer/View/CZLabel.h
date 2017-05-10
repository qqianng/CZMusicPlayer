//
//  CZLabel.h
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZLabel : UILabel
/**
 *  文字的高亮颜色
 */
@property (strong, nonatomic) UIColor *highLightColor;
/**
 *  高亮颜色文字的进度
 */
@property (assign, nonatomic) CGFloat progress;

@end
