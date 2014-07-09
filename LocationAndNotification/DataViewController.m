//
//  DataViewController.m
//  LocationAndNotification
//
//  Created by 浜中 誠 on 2014/07/09.
//  Copyright (c) 2014年 tonchi. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()
            

@end

@implementation DataViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

@end
