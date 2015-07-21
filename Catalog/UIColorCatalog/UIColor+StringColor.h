//
//  UIColor+StringColor.h
//  ListSwitchViewDemo
//
//  Created by emoneybag on 15/7/20.
//  Copyright (c) 2015年 emoneybag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(StringColor)

//设置RGB颜色值
#define SETCOLOR(R,G,B,A)       [UIColor colorWithRed:(CGFloat)R/255 green:(CGFloat)G/255 blue:(CGFloat)B/255 alpha:A]

/** 颜色转换 IOS中十六进制的颜色转换为UIColor **/
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
