//
//  ZXView.h
//  折线图
//
//  Created by iOS on 16/6/28.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawLine : UIView

@property (nonatomic, strong) NSArray * xDataArray;
@property (nonatomic, strong) NSArray * yDataArray;
@property (nonatomic, strong) NSArray * dataArray;

- (instancetype)initWithFrame:(CGRect)frame withColumCount:(int)columCount rowCount:(int)rowCount;

@end
