//
//  QLKEnvironmentModel.m
//  CloudsOutpatient
//
//  Created by 黎红伟 on 2018/10/22.
//  Copyright © 2018年 HC. All rights reserved.
//

#import "QLKEnvironmentModel.h"

static QLKEnvironmentModel *dataModel;
@interface QLKEnvironmentModel ()

@end

@implementation QLKEnvironmentModel
/**
 *  创建QLKEnvironmentModel用于数据处理
 *
 *  @return dataModel
 */
+ (QLKEnvironmentModel *)shareDataModel{
    if (dataModel == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dataModel = [super alloc];
            dataModel = [dataModel init];
        });
    }
    return dataModel;
}

/**
 *  重写allocWithZone
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataModel = [super allocWithZone:zone];
        [dataModel exchangeEnviroment];
    });
    return dataModel;
}

//如果需要使用自定义Copy方法,就需要重写copyWithZone,同时需要遵循nscoding 协议
- (id)copyWithZone:(NSZone *)zone{
    QLKEnvironmentModel *model = [[QLKEnvironmentModel alloc] init];
    return model;
}

- (void)exchangeEnviroment{
    NSString *envi = [[NSUserDefaults standardUserDefaults] objectForKey:@"qlkEnvServer"];
    if (nil == envi) {
        envi = @"4";//默认是测试环境，当手动切换到线上环境后，需要删除APP重装才能切回到测试环境
    }
    switch ([envi intValue]) {
        case 1://线上环境
        {
            self.data_KHostURL = 1;
            self.data_kHost = @"ad.dabai.7lk.com";//线上服务器地址
        }
            break;
        case 2://预发布
        {
            self.data_KHostURL = 2;
            self.data_kHost = @"ad.dabaipre.7lk.com";//预发布服务器地址
        }
            break;
        case 3://开发环境
        {
            self.data_KHostURL = 3;
            self.data_kHost = @"ad.7lk.me";//开发环境服务器地址
        }
            break;
        case 4://测试环境
        {
            self.data_KHostURL = 4;
            self.data_kHost = @"ad.dabaitest.7lk.cn";//测试环境服务器地址
        }
            break;
        default:
            break;
    }
}
@end
