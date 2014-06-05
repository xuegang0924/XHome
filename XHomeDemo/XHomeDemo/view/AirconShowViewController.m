//
//  AirconShowViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-6-4.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "AirconShowViewController.h"

@interface AirconShowViewController ()

@end

@implementation AirconShowViewController
@synthesize btnCold;
@synthesize btnDown;
@synthesize btnFengsu;
@synthesize btnHot;
@synthesize btnONOFF;
@synthesize btnRightleft;
@synthesize btnTongfeng;
@synthesize btnUP;
@synthesize btnUpdown;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    [btnONOFF setBackgroundImage:[UIImage imageNamed:@"kaiguan_400_400.png"] forState:UIControlStateNormal];

    [btnCold setBackgroundImage:[UIImage imageNamed:@"cold_400_400.png"] forState:UIControlStateNormal];
    [btnHot setBackgroundImage:[UIImage imageNamed:@"hot_400_400.png"] forState:UIControlStateNormal];
    [btnTongfeng setBackgroundImage:[UIImage imageNamed:@"ventilate_400_400.png"] forState:UIControlStateNormal];
    [btnFengsu setBackgroundImage:[UIImage imageNamed:@"fengsu_400_400.png"] forState:UIControlStateNormal];
    [btnUpdown setBackgroundImage:[UIImage imageNamed:@"updown_400_400.png"] forState:UIControlStateNormal];
    [btnRightleft setBackgroundImage:[UIImage imageNamed:@"rightleft_400_400.png"] forState:UIControlStateNormal];
    [btnUP setBackgroundImage:[UIImage imageNamed:@"up_400_400.png"] forState:UIControlStateNormal];
    [btnDown setBackgroundImage:[UIImage imageNamed:@"down_400_400.png"] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
