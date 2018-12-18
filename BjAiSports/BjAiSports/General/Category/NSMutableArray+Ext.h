//
//  NSMutableArray+Ext.h
//  Qilekang
//
//  Created by chaizhiyong on 14-7-11.
//  Copyright (c) 2014年 Qilekang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (ext)

- (id)mutableDeepCopy;
- (NSArray *)arrayByReplacingNullsWithBlanks;
@end
