//
//  WHWebViewController.m
//
//  Created by WangHui on 2016/12/17.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHWebViewController.h"

#import <WebKit/WebKit.h>

@interface WHWebViewController ()<WKUIDelegate>

@property (weak,   nonatomic) IBOutlet UIView *webContentView;
@property (weak,   nonatomic) WKWebView *wkWebView;
@property (strong, nonatomic) NSURL *webUrl;

@end

@implementation WHWebViewController

/**
 快速创建控制器
 
 @param title 标题
 @param url 网页URL
 @return WHWebViewController
 */
+ (instancetype)WebViewControllerWithTitile:(NSString *)title withWebUrl:(NSString *)url
{
    WHWebViewController *webVc = [WHWebViewController new];
    webVc.title = title;
    if ([url containsString:@"html"] && ![url hasPrefix:@"http"])
    {
        webVc.webUrl = [NSURL fileURLWithPath:url];
    }
    else
    {
        webVc.webUrl = [NSURL URLWithString:url];
    }
    
    return webVc;
}

- (WKWebView *)wkWebView
{
    if (_wkWebView == nil)
    {
        WKWebView *webView = [[WKWebView alloc] init];
        webView.UIDelegate = self;
        webView.scrollView.bounces = NO;
        [self.webContentView addSubview:webView];
        _wkWebView = webView;
    }
    return _wkWebView;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.wkWebView.frame = self.webContentView.bounds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self deleteWKWebViewCahce];
    [self loadWkWebView];
}

/**
 删除WkWebvie 缓存
 */
- (void)deleteWKWebViewCahce
{
    if (@available(iOS 9.0, *))
    {
        WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
        [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                         completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                             for (WKWebsiteDataRecord *record  in records)
                             {
                                 [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                           forDataRecords:@[record]
                                                                        completionHandler:^{
                                                                            NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                        }];
                             }
                         }];
    }
    else
    {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
        NSString *path = [NSString stringWithFormat:@"/WebKit/%@/WebsiteData/LocalStorage", bundleID];
        NSString *webKitWebCachePath = [libraryPath stringByAppendingPathComponent:path];
        [[NSFileManager defaultManager] removeItemAtPath:webKitWebCachePath error:nil];
        NSLog(@"%@", webKitWebCachePath);
    }
}

/**
 加载WkWebView
 */
- (void)loadWkWebView
{
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:self.webUrl]];
}

#pragma mark WKUIDelegate
//加载网页后，点击 按钮 或者 URL 进行跳转
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame)
    {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

@end
