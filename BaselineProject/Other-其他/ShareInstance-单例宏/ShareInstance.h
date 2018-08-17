//
//  ShareInstance.h
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//
/**
 
    单例宏
 
 */

#define SHARE_INSTANCE_H(name) + (instancetype)share##name;

#define SHARE_INSTANCE_M(name, class)\
static class *class##_instance = nil;\
\
+(instancetype)share##name\
{\
    static dispatch_once_t class##_predicate;\
    dispatch_once(&class##_predicate, ^() {\
        class##_instance = [[class alloc] init];\
    });\
    return class##_instance;\
}
