//
//  MYRootViewController.m
//  WeexDemo
//
//  Created by Baird-weng on 2018/8/23.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "MYRootViewController.h"
#import <WeexSDK/WXSDKInstance.h>
#import <WeexSDK/WXSDKEngine.h>
#import <WeexSDK/WXUtility.h>
#import <WeexSDK/WXDebugTool.h>
#import <WeexSDK/WXSDKManager.h>
#import <SRWebSocket.h>
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
@interface MYRootViewController ()<UIScrollViewDelegate, UIWebViewDelegate,SRWebSocketDelegate>
@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;
@property (nonatomic, strong) SRWebSocket *hotReloadSocket;

@end

@implementation MYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
#if DEBUG
    NSString * hotReloadURL =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"WXSocketConnectionURL"];
    if (hotReloadURL){
        _hotReloadSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:hotReloadURL]];
        _hotReloadSocket.delegate = self;
        [_hotReloadSocket open];
    }
    
#endif
    
    [self render];
    // Do any additional setup after loading the view.
}
- (void)render
{
    [_instance destroyInstance];
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = self.view.frame;
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, weakSelf.weexView);
    };
    _instance.onFailed = ^(NSError *error) {
    };
    
    _instance.renderFinish = ^(UIView *view) {
        WXLogDebug(@"%@", @"Render Finish...");
//        [weakSelf updateInstanceState:WeexInstanceAppear];
    };
    
    _instance.updateFinish = ^(UIView *view) {
        WXLogDebug(@"%@", @"Update Finish...");
    };
    if (!self.url) {
        WXLogError(@"error: render url is nil");
        return;
    }
    NSURL *URL = [self testURL: [self.url absoluteString]];
    NSString *randomURL = [NSString stringWithFormat:@"%@%@random=%d",URL.absoluteString,URL.query?@"&":@"?",arc4random()];
    [_instance renderWithURL:[NSURL URLWithString:randomURL] options:@{@"bundleUrl":URL.absoluteString} data:nil];
}
- (NSURL*)testURL:(NSString*)url
{
    NSRange range = [url rangeOfString:@"_wx_tpl"];
    if (range.location != NSNotFound) {
        NSString *tmp = [url substringFromIndex:range.location];
        NSUInteger start = [tmp rangeOfString:@"="].location;
        NSUInteger end = [tmp rangeOfString:@"&"].location;
        ++start;
        if (end == NSNotFound) {
            end = [tmp length] - start;
        }
        else {
            end = end - start;
        }
        NSRange subRange;
        subRange.location = start;
        subRange.length = end;
        url = [tmp substringWithRange:subRange];
    }
    return [NSURL URLWithString:url];
}
#pragma mark - websocket
- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    if ([@"refresh" isEqualToString:message]) {
        [self render];
    }
    @try {
        NSDictionary * messageDic = [WXUtility objectFromJSON:message];
        NSString *method = messageDic[@"method"];
        if ([method hasPrefix:@"WXReload"]) {
            if ([method isEqualToString:@"WXReloadBundle"] && messageDic[@"params"]) {
                self.url = [NSURL URLWithString:messageDic[@"params"]];
            }
            [self render];
        }
        
    }@catch(NSError * error) {
        NSLog(@"error");
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
