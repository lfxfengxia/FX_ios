//
//  UIView+CutLayer.h
//  SP2P_6.1
//
//  Created by emoneybag on 15/7/1.
//  Copyright (c) 2015年 EIMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CutLayer)

- (void)cutLayerByCornerRaius:(CGFloat)radius;

- (void)setBord;

- (void)setBordWithBordcolor:(UIColor *)corlor;

+ (UILabel *)customLableWithRect:(CGRect)rect text :(NSString *)text;

+ (UIButton *)customButtonWithRect:(CGRect)rect title :(NSString *)title;

@end
