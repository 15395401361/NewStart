//
//  QLKApiClient+Ext.m
//  CloudsOutpatient
//
//  Created by 吴林丰 on 2017/2/24.
//  Copyright © 2017年 HC. All rights reserved.
//

#import "QLKApiClient+Ext.h"
#import "QLKApiClient.h"


#pragma mark-用于消息api


@implementation QLKApiClient (Ext)

#pragma mark ----- 正常请求数据
+ (void)requestWithUrlString:(NSString *)urlString andBaseUrl:(NSString *)baseUrl params:(NSMutableDictionary *)params httpMethod:(NSString*)httpMethod didFinishLoaded:(QLKResponseSuccess)success didFailLoaded:(QLKResponseFail)fail{
    NSMutableString *nsMurlString;
    if(!([urlString hasPrefix:@"https://"] || [urlString hasPrefix:@"http://"])){
        if (IS_NOT_EMPTY(baseUrl)) {
            nsMurlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",baseUrl,urlString?urlString:@""];
        }else{
            nsMurlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",kHOST,urlString?urlString:@""];
        }
    }else{
        nsMurlString = [urlString copy];
    }
//    if([QLKUser sharedInstance].token){
//        [params setObject:[QLKUser sharedInstance].token forKey:@"token"];
//    }
//    if ([QLKUser sharedInstance].doctorId) {
//        [params setObject:[QLKUser sharedInstance].doctorId forKey:@"doctorId"];
//    }
    QLKDLog(@"地址=======%@参数=======%@",nsMurlString,params);
    AFHTTPSessionManager *manager = [QLKApiClient managerWithBaseURL:nil sessionConfiguration:NO];
    if ([@"POST" isEqualToString:httpMethod]) {
        [manager POST:nsMurlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id dic = [QLKApiClient responseConfiguration:responseObject];
            KXJson *result = [KXJson jsonWithJsonString:[dic JSONString]];
            [QLKApiClient dealResultWithJsons:result andSuccess:success andFail:fail andPath:nsMurlString];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail(error,nsMurlString);
        }];
    }else if ([@"GET" isEqualToString:httpMethod]){
        [manager GET:nsMurlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id dic = [QLKApiClient responseConfiguration:responseObject];
            KXJson *result = [KXJson jsonWithJsonString:[dic JSONString]];
            [QLKApiClient dealResultWithJsons:result andSuccess:success andFail:fail andPath:nsMurlString];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail(error,nsMurlString);
        }];
    }
}

#pragma mark --- 后台返回链接直接使用
+ (void)sendBackgroundUrl:(NSString *)url params:(NSMutableDictionary *)params httpMethod:(NSString*)httpMethod didFinishLoaded:(QLKResponseSuccess)success didFailLoaded:(QLKResponseFail)fail{
//    if([QLKUser sharedInstance].token){
//        [params setObject:[QLKUser sharedInstance].token forKey:@"token"];
//    }
//    if ([QLKUser sharedInstance].doctorId) {
//        [params setObject:[QLKUser sharedInstance].doctorId forKey:@"doctorId"];
//    }
    QLKDLog(@"地址=======%@参数=======%@",url,params);
    AFHTTPSessionManager *manager = [QLKApiClient managerWithBaseURL:nil sessionConfiguration:NO];
    if ([@"POST" isEqualToString:httpMethod]) {
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id dic = [QLKApiClient responseConfiguration:responseObject];
            KXJson *result = [KXJson jsonWithJsonString:[dic JSONString]];
            [QLKApiClient dealResultWithJsons:result andSuccess:success andFail:fail andPath:url];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail(error,url);
        }];
    }else if ([@"GET" isEqualToString:httpMethod]){
        [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id dic = [QLKApiClient responseConfiguration:responseObject];
            KXJson *result = [KXJson jsonWithJsonString:[dic JSONString]];
            [QLKApiClient dealResultWithJsons:result andSuccess:success andFail:fail andPath:url];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail(error,url);
        }];
    }
}

#pragma mark ----- 上传文件
+ (void)requestWithString:(NSString *)urlString andBaseUrl:(NSString *)baseUrl params:(NSMutableDictionary *)params data:(NSData*)data  httpMethod:(NSString*)httpMethod didFinishLoaded:(didFinishUpload)finish progress:(QLKprogress)progress didFailLoaded:(didFailLoaded)fail{
    NSMutableString *nsMurlString;
    if(!([urlString hasPrefix:@"https://"] || [urlString hasPrefix:@"http://"])){
        if (IS_NOT_EMPTY(baseUrl)) {
            nsMurlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",baseUrl,urlString];
        }else{
            nsMurlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",kHOST,urlString];
        }
    }else{
        nsMurlString = [NSMutableString stringWithString:urlString];
    }
//    if([QLKUser sharedInstance].token){
//        [params setObject:[QLKUser sharedInstance].token forKey:@"token"];
//    }
//    if ([QLKUser sharedInstance].doctorId) {
//        [params setObject:[QLKUser sharedInstance].doctorId forKey:@"doctorId"];
//    }
    QLKDLog(@"地址=======%@参数=======%@",nsMurlString,params);
    AFHTTPSessionManager *manager = [QLKApiClient managerWithBaseURL:nil sessionConfiguration:NO];
    [manager POST:nsMurlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /*
         *该方法的参数
         1. appendPartWithFileData：要上传的照片[二进制流]
         2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
         3. fileName：要保存在服务器上的文件名
         4. mimeType：上传的文件的类型
         */
        if ([[params objectForKey:@"type"] integerValue] == 2) {
            [formData appendPartWithFileData:data name:@"file" fileName:@"imgFile" mimeType:@"image/jpg"]; //
        }
        if ([[params objectForKey:@"type"] integerValue] == 4) {
            [formData appendPartWithFileData:data name:@"file" fileName:@"mp3File" mimeType:@"audio/mp3"];
        }
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        QLKDLog(@"---上传进度--- %f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QLKDLog(@"上传成功%@", responseObject);
        id dic = [QLKApiClient responseConfiguration:responseObject];
        KXJson *result = [KXJson jsonWithJsonString:[dic JSONString]];
        [QLKApiClient dealResultWithJsons:result andSuccess:finish andFail:fail andPath:nsMurlString];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QLKDLog(@"xxx上传失败xxx %@", error);
        fail(error,nsMurlString);
    }];
    
}


#pragma mark ----- 上传多张图片
+ (void)requestWithString:(NSString *)urlString andBaseUrl:(NSString *)baseUrl params:(NSMutableDictionary *)params  imageDatas:(NSDictionary*)imageDatas  httpMethod:(NSString*)httpMethod progress:(QLKprogress)progress  didFinishLoaded:(didFinishLoaded)finish didFailLoaded:(didFailLoaded)fail{
    NSMutableString *nsMurlString;
    if(!([urlString hasPrefix:@"https://"] || [urlString hasPrefix:@"http://"])){
        if (IS_NOT_EMPTY(baseUrl)) {
            nsMurlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",baseUrl,urlString];
        }else{
            nsMurlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",kHOST,urlString];
        }
    }else{
        nsMurlString = [NSMutableString stringWithString:urlString];
    }
//    if([QLKUser sharedInstance].token){
//        [params setObject:[QLKUser sharedInstance].token forKey:@"token"];
//    }
//    if ([QLKUser sharedInstance].doctorId) {
//        [params setObject:[QLKUser sharedInstance].doctorId forKey:@"doctorId"];
//    }
    QLKDLog(@"地址=======%@参数=======%@",nsMurlString,params);
    AFHTTPSessionManager *manager = [QLKApiClient managerWithBaseURL:nil sessionConfiguration:NO];
    [manager POST:nsMurlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if ([[imageDatas objectForKey:@"imageCode"] isEqualToString:@"QLKSuffererIllnessNote"]) {
            NSArray *tempArray=[imageDatas objectForKey:@"pictures"];
            [tempArray enumerateObjectsUsingBlock:^(NSData *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [formData appendPartWithFileData:obj name:@"pictures" fileName:@"imgFile" mimeType:@"image/png"]; //
            }];
        }else if([[imageDatas objectForKey:@"imageCode"] isEqualToString:@"QLKPatientRecord"]){
            NSArray *tempArray=[imageDatas objectForKey:@"pictures"];
            [tempArray enumerateObjectsUsingBlock:^(NSData *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                [formData appendPartWithFileData:obj name:@"file" fileName:fileName mimeType:@"image/png"]; //
            }];
        }else{
            NSArray *keys=imageDatas.allKeys;
            for (int i=0; i<keys.count; i++) {
                [formData appendPartWithFileData:imageDatas[keys[i]] name:keys[i] fileName:@"imgFile" mimeType:@"image/png"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        QLKDLog(@"---上传进度--- %f",uploadProgress.fractionCompleted);
        if (progress) {
            progress(uploadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QLKDLog(@"上传成功%@", responseObject);
        id dic = [QLKApiClient responseConfiguration:responseObject];
        KXJson *result = [KXJson jsonWithJsonString:[dic JSONString]];
        [QLKApiClient dealResultWithJsons:result andSuccess:finish andFail:fail andPath:nsMurlString];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QLKDLog(@"xxx上传失败xxx %@", error);
        fail(error,nsMurlString);
    }];
}



#pragma mark ----- 文件下载
+ (void)downFileFromServerWithPath:(NSString *)urlString andBaseUrl:(NSString *)baseUrl filepath:(NSString *)filepath httpMethod:(NSString*)httpMethod didFinishLoaded:(didFinishUpload)finish progress:(didFinishProgress)progress didFailLoaded:(didFailLoaded)fail{
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    AFHTTPSessionManager *manager = [QLKApiClient managerWithBaseURL:nil sessionConfiguration:NO];
    NSURLSessionDownloadTask *dataTask =  [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        QLKDLog(@"下载进度%f",downloadProgress.fractionCompleted*100);
        if (progress) {
            progress(downloadProgress.fractionCompleted);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        return [NSURL fileURLWithPath:filepath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        QLKDLog(@"文件路径%@",filePath)
        //设置下载完成操作
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        if (nil != filePath && nil != response) {
            if (finish) {
                finish(nil,[filePath path]);
            }
        }else{
            if (fail) {
                fail(error,[filePath path]);
            }
        }
    }];
    [dataTask resume];
}

#pragma mark ----- 返回的错误统一处理
+ (void)dealResultWithJsons:(KXJson *)result andSuccess:(QLKResponseSuccess)success andFail:(QLKResponseFail)fail andPath:(NSString *)path{
    if (success) {
        success(result,path);
    }
}
@end
