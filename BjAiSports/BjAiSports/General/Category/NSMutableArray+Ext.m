//
//  NSMutableArray+Ext.m
//  Qilekang
//
//  Created by chaizhiyong on 14-7-11.
//  Copyright (c) 2014年 Qilekang. All rights reserved.
//
#import "NSDictionary+Ext.h"
#import "NSMutableArray+Ext.h"

@implementation NSMutableArray (ext)

- (id)mutableDeepCopy
{
     NSMutableArray *copy = [[[self class]alloc]initWithCapacity:self.count];
     for (int i = 0; i < self.count; i++) {
         if([[self objectAtIndex:i] respondsToSelector:@selector(copy)]){
           id copyItem = [[self objectAtIndex:i] copy];
           [copy addObject:copyItem];
         }
     }
     return copy;
}

- (NSArray *)arrayByReplacingNullsWithBlanks{
    
    NSMutableArray *replaced = [self mutableCopy];
    
    const id nul = [NSNull null];
    
    const NSString *blank = @"";
    
    for (int idx = 0; idx < [replaced count]; idx++) {
        
        id object = [replaced objectAtIndex:idx];
        
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[object dictionaryByReplacingNullsWithBlanks]];
        
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[object arrayByReplacingNullsWithBlanks]];
        
    }
    
    return [replaced copy];
    
}
 
@end
