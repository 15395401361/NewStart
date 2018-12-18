//
//  QLKAFAPIClient+Ext.h
//  CloudsOutpatient
//
//  Created by 吴林丰 on 2017/2/24.
//  Copyright © 2017年 HC. All rights reserved.
//

#import "QLKApiClient.h"
#import "KXJson.h"

typedef void (^didFinishLoaded)(KXJson *json, NSString *path);
typedef void (^didFinishProgress)(double progress);
typedef void (^didFinishUpload)(KXJson *json, NSString *path);
typedef void (^didFailLoaded)(NSError *error, NSString *path);
typedef void (^sendChatFinishLoaded)(KXJson *json,NSInteger index);


@interface QLKApiClient (Ext)

//发送请求
+ (void)requestWithUrlString:(NSString *)urlString andBaseUrl:(NSString *)baseUrl params:(NSMutableDictionary *)params httpMethod:(NSString*)httpMethod didFinishLoaded:(QLKResponseSuccess)success didFailLoaded:(QLKResponseFail)fail;
//根据后端的链接发送请求
+ (void)sendBackgroundUrl:(NSString *)url params:(NSMutableDictionary *)params httpMethod:(NSString*)httpMethod didFinishLoaded:(QLKResponseSuccess)success didFailLoaded:(QLKResponseFail)fail;

//上传文件
+ (void)requestWithString:(NSString *)urlString andBaseUrl:(NSString *)baseUrl params:(NSMutableDictionary *)params data:(NSData*)data  httpMethod:(NSString*)httpMethod didFinishLoaded:(didFinishUpload)finish progress:(QLKprogress)progress didFailLoaded:(didFailLoaded)fail;

//上传多张图片
+ (void)requestWithString:(NSString *)urlString andBaseUrl:(NSString *)baseUrl params:(NSMutableDictionary *)params  imageDatas:(NSDictionary*)imageDatas  httpMethod:(NSString*)httpMethod progress:(QLKprogress)progress  didFinishLoaded:(didFinishLoaded)finish didFailLoaded:(didFailLoaded)fail;


//下载
+ (void)downFileFromServerWithPath:(NSString *)urlString andBaseUrl:(NSString *)baseUrl filepath:(NSString *)filepath httpMethod:(NSString*)httpMethod didFinishLoaded:(didFinishUpload)finish progress:(didFinishProgress)progress didFailLoaded:(didFailLoaded)fail;

@end
