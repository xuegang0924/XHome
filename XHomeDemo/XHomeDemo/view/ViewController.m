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
#import "TVViewController.h"
#import "AirconViewController.h"
#import "SocViewController.h"
#import "CurtainViewController.h"
#import "WebcamViewController.h"

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
    
    UIButton *TVBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    TVBtn.frame = CGRectMake(150, 220, 100, 100);
    TVBtn.backgroundColor = [UIColor brownColor];
    [TVBtn setTitle:@"TV" forState:UIControlStateNormal];
    [TVBtn addTarget:self action:@selector(TVBtnClc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TVBtn];
    
    
    UIButton *airconBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    airconBtn.frame = CGRectMake(10, 340, 100, 100);
    airconBtn.backgroundColor = [UIColor lightGrayColor];
    [airconBtn setTitle:@"Aircon" forState:UIControlStateNormal];
    [airconBtn addTarget:self action:@selector(airconBtnClc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:airconBtn];
    
    UIButton *socBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    socBtn.frame = CGRectMake(150, 340, 100, 100);
    socBtn.backgroundColor = [UIColor redColor];
    [socBtn setTitle:@"Soc" forState:UIControlStateNormal];
    [socBtn addTarget:self action:@selector(socBtnClc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:socBtn];
    
    
    UIButton *curtainBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    curtainBtn.frame = CGRectMake(10, 460, 100, 100);
    curtainBtn.backgroundColor = [UIColor cyanColor];
    [curtainBtn setTitle:@"Curtain" forState:UIControlStateNormal];
    [curtainBtn addTarget:self action:@selector(curtainBtnClc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:curtainBtn];
    
    UIButton *webcamBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    webcamBtn.frame = CGRectMake(150, 460, 100, 100);
    webcamBtn.backgroundColor = [UIColor yellowColor];
    [webcamBtn setTitle:@"Webcam" forState:UIControlStateNormal];
    [webcamBtn addTarget:self action:@selector(webcamBtnClc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:webcamBtn];
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

- (void)TVBtnClc:(id)sender
{
    TVViewController *rvc = [[TVViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}

- (void)airconBtnClc:(id)sender
{
    AirconViewController *svc = [[AirconViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)socBtnClc:(id)sender
{
    SocViewController *lvc = [[SocViewController alloc] init];
    [self.navigationController pushViewController:lvc animated:YES];
}


- (void)curtainBtnClc:(id)sender
{
    CurtainViewController *rvc = [[CurtainViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}

- (void)webcamBtnClc:(id)sender
{
    WebcamViewController *svc = [[WebcamViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
