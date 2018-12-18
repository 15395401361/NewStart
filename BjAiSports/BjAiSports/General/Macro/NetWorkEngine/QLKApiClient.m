//
//  QLKAFAPIClient.m
//  CloudsOutpatient
//
//  Created by 吴林丰 on 2017/2/24.
//  Copyright © 2017年 HC. All rights reserved.
//

#import "QLKApiClient.h"
#import "NSDictionary+Ext.h"
@implementation QLKApiClient

+ (void)GET:(NSString *)url params:(NSMutableDictionary *)params success:(QLKResponseSuccess)success fail:(QLKResponseFail)fail{
    NSMutableString *urlString;
    if (!([url hasPrefix:@"https"] || [url hasPrefix:@"http"])) {
        urlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",kHOST,url];
    }else{
        urlString = [url mutableCopy];
    }
//    if([QLKUser sharedInstance].token){
//        [params setObject:[QLKUser sharedInstance].token forKey:@"token"];
//    }
//    if ([QLKUser sharedInstance].doctorId) {
//        [params setObject:[QLKUser sharedInstance].doctorId forKey:@"doctorId"];
//    }
  QLKDLog(@"地址=======%@参数=======%@",urlString,params);
    AFHTTPSessionManager *manager = [QLKApiClient managerWithBaseURL:nil sessionConfiguration:NO];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         id dic = [QLKApiClient responseConfiguration:responseObject];
         KXJson *result = [KXJson jsonWithJsonString:[dic JSONString]];
        if (success) {
            success(result,urlString);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error,urlString);
        }
    }];
}


+ (void)GET:(NSString *)url baseURL:(NSString *)baseUrl params:(NSMutableDictionary *)params success:(QLKResponseSuccess)success fail:(QLKResponseFail)fail{
    NSMutableString *urlString;
    if(!([url hasPrefix:@"https://"] || [url hasPrefix:@"http://"])){
        if (IS_NOT_EMPTY(baseUrl)) {
            urlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",baseUrl,url];
        }else{
            urlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",kHOST,url];
        }
    }else{
            urlString = [urlString mutableCopy];
    }
//    if([QLKUser sharedInstance].token){
//        [params setObject:[QLKUser sharedInstance].token forKey:@"token"];
//    }
//    if ([QLKUser sharedInstance].doctorId) {
//        [params setObject:[QLKUser sharedInstance].doctorId forKey:@"doctorId"];
//    }
  QLKDLog(@"地址=======%@参数=======%@",urlString,params);
    AFHTTPSessionManager *manager = [QLKApiClient managerWithBaseURL:nil sessionConfiguration:NO];
    [manager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic = [QLKApiClient responseConfiguration:responseObject];
        KXJson *result = [KXJson jsonWithJsonString:[dic JSONString]];
        if (success) {
            success(result,urlString);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error,urlString);
        }
    }];

}


+(void)POST:(NSString *)url params:(NSMutableDictionary *)params success:(QLKResponseSuccess)success fail:(QLKResponseFail)fail{
    NSMutableString *urlString;
    if (!([url hasPrefix:@"https"] || [url hasPrefix:@"http"])) {
        urlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",kHOST,url];
    }else{
        urlString = [url mutableCopy];
    }
//    if([QLKUser sharedInstance].token){
//        [params setObject:[QLKUser sharedInstance].token forKey:@"token"];
//    }
//    if ([QLKUser sharedInstance].doctorId) {
//        [params setObject:[QLKUser sharedInstance].doctorId forKey:@"doctorId"];
//    }
  QLKDLog(@"地址=======%@参数=======%@",urlString,params);
    AFHTTPSessionManager *manager = [QLKApiClient managerWithBaseURL:nil sessionConfiguration:NO];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic = [QLKApiClient responseConfiguration:responseObject];
        KXJson *result = [KXJson jsonWithJsonString:[dic JSONString]];
        if (success) {
          success(result,urlString);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error,urlString);
        }
    }];
}


+(void)POST:(NSString *)url baseURL:(NSString *)baseUrl params:(NSMutableDictionary *)params
    success:(QLKResponseSuccess)success fail:(QLKResponseFail)fail{
    NSMutableString *urlString;
    if(!([url hasPrefix:@"https://"] || [url hasPrefix:@"http://"])){
        if (IS_NOT_EMPTY(baseUrl)) {
            urlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",baseUrl,url];
        }else{
            urlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",kHOST,url];
        }
    }else{
        urlString = [urlString mutableCopy];
    }
//    if([QLKUser sharedInstance].token){
//        [params setObject:[QLKUser sharedInstance].token forKey:@"token"];
//    }
//    if ([QLKUser sharedInstance].doctorId) {
//        [params setObject:[QLKUser sharedInstance].doctorId forKey:@"doctorId"];
//    }
  QLKDLog(@"地址=======%@参数=======%@",urlString,params);
    AFHTTPSessionManager *manager = [QLKApiClient managerWithBaseURL:nil sessionConfiguration:NO];
    [manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic = [QLKApiClient responseConfiguration:responseObject];
        KXJson *result = [KXJson jsonWithJsonString:[dic JSONString]];
        if (success) {
            success(result,urlString);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error,urlString);
        }
    }];
}


+(void)uploadWithURL:(NSString *)url params:(NSMutableDictionary *)params fileData:(NSData *)filedata name:(NSString *)name fileName:(NSString *)filename mimeType:(NSString *) mimeType progress:(QLKprogress)progress success:(QLKResponseSuccess)success fail:(QLKResponseFail)fail{
    
//    if([QLKUser sharedInstance].token){
//        [params setObject:[QLKUser sharedInstance].token forKey:@"token"];
//    }
//    if ([QLKUser sharedInstance].doctorId) {
//        [params setObject:[QLKUser sharedInstance].doctorId forKey:@"doctorId"];
//    }
      QLKDLog(@"地址=======%@参数=======%@",url,params);
    AFHTTPSessionManager *manager = [QLKApiClient managerWithBaseURL:nil sessionConfiguration:NO];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic = [QLKApiClient responseConfiguration:responseObject];
        KXJson *result = [KXJson jsonWithJsonString:[dic JSONString]];
        if (success) {
            success(result,url);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error,url);
        }
    }];
}



+(void)uploadWithURL:(NSString *)url baseURL:(NSString *)baseurl params:(NSMutableDictionary *)params fileData:(NSData *)filedata name:(NSString *)name fileName:(NSString *)filename mimeType:(NSString *) mimeType progress:(QLKprogress)progress success:(QLKResponseSuccess)success fail:(QLKResponseFail)fail{
    NSMutableString *urlString;
    if(!([url hasPrefix:@"https://"] || [url hasPrefix:@"http://"])){
        if (IS_NOT_EMPTY(baseurl)) {
            urlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",baseurl,url];
        }else{
            urlString = [NSMutableString stringWithFormat:@"%@://%@%@",@"http",kHOST,url];
        }
    }else{
        urlString = [urlString mutableCopy];
    }
//    if([QLKUser sharedInstance].token){
//        [params setObject:[QLKUser sharedInstance].token forKey:@"token"];
//    }
//    if ([QLKUser sharedInstance].doctorId) {
//        [params setObject:[QLKUser sharedInstance].doctorId forKey:@"doctorId"];
//    }
    QLKDLog(@"地址=======%@参数=======%@",urlString,params);
    AFHTTPSessionManager *manager = [QLKApiClient managerWithBaseURL:nil sessionConfiguration:YES];
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic = [QLKApiClient responseConfiguration:responseObject];
        KXJson *result = [KXJson jsonWithJsonString:[dic JSONString]];
        if (success) {
            success(result,url);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error,url);
        }
    }];
}


+(NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url savePathURL:(NSURL *)fileURL progress:(QLKprogress )progress
                                     success:(void (^)(NSURLResponse *, NSURL *))success fail:(void (^)(NSError *))fail{
    
    NSURL *urlpath = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlpath];
    QLKDLog(@"下载文件的链接地址%@",url);
    AFHTTPSessionManager *manager = [self managerWithBaseURL:nil sessionConfiguration:YES];
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress.fractionCompleted);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [fileURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            fail(error);
        }else{
            success(response,filePath);
        }
    }];
    
    [downloadtask resume];
    
    return downloadtask;
}

#pragma mark - Private

+(AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    NSURL *url = [NSURL URLWithString:baseURL];
    if (isconfiguration) {
        
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    }else{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
//    manager.securityPolicy.allowInvalidCertificates = YES;
    //  先导入证书
    //  NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"fullway" ofType:@"cer"];//证书的路径
    //  NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    // AFSSLPinningModeCertificate 使用证书验证模式
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
//    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是<a href="\"http://www.google.com\"" target="\"_blank\"" onclick="\"return" checkurl(this)\"="" id="\"url_1\"">www.google.com</a>，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
//    securityPolicy.validatesDomainName = NO;
    // 加上这行代码，https ssl 验证。
//    [manager setSecurityPolicy:securityPolicy];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/x-www-form-urlencoded;charset=utf-8;", @"Content-Type",[NSString getDeviceName],@"_m",@"1",@"_p",@"1",@"_o",@"1",@"_n",STORE_VERSION,@"_v",nil];
    if (headers != nil) {
        for (NSString *httpHeaderField in headers.allKeys) {
            NSString *value = headers[httpHeaderField];
            [manager.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    
    return manager;
}


+(id)responseConfiguration:(id)responseObject{
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (nil == data) {
        return [[NSDictionary alloc] init];
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    return dic;
    NSDictionary *newDict = [NSDictionary changeType:dic];
    return newDict;
}

@end
