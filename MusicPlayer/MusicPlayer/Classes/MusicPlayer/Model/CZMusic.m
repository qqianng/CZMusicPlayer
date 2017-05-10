//
//  CZMusic.m
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "CZMusic.h"

@implementation CZMusic

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {};

@end
