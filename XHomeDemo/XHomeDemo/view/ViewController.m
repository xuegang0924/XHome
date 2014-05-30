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
#import "LampViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"XHome";
    self.view.backgroundColor = [UIColor blackColor];
    UIButton *roomBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    roomBtn.frame = CGRectMake(10, 100, 100, 100);
    roomBtn.backgroundColor = [UIColor greenColor];
    [roomBtn setTitle:@"Rooms" forState:UIControlStateNormal];
    [roomBtn addTarget:self action:@selector(roomBtnClc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:roomBtn];
    
    UIButton *scenaryBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    scenaryBtn.frame = CGRectMake(150, 100, 100, 100);
    scenaryBtn.backgroundColor = [UIColor purpleColor];
    [scenaryBtn setTitle:@"Scenary" forState:UIControlStateNormal];
    [scenaryBtn addTarget:self action:@selector(scenaryBtnClc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scenaryBtn];
    
    UIButton *lampBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    lampBtn.frame = CGRectMake(10, 220, 100, 100);
    lampBtn.backgroundColor = [UIColor blueColor];
    [lampBtn setTitle:@"Lamp" forState:UIControlStateNormal];
    [lampBtn addTarget:self action:@selector(lampBtnClc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lampBtn];
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

- (void)lampBtnClc:(id)sender
{
    LampViewController *lvc = [[LampViewController alloc] init];
    [self.navigationController pushViewController:lvc animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
