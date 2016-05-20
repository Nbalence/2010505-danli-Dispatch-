//
//  QYmode.m
//  02-单例
//
//  Created by qingyun on 16/5/5.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYmode.h"


@implementation QYmode

+(instancetype)ShareMode{
    static QYmode *mode=nil;
    
//    if (mode==nil) {
//          NSLog(@"=======执行");
//        mode=[[QYmode alloc] init];
//    }
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        mode=[[QYmode alloc] init];
        NSLog(@"=====唯一性==执行");
    });
    return mode;
}
@end
