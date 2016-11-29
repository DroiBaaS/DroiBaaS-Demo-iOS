//
//  BaseViewController.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/8.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "BaseViewController.h"
#import <DroiAnalytics/DroiAnalytics.h>
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
//    [DroiAnalytics beginLogPageView:[[self class] description]];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
//    [DroiAnalytics endLogPageView:[[self class] description]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
