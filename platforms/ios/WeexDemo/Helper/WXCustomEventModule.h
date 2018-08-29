//
//  WXCustomEventModule.h
//  WeexDemo
//
//  Created by Baird-weng on 2018/8/27.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>

@interface WXCustomEventModule : NSObject<WXModuleProtocol>
-(void)setStateBarHidden:(BOOL)hidden;
@end
