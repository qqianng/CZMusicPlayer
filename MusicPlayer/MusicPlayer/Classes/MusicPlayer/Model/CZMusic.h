//
//  CZMusic.h
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZMusic : NSObject

/**
*  歌曲图片
*/
@property (nonatomic, copy) NSString *image;

/**
 *  歌词文件名
 */
@property (nonatomic, copy) NSString *lrc;

/**
 *  歌曲文件名称
 */
@property (nonatomic, copy) NSString *mp3;

/**
 *  歌曲名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  歌手名称
 */
@property (nonatomic, copy) NSString *singer;

/**
 *  专辑名称
 */
@property (nonatomic, copy) NSString *album;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
