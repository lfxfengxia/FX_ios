//
//  ListSwitchView.m
//  catalog
//
//  Created by emoneybag on 15/7/20.
//  Copyright (c) 2015年 emoneybag. All rights reserved.
//

#import "ListSwitchView.h"
#pragma mark - list item

@interface ListItem : UIButton

@property (nonatomic) NSInteger index;
@property (nonatomic, strong) NSString *title;
@property(nonatomic,getter=isSelected) BOOL selected;

- (id)initListItemWithFrame:(CGRect)rect title:(NSString *)title;

@end

@implementation ListItem

@dynamic selected;

- (id)initListItemWithFrame:(CGRect)rect title:(NSString *)title {
    self = [super initWithFrame:rect];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateSelected];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    return self;
}

@end

#pragma mark - list switch view

@interface ListSwitchView ()

@property (nonatomic, strong) UIView *grayLineView;
@property (nonatomic, strong) UIView *redLineView;
@property (nonatomic) NSInteger numbersOfButton;
@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation ListSwitchView

- (id)initListSwitchViewWithframe:(CGRect)frame titleArray :(NSArray *)titlesArray hasSeperatorLine:(BOOL)seperator{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.numbersOfButton = titlesArray.count;
        self.titlesArray = titlesArray;
        
        CGFloat width = fabs(self.bounds.size.width/titlesArray.count);
        CGFloat height = self.bounds.size.height;
        
        self.grayLineView = [[UIView alloc]initWithFrame:CGRectMake(0, height - 1.5, self.bounds.size.width, 1.5)];
        self.grayLineView.backgroundColor = [UIColor lightGrayColor];
        
        self.redLineView = [[UIView alloc]initWithFrame:CGRectMake(0, height - 2.5, width, 2.5)];
        self.redLineView.backgroundColor = [UIColor redColor];
        
        for (int i = 0; i < self.numbersOfButton; i ++) {
            
            ListItem *item = [[ListItem alloc]initListItemWithFrame:CGRectMake(i *width, 0, width, height - 2) title:titlesArray[i]];
            [item addTarget:self action:@selector(clickItemButton:) forControlEvents:UIControlEventTouchUpInside];
            item.index = i;
            item.tag = i;
            item.titleLabel.font = [UIFont systemFontOfSize:14];
            if (i == 0) {
                item.selected = YES;
            }
            [self addSubview:item];
        }
        [self addSubview:self.grayLineView];
        [self addSubview:self.redLineView];
        
        if (seperator == YES) {
            
            UIView *upLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width * titlesArray.count, 1)];
            upLine.backgroundColor = [UIColor grayColor];
            [self addSubview:upLine];
            
            for (int i = 0; i < titlesArray.count; i ++) {
                UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(width * (i + 1), 1, 1, height-2)];
                seperator.backgroundColor = [UIColor grayColor];
                [self addSubview:seperator];
            }
        }
    }
    return self;
}

#pragma mark list switch property set

- (void)setGrayLineColor:(UIColor *)grayLineColor {
    self.grayLineView.backgroundColor = grayLineColor;
}

- (void)setRedLineColor:(UIColor *)redLineColor {
    self.redLineView.backgroundColor = redLineColor;
}

- (NSArray *)titlesArray {
    return _titlesArray;
}

- (NSInteger)numbersOfButton {
    return _numbersOfButton;
}

#pragma mark list switch view item click action

- (void)clickItemButton:(ListItem *)sender {
    
    NSInteger senderIndex = sender.index;
    
    for (UIView *view in self.subviews) {
        if (view.tag != senderIndex && [view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.selected = NO;
        }
    }
    
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.redLineView.center = CGPointMake(sender.center.x, self.frame.size.height - 2);
    }];
    [self.delegate ListSwitchViewDidClickeButtonIndex:sender.index];
}


@end
