//
//  KXJson.m
//  KaiXinClient
//
//  Created by liu feng on 11-12-7.
//  Copyright (c) 2011年 kaixin001. All rights reserved.
//

#import "KXJson.h"
#import "JSONKit.h"

@implementation KXJson
@synthesize json;

#pragma mark - Create a KXJson object
+ (KXJson *)jsonWithArray
{
    return [self.class jsonWithObject:[NSMutableArray array]];
}
+ (KXJson *)jsonWithDictonary
{
    return [self.class jsonWithObject:[NSMutableDictionary dictionary]]; 
}
+(KXJson*)jsonWithObject:(id)object
{
    KXJson* jsonObj = [[[KXJson alloc] init] autorelease];
    if ([object isKindOfClass:[NSDictionary class]] || [object isKindOfClass:[NSArray class]]) {
        jsonObj.json = object;
    }
    
    return jsonObj;
}

+ (KXJson *)jsonWithJsonString:(NSString *)jsonString
{
    return [self.class jsonWithObject:[jsonString mutableObjectFromJSONString]];
}

-(void) dealloc
{
    [json release];
    [super dealloc];
}

#pragma mark - Get json element functions
-(KXJson*)getJsonForKey:(NSString*)key
{
    id retObj = nil;
    
    if (nil != key &&
        [json isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)json;
        retObj = [dict objectForKey:key];
    }
    
    if (retObj == nil)
    {
        retObj = [NSDictionary dictionary];
    }
    
    return [KXJson jsonWithObject:retObj];
}

-(KXJson*)getJsonForIndex:(int)index
{
    id retObj = nil;
    
    if ([json isKindOfClass:[NSArray class]]) {
        
        NSArray* array = (NSArray*)json;
        
        if ([array count] > index) 
        {
            retObj = [array objectAtIndex:index];            
        }
    }
    
    if (retObj == nil) {
        retObj = [NSArray array];
    }
    
    return [KXJson jsonWithObject:retObj];
}

-(NSString*)getStringForKey:(NSString*)key
{
    id retObj = [NSString string];
    
    if (nil != key &&
        [json isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)json;
        retObj = [dict objectForKey:key];
        
        if ([retObj isKindOfClass:[NSNumber class]])
        {
            retObj = [retObj stringValue];
        }
        
        if (![retObj isKindOfClass:[NSString class]])
        {
            retObj = [NSString string];
        }
    }
    
    return retObj;
}

- (id)getObjectForKey:(NSString *)key
{
    id retObj = nil;
    if (nil != key &&
        [json isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)json;
        retObj = [dict objectForKey:key];
    }
    return retObj;
}

- (int)getIntForKey:(NSString *)key
{
    return [[self getStringForKey:key] intValue];
}

- (long long)getLongLongForKey:(NSString *)key
{
    return [[self getStringForKey:key] longLongValue];
}

- (BOOL)getBoolForKey:(NSString *)key
{
    return [[self getStringForKey:key] boolValue];
}

- (float)getFloatForKey:(NSString *)key
{
    return [[self getStringForKey:key] floatValue];
}

- (double)getDoubleForKey:(NSString *)key
{
    return [[self getStringForKey:key] doubleValue];
}

-(NSString*)getStringForIndex:(int)index
{
    id retObj = [NSString string];
    
    if ([json isKindOfClass:[NSArray class]])
    {
        NSArray* array = (NSArray*)json;
        
        if ([array count] > index) 
        {
            retObj = [array objectAtIndex:index];
        }
        
        if ([retObj isKindOfClass:[NSNumber class]]) {
            retObj = [retObj stringValue];
        }
        
        if (![retObj isKindOfClass:[NSString class]]) {
            retObj = [NSString string];
        }
    }
    
    return retObj;
}

- (int)getIntForIndex:(int)index
{
    return [[self getStringForIndex:index] intValue];
}

- (long long)getLongLongForIndex:(int)index
{
    return [[self getStringForIndex:index] longLongValue];
}

- (BOOL)getBoolForIndex:(int)index
{
    return [[self getStringForIndex:index] boolValue];
}

- (float)getFloatForIndex:(int)index
{
    return [[self getStringForIndex:index] floatValue];
}

- (double)getDoubleForIndex:(int)index
{
    return [[self getStringForIndex:index] doubleValue];
}

- (id)getObjectForIndex:(int)index
{
    id retObj = nil;
    
    if ([json isKindOfClass:[NSArray class]]) {
        
        NSArray* array = (NSArray*)json;
        
        if ([array count] > index)
        {
            retObj = [array objectAtIndex:index];
        }
    }
    
    if (retObj == nil) {
        retObj = [NSArray array];
    }
    
    return retObj;
}

- (BOOL)haveIntValueForKey:(NSString*)key
{
    if (nil != key &&
        [json isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)json;
        id retObj = [dict objectForKey:key];
        
        if (!retObj) return NO;
        
        if ([retObj isKindOfClass:[NSNumber class]] || [retObj isKindOfClass:[NSString class]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)haveDoubleValueForKey:(NSString*)key
{
    if (nil != key &&
        [json isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)json;
        id retObj = [dict objectForKey:key];
        
        if (!retObj) return NO;
        
        if ([retObj isKindOfClass:[NSNumber class]] || [retObj isKindOfClass:[NSString class]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)haveFloatValueForKey:(NSString *)key
{
    if (nil != key &&
        [json isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)json;
        id retObj = [dict objectForKey:key];
        
        if (!retObj) return NO;
        
        if ([retObj isKindOfClass:[NSNumber class]] || [retObj isKindOfClass:[NSString class]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)haveStringValueForKey:(NSString*)key
{
    if (nil != key &&
        [json isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)json;
        id retObj = [dict objectForKey:key];
        
        if (!retObj) return NO;
        
        if ([retObj isKindOfClass:[NSString class]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)haveJsonValueForKey:(NSString*)key;
{
    if (nil != key &&
        [json isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)json;
        id retObj = [dict objectForKey:key];
        
        if (!retObj) return NO;
        
        if ([retObj isKindOfClass:[NSDictionary class]]
            || [retObj isKindOfClass:[NSArray class]])
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL)removeDataAtIndex:(NSInteger)index;
{
    if (![json isKindOfClass:[NSArray class]])
    {
        return NO; 
    }
    
    if (index < [self count] && index >= 0)
    {
        [json removeObjectAtIndex:index];  
        return YES;
    } 
    
    return NO; 
}

- (BOOL)removeDataAtArray:(NSArray*)array;
{
    if (![json isKindOfClass:[NSArray class]])
    {
        return NO;
    }
    if (array && array.count > 0) {
         [json  removeObjectsInArray:array];
         return YES;
    }
     return NO;
}

- (BOOL)insertData:(id)data atIndex:(NSInteger)index
{
    if (![json isKindOfClass:[NSArray class]]) {
        
        return NO; 
    }
    
    if (index >= [self count]) {
        
        [json addObject:data];  
    } else {
        [json insertObject:data atIndex:index];
    }
    
    return YES; 
}

- (BOOL)insertData:(NSObject *)data forKey:(NSString *)key
{
    if (nil == key || nil == data)
    {
        return NO;
    }
    
    if (![json isKindOfClass:[NSDictionary class]])
    {
        return NO; 
    }

    [json setValue:data forKey:key]; 
    
    return YES; 
}

// 修改值 dong jianbo
- (BOOL)setData:(NSObject *)data atIndex:(NSInteger)index
{
    if (![json isKindOfClass:[NSArray class]]) {
        
        return NO; 
    }
    
    if (index >= [self count]) {
        [json addObject:data];  
    } else {
        [json replaceObjectAtIndex:index withObject:data];
    }
    
    return YES; 
}

- (BOOL)setData:(NSObject *)data forKey:(NSString *)key
{
    if (nil == data || nil == key)
    {
        return NO;
    }
    
    if (![json isKindOfClass:[NSDictionary class]] &&
        ![json isKindOfClass:[NSArray class]] &&
        ![json respondsToSelector:@selector(setValue:forKey:)]) // cn
    {
        return NO; 
    }
    
    [json setValue:data forKey:key]; 
    
    return YES; 
}
- (BOOL)setIntValue:(int)value forKey:(NSString *)key
{
    if (nil == key)
    {
        return NO;
    }
    
    if (![json isKindOfClass:[NSDictionary class]]) {
        
        return NO; 
    }
    
    [json setValue:[NSNumber numberWithInt:value] forKey:key]; 
    
    return YES; 
}

-(unsigned int)count
{
    unsigned int ret = 0;
    if ([json respondsToSelector:@selector(count)]) 
    {
        ret = [json count];
    }
    return ret;
}

- (NSString *)toString
{
    return [json toString];//[json JSONRepresentation];
    
}

#pragma mark - Print
-(void)printJson
{
    QLKDLog(@"json is:\r\n %@", json);
}

- (id)copyWithZone:(NSZone *)zone
{
    KXJson *result = [[[self class] allocWithZone:zone] init];
    result.json = self.json;
    return result;
}

- (BOOL)isEqual:(id)anObject
{
    if ([anObject isKindOfClass:[KXJson class]]) {
        return [self.json isEqual: [anObject json]];
    }
    return NO;
}

- (NSUInteger)hash
{
    return [self.json hash];
}

- (NSString*) description
{
    return [json description];
}
- (NSString *)toJsonString
{
    return [json JSONString];
//    return [json JSONRepresentation];
}
@end
