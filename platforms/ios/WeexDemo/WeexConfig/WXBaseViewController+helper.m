//
//  WXBaseViewController+helper.m
//  WeexDemo
//
//  Created by Baird-weng on 2018/8/25.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "WXBaseViewController+helper.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import <objc/runtime.h>
#import <WeexSDK/WeexSDK.h>
@implementation WXBaseViewController (helper)

+ (void)load
{

    method_exchangeImplementations(
                                   class_getInstanceMethod(self, @selector(viewWillAppear:)),
                                   class_getInstanceMethod(self, @selector(nima_viewWillAppear:))
                                  );
    
    
    method_exchangeImplementations(
                                   class_getInstanceMethod(self, @selector(viewDidAppear:)),
                                   class_getInstanceMethod(self, @selector(f_viewDidAppear:))
                                   );
    
    method_exchangeImplementations(
                                   class_getInstanceMethod(self, @selector(viewDidLoad)),
                                   class_getInstanceMethod(self, @selector(f_viewDidLoad))
                                   );
}
-(void)f_viewDidLoad{
    [self f_viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
}
-(void)nima_viewWillAppear:(BOOL)animated{
    @try{
        [self nima_viewWillAppear:animated];
        
    }@catch(NSException *ex){
        
    }@finally{
    }
    WXSDKInstance *ins =  [WXSDKManager bridgeMgr].topInstance;
    NSLog(@"%@",ins);
}
- (void)f_viewDidAppear:(BOOL)animated{
    [self f_viewDidAppear:animated];
    WXSDKInstance *ins =  [WXSDKManager bridgeMgr].topInstance;
    __block typeof(ins)b_ins = ins;
    [b_ins fireGlobalEvent:@"geolocation" params:@{@"key":@"value"}];
}

@end
