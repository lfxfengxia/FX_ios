//
//  ListSwitchView.h
//  catalog
//
//  Created by emoneybag on 15/7/20.
//  Copyright (c) 2015年 emoneybag. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ListSwitchViewDelegate <NSObject>

@optional

- (void)ListSwitchViewDidClickeButtonIndex:(NSInteger)buttonIndex;

@end

@interface ListSwitchView : UIView

@property (nonatomic, strong) UIColor *grayLineColor;
@property (nonatomic, strong) UIColor *redLineColor;

@property (nonatomic,readonly) NSInteger numbersOfButton;
@property (nonatomic, readonly) NSArray *titlesArray;

@property (nonatomic, strong) id <ListSwitchViewDelegate>delegate;

- (id)initListSwitchViewWithframe:(CGRect)frame titleArray :(NSArray *)titlesArray hasSeperatorLine:(BOOL)seperator;

@end
