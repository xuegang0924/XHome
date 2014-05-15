//
//  ViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "ViewController.h"
#import "RoomsViewController.h"
#import "ScenaryViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *roomBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    roomBtn.frame = CGRectMake(0, 100, 100, 40);
    [roomBtn setTitle:@"Rooms" forState:UIControlStateNormal];
    [roomBtn addTarget:self action:@selector(roomBtnClc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:roomBtn];
    
    UIButton *scenaryBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    scenaryBtn.frame = CGRectMake(100, 100, 100, 40);
    [scenaryBtn setTitle:@"Scenary" forState:UIControlStateNormal];
    [scenaryBtn addTarget:self action:@selector(scenaryBtnClc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scenaryBtn];
}

- (void)roomBtnClc:(id)sender
{
    RoomsViewController *rvc = [[RoomsViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}

- (void)scenaryBtnClc:(id)sender
{
    ScenaryViewController *svc = [[ScenaryViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
