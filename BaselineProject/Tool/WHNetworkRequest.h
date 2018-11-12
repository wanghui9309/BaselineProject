//
//  WHNetworkRequest.h
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestSerializerType)
{
    RequestSerializerType_Json = 0,
    RequestSerializerType_Http
};

@interface WHNetworkRequest : NSObject

/** 请求类型 默认：Json */
@property (nonatomic, assign) RequestSerializerType requestType;

SHARE_INSTANCE_H(NetworkRequest)

/**
 POST FormData 请求
 
 @param urlStr URL
 @param photos 图片数组
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)POSTFormDataWithUrl:(NSString *)urlStr photos:(NSMutableArray<UIImage *> *)photos withParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSString *error))failure;

/**
 POST FormData 请求
 
 @param urlStr URL
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)POSTFormDataWithUrl:(NSString *)urlStr withParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSString *error))failure;

/**
 GET请求
 
 @param urlStr URL
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)GET:(NSString *)urlStr withParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSString *error))failure;

/**
 POST请求
 
 @param urlStr URL
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)POST:(NSString *)urlStr withParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSString *error))failure;

@end
