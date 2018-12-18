//
//  QLKEnvironmentModel.h
//  CloudsOutpatient
//
//  Created by 黎红伟 on 2018/10/22.
//  Copyright © 2018年 HC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLKEnvironmentModel : NSObject<NSCopying>

@property (nonatomic,assign) NSInteger data_KHostURL;//环境 1:线上 2:预发布 3:开发 4:测试
@property (nonatomic,copy) NSString *data_kHost; //服务

+ (QLKEnvironmentModel *)shareDataModel;

@end
