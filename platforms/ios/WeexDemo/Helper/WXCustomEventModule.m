//
//  WXCustomEventModule.m
//  WeexDemo
//
//  Created by Baird-weng on 2018/8/27.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "WXCustomEventModule.h"
@implementation WXCustomEventModule
WX_EXPORT_METHOD(@selector(setStateBarHidden:))

-(void)setStateBarHidden:(BOOL)hidden{
    [[UIApplication sharedApplication]setStatusBarHidden:hidden];
}
@end
