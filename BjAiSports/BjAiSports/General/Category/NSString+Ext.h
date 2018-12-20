//
//  NSString+Ext.h
//  BjAiSports
//
//  Created by 吴林丰 on 2018/12/18.
//  Copyright © 2018 吴林丰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Ext)
//过滤表情
- (NSString *)emojizedString;
+ (NSString *)emojizedStringWithString:(NSString *)text;
+ (BOOL)stringContainsEmoji:(NSString *)string;
+ (NSString *)disable_emoji:(NSString *)text;

/**
 * 获取设备名称
 */
+ (NSString *)getDeviceName;


@end

NS_ASSUME_NONNULL_END
