//
//  KXJson.h
//  KaiXinClient
//
//  Created by liu feng on 11-12-7.
//  Copyright (c) 2011年 kaixin001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KXJson : NSObject <NSCopying>
{
    id json;
}

@property(nonatomic, retain) id json;

- (KXJson *)getJsonForKey:(NSString*)key;
- (KXJson *)getJsonForIndex:(int)index;

- (NSString *)getStringForKey:(NSString*)key;
- (int)getIntForKey:(NSString *)key;
- (long long)getLongLongForKey:(NSString *)key;
- (BOOL)getBoolForKey:(NSString *)key;
- (float)getFloatForKey:(NSString *)key;
- (double)getDoubleForKey:(NSString *)key;
- (id)getObjectForKey:(NSString *)key;

- (NSString*)getStringForIndex:(int)index;
- (int)getIntForIndex:(int)index;
- (long long)getLongLongForIndex:(int)index;
- (BOOL)getBoolForIndex:(int)index;
- (float)getFloatForIndex:(int)index;
- (double)getDoubleForIndex:(int)index;
- (id)getObjectForIndex:(int)index;

- (BOOL)haveIntValueForKey:(NSString*)key;
- (BOOL)haveDoubleValueForKey:(NSString*)key;
- (BOOL)haveFloatValueForKey:(NSString *)key;
- (BOOL)haveStringValueForKey:(NSString*)key;
- (BOOL)haveJsonValueForKey:(NSString*)key;

-(unsigned int)count;

-(void)printJson;

+(KXJson*)jsonWithDictonary;
+(KXJson*)jsonWithArray;
+(KXJson*)jsonWithObject:(id)object;
+(KXJson*)jsonWithJsonString:(NSString *)jsonString; //通过字符串创建
- (NSString *)toJsonString; //转化为JSON字符串

- (NSString *)toString;

// 修改数据相关 不建议使用这些函数，因为无法通知相关的observer数据已被修改
// 插入
- (BOOL)insertData:(id)data atIndex:(NSInteger)index; 
- (BOOL)insertData:(NSObject *)data forKey:(NSString *)key;

// 修改值 dong jianbo
- (BOOL)setData:(NSObject *)data atIndex:(NSInteger)index;
- (BOOL)setData:(NSObject *)data forKey:(NSString *)key;
- (BOOL)setIntValue:(int)value forKey:(NSString *)key;
//删除
- (BOOL)removeDataAtIndex:(NSInteger)index;
- (BOOL)removeDataAtArray:(NSArray*)array;

@end
