//
//  WHNetworkRequest.m
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHNetworkRequest.h"

#import "WHNetworkActivityIndicator.h"

#import <Reachability/Reachability.h>
#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, NetworkRequestType)
{
    NetworkRequestType_GET,             //GET请求
    NetworkRequestType_POST,            //POST请求
    NetworkRequestType_FormData         //formData
};

@interface WHNetworkRequest ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableSet<NSURLSessionTask *> *operationTask;

@end

@implementation WHNetworkRequest

SHARE_INSTANCE_M(NetworkRequest, WHNetworkRequest)

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _sessionManager = [AFHTTPSessionManager manager];
        //响应体
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"application/javascript", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/png", @"image/jpeg", nil];
        
        _operationTask = [NSMutableSet set];
        
#if TARGET_OS_IOS
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
#endif
    }
    return self;
}

#pragma mark - requestMethod
/**
 发起请求

 @param requestType 请求类型
 @param urlStr url
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)requestWithNetworkType:(NetworkRequestType)requestType
                       withUrl:(NSString *)urlStr
                withParameters:(NSDictionary *)parameters
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure
{
    [self requestWithNetworkType:requestType withUrl:urlStr photos:nil withParameters:parameters success:success failure:failure];
}

/**
 发起请求
 
 @param requestType 请求类型
 @param urlStr url
 @param photos 图片数组
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)requestWithNetworkType:(NetworkRequestType)requestType
                       withUrl:(NSString *)urlStr
                        photos:(NSMutableArray<UIImage *> *)photos
                withParameters:(NSDictionary *)parameters
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure
{
    BOOL isReachable = [[Reachability reachabilityForInternetConnection] isReachable];
    if (!isReachable)
    {
        if (failure)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(nil);
            });
        }
        return;
    }
    
    [[WHNetworkActivityIndicator sharedActivityIndicator] startActivity];
    
    __weak typeof(self) weakSelf = self;
    //请求成功的回调
    void (^successBlock)(NSURLSessionTask *task, id responseObject) = ^(NSURLSessionTask *task, id responseObject){
        
        [weakSelf.operationTask removeObject:task];
        [[WHNetworkActivityIndicator sharedActivityIndicator] stopActivity];
        
        WHLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        if (success)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(responseObject);
            });
        }
    };
    
    //请求失败的回调
    void (^failureBlock)(NSURLSessionTask *task, NSError *error) = ^(NSURLSessionTask *task, NSError *error){
        
        [weakSelf.operationTask removeObject:task];
        [[WHNetworkActivityIndicator sharedActivityIndicator] stopActivity];
        
        WHLog(@"%@", error);
        
        if (failure)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    };
    
    //请求头
    switch (self.requestType)
    {
        case RequestSerializerType_Http:
            _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
            
        default:
            _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
    }
    // 超时时间
    _sessionManager.requestSerializer.timeoutInterval = 15.0f;
    
    NSURLSessionTask *task = nil;
    switch (requestType)
    {
        case NetworkRequestType_GET:
        {
            task = [_sessionManager GET:urlStr parameters:parameters progress:nil success:successBlock failure:failureBlock];
        }
            break;
            
        case NetworkRequestType_POST:
        {
            task = [_sessionManager POST:urlStr parameters:parameters progress:nil success:successBlock failure:failureBlock];
        }
            break;
            
        case NetworkRequestType_FormData:
        {
            task = [_sessionManager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                // 直接以 key value 的形式向 formData 中追加二进制数据
                for (NSString *key in parameters.allKeys)
                {
                    id data = parameters[key];
                    
                    if ([data isKindOfClass:NSString.class])
                    {
                        [formData appendPartWithFormData:[data dataUsingEncoding:NSUTF8StringEncoding] name:key];
                    }
                }
                
                [photos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:UIImage.class])
                    {
                        NSString *fileName = [NSString stringWithFormat:@"file_%lu.png", idx];
                        NSData *imageData = UIImageJPEGRepresentation(obj, 0.7);
                        
                        
                        [formData appendPartWithFileData:imageData name:@"file[]" fileName: fileName mimeType:@"image/png"];
                    }
                }];
                
            } progress:nil success:successBlock failure:failureBlock];
        }
            break;
            
        default:
            break;
    }
    [_operationTask addObject:task];
}

/**
 POST FormData 请求
 
 @param urlStr URL
 @param photos 图片数组
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)POSTFormDataWithUrl:(NSString *)urlStr photos:(NSMutableArray<UIImage *> *)photos withParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSString *error))failure
{
    // 1、成功的回调
    void (^successBlock)(id responseObject) = ^(id responseObject){
        
        if (success) success(responseObject);
        
    };
    
    void (^failureBlock)(NSError *error) = ^(NSError *error){
        
        if (failure) failure(error.localizedDescription);
    };
    
    [self requestWithNetworkType:NetworkRequestType_FormData withUrl:urlStr photos:photos withParameters:parameters success:successBlock failure:failureBlock];
}

/**
 POST FormData 请求
 
 @param urlStr URL
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)POSTFormDataWithUrl:(NSString *)urlStr withParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSString *error))failure
{
    // 1、成功的回调
    void (^successBlock)(id responseObject) = ^(id responseObject){
        
        if (success) success(responseObject);
        
    };
    
    void (^failureBlock)(NSError *error) = ^(NSError *error){
        
        if (failure) failure(error.localizedDescription);
    };
    
    [self requestWithNetworkType:NetworkRequestType_FormData withUrl:urlStr withParameters:parameters success:successBlock failure:failureBlock];
}



/**
 GET请求
 
 @param urlStr URL
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)GET:(NSString *)urlStr withParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSString *error))failure
{
    // 1、成功的回调
    void (^successBlock)(id responseObject) = ^(id responseObject){
        
        if (success) success(responseObject);
        
    };
    
    void (^failureBlock)(NSError *error) = ^(NSError *error){
        
        if (failure) failure(error.localizedDescription);
    };
    
    [self requestWithNetworkType:NetworkRequestType_GET withUrl:urlStr withParameters:parameters success:successBlock failure:failureBlock];
}

/**
 POST请求
 
 @param urlStr URL
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)POST:(NSString *)urlStr withParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSString *error))failure
{
    // 1、成功的回调
    void (^successBlock)(id responseObject) = ^(id responseObject){
        
        if (success) success(responseObject);
        
    };
    
    void (^failureBlock)(NSError *error) = ^(NSError *error){
        
        if (failure) failure(error.localizedDescription);
    };
    
    [self requestWithNetworkType:NetworkRequestType_POST withUrl:urlStr withParameters:parameters success:successBlock failure:failureBlock];
}

#pragma mark - Notification
/**
 进入后台通知
 */
- (void)backgroundNotification
{
    [self cancelAllTask];
    [[WHNetworkActivityIndicator sharedActivityIndicator] stopAllActivity];
}

/**
 取消全部task
 */
- (void)cancelAllTask
{
    for (NSURLSessionTask *task in _operationTask)
    {
        [task cancel];
    }
    [_operationTask removeAllObjects];
}

- (void)dealloc
{
    [self backgroundNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
