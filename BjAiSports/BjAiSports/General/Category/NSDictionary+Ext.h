//
//  NSDictionary+Ext.h
//  Qilekang
//
//  Created by wj on 14-7-11.
//  Copyright (c) 2014年 Qilekang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  从字典中获取一般数据类型值
 */
@interface NSDictionary (value)

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;
/**
 *  序列化
 */
-(void)archiverOriginalWithCoder:(NSString*)coder;

/**
 *  反序列化
 */

+(id)unarchiverOriginalWithCoder:(NSString*)coder;

+(id)changeType:(id)myObj;
/**
 *  是否存在关键字
 *
 *  @param key 关键字
 *
 *  @return false,true
 */
- (BOOL)hasValueForKey:(NSString *)key;

/**
 *  布尔值
 *
 *  @param key 关键字
 */
- (BOOL)boolValueForKey:(NSString *)key;

/**
 *  整型值
 *
 *  @param key 关键字
 */
- (int)intValueForKey:(NSString *)key;
- (NSInteger)integerValueForKey:(NSString *)key;

/**
 *  长整型
 *
 *  @param key 关键字
 */
- (long)longValueForKey:(NSString *)key;

/**
 *  超长整型
 *
 *  @param key 关键字
 */
- (long long)longlongValueForKey:(NSString *)key;

/**
 *  浮点型
 *
 *  @param key 关键字
 */
- (float)floatValueForKey:(NSString *)key;

/**
 *  双精度浮点型
 *
 *  @param key 关键字
 */
- (double)doubleValueForKey:(NSString *)key;


@end

/**
 *  从字典中获取一般
 */
@interface NSDictionary (Data)

/**
 *  矩形
 *
 *  @param key 关键字
 */
- (CGRect)rectForKey:(NSString *)key;

/**
 *  点
 *
 *  @param key 关键字
 */
- (CGPoint)pointForKey:(NSString *)key;

/**
 *  大小
 *
 *  @param key 关键字
 */
- (CGSize)sizeForKey:(NSString *)key;

/**
 *  C字符串
 *
 *  @param key 关键字
 *
 *  @return 返回C字符串，自动释放，因此如果需要使用，需要拷贝存储
 */
- (const char*)cStringForKey:(NSString *)key;

/**
 *  selector
 *
 *  @param key 关键字
 */
- (SEL)selectorForKey:(NSString *)key;

@end

//字典深拷贝
@interface NSDictionary (MutableDeepCopy)

- (NSMutableDictionary *)mutableDeepCopy;


- (NSString*)coverString;
@end
