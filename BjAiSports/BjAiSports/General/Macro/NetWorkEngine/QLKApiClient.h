//
//  QLKAFAPIClient.h
//  CloudsOutpatient
//
//  Created by 吴林丰 on 2017/2/24.
//  Copyright © 2017年 HC. All rights reserved.
//
#import "KXJson.h"
#import "JSONKit.h"
#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "QLKEnvironmentModel.h"
#import "KCConstants_API.h"
/**
 *
 *  宏定义文件路径Block
 *
 *  @param fileURL 请求路径
 */
typedef void (^QLKFileBlock)(NSString *fileURL);
/**
 *
 *  宏定义网络请求成功的block
 *
 *  @param response 请求成功返回的数据
 */

//typedef void (^QLKResponseSuccess)(NSURLSessionDataTask *task,id responseObject);
typedef void (^QLKResponseSuccess)(KXJson *json,NSString *path);
/**
 *
 * 宏定义请求失败的block
 *
 * @param error 报错信息
 */
//typedef void (^QLKResponseFail)(NSURLSessionDataTask * task, NSError * error);
typedef void (^QLKResponseFail)(NSError *error, NSString *path);


/**
 *  上传或者下载的进度
 *
 *  @param progress 进度
 */
typedef void (^QLKprogress)(double progress);
//typedef void (^QLKprogress)(double progress);

@interface QLKApiClient : NSObject



/**
 *  普通get方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)GET:(NSString *)url params:(NSMutableDictionary *)params success:(QLKResponseSuccess)success
      fail:(QLKResponseFail)fail;



/**
 *  含有baseURL的get方法
 *
 *  @param url     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)GET:(NSString *)url baseURL:(NSString *)baseUrl  params:(NSMutableDictionary *)params success:(QLKResponseSuccess)success fail:(QLKResponseFail)fail;



/**
 *  普通post方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)POST:(NSString *)url params:(NSMutableDictionary *)params success:(QLKResponseSuccess)success
    fail:(QLKResponseFail)fail;




/**
 *  含有baseURL的post方法
 *
 *  @param url     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)POST:(NSString *)url baseURL:(NSString *)baseUrl params:(NSMutableDictionary *)params success:(QLKResponseSuccess)success
       fail:(QLKResponseFail)fail;


/**
 *  普通路径上传文件
 *
 *  @param url      请求网址路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 */
+(void)uploadWithURL:(NSString *)url
              params:(NSMutableDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(QLKprogress)progress
             success:(QLKResponseSuccess)success
                fail:(QLKResponseFail)fail;



/**
 *  含有跟路径的上传文件
 *
 *  @param url      请求网址路径
 *  @param baseurl  请求网址根路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 */
+(void)uploadWithURL:(NSString *)url
             baseURL:(NSString *)baseurl
              params:(NSMutableDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(QLKprogress)progress
             success:(QLKResponseSuccess)success
                fail:(QLKResponseFail)fail;

/**
 *  下载文件
 *
 *  @param url      请求网络路径
 *  @param fileURL  保存文件url
 *  @param progress 下载进度
 *  @param success  成功回调
 *  @param fail     失败回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，重新开启下载调用resume方法
 */
+(NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                 savePathURL:(NSURL *)fileURL
                                    progress:(QLKprogress )progress
                                     success:(void (^)(NSURLResponse *, NSURL *))success
                                        fail:(void (^)(NSError *))fail;

//AF3.0过后的网络请求Manager
+(AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration;
//解析返回数据
+(id)responseConfiguration:(id)responseObject;
@end
