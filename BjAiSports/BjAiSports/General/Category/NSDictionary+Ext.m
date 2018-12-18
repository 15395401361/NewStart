//
//  NSDictionary+Ext.m
//  Qilekang
//
//  Created by wj on 14-7-11.
//  Copyright (c) 2014年 Qilekang. All rights reserved.
//

#import "NSDictionary+Ext.h"
#import "NSMutableArray+Ext.h"
@implementation NSDictionary (value)

#define documentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
-(void)archiverOriginalWithCoder:(NSString*)coder
{
      NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",coder]];
      BOOL result = [NSKeyedArchiver archiveRootObject:self toFile:filePath];
      if (result) {
         QLKDLog(@"归档成功");
      }else{
         QLKDLog(@"归档失败");
      }
}

+(id)unarchiverOriginalWithCoder:(NSString*)coder
{
      NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",coder]];
      NSMutableDictionary *unarchiverArr = [NSMutableDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:filePath]];
      return unarchiverArr;
}

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks {
    
    const NSMutableDictionary *replaced = [self mutableCopy];
    
    const id nul = [NSNull null];
    
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        
        id object = [self objectForKey:key];
        
        if (object == nul) [replaced setObject:blank forKey:key];
        
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setObject:[object dictionaryByReplacingNullsWithBlanks] forKey:key];
        
        else if ([object isKindOfClass:[NSArray class]]) [replaced setObject:[object arrayByReplacingNullsWithBlanks] forKey:key];
        
        if([object isKindOfClass:[NSNumber class]]){
            
            //   如果后台返回有 double  float类型,,此步骤时候 经过ios 自带json解析(6.66  就已经变成了6.5999999999) 下面的方法 全局处理 保留三位小数精度,,相当于还原了 ios自带json 解析丢失精度的问题,亲测有效)
            double conversionValue = (double)[object floatValue];
            NSString *d2Str = [NSString stringWithFormat:@"%.3lf",conversionValue];
            
            NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:d2Str];
            
            NSString *strD2 = [num1 stringValue];
            
            [replaced setObject:strD2 forKey:key];
            
        }
        
    }
    
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
    
}




//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSArray中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}

//主要方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
//    else if([myObj isKindOfClass:[NSArray class]])
//    {
//        return [self nullArr:myObj];
//    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}

- (BOOL)hasValueForKey:(NSString *)key
{
    BOOL hasValue = FALSE;
    if (key) {
        if ([self valueForKey:key]) {
            hasValue = TRUE;
        }
    }
    
    return hasValue;
}

- (BOOL)boolValueForKey:(NSString *)key
{
    BOOL boolValue = FALSE;
    if (key) {
        id object = [self valueForKey:key];
        if ([object respondsToSelector:@selector(boolValue)]) {
            boolValue = [object boolValue];
        }
    }
    
    return boolValue;
}

- (int)intValueForKey:(NSString *)key
{
    int intValue = 0;
    if (key) {
        id object = [self valueForKey:key];
        if ([object respondsToSelector:@selector(intValue)]) {
            intValue = [object intValue];
        }
    }
    
    return intValue;
}

- (NSInteger)integerValueForKey:(NSString *)key
{
    NSInteger integerValue = 0;
    if (key) {
        id object = [self valueForKey:key];
        if ([object respondsToSelector:@selector(integerValue)]) {
            integerValue = [object integerValue];
        }
    }
    
    return integerValue;
}

- (long)longValueForKey:(NSString *)key
{
    long longValue = 0;
    if (key) {
        id object = [self valueForKey:key];
        if ([object respondsToSelector:@selector(longValue)]) {
            longValue = [object longValue];
        }
    }
    
    return longValue;
}

- (long long)longlongValueForKey:(NSString *)key
{
    long long longlongValue = 0;
    if (key) {
        id object = [self valueForKey:key];
        if ([object respondsToSelector:@selector(longLongValue)]) {
            longlongValue = [object longLongValue];
        }
    }
    
    return longlongValue;
}

- (float)floatValueForKey:(NSString *)key
{
    float floatValue = 0;
    if (key) {
        id object = [self valueForKey:key];
        if ([object respondsToSelector:@selector(floatValue)]) {
            floatValue = [object floatValue];
        }
    }
    
    return floatValue;
}

- (double)doubleValueForKey:(NSString *)key
{
    double doubleValue = 0;
    if (key) {
        id object = [self valueForKey:key];
        if ([object respondsToSelector:@selector(doubleValue)]) {
            doubleValue = [object doubleValue];
        }
    }
    
    return doubleValue;
}

@end

@implementation NSDictionary (Data)

- (CGRect)rectForKey:(NSString *)key
{
    CGRect rectValue = CGRectZero;
    if (key) {
        id object = [self valueForKey:key];
        if (object && [object isKindOfClass:[NSDictionary class]]) {
            BOOL result = FALSE;
            result = CGRectMakeWithDictionaryRepresentation((CFDictionaryRef)object, &rectValue);
            if (!result) {
                rectValue = CGRectZero;
            }
        }
    }
    
    return rectValue;
}

- (CGPoint)pointForKey:(NSString *)key
{
    CGPoint pointValue = CGPointZero;
    if (key) {
        id object = [self valueForKey:key];
        if (object && [object isKindOfClass:[NSDictionary class]]) {
            BOOL result = FALSE;
            result = CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)object, &pointValue);
            if (!result) {
                pointValue = CGPointZero;
            }
        }
    }
    
    return pointValue;
}

- (CGSize)sizeForKey:(NSString *)key
{
    CGSize sizeValue = CGSizeZero;
    if (key) {
        id object = [self valueForKey:key];
        if (object && [object isKindOfClass:[NSDictionary class]]) {
            BOOL result = FALSE;
            result = CGSizeMakeWithDictionaryRepresentation((CFDictionaryRef)object, &sizeValue);
            if (!result) {
                sizeValue = CGSizeZero;
            }
        }
    }
    
    return sizeValue;
}

- (const char*)cStringForKey:(NSString *)key
{
    const char *cString = NULL;
    if (key) {
        id object = [self valueForKey:key];
        if ([object respondsToSelector:@selector(UTF8String)]) {
            cString = [object UTF8String];
        }
    }
    
    return cString;
}

- (SEL)selectorForKey:(NSString *)key
{
    SEL selector = NULL;
    const char *name = [self cStringForKey:key];
    if (name) {
        selector = sel_registerName(name);
    }
    
    return selector;
}

@end


@implementation NSDictionary (MutableDeepCopy)

- (NSMutableDictionary *) mutableDeepCopy {
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithCapacity:[self count]];
    NSArray *keys=[self allKeys];
    for(id key in keys)
    {
        id value=[self objectForKey:key];
        id copyValue;
        if ([value respondsToSelector:@selector(mutableDeepCopy)])
        {
            copyValue=[value mutableDeepCopy];
        }
        else if([value respondsToSelector:@selector(mutableCopy)])
        {
            if ([value isMemberOfClass:[UIImage class]])
            {
                continue;
            }
            copyValue=[value mutableCopy];
        }
        if(copyValue==nil)
        {
            copyValue=[value copy];
        }
        [dict setObject:copyValue forKey:key];
    }
    return dict;
}


- (NSString*)coverString
{
    if ([self isKindOfClass:[NSDictionary class]]) {
        NSMutableString * temp = [NSMutableString string];
        for (int i = 0; i < [[self allKeys]count]; i++) {
            NSString* key = [[self allKeys] objectAtIndex:i];
            [temp appendFormat:@"%@=",key];
            if (i < [[self allKeys]count] - 1) {
                [temp appendFormat:@"\"%@\";",[self objectForKey:key]];
            }else{
                [temp appendFormat:@"\"%@\"",[self objectForKey:key]];
            }
        }
        return temp;
    }
    return [NSString string];
}

- (NSString*)coverPreString
{
    if ([self isKindOfClass:[NSDictionary class]]) {
        NSMutableString * temp = [NSMutableString string];
        for (int i = 0; i < [[self allKeys]count]; i++) {
            NSString* key = [[self allKeys] objectAtIndex:i];
            [temp appendFormat:@"%@=",key];
            if (i < [[self allKeys]count] - 1) {
                [temp appendFormat:@"%@;",[self objectForKey:key]];
            }else{
                [temp appendFormat:@"%@",[self objectForKey:key]];
            }
        }
        return temp;
    }
    return [NSString string];
}

@end
