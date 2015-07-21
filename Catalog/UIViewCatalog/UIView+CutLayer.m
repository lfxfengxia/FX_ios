//
//  UIView+CutLayer.m
//  SP2P_6.1
//
//  Created by emoneybag on 15/7/1.
//  Copyright (c) 2015年 EIMS. All rights reserved.
//

#import "UIView+CutLayer.h"

#import "ColorTools.h"

@implementation UIView (CutLayer)

- (void)cutLayerByCornerRaius:(CGFloat)radius{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)setBord{

    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0;
    [self cutLayerByCornerRaius:5.0];
}

- (void)setBordWithBordcolor:(UIColor *)corlor{
    
    self.layer.borderColor = corlor.CGColor;
    self.layer.borderWidth = 1.0;
    [self cutLayerByCornerRaius:5.0];
}

+ (UILabel *)customLableWithRect:(CGRect)rect text :(NSString *)text {
    UILabel *lb = [[UILabel alloc]initWithFrame:rect];
    lb.font = [UIFont systemFontOfSize:12];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor grayColor];
    lb.text = text;
    return lb;
}

+ (UIButton *)customButtonWithRect:(CGRect)rect title:(NSString *)title {
    UIButton *btn = [[UIButton alloc]initWithFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBord];
    return btn;
}

@end
