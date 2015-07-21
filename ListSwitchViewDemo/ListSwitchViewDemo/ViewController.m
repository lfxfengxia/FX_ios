//
//  ViewController.m
//  ListSwitchViewDemo
//
//  Created by emoneybag on 15/7/20.
//  Copyright (c) 2015年 emoneybag. All rights reserved.
//

#import "ViewController.h"

#import "ListSwitchView.h"

@interface ViewController () <ListSwitchViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ListSwitchView *view = [[ListSwitchView alloc]initListSwitchViewWithframe:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 40) titleArray:[NSArray arrayWithObjects:@"1",@"2",@"3", nil] hasSeperatorLine:YES];
    view.delegate = self;
    view.grayLineColor = [UIColor darkGrayColor];
    view.redLineColor = [UIColor orangeColor];
    [self.view addSubview:view];
}

#pragma mark - list switch delegate

- (void)ListSwitchViewDidClickeButtonIndex:(NSInteger)buttonIndex {
    
    NSLog(@"click button index ----%ld-----",buttonIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
